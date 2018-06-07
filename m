Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1L5HO6NeGVuoMQAAmS7hNA
	; Thu, 07 Jun 2018 16:34:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BBFA96089E; Thu,  7 Jun 2018 16:34:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4/F02d+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 384C7605A2;
	Thu,  7 Jun 2018 16:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 384C7605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753972AbeFGQev (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:34:51 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43533 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbeFGQet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:34:49 -0400
Received: by mail-qk0-f196.google.com with SMTP id g126-v6so6943931qke.10;
        Thu, 07 Jun 2018 09:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0bfsOsY3PU7s9BIBSBhk9zghXzXTYD4pSVLhenYc5Bo=;
        b=O4/F02d+Wrdhqxx3Fpf7klqzOD0bOIBRJv1b7q0wkpD+QykVFnCUcD3h2i7292zY4h
         Effqs/g2excx8ozMaO8CJXIZwK+RLKbyKk12MWuiuYA2y9eL4tY/eSDXscYFca2f1ltD
         ZrH/gJrSYyEMRRh++2sjdQ60/w88YEeDj10inGTnDBnqHOGtSddp2Ayt8WuTJ8FMQXxi
         D0OF/iiM3g/5ypcWGI7ynrOStRgp/lDvf9JHbjgcU6N///oeiyIRVXWppNEFhbSWbusY
         HT045ZTT5pQ9ESuNxbOwLWPvwkXb7XSJuBTbGVT+kQXMAYvvQcVTwZT8DPf33UJ8a4HK
         dWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0bfsOsY3PU7s9BIBSBhk9zghXzXTYD4pSVLhenYc5Bo=;
        b=n3AQ2ZN9H0V7oCdFf7b6r+vme7AhNj/dqqbuPTa9KjqUAQORTVCTg9aks2YKpUb1E/
         rtmwaDSILtQdh2f3xOXZ+Ozz2yAiWmzh/zrytZiuc3Mcdad5oolh5UlXyyGc/87ScClt
         Jk+Hl1zOMP2lZzmjXYR4Hl5Lrhq9TeaC9v+Purj7ttn1dwL/C/BCz5NmFXWhURqyxe2G
         fiNdKpAgrCJViP/bYiih3FUyRwh4ZZoL8UwTod8iUbdJ9DwFo+V68ZXfV6IvMFseluJw
         oNmVmqW89E8PC8MgbvGq0gGb96vb5ADqDFTkW1kQk5j93QUilEFyD8FiNi6uVwXW7/3M
         En2Q==
X-Gm-Message-State: APt69E0LsYn9SyTpmeViRKV6SBCT5KsYYEdqV53Gz72071OYCU1oeyBV
        W8sRStHcIEphas8N4t8lh73FfbNZZGGX1cXUjB0=
X-Google-Smtp-Source: ADUXVKKHzNStcAgolDopZcCvD51S3qRQjFfGQL9DmzLL2daTliSbdss7HlULBPuvgGT7dVd8KnK8wn7bXnJMi/s9WnY=
X-Received: by 2002:a37:c20d:: with SMTP id i13-v6mr2189984qkm.255.1528389288745;
 Thu, 07 Jun 2018 09:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <1528378654-1484-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1528378654-1484-1-git-send-email-geert@linux-m68k.org>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date: Thu, 7 Jun 2018 18:34:29 +0200
Message-ID: <CAJ+HfNiciU0+4zd3ppapH12Gg_SFf9oUWTy+yafJSxCX8Mv-Dg@mail.gmail.com>
Subject: Re: [PATCH] xsk: Fix umem fill/completion queue mmap on 32-bit
To: geert@linux-m68k.org
Cc: David Miller <davem@davemloft.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>, ast@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org,
        Netdev <netdev@vger.kernel.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den tors 7 juni 2018 kl 15:37 skrev Geert Uytterhoeven <geert@linux-m68k.or=
g>:
>
> With gcc-4.1.2 on 32-bit:
>
>     net/xdp/xsk.c:663: warning: integer constant is too large for =E2=80=
=98long=E2=80=99 type
>     net/xdp/xsk.c:665: warning: integer constant is too large for =E2=80=
=98long=E2=80=99 type
>
> Add the missing "ULL" suffixes to the large XDP_UMEM_PGOFF_*_RING values
> to fix this.
>
>     net/xdp/xsk.c:663: warning: comparison is always false due to limited=
 range of data type
>     net/xdp/xsk.c:665: warning: comparison is always false due to limited=
 range of data type
>
> "unsigned long" is 32-bit on 32-bit systems, hence the offset is
> truncated, and can never be equal to any of the XDP_UMEM_PGOFF_*_RING
> values.  Use loff_t (and the required cast) to fix this.
>
> Fixes: 423f38329d267969 ("xsk: add umem fill queue support and mmap")
> Fixes: fe2308328cd2f26e ("xsk: add umem completion queue support and mmap=
")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Compile-tested only.
> ---
>  include/uapi/linux/if_xdp.h | 4 ++--
>  net/xdp/xsk.c               | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> index 1fa0e977ea8d0224..caed8b1614ffc0aa 100644
> --- a/include/uapi/linux/if_xdp.h
> +++ b/include/uapi/linux/if_xdp.h
> @@ -63,8 +63,8 @@ struct xdp_statistics {
>  /* Pgoff for mmaping the rings */
>  #define XDP_PGOFF_RX_RING                        0
>  #define XDP_PGOFF_TX_RING               0x80000000
> -#define XDP_UMEM_PGOFF_FILL_RING       0x100000000
> -#define XDP_UMEM_PGOFF_COMPLETION_RING 0x180000000
> +#define XDP_UMEM_PGOFF_FILL_RING       0x100000000ULL
> +#define XDP_UMEM_PGOFF_COMPLETION_RING 0x180000000ULL
>
>  /* Rx/Tx descriptor */
>  struct xdp_desc {
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index c6ed2454f7ce55e8..36919a254ba370c3 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -643,7 +643,7 @@ static int xsk_getsockopt(struct socket *sock, int le=
vel, int optname,
>  static int xsk_mmap(struct file *file, struct socket *sock,
>                     struct vm_area_struct *vma)
>  {
> -       unsigned long offset =3D vma->vm_pgoff << PAGE_SHIFT;
> +       loff_t offset =3D (loff_t)vma->vm_pgoff << PAGE_SHIFT;
>         unsigned long size =3D vma->vm_end - vma->vm_start;
>         struct xdp_sock *xs =3D xdp_sk(sock->sk);
>         struct xsk_queue *q =3D NULL;
> --
> 2.7.4
>

Thanks Geert!

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
