Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F8EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823D422522
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="FU87t942"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823D422522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeGCClY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:41:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35562 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932339AbeGCClX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:41:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id i125-v6so297306lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 19:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4LgUEzAv/cxv8lXv40sqxMZyx2LcEF/wKI1JOo3zy0=;
        b=FU87t942iYHn5zG2euTU2VTtsvkcJ9aSLXsMkhJ1Uqx8XJSP66Zl4bHb/flFmcWDL4
         2cM8fu+72hsRzR04tSHqGtUxPqi55dBCy95NgP0cPoo4ajp/NSXwVQ2ZwLf1HXj/SC8Z
         TqUZNzXRRFwy7ISICx2CPDG/i0EM3IPqz5JBHmSDe9FGu7q/jHmCzPG2BDQ75YKLAfd2
         gYBmtSoSzjCICAC76wT8gfMF/DrHXI+IImKFcBcfcqRWUipVUcuoih0oCmIsPGeFobYr
         JeVUd2Pat4EnQHJIH15vVTiOBXTWn559QD0GH7RtwMmPsf7EDodFe7h3dlUWGMxtIxo1
         Mi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4LgUEzAv/cxv8lXv40sqxMZyx2LcEF/wKI1JOo3zy0=;
        b=PCiFCWzuTra09f/4vRZw6NvxlzIhU7qpTOw1rS2wNw3PBcqNJOsX02qTj2PnhUMGeX
         O12CBK7iFLW6fOyOT7GuXy97n0oygW/5InTAKl41D+y/b4WczWyad/KQ681efFpKxmW+
         3Mg1f8kipi38QObf240hB/8vrxhmuRIlvEGj6KUq65AWSVzN9P/VT5Q0kTkxnADtS4Rd
         dpVGRBsWbaGPuhTZBM4j3QAFyHi9X573pvmPgb1f7GZC0XXdo8dPK57A8oe6hEQGXBmJ
         GTOYMFOI3pnWbPDqTS4gqTQsgRmwbxapfa2A3tOfZcUXpBL7msmf42fTeZ2+3ija1CHV
         Ko1w==
X-Gm-Message-State: APt69E38cxR0IBdNzgxx65Rm9LnBLDB2whSloHNLt6TdtpNp+0fDTHc9
        2RB9VvxMK20a1JaSKwxbJY7GNiH2ISkz1g6tUThr
X-Google-Smtp-Source: AAOMgpemP2hKrsDMnHOzYGryLRuwWEcJzpW/saTsMSaXaJkTXq/SYRFfx4fI8Oved/47JiJPcEKKphywlnT3UeX3V8I=
X-Received: by 2002:a2e:741:: with SMTP id i1-v6mr17723348ljd.87.1530585681656;
 Mon, 02 Jul 2018 19:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <3880c8030c55a97ee38335fc0dbf5dfd4f296c59.1529476660.git.joe@perches.com>
 <CAHC9VhS_UmWfv0aFGLfaqw-fLSmoGiDEcXGFZ3bvwNgp2PF=zg@mail.gmail.com>
 <d729f7dc451cf26f5fdb63e44930c8fb67da41d3.camel@perches.com>
 <CAHC9VhTzV5QKcjaQL0L_mTZECCexUq=FaSuQjC1AZjubD+VdJA@mail.gmail.com> <743d2fd7b0b661bc636766e7b569fefa95a462f6.camel@perches.com>
In-Reply-To: <743d2fd7b0b661bc636766e7b569fefa95a462f6.camel@perches.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 Jul 2018 22:41:10 -0400
Message-ID: <CAHC9VhTRmWnobxqjffSwvUQfjOP0mo-qOVF_CAd5po_8tGpR5A@mail.gmail.com>
Subject: Re: [PATCH] selinux: Use pr_fmt to prefix "SELinux: "
To:     joe@perches.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, peter.enderborg@sony.com,
        selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 10:10 PM Joe Perches <joe@perches.com> wrote:
> On Mon, 2018-07-02 at 21:15 -0400, Paul Moore wrote:
> > On Mon, Jul 2, 2018 at 5:31 PM Joe Perches <joe@perches.com> wrote:
> > > On Mon, 2018-07-02 at 16:51 -0400, Paul Moore wrote:
> > > > On Wed, Jun 20, 2018 at 2:39 AM Joe Perches <joe@perches.com> wrote:
> > > > > pr_fmt can be used with the pr_<level> macros to prefix
> > > > > arbitrary content to logging messages.
> > > > >
> > > > > So add '#define pr_fmt(fmt) "SELinux: " fmt' to selinux files
> > > > > that use pr_<level> and remove embedded "SELinux: " prefixes
> > > > > from the format strings.
> > > []
> > > > What tree did you base your patch on?
> > >
> > > next-20180619 on the day it was sent.
> > >
> > > > Please base SELinux patches
> > > > either on the SELinux tree or Linus' tree.  The SELinux tree can be
> > > > found at the links below:
> > > >
> > > > * git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> > > > * https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> > >
> > > It's almost always better to use selinux/next.
> > > Why should this patch be different?
> >
> > Yes, that's what I said, please base your patch against the selinux/next branch.
>
> Again, this patch was based on that branch on the date the
> patch was sent.
>
> It still applies today to -next.

It doesn't apply cleanly to the selinux/next branch, I believe because
there are other trees which have made changes under security/selinux/*
(I believe there was some fs related work from David Howells that
touched some SELinux/LSM code).

As I said earlier, if you want me to apply your patches to the SELinux
tree, please base them either against the selinux/next tree or against
Linus' tree.

-- 
paul moore
www.paul-moore.com
