Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06434C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4642075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nenhQCAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4642075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967580AbeF2Aii (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:38:38 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46018 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965834AbeF2Aid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:38:33 -0400
Received: by mail-lf0-f67.google.com with SMTP id m13-v6so5513148lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEE5k5TsUuuSwtzhEYXYJWDsrrg/SVm5AjmwOYC0o7I=;
        b=nenhQCAaLJHLiIwhvTkL0UXOUfkyeXa0HYMAS9bqMAcfWLXFdeyihe/WLZ4RZdVZ20
         t5Qo5hry402DcbgbCdk8Qnk8/cyXuAuoWMk2pNs7TZ0RLfp1Pf9sjg0JI2k4PpzW9Gvf
         hkFk7VHwQ5wMV63D3/+EdLnm56kZeqS0p2oKmVDNT7E0mOdBL8pk6oPusu+dwCsr9vaT
         e4EkQIxEP5gUUngUmDKVFE3vbLFP+tyATWWbgF3jkHIeydYX96b92CtPgBDCNNUekIkP
         4L5Mse7cQd1wajAs8HxBH6zPxbQ1oKnmg74LEZI+tZcvB87I5JI2Xnpad7DmA1nq9f/x
         WJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEE5k5TsUuuSwtzhEYXYJWDsrrg/SVm5AjmwOYC0o7I=;
        b=uOzMphJSbprSZnqk7qlpcvThREpdSRrzzaDhUgDPZlSepDfOXCZEM0YkCHMVSjQBwh
         Sj6rD9mMRvdOSAR33uXrZKkiGou7q/K2Y9bKr/ZVCcllnunIXtptCHOorRgXbztXVLth
         ZZkQg0TELUwyBMP71EgEuz3bfOglyy/UaVbZ3h4zaUjvWazzfq/9cb2rGQpa9F0hmldg
         eHyTld+K3OgZWPoFmxr5e3XqtIkLfn6H23VHTJDnDhmTeVL3ArUIyS2pXndMldvbhjRE
         19XEoX1HC3K5WZ7YGp69VsKOKFEns/64mStoxhlybEzp7fcN+qnIGwRN5saTf3pfuKry
         YDVg==
X-Gm-Message-State: APt69E1LTlKW3RWbfiW8AdWVxrrdJO5bB4HHoW4JVEUZIeOc8hgBMoPJ
        iT9qgs019pTUxWVxWeta3InBlIFd9mCkxEGrghnZ
X-Google-Smtp-Source: AAOMgpf2FzFNqtApRTNgdBDYzeDXCTY1TlPqET2aANvJquqMgL2mwKJGs+A3Gcv26reEuwpSraOHVveLIZvzBnnXQRY=
X-Received: by 2002:a19:d5c7:: with SMTP id m190-v6mr8001233lfg.12.1530232712454;
 Thu, 28 Jun 2018 17:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180625163425.216965-1-jannh@google.com> <9d5d0cb7-5875-0814-835b-097db650b6a1@tycho.nsa.gov>
 <CAHC9VhQ7ep3HSw8iqWBsiW0hhZ-drVtk7bW1rA1uAyUrbm3PqA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ7ep3HSw8iqWBsiW0hhZ-drVtk7bW1rA1uAyUrbm3PqA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 28 Jun 2018 20:38:21 -0400
Message-ID: <CAHC9VhTcncUn3CgAgG-FiXyyoNiq5DdHF1cSYJeWpu8PvRXucw@mail.gmail.com>
Subject: Re: [PATCH] selinux: move user accesses in selinuxfs out of locked regions
To:     jannh@google.com
Cc:     Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        security@kernel.org, linux-kernel@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 8:23 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jun 26, 2018 at 8:15 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 06/25/2018 12:34 PM, Jann Horn wrote:
> > > If a user is accessing a file in selinuxfs with a pointer to a userspace
> > > buffer that is backed by e.g. a userfaultfd, the userspace access can
> > > stall indefinitely, which can block fsi->mutex if it is held.
> > >
> > > For sel_read_policy(), remove the locking, since this method doesn't seem
> > > to access anything that requires locking.
> > >
> > > For sel_read_bool(), move the user access below the locked region.
> > >
> > > For sel_write_bool() and sel_commit_bools_write(), move the user access
> > > up above the locked region.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Jann Horn <jannh@google.com>
> >
> > Only question I have is wrt the Fixes line, i.e. was this an issue until userfaultfd was introduced, and if not,
> > do we need it to be back-ported any further than the commit which introduced it.
>
> Considering we are talking about v2.6.12 I have to wonder if anyone is
> bothering with backports for kernels that old.  Even the RHEL-5.x
> based systems are at least on v2.6.18.
>
> Regardless, I think this is fine to merge as-is; thanks everyone.

FYI, I did have to remove the "fsi" variable from sel_read_policy() to
keep the compiler happy.  Please double check to make sure your code
compiles cleanly in the future.

-- 
paul moore
www.paul-moore.com
