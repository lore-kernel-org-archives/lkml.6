Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EA4ECDFC0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADA420854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QykjRaPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADA420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeIKNPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:15:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36132 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbeIKNPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:15:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id e1-v6so15556590wrt.3;
        Tue, 11 Sep 2018 01:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:subject:to:cc:in-reply-to:references:mime-version
         :date:content-transfer-encoding;
        bh=Pn/WCQss2Ghxz3reHWoz8hN6sNjXMsj23Njfd6JrtCQ=;
        b=QykjRaPWe53T/Bhh/mh7lZuiv7eB0Gaeuo+WEUTs03CX8ix/ig977kyKdjWNO1kx5K
         rwLwy+CvhnynblChg41zukFCg/tXFr64IK46MGXGGieAmoXRafoAXMmg9F0nnGb2NT6A
         zKA0Hgt/+zWCe5yW+D+CgB0WyvikMnr66rJeCPps4Fpp3KHMyHLuWKlQfY5G0+ICQEu1
         /hSC5SpR+m/1kD9DzwcXU3uitFsU+fk29Lb+ACdMpwEJFzEx47Ni2Zdb1bxat+XROuQa
         UDvIjbj0Ym2MHa2s13/jklWR2T62bAj8GfDWncwRQI6bzifagpfDPybdC50BOJrVgr82
         vd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:subject:to:cc:in-reply-to
         :references:mime-version:date:content-transfer-encoding;
        bh=Pn/WCQss2Ghxz3reHWoz8hN6sNjXMsj23Njfd6JrtCQ=;
        b=HKGoWPk49irOc6k8QKzn+rK5AUeawONtpm9Yq6PnwTw8ZgW0tjKEwRYznzPL3AcLLU
         Y68iEuvhHguUJ/HT44CEYNVkY7vIl4e0c8XOaBbyXxnOVtRwNJmXOOdP08/PFvezAD2h
         +IC7vvlO7dzJ5DoQQ+Z3LfefwRwmhc+pqnSpaMW2uk/8RJMe0J5XlZKVVx9uW2W1Jgld
         iTY+Eifi3NW7zPfc55d71GAITRD1Lz34zGm7nDAbdRmYAOJYyoPKtZXrSvNqOmZ9My5F
         AAFqaa+hrv4w2+a8Mc2bbAy9D1HRIJI+I0USimuBpzxmWnC27K6scLZfCBcVVxW85ZBs
         JFKw==
X-Gm-Message-State: APzg51AH/hCU4WFifjPBtYVQRyXg4krze4FOGA9N59tWVSSptvI0pWv8
        L9azsPKyyZ45T1AoDLlc/D8=
X-Google-Smtp-Source: ANB0VdbgAWVNN4IgaSJBNQv6AuLzM3iQJn3V6sW8WoozFd3nHaZIvvBrMVQy3qQYXX/1qthbwOsSFQ==
X-Received: by 2002:a5d:6b8d:: with SMTP id n13-v6mr9035752wrx.149.1536653858422;
        Tue, 11 Sep 2018 01:17:38 -0700 (PDT)
Received: from asus-rog (arh.pub.ro. [141.85.160.17])
        by smtp.gmail.com with ESMTPSA id b22-v6sm298005wme.48.2018.09.11.01.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 01:17:37 -0700 (PDT)
From:   Radu Nicolae Pirea <pirea.radu@gmail.com>
X-Google-Original-From: Radu Nicolae Pirea <radu_nicolae.pirea@upb.ro>
Message-ID: <bd9104b702feec556ed01311e9efcb96790131d0.camel@upb.ro>
Subject: Re: [GIT PULL] Immutable branch between MFD, SPI and TTY due for
 the v4.20 merge window
To:     Lee Jones <lee.jones@linaro.org>,
        Radu Pirea <radu.pirea@microchip.com>
Cc:     broonie@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, richard.genoud@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20180910151803.GX28860@dell>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
         <20180910151803.GX28860@dell>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Date:   Tue, 11 Sep 2018 11:14:33 +0300
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Thank you for taking the patch series, but you didn't take the latest
version(v12) :)


On Mon, 2018-09-10 at 16:18 +0100, Lee Jones wrote:
> Enjoy!
> 
> The following changes since commit
> 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-
> mfd-spi-tty-v4.20
> 
> for you to fetch changes up to
> c24d25317a7c6bb3053d4c193b3cf57d1e9a3e4b:
> 
>   tty/serial: atmel: Change the driver to work under at91-usart MFD
> (2018-09-10 16:12:43 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD, SPI and TTY due for the v4.20 merge
> window
> 
> ----------------------------------------------------------------
> Radu Pirea (6):
>       MAINTAINERS: Add AT91 USART MFD entry
>       dt-bindings: Add binding for atmel-usart in SPI mode
>       mfd: at91-usart: Add MFD driver for USART
>       MAINTAINERS: Add AT91 USART SPI entry
>       spi: at91-usart: Add driver for at91-usart as SPI
>       tty/serial: atmel: Change the driver to work under at91-usart
> MFD
> 
>  .../bindings/{serial => mfd}/atmel-usart.txt       |  25 +-
>  MAINTAINERS                                        |  16 +
>  drivers/mfd/Kconfig                                |   9 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/at91-usart.c                           |  71 ++++
>  drivers/spi/Kconfig                                |   8 +
>  drivers/spi/Makefile                               |   1 +
>  drivers/spi/spi-at91-usart.c                       | 432
> +++++++++++++++++++++
>  drivers/tty/serial/Kconfig                         |   1 +
>  drivers/tty/serial/atmel_serial.c                  |  42 +-
>  include/dt-bindings/mfd/at91-usart.h               |  17 +
>  11 files changed, 606 insertions(+), 17 deletions(-)
>  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-
> usart.txt (76%)
>  create mode 100644 drivers/mfd/at91-usart.c
>  create mode 100644 drivers/spi/spi-at91-usart.c
>  create mode 100644 include/dt-bindings/mfd/at91-usart.h
> 

