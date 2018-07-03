Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EF9C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A6B247C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJPJeSeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A6B247C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbeGCX5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:57:02 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36968 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753366AbeGCX5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:57:00 -0400
Received: by mail-oi0-f53.google.com with SMTP id k81-v6so7290676oib.4;
        Tue, 03 Jul 2018 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zUwEOA/++hMtXNS08vLjlbRPZCh9geuRo3n4KUi0fQI=;
        b=rJPJeSeT+kvwjZIiIuMZKMaRKxbKI4B3M7AYawDbvxQ5Bjt+S0BIShDqh/vlofHgGu
         HiFwDqoTWHcCIbKC3bb6xe84MevqmRz6bZ45d/8akX86k6iy0HewvHqDUhgEi5GaAGsp
         mXJdV7CF8awMxoXJKaBDUkIvR/FGiDfOwHKHnd8h1YgtDPaiEFJElYFwgOIHEtKoIomE
         aQdNtrGtMZ4kGtO1RKkSbsEYDa3XJJugMoWIgkMnFJ3blIbse5xnKqLFc8K/fyW0BkGo
         rqlPd3NoUzFtoO5FPj0YpfC+T9avFigIWFqx1OzJKpdV7oNQj2gfecnXpdqinOq5hj9S
         zCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zUwEOA/++hMtXNS08vLjlbRPZCh9geuRo3n4KUi0fQI=;
        b=QmJ1GqahSBeUwbXb+07heOjpY8JgKC2SuA4Pwnc0NufNtFP9+tQomUVZw6dQrKzSPi
         P3XFdQcRk6FvCXgmu5jNkRqJFoSvdRMupgOxqS/q8ztk5yf3U9a5xeM+GTgI9SwsaTrK
         +WyhTzqfYGH2KjKhx5he64e8QZFQASJE/xmrHONp7RYHZqZMwxOX9K/fey1e97Asyzja
         yoOy/7LeTQAI6GokKcbM3FYeBIDcnm6AXti5GfY2N04iKvdHHmpGOhXNb/O8FnPKWDZ1
         Z5j4wDsins1dZCHtgSkwNSKf3rIV1qq1YMnocnSc7n4/vpIBP48/vm5jj0umuimOpspK
         PYHg==
X-Gm-Message-State: APt69E34qSWo4Srxeaf6VE9h4ul5uGr+B32vnAbIofJp6y8KU1apaBmK
        059YtDBq8lzQTDWnERwSbFyi+FFuQ5i+5/jYj3I=
X-Google-Smtp-Source: AAOMgpdxMMSUesDFAV3/5Jzls7yzPQL0jTNpA8o8mFcw0kmJ5Ra+MyFtukvY2NjPGgAEhmCz8Rb8M0BmDBDbgnlLYaI=
X-Received: by 2002:aca:3ac6:: with SMTP id h189-v6mr24312041oia.336.1530662219504;
 Tue, 03 Jul 2018 16:56:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 16:56:58 -0700 (PDT)
In-Reply-To: <81e128b6-b365-b2c8-d86e-50f40024eb9d@deltatee.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com> <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <CAHp75VefGpNkF0ANA_wBm627aZXS60NPZ9VAdOYqr_iZ8Hvpzw@mail.gmail.com>
 <CAOMZO5Ayn4ik4F3sWhTo9Q5DGHG6nuf71M3DLsM+heMi0TFjVg@mail.gmail.com> <81e128b6-b365-b2c8-d86e-50f40024eb9d@deltatee.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Jul 2018 20:56:58 -0300
Message-ID: <CAOMZO5Dyk+shJFRFimZOyvJkS=OsNUbfjtLUoqSdZ6bQVCDTUQ@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-ntb@googlegroups.com,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 6:16 PM, Logan Gunthorpe <logang@deltatee.com> wrote:

> Is this a virtual machine? And if so, any chance we can get an image and
> qemu command line to run it ourselves?

This is a real imx6 development board. I have never tried it on qemu.
Let me see if I can reproduce it on quemu.
