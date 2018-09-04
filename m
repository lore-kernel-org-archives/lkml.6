Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA08FC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558D82077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="CjNi2+/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558D82077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeIDPEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:04:30 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39033 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeIDPE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:04:29 -0400
Received: by mail-ua1-f68.google.com with SMTP id g18-v6so2464035uam.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXLKVKrpdHaAiGg7SyFGjtz1XjDdIadRdAZPuM8b6fc=;
        b=CjNi2+/A7CV8bMoMKizrcQwS1D7uFOUPPzuD90Gf5JTNs279rd0vzj8wuCRpOb6KxA
         yDy2GusFYyyWAtAJGmyLiHVRmOi6tZ7i3gkm6a3JVq6DsFQi+4JzMI3cOB4/0fC4Ebbl
         Fo0x19DUrSGLFyq5w4lSCT0ZVnf5pArIWGqDVPsuyYhMbwxe+m1bPRWKHwdaEb9FAu2D
         Dkl1noZC1BZm+k4QyrgWglitzm21FazE90F2YM31acct+1EFRvgPUu8zddCret9Xn8Kv
         JD3fE29UMHTqUQECdzaBGfnrBXWhEv7iKpEF9YR94SU3i+cTDQdE5wrlANCI5ztLMBqH
         lkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXLKVKrpdHaAiGg7SyFGjtz1XjDdIadRdAZPuM8b6fc=;
        b=W5twfpFriKEKRFckH6oAX5wUvu7vndEn5luUaasTP/B8DyNyzGYo6/LhEnWLQ2BZxd
         X1mK9fSuVikVZQG1eIq4ptf1AUfpYIsjvwRZuUDYdOzZwFSHGS3w/D0lZCtDzaUQmbM9
         5bWrKz9Km25xySVk6R0p5OMXuKu2OgLHA9DW8br0dI8PtJ+N4sKLSGh+sgNGB9bCiqgc
         Wiylfcc3BIxtdSokG6/IfRnSpZbQEhKo5YPXnbJ/5EuJWCkUCCAKgtSm14/rQ86GJAkQ
         DlD5XYo//LApT+hizmi4kIBVbBe9SMuRxdE+MI/nMJJQsLWixoySi3m//F3GZhjuA811
         bq4w==
X-Gm-Message-State: APzg51AZwzgjnjWst2J+HIe3GaMEzDxiZWcbIBZZaiKhl6eUbdDBL5IP
        8MTNiXgNLLoHwdXdoe6pJKYVejrP4mFVBNJUvCQTrgfKzoM=
X-Google-Smtp-Source: ANB0VdZizaZ60CRxstaLymHdePvBYAgehoUR7m0N0jVqeZdc1FwY1Ul7deY4RtyfftUNHxGUMfIEcEWNtXE50nE/Q+A=
X-Received: by 2002:a67:744b:: with SMTP id p72-v6mr10224535vsc.101.1536057597403;
 Tue, 04 Sep 2018 03:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1535545877-770-5-git-send-email-hans.ml.holmberg@owltronix.com> <AE72A23A-F779-466B-89A7-846A232DD9B2@cnexlabs.com>
In-Reply-To: <AE72A23A-F779-466B-89A7-846A232DD9B2@cnexlabs.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Tue, 4 Sep 2018 12:39:46 +0200
Message-ID: <CANr-nt3kvXVMSeaEZf3hZo2tR31G+h1B9X300Ew+Ys5QiK02QQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] lightnvm: pblk: add tracing for chunk resets
To:     Javier Gonzalez <javier@cnexlabs.com>
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:09 PM Javier Gonzalez <javier@cnexlabs.com> wrote:
>
> > On 29 Aug 2018, at 14.31, Hans Holmberg <hans.ml.holmberg@owltronix.com> wrote:
> >
> > From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >
> > Trace state of chunk resets.
> >
> > Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> > ---
> > drivers/lightnvm/pblk-core.c  | 12 ++++++++++++
> > drivers/lightnvm/pblk-trace.h | 31 +++++++++++++++++++++++++++++++
> > drivers/lightnvm/pblk.h       |  6 ++++++
> > 3 files changed, 49 insertions(+)
> >
> > diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> > index 566a5d3165ee..b874001d1175 100644
> > --- a/drivers/lightnvm/pblk-core.c
> > +++ b/drivers/lightnvm/pblk-core.c
> > @@ -90,9 +90,15 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
> >       atomic_dec(&line->left_seblks);
> >
> >       if (rqd->error) {
> > +             trace_pblk_chunk_reset(pblk_disk_name(pblk),
> > +                             &rqd->ppa_addr, PBLK_CHUNK_RESET_FAILED);
> > +
> >               chunk->state = NVM_CHK_ST_OFFLINE;
> >               pblk_mark_bb(pblk, line, rqd->ppa_addr);
> >       } else {
> > +             trace_pblk_chunk_reset(pblk_disk_name(pblk),
> > +                             &rqd->ppa_addr, PBLK_CHUNK_RESET_DONE);
> > +
> >               chunk->state = NVM_CHK_ST_FREE;
> >       }
> >
> > @@ -958,6 +964,9 @@ int pblk_line_erase(struct pblk *pblk, struct pblk_line *line)
> >               WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
> >               spin_unlock(&line->lock);
> >
> > +             trace_pblk_chunk_reset(pblk_disk_name(pblk),
> > +                             &ppa, PBLK_CHUNK_RESET_START);
> > +
>
> Can you move this inside of pblk_blk_erase_sync() instead? I was looking
> at the code now to implement a different thing and it is confusing to
> see tracing inside erase_async and not in erase_sync.
>

Fixed in a V2. Thanks.
