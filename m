Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64064C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35100218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFQS50W9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBGHnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 02:43:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42964 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfBGHnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 02:43:15 -0500
Received: by mail-qt1-f196.google.com with SMTP id b8so10911026qtr.9;
        Wed, 06 Feb 2019 23:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hgWiPuQktGDPbFQrOQ3Zw6WnbDS/jHeyLQ4R4JqPa1k=;
        b=sFQS50W9xOhD0g+DL/NQVoLqngbI0oniG4ARw3FONq4btMQmjVPCfS42/cOhgliKff
         mHNiWREzOlNAZQQfB6khK4OXLyIVNU1rGp1rC8pYQO2Ya0HHmKAgI8Eavkcfuy55ml52
         4olKvAZxp5sN4kexTIBg1uJWLSig2IxB4KSEnMqjYAT8HqAufCATorfSWA1Ao3SjSw3+
         43GvsJRzNyGZUiP9mOD8SxFKHP0lloRYV/lP3gCiNYwtpneDOFTPsilQvoHf8xTrr9jD
         yNI5rYE4CQQn8CXTriDBXZ/XFInKCk6BrP2/na8mpXw6X/5tobMJ4p8gBT8ORaXuevud
         g7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hgWiPuQktGDPbFQrOQ3Zw6WnbDS/jHeyLQ4R4JqPa1k=;
        b=dpCssAd0XFt9KYWagSH2DzoUZ0RKrSMtp82U9waDb/z3V0oUOUvLtNWM98/PBbEBGJ
         oaSM5UU2j0sRxUeREjnZ4kT+Lnk5y93nC4m5NtxzN58me1zAsK0VxNt1Rt0D9pldMMPn
         U58cWp6AtIS1dyp9A1XEooEvWjmLQyk7j63i+BHuhut297y5/x+TeMM4xTSJ/hBpgU6b
         jqWZXTj/mWjXdwB+e1GczSqbhcxP+7vcA6EoSq09H4Zz6LQvrhfzQtBNkXYXkdvRsPEd
         gSoDPSpZj2iKvSXOSNTZX4rtljSOxBWF4WnXHQW/NBEg6bvfS3qUbMvD1k9BvnnCpOCW
         UWHg==
X-Gm-Message-State: AHQUAua+/kleOCeqL+lisaq+H2bN//kjTR0Vwe3dhvgXSXlaAIPYObYN
        Mr46BiL4jrVYdRjyu/qKD7cvp0uacODwm1Mv1pE=
X-Google-Smtp-Source: AHgI3IbWQOMVE5pdb7AUDgZmR0M9ALEakMOW8WteZdZIB6Ntsh0TzahDpdKwo1h1zwuIehnKKjj/0e+1Mtl8buJTpho=
X-Received: by 2002:ac8:4453:: with SMTP id m19mr855654qtn.303.1549525393551;
 Wed, 06 Feb 2019 23:43:13 -0800 (PST)
MIME-Version: 1.0
References: <20190207053740.26915-1-dave@stgolabs.net> <20190207053740.26915-2-dave@stgolabs.net>
In-Reply-To: <20190207053740.26915-2-dave@stgolabs.net>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Thu, 7 Feb 2019 08:43:02 +0100
Message-ID: <CAJ+HfNg=Wikc_uY9W1QiVCONq3c1GyS44-xbrq-J4gqfth2kwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] xsk: do not use mmap_sem
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Bjorn Topel <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Netdev <netdev@vger.kernel.org>, Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den tors 7 feb. 2019 kl 06:38 skrev Davidlohr Bueso <dave@stgolabs.net>:
>
> Holding mmap_sem exclusively for a gup() is an overkill.
> Lets replace the call for gup_fast() and let the mm take
> it if necessary.
>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Bjorn Topel <bjorn.topel@intel.com>
> Cc: Magnus Karlsson <magnus.karlsson@intel.com>
> CC: netdev@vger.kernel.org
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  net/xdp/xdp_umem.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> index 5ab236c5c9a5..25e1e76654a8 100644
> --- a/net/xdp/xdp_umem.c
> +++ b/net/xdp/xdp_umem.c
> @@ -265,10 +265,8 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem)
>         if (!umem->pgs)
>                 return -ENOMEM;
>
> -       down_write(&current->mm->mmap_sem);
> -       npgs =3D get_user_pages(umem->address, umem->npgs,
> -                             gup_flags, &umem->pgs[0], NULL);
> -       up_write(&current->mm->mmap_sem);
> +       npgs =3D get_user_pages_fast(umem->address, umem->npgs,
> +                                  gup_flags, &umem->pgs[0]);
>

Thanks for the patch!

The lifetime of the pinning is similar to RDMA umem mapping, so isn't
gup_longterm preferred?


Bj=C3=B6rn

>         if (npgs !=3D umem->npgs) {
>                 if (npgs >=3D 0) {
> --
> 2.16.4
>
