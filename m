Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C62C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2473223FFF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SLqNXA+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2473223FFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754136AbeFVKCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:02:31 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38950 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbeFVKCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:02:30 -0400
Received: by mail-it0-f49.google.com with SMTP id p185-v6so2145649itp.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 03:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=27LbBjZOHWp0cjT3ETH61MhEbHQSkIPj1OPOu0x5HXA=;
        b=SLqNXA+gktWgB2kownAs1wg5u9uSmQupHP1oN0+xORxnWZNV6DGM+AcoasAXdNlSiz
         O3INvesdYh9AF1dAv1+AcPsIzPGxFA9yhasSQJbUDwBqx9fQIt7awDGFI/AuUsNSjdsm
         CRdkMJwFm1aZragY+Qn+0feJFYcx8MR0cM8gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27LbBjZOHWp0cjT3ETH61MhEbHQSkIPj1OPOu0x5HXA=;
        b=YGjZySOtqS+lB9kXi3mpKb6dbDDgBZ1lKl/NBXPv/Lgwh2w/x0I1O84Bw0SYpUq47q
         fMktnkYJeJJA0x2CaTb8pI/BvXLmltEf9GrjEV7mjVeuo8SFiTOupWB0VjL4d/SKmosv
         E1gZRJyPExijDfERE1xn41LFTMxhmuOaGhBh5Yo1aeOmeOmDTaPT8oPjvPzbLcinvh9p
         zeGnzbSeqyLTAvCAO6l5HMJV+FTAuKarXBdtH/wl6/L/uRwzServ/D7UuKVDmDpvXrP0
         +7+tLFuOkgyz+8GMH/R5iXB16ipKHYv8wedMY9BXPF/Z3tfw0RmWA8VLTvC4DEb5abc6
         Ba8w==
X-Gm-Message-State: APt69E0n85Re416f4A6rqMWAtENXylWlKVGWVhIX1Eg2lSsaH6QcmQaY
        YVwdSRQw4jiXL92jQklx3380fU5JXMOP7AWnazcM9g==
X-Google-Smtp-Source: ADUXVKIN2MTdKhOBmduUHTgLn47770UXNqREpeXpN/sL1RnZIWlDYGwqAUbsidJtvAFUVL3NSCM+h/TFGWYrejXge4c=
X-Received: by 2002:a24:3cd7:: with SMTP id m206-v6mr921501ita.113.1529661749178;
 Fri, 22 Jun 2018 03:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180622082752.GX11011@yexl-desktop> <CA+55aFw5ghByk_zCN25G6rPPSAQma3Mh0t4s18CtLg=h6U9+Zg@mail.gmail.com>
 <20180622095608.GA12263@lst.de>
In-Reply-To: <20180622095608.GA12263@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Jun 2018 19:02:18 +0900
Message-ID: <CA+55aFyW-zN4363TOwptyzZ=6S1fDeatZMe6hYa656AJmnhmXA@mail.gmail.com>
Subject: Re: [lkp-robot] [fs] 3deb642f0d: will-it-scale.per_process_ops -8.8% regression
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <xiaolong.ye@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 6:46 PM Christoph Hellwig <hch@lst.de> wrote:
>
> > The disadvantages are obvious: every poll event now causes *two*
> > indirect branches to the low-level filesystem or driver - one to get
> > he poll head, and one to get the mask. Add to that all the new "do we
> > have the new-style or old sane poll interface" tests, and poll is
> > obviously more complicated.
>
> It already caused two

No it didn't. If the data was ready, all that got short-circuited, and
we just had that ->poll() call.

Only if you *waited* did you get the second one to check the result,
and the whole poll_wait(). You could just say "I already have the
data, there's no wait-queu to add, I'll just return immediately".

You're making this all unconditionally pessimal.

Admit it. The new interface is inferior.

> In the meantime below is an ugly patch that removes the _qproc
> indirect for ->poll only (similar patch is possible for select
> assuming the code uses select).  And for next merge window I plan
> to kill it off entirely.

You're just making the code even worse here.

Seriously, this patch is beyond ugly. The new interface is nasty shit.

Get your act together. Don't uglify and slow down everything else just
because you're concentrating only on aio.

Your reply so far just makes me more convinced this was not thought
through properly.

            Linus
