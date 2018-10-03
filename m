Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0B2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2864C20644
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqExQ1Qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2864C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeJCSDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:03:35 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38624 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbeJCSDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:03:35 -0400
Received: by mail-it1-f196.google.com with SMTP id i76-v6so8216140ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 04:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bLjRDio3bV/7rTJCHky/RMEdZwoNZ7bJA/E3nJqT7qs=;
        b=XqExQ1Qd1D8AXoRHohHKQLTylyUS4bluGfb72Vfiibr/AyvKUvHefKLSobWbq4svEX
         G12u7i0sY7jZEE2v4v78sNCq5wxooKiaZEneBHqfF6mKFaidvpqNXbe5Cpo9voAW/EO7
         7OOK2SbPFp6fv7YK4ritoUNlvgbAhhlI/b2VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bLjRDio3bV/7rTJCHky/RMEdZwoNZ7bJA/E3nJqT7qs=;
        b=YMUlB1aYlSfknhj5Uy3EHb0e1xj8K2Pg//2VFq/MityZKb72Xkonmip0N1gIT0sHhl
         EhsqTJcO2dxTAU6jCMV95hRl5azZVjCk/wziwHZUugOyLEqUTb+DtHLeXphZ5qcSg/Y3
         vGp5iWmHk3tA1dlYns7YnW25w3pWy4BP9u3t8PdMz88tBWd72sqMXRvGhLjim5EuQPnt
         MqmtMYaVnoTMGQfS5Sdq5vQ3B+FIECg1noVL8mUHN5MVm9L4/lQ1+ufOM1JsKS+GE4ZD
         mfOwwc6AsuRM0roCaSgj5mch9XVf+TU9CuAZP2HAeBNsJfwgH6whgoa4dEfkNRoHBrMZ
         9VkA==
X-Gm-Message-State: ABuFfoiSwLT8UyIFmV2OJSrnNfhmyF3xm1FN4pobh3V5TbPsEkK42lOL
        jXl8/7PIVdbXe4nRwdupywmvDswxs++XmY1LaFGklA==
X-Google-Smtp-Source: ACcGV61OtLZoxIUVTc/esa7StoVufup/Qkrlj0qqcVCCdkXRddgQ1XGGjaD7/vrngPJOmCWNU1vaU/BbIaK4g5Q0Cmo=
X-Received: by 2002:a24:57cb:: with SMTP id u194-v6mr864141ita.148.1538565338697;
 Wed, 03 Oct 2018 04:15:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Wed, 3 Oct 2018 04:15:38 -0700 (PDT)
In-Reply-To: <20180925145622.29959-24-Jason@zx2c4.com>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-24-Jason@zx2c4.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 3 Oct 2018 13:15:38 +0200
Message-ID: <CAKv+Gu-oCH4D_otvMk+R_6z_p73Le90PkdQUUPnT6q0kWVL4Jw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 23/23] net: WireGuard secure network tunnel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 September 2018 at 16:56, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> WireGuard is a layer 3 secure networking tunnel made specifically for
> the kernel, that aims to be much simpler and easier to audit than IPsec.
...
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: David Miller <davem@davemloft.net>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> ---
>  MAINTAINERS                                  |   8 +
>  drivers/net/Kconfig                          |  30 +
>  drivers/net/Makefile                         |   1 +
>  drivers/net/wireguard/Makefile               |  18 +
>  drivers/net/wireguard/allowedips.c           | 404 ++++++++++
>  drivers/net/wireguard/allowedips.h           |  55 ++
>  drivers/net/wireguard/cookie.c               | 234 ++++++
>  drivers/net/wireguard/cookie.h               |  59 ++
>  drivers/net/wireguard/device.c               | 438 +++++++++++
>  drivers/net/wireguard/device.h               |  65 ++
>  drivers/net/wireguard/hashtables.c           | 209 +++++
>  drivers/net/wireguard/hashtables.h           |  63 ++
>  drivers/net/wireguard/main.c                 |  65 ++
>  drivers/net/wireguard/messages.h             | 128 +++
>  drivers/net/wireguard/netlink.c              | 606 ++++++++++++++
>  drivers/net/wireguard/netlink.h              |  12 +
>  drivers/net/wireguard/noise.c                | 784 +++++++++++++++++++
>  drivers/net/wireguard/noise.h                | 129 +++
>  drivers/net/wireguard/peer.c                 | 191 +++++
>  drivers/net/wireguard/peer.h                 |  87 ++
>  drivers/net/wireguard/queueing.c             |  52 ++
>  drivers/net/wireguard/queueing.h             | 193 +++++
>  drivers/net/wireguard/ratelimiter.c          | 220 ++++++
>  drivers/net/wireguard/ratelimiter.h          |  19 +
>  drivers/net/wireguard/receive.c              | 595 ++++++++++++++
>  drivers/net/wireguard/selftest/allowedips.h  | 663 ++++++++++++++++
>  drivers/net/wireguard/selftest/counter.h     | 103 +++
>  drivers/net/wireguard/selftest/ratelimiter.h | 178 +++++
>  drivers/net/wireguard/send.c                 | 420 ++++++++++
>  drivers/net/wireguard/socket.c               | 432 ++++++++++
>  drivers/net/wireguard/socket.h               |  44 ++
>  drivers/net/wireguard/timers.c               | 256 ++++++
>  drivers/net/wireguard/timers.h               |  30 +
>  drivers/net/wireguard/version.h              |   1 +
>  include/uapi/linux/wireguard.h               | 190 +++++
>  tools/testing/selftests/wireguard/netns.sh   | 499 ++++++++++++
>  36 files changed, 7481 insertions(+)
>  create mode 100644 drivers/net/wireguard/Makefile
>  create mode 100644 drivers/net/wireguard/allowedips.c
>  create mode 100644 drivers/net/wireguard/allowedips.h
>  create mode 100644 drivers/net/wireguard/cookie.c
>  create mode 100644 drivers/net/wireguard/cookie.h
>  create mode 100644 drivers/net/wireguard/device.c
>  create mode 100644 drivers/net/wireguard/device.h
>  create mode 100644 drivers/net/wireguard/hashtables.c
>  create mode 100644 drivers/net/wireguard/hashtables.h
>  create mode 100644 drivers/net/wireguard/main.c
>  create mode 100644 drivers/net/wireguard/messages.h
>  create mode 100644 drivers/net/wireguard/netlink.c
>  create mode 100644 drivers/net/wireguard/netlink.h
>  create mode 100644 drivers/net/wireguard/noise.c
>  create mode 100644 drivers/net/wireguard/noise.h
>  create mode 100644 drivers/net/wireguard/peer.c
>  create mode 100644 drivers/net/wireguard/peer.h
>  create mode 100644 drivers/net/wireguard/queueing.c
>  create mode 100644 drivers/net/wireguard/queueing.h
>  create mode 100644 drivers/net/wireguard/ratelimiter.c
>  create mode 100644 drivers/net/wireguard/ratelimiter.h
>  create mode 100644 drivers/net/wireguard/receive.c
>  create mode 100644 drivers/net/wireguard/selftest/allowedips.h
>  create mode 100644 drivers/net/wireguard/selftest/counter.h
>  create mode 100644 drivers/net/wireguard/selftest/ratelimiter.h
>  create mode 100644 drivers/net/wireguard/send.c
>  create mode 100644 drivers/net/wireguard/socket.c
>  create mode 100644 drivers/net/wireguard/socket.h
>  create mode 100644 drivers/net/wireguard/timers.c
>  create mode 100644 drivers/net/wireguard/timers.h
>  create mode 100644 drivers/net/wireguard/version.h
>  create mode 100644 include/uapi/linux/wireguard.h
>  create mode 100755 tools/testing/selftests/wireguard/netns.sh
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5967c737f3ce..32db7ebad86e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15823,6 +15823,14 @@ L:     linux-gpio@vger.kernel.org
>  S:     Maintained
>  F:     drivers/gpio/gpio-ws16c48.c
>
> +WIREGUARD SECURE NETWORK TUNNEL
> +M:     Jason A. Donenfeld <Jason@zx2c4.com>
> +S:     Maintained
> +F:     drivers/net/wireguard/
> +F:     tools/testing/selftests/wireguard/
> +L:     wireguard@lists.zx2c4.com
> +L:     netdev@vger.kernel.org
> +
>  WISTRON LAPTOP BUTTON DRIVER
>  M:     Miloslav Trmac <mitr@volny.cz>
>  S:     Maintained
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index d03775100f7d..aa631fe3b395 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -70,6 +70,36 @@ config DUMMY
>           To compile this driver as a module, choose M here: the module
>           will be called dummy.
>
> +config WIREGUARD
> +       tristate "WireGuard secure network tunnel"
> +       depends on NET && INET

I think you need to add IPV6 here

> +       select NET_UDP_TUNNEL
> +       select DST_CACHE
> +       select ZINC_CHACHA20POLY1305
> +       select ZINC_BLAKE2S
> +       select ZINC_CURVE25519
> +       default m

Please drop this - we usually leave it up to the defconfigs or distro
configs to enable stuff like this.

> +       help
> +         WireGuard is a secure, fast, and easy to use replacement for IPSec
> +         that uses modern cryptography and clever networking tricks. It's
> +         designed to be fairly general purpose and abstract enough to fit most
> +         use cases, while at the same time remaining extremely simple to
> +         configure. See www.wireguard.com for more info.
> +
> +         It's safe to say Y or M here, as the driver is very lightweight and
> +         is only in use when an administrator chooses to add an interface.
> +
> +config WIREGUARD_DEBUG
> +       bool "Debugging checks and verbose messages"
> +       depends on WIREGUARD
> +       help
> +         This will write log messages for handshake and other events
> +         that occur for a WireGuard interface. It will also perform some
> +         extra validation checks and unit tests at various points. This is
> +         only useful for debugging.
> +
> +         Say N here unless you know what you're doing.
> +
>  config EQUALIZER
>         tristate "EQL (serial line load balancing) support"
>         ---help---
...
