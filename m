Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9FDC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E8A2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2BBJ5zQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E8A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeKAKm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:42:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36839 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeKAKm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:42:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id j22-v6so4688143pfh.3;
        Wed, 31 Oct 2018 18:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GU1ioPxTyrjVE/jzOFBKkMcDEXxiiSzRJyn0kDmOMoE=;
        b=o2BBJ5zQgvgOFpWyUaGvaMxm6EprRBnl91Z0VVEud0W6PyKSfnzhJcOM9cAblCM4ZC
         wn6MTbdw7FP83aB9H5tvQcoFyI4y8+BFpLxD5ssz61cqVIhe/opfo8leY4saxx0o94Dv
         ClybdUKCEojt4ah3AO4cihsa64oTf7bJclyhDQ0uvxLsPtqRxhQwBzQC0/EA4p10ku4x
         JbISYxlEZyK/MBiaKloBgdJxxzNCSLAwhmB7SjA7uZZNgnY1m6xw3taly2PsTGf8btDI
         8SLyyXB89LzOle64O4k+5MnnKNEyguREOC2OxL3aPrJ5b/A3R9QkrDY/Y91cuki8qq5x
         z5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GU1ioPxTyrjVE/jzOFBKkMcDEXxiiSzRJyn0kDmOMoE=;
        b=rSRjTABJ9nH3eASQ1OERANOTbi20m/wepM1zcEHXiMWRaM6icvsp0iGHkuudtc4964
         4gHuDCl7aozW14rPcWBXIju2mxCAvzxJfyfVD2EbolAFEE+tq3/iYGwfsBio7aPkqFYb
         9RoK0N0qdS/Pz2J5xjbQCzeyv+JYjj+nalgPxHMQ8/V7f4DAM9RwcV0jKg8qmFEA1Jmg
         M/ZM7Jphtdnk/OC9K1q3HwpdZfqSrGCZi7qxPU8Oku6Xh0KmT+ArF56fs2C51ynSijwa
         A9rnvrbqj1d6sykWtEyA6G+iUscjdJ0RXhe7nIffkrVvTaZgs9oQZ3fh/VgXA3kBpX8T
         w34w==
X-Gm-Message-State: AGRZ1gI/6lzg9sqqRnRNAYzQR/23P7Us9COpk1rQYTc5NCO2muEwEzHc
        hPBLs84gQCdDsdxJ89h5wV0IkEXyiDMXjgqPr3rpKA==
X-Google-Smtp-Source: AJdET5cEkqA1CUYGrD6LwTte9qhqMOn+/wsy9eDTI23nD1rF3uhoq+/K68/EJwJeF/stLBMr0unNvjtHK3r69AAlxZU=
X-Received: by 2002:a65:6684:: with SMTP id b4mr5375507pgw.55.1541036500738;
 Wed, 31 Oct 2018 18:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181031221311.2596-1-longli@linuxonhyperv.com> <20181031221311.2596-3-longli@linuxonhyperv.com>
In-Reply-To: <20181031221311.2596-3-longli@linuxonhyperv.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 31 Oct 2018 20:41:29 -0500
Message-ID: <CAH2r5mu0KcrHcfmdBgM4fz7qtrN8xa=A3SRxt+CupnT=iLgR9w@mail.gmail.com>
Subject: Re: [Patch v4 3/3] CIFS: Add direct I/O functions to file_operations
To:     Long Li <longli@microsoft.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

made minor cleanup to patch 1 and 2, added Ronnie's reviewed to patch
3, and tentatively merged to cifs-2.6.git for-next
On Wed, Oct 31, 2018 at 5:16 PM Long Li <longli@linuxonhyperv.com> wrote:
>
> From: Long Li <longli@microsoft.com>
>
> With direct read/write functions implemented, add them to file_operations.
>
> Dircet I/O is used under two conditions:
> 1. When mounting with "cache=none", CIFS uses direct I/O for all user file
> data transfer.
> 2. When opening a file with O_DIRECT, CIFS uses direct I/O for all data
> transfer on this file.
>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  fs/cifs/cifsfs.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index 62f1662..f18091b 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1113,9 +1113,8 @@ const struct file_operations cifs_file_strict_ops = {
>  };
>
>  const struct file_operations cifs_file_direct_ops = {
> -       /* BB reevaluate whether they can be done with directio, no cache */
> -       .read_iter = cifs_user_readv,
> -       .write_iter = cifs_user_writev,
> +       .read_iter = cifs_direct_readv,
> +       .write_iter = cifs_direct_writev,
>         .open = cifs_open,
>         .release = cifs_close,
>         .lock = cifs_lock,
> @@ -1169,9 +1168,8 @@ const struct file_operations cifs_file_strict_nobrl_ops = {
>  };
>
>  const struct file_operations cifs_file_direct_nobrl_ops = {
> -       /* BB reevaluate whether they can be done with directio, no cache */
> -       .read_iter = cifs_user_readv,
> -       .write_iter = cifs_user_writev,
> +       .read_iter = cifs_direct_readv,
> +       .write_iter = cifs_direct_writev,
>         .open = cifs_open,
>         .release = cifs_close,
>         .fsync = cifs_fsync,
> --
> 2.7.4
>


-- 
Thanks,

Steve
