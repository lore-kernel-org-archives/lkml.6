Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E703C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0682087F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buj8fO2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfAEK6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 05:58:12 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:33884 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfAEK6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 05:58:12 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so3281544itd.1;
        Sat, 05 Jan 2019 02:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0JpiVsH1BCkuaG8RxMJDYvF0OfDV/ul7UkqCUuHXCQc=;
        b=buj8fO2H41WvQobehCsceFfz1eEGBw7Pfa8rvEy0W6iVs7YfAeNocVzmxx6eZQ+p97
         i33EpET+eFI26NcR1bTxjdAOSaVkXqiZG0iXgP6f8Brt2anI9WS33V082yxDa5oFaJPM
         UP3ADli5SuMvdOf3ZzymmzFfKS9jBXqmJZwiEtsfTpXl0ipE6jw1hmhD54YPwFBUFaE+
         YeOL0Xt82C283vV21Au8iAr2GuR0yuW8rvDK1e1k2zA3UJRCzj4bLaoJn7hSs/+AfU6h
         fN2J5+lL4TMAsq3fZWoqTCEwHL3JeDOS7qjKpmoL5KtEbGQ5zzAYOzxVShnX4ZHr7ZE+
         r0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0JpiVsH1BCkuaG8RxMJDYvF0OfDV/ul7UkqCUuHXCQc=;
        b=JxYsKG2x9a+oy/iEngZPLkUpUUhdoNie1/923H/4s5truRBCyp1R2pRovd8vCXLdWP
         J7rAyXC6oKh6Affst8uqpYGlVfoqG6w65rMGWcqh/KpkCagAepzEjcHPPj/44uSR4Yas
         HwrlI6AzQSOxKvsAPvG53qCPmAEjoW0QJA+BlBKF+C03MYqtRH/bVffJv4MJRhUr8mS4
         ARgXfpaQFfEI0hImpvZlc7/dOYYzfv4lszWLwxuWTjLH5PnvP7E2OpARjR/h5P7FAfJD
         d5G5ex+R47FATOjTzC7hRN7/nNr9FuyDPbR3nnsTow3pjpaRdWg3aIKjfGELxWrOc9UM
         fD2g==
X-Gm-Message-State: AJcUukdu0R5c5gQXAQ9qlyiqt9D5xPK5ZWqewM1IrwjNscGEe+BUfzMz
        tIKwh8ORkRbDCmBFO1bOcku+Wsqzr+Yo1mIUDMI=
X-Google-Smtp-Source: ALg8bN68SzJ+Raqk+0lUiitH2r5ZHaYVeo8nEOQdIV9nwJymViop7Um3g2tgcwmngpd5IZOsY/PI+84cAsNV+6GAwZE=
X-Received: by 2002:a24:1aca:: with SMTP id 193mr3086828iti.150.1546685890184;
 Sat, 05 Jan 2019 02:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20190104193029.GA15903@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190104193029.GA15903@jordon-HP-15-Notebook-PC>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Sat, 5 Jan 2019 11:58:19 +0100
Message-ID: <CAOi1vP_bgMmQyvm2Gd-oBY5kTZuQBMvj0xKyyzDecvhUfypXDw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/addr.c: Convert to use vmf_error()
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 8:26 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> This code is converted to use vmf_error().
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  fs/ceph/addr.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 8eade7a..fa2a85d 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1495,10 +1495,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
>                 if (err < 0 || off >= i_size_read(inode)) {
>                         unlock_page(page);
>                         put_page(page);
> -                       if (err == -ENOMEM)
> -                               ret = VM_FAULT_OOM;
> -                       else
> -                               ret = VM_FAULT_SIGBUS;
> +                       ret = vmf_error(err);
>                         goto out_inline;
>                 }
>                 if (err < PAGE_SIZE)

Applied.

Thanks,

                Ilya
