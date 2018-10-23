Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF401C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08A6207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYDroE7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08A6207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeJWUBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:01:44 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:38003 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbeJWUBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:01:43 -0400
Received: by mail-vk1-f195.google.com with SMTP id j20so242271vke.5;
        Tue, 23 Oct 2018 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOlkRSKN//LyAA072zP7IYIF2xXwxuJvCbHoMHKNPNw=;
        b=BYDroE7w4YSnLTWNqY1j17nvgv6kRBxi05TEnRZKdlnGULQ+ZoKoblQr6ky+OdBK5i
         xnLn7zG5D3aCOMWn+QYzOiazXC1V/Xr3ulqNPYZwijXS5Ep27lR5ZrZvb6GAag+jhxi9
         fsgwmnXOYxtC+DxrbqPKrs6OSg+ixIaDHbmcT9Gsk2UZFAmET76t3wZ7EqrKJ/DRosvx
         yvozs3Xn7tuhEEa2uJTZAeCCfz8pW5VHDAhr4/thw+kxWIdSKN6UX/6diQNNgsDWhBNB
         Jse7kkuCYbhurxv2/3MG3B6725SCPDbPrB/W6/BfHT/B8+4Mr+uw+UP5ds3NBDgddw7B
         X4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOlkRSKN//LyAA072zP7IYIF2xXwxuJvCbHoMHKNPNw=;
        b=LIkUUaOHQIKC3JZyQMIqy7kpaf7GnIDRWFI/I7i6PJPmQjldZpJL3GrdmseEfnX2cf
         apQhVi6zitEzJeRGbPX7YJddE9DfiNF0/T5u/K7tuPOtAs4ZB9LhmnUCM6jo7CXFdyk1
         azWIvGnIPfMnuYB92NNjkFT3HNEMk1ZQK7ThUeMFT+m5ODOLydsO9AVam8waLiw55Uiz
         utGLjkhUsNiN3ZTC4nHBfX4FE6hUMCNzGD5GsuGzPUALCunhuAkDf2EJyRKsG8wK0z4H
         oE0kr5CRk8zTVTZyqNvot+ZPKZ8qr2sWPmIUAajIyAEFRskCo1VcAZe2sxxqPuWmNrcG
         QFFg==
X-Gm-Message-State: ABuFfog9u3TRSzlKZBrENT77fyakXI810jtr+hWShXNOxyGXtDsE7tkQ
        /8aiV4H1lrZYBZrxkWeLl0UTQH0xynQV/FfA3Ok=
X-Google-Smtp-Source: ACcGV61DAjUErAn2jr9QNeJEaIWi7rreXV9Jt4g0ljeBteiHlPufiCZJT+pcKXI7AcdH3E/XHeqnMQg2YFLzmlvUwUE=
X-Received: by 2002:a1f:9fcd:: with SMTP id i196mr20299537vke.77.1540294716624;
 Tue, 23 Oct 2018 04:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181023085314.3561-1-lhenriques@suse.com>
In-Reply-To: <20181023085314.3561-1-lhenriques@suse.com>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Tue, 23 Oct 2018 19:38:24 +0800
Message-ID: <CAAM7YA=k5h-PdqACkmWGtiu+5cpRki0FWyMW4ukyzSgdMKGa6w@mail.gmail.com>
Subject: Re: [PATCH] ceph: add destination file data sync before doing any
 remote copy
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Zheng Yan <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 5:08 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> If we try to copy into a file that was just written, any data that is remote
> copied will be overwritten by our buffered writes once they are flushed.  When
> this happens, the call to invalidate_inode_pages2_range will also return a
> -EBUSY error.
>
> This patch fixes this by also sync'ing the destination file before starting any
> copy.
>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/file.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index f788496fafcc..b4607baa8969 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1932,10 +1932,17 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
>         if (!prealloc_cf)
>                 return -ENOMEM;
>
> -       /* Start by sync'ing the source file */
> +       /* Start by sync'ing the source and destination files */
>         ret = file_write_and_wait_range(src_file, src_off, (src_off + len));
> -       if (ret < 0)
> +       if (ret < 0) {
> +               dout("failed to write src file (%zd)\n", ret);
> +               goto out;
> +       }
> +       ret = file_write_and_wait_range(dst_file, dst_off, (dst_off + len));
> +       if (ret < 0) {
> +               dout("failed to write dst file (%zd)\n", ret);
>                 goto out;
> +       }
>
>         /*
>          * We need FILE_WR caps for dst_ci and FILE_RD for src_ci as other

Applied, thanks

Yan, Zheng
