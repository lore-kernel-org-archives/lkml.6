Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6425C4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1A8218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkXD9mqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfBKQWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:22:03 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42028 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfBKQWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:22:02 -0500
Received: by mail-qk1-f195.google.com with SMTP id y140so6743461qkb.9;
        Mon, 11 Feb 2019 08:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cW7tWR8jGU6zZ9qwHpZvVc4mElp1JZn1A2mPsX4Px5E=;
        b=jkXD9mqfWW3yXbG8w0LZFxPfA2yQmsA507fb3oPSKudLwSr06rY7lKpkWsvp8gyDJn
         mje9T/31t+keyaV3PDToa5jAAqyUX0WsaHAXW8uu5aNkYlsraE48lbYzzv6U9yDLV4DE
         D1bba6Y9KgNsImsmZRm+vMjRY41YyAa9YO9js9RqBukfHHYtFTWkW98IqIoxCMaMN/Jy
         vVWRtyqmN6jy+0UPJTNdAW1oupFbp1TsG5ZjpU0A2TY+Fxr9Qs3klWX3R0VgbUdMWgAz
         CME4zS9naGnbE6twvA7xihqe1qIy1F+npUtRSk0Xs6lBYc9TlTuXH6bKsmQ7IHT+f8z0
         ppVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=cW7tWR8jGU6zZ9qwHpZvVc4mElp1JZn1A2mPsX4Px5E=;
        b=PM61GKxT0PsaSXt5aBfDDF6IrolxV6Jbj28Nh4NcihakQPAYERhv0LbExMho7rvHUR
         uJ3CsxN0NT4FVwKWsXeSV37f6CpkcbDpBTLkT9RWAijrdj6eywwjX6bXa7BlFLw6bmod
         r3wmUwZRRJ1fyj/P9a7I/LWjL7LFJbENEu7yYqwFb0EcrE5LO46tCHNaxnBEZmRc6aUY
         8Rp9IOUoxHvR60Lr8FH8s2x2OjLriRFGvyKgDKxJNtb6qUXpzJJaFTN5N7Bz9B5OaBmb
         HTgOPJCJpMkunmKHzVmda6BQrXTx40cv5sLltMYxrtldgqsN7KocSEM/27kgY9lvZTPR
         Rk/w==
X-Gm-Message-State: AHQUAuYZ0GnvBJmVmltCiRUgFxUQB/RirNFR3GtNnrmv5SuX5DC4dqBW
        ve6aSSj74DQg/XGeKeYWuutGx6ZwO0OZbzBi+O4=
X-Google-Smtp-Source: AHgI3IbCQXC33QsGEJonTzW4/yy3yyPzPYZR6ATkgkmltAkIDqUglEFH2FjqqLfUZUyNdEMGxCHBmpiXk0ANAVD3Izs=
X-Received: by 2002:a37:5807:: with SMTP id m7mr26465615qkb.141.1549902121590;
 Mon, 11 Feb 2019 08:22:01 -0800 (PST)
MIME-Version: 1.0
References: <20190207053740.26915-1-dave@stgolabs.net> <20190207053740.26915-2-dave@stgolabs.net>
 <20190211161529.uskq5ca7y3j5522i@linux-r8p5>
In-Reply-To: <20190211161529.uskq5ca7y3j5522i@linux-r8p5>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Mon, 11 Feb 2019 17:21:49 +0100
Message-ID: <CAJ+HfNj3jwqT7980grynDp7sPj6XL8_JFgs5AK6Zhhj7spRpTg@mail.gmail.com>
Subject: Re: [PATCH v2] xsk: share the mmap_sem for page pinning
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
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

Den m=C3=A5n 11 feb. 2019 kl 17:15 skrev Davidlohr Bueso <dave@stgolabs.net=
>:
>
> Holding mmap_sem exclusively for a gup() is an overkill.
> Lets share the lock and replace the gup call for gup_longterm(),
> as it is better suited for the lifetime of the pinning.
>

Thanks for the cleanup!

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

> Cc: David S. Miller <davem@davemloft.net>
> Cc: Bjorn Topel <bjorn.topel@intel.com>
> Cc: Magnus Karlsson <magnus.karlsson@intel.com>
> CC: netdev@vger.kernel.org
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  net/xdp/xdp_umem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> index 5ab236c5c9a5..e7fa8d0d7090 100644
> --- a/net/xdp/xdp_umem.c
> +++ b/net/xdp/xdp_umem.c
> @@ -265,10 +265,10 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem=
)
>         if (!umem->pgs)
>                 return -ENOMEM;
>
> -       down_write(&current->mm->mmap_sem);
> -       npgs =3D get_user_pages(umem->address, umem->npgs,
> +       down_read(&current->mm->mmap_sem);
> +       npgs =3D get_user_pages_longterm(umem->address, umem->npgs,
>                               gup_flags, &umem->pgs[0], NULL);
> -       up_write(&current->mm->mmap_sem);
> +       up_read(&current->mm->mmap_sem);
>
>         if (npgs !=3D umem->npgs) {
>                 if (npgs >=3D 0) {
> --
> 2.16.4
>
