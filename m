Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZMFZJyfdGFswcgAAmS7hNA
	; Thu, 07 Jun 2018 07:22:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EF1D66089E; Thu,  7 Jun 2018 07:22:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="l4x+7Vyb"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 593D1607DC;
	Thu,  7 Jun 2018 07:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 593D1607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=hartkopp.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeFGHWt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:22:49 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:17538 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbeFGHWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1528356162;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Zjsr9iM5NRJN32C3bN3+dJkd6WuNgwbA2/gzfYnlOKE=;
        b=l4x+7Vybs48rMJhlIzKH5MSwTPXyQIZk/+r3nJIgG6Gckhmq5vYRcI2bm8kZWzljCp
        xbkF8cQRcN7qKj/VPYExIlWVg936D8WjqWockqsxrwsXfHdBxAxPmG5LkY8PC1nJzGiu
        Q4ZsSA8W+TIkGkOMK1BMnGl9zlQUVc6m8KpZIBycfgU5Jgxg6AbsCiRKXHug7SqyCQ8O
        tDgRYQ0qoXzcW09oYEYKS1n6284SdQwnjIUgOeyrocm4jtweA/IvPCcvN2daFPb8fHcP
        7JwQRhrIHwITsZnCueYGZNASlmT4r053E313542DqHN8CY4nH7Jh/8ftIANSdve4ofe5
        G7Xg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1rHLMalyLi1fNpX87/zI="
X-RZG-CLASS-ID: mo00
Received: from [10.180.29.82]
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id j0912bu577MfD33
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 7 Jun 2018 09:22:41 +0200 (CEST)
Subject: Re: [PATCH 0/5] can: enable multi-queue for SocketCAN devices
To: Mark Jonas <mark.jonas@de.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hs@denx.de, yi.zhu5@cn.bosch.com
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
From: Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <e27cbd23-f922-218b-b314-ff99e1401609@hartkopp.net>
Date: Thu, 7 Jun 2018 09:22:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/05/2018 08:43 PM, Mark Jonas wrote:
> Upon request by Marc Kleine-Budde this patch series does not only
> contain our patch to enable enable multi-queue for SocketCAN devices
> but also a driver (Companion driver suite) which makes active use of
> this feature.
> 
> The driver suite implements
>    - two CAN interfaces
>    - one generic command interfaces
> and offers a SocketCAN as well as a char device interface. The
> SocketCAN interface supports multi-queue.
> 
> The functionality bases on an external peripheral chip named Companion.
> It offers two CAN interfaces, each has 8 prioritized transmit FIFOs as
> well as one receive FIFO. Besides CAN, undisclosed additional functions
> can be accessed through the char device.
> 
> A standard SPI interface with two additional lines for flow control is
> used. The Companion chip is the SPI slave.
> 
> The driver suite consists of three separate drivers. The following
> diagram illustrates the dependencies in layers.
> 
>             /dev/companion       SocketCAN                User Space
> -------------------------------------------------------------------
>           +----------------+ +---------------+
>           | companion-char | | companion-can |
>           +----------------+ +---------------+
>           +----------------------------------+
>           |          companion-spi           |
>           +----------------------------------+
>           +----------------------------------+
>           |     standard SPI subsystem       |
>           +----------------------------------+          Linux Kernel
> -------------------------------------------------------------------
>                 | | | |      | |                            Hardware
>              CS-+ | | |      | +-BUSY
>              CLK--+ | |      +---REQUEST
>              MOSI---+ |
>              MISO-----+
> 
> companion-spi
>     core.c: handles SPI, sysfs entry and interface to upper layer
>     protocol-manager.c: handles protocol with the SPI HW
>     queue-manager.c: handles buffering and packets scheduling
> 
> companion-can
>     makes use of multi-queue support and allows to use tc to configure
>     the queuing discipline (e.g. mqprio). Together with the SO_PRIORITY
>     socket option this allows to specify the FIFO a CAN frame shall be
>     sent to.
> 
> companion-char
>     handles messages to other undisclosed functionality beyond CAN.
> 
> Zhu Yi (5):
>    can: enable multi-queue for SocketCAN devices
>    spi: implement companion-spi driver
>    char: implement companion-char driver
>    can: implement companion-can driver
>    spi,can,char: add companion DT binding documentation
> 
>   .../devicetree/bindings/spi/bosch,companion.txt    |   82 ++
>   drivers/char/Kconfig                               |    7 +
>   drivers/char/Makefile                              |    2 +
>   drivers/char/companion-char.c                      |  367 ++++++
>   drivers/net/can/Kconfig                            |    8 +
>   drivers/net/can/Makefile                           |    1 +
>   drivers/net/can/companion-can.c                    |  694 ++++++++++++

Please place the companion driver in

drivers/net/can/spi/companion.c

It also makes more sense in the Kconfig structure.

Probably this naming scheme also makes sense for

linux/drivers/char/spi/companion.c

then ...

If not it should be named at least

drivers/char/companion-spi.c

or

drivers/char/spi-companion.c

BR Oliver

>   drivers/net/can/dev.c                              |    8 +-
>   drivers/spi/Kconfig                                |    2 +
>   drivers/spi/Makefile                               |    2 +
>   drivers/spi/companion/Kconfig                      |    5 +
>   drivers/spi/companion/Makefile                     |    2 +
>   drivers/spi/companion/core.c                       | 1189 ++++++++++++++++++++
>   drivers/spi/companion/protocol-manager.c           | 1035 +++++++++++++++++
>   drivers/spi/companion/protocol-manager.h           |  348 ++++++
>   drivers/spi/companion/protocol.h                   |  273 +++++
>   drivers/spi/companion/queue-manager.c              |  146 +++
>   drivers/spi/companion/queue-manager.h              |  245 ++++
>   include/linux/can/dev.h                            |    7 +-
>   include/linux/companion.h                          |  258 +++++
>   20 files changed, 4677 insertions(+), 4 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/spi/bosch,companion.txt
>   create mode 100644 drivers/char/companion-char.c
>   create mode 100644 drivers/net/can/companion-can.c
>   create mode 100644 drivers/spi/companion/Kconfig
>   create mode 100644 drivers/spi/companion/Makefile
>   create mode 100644 drivers/spi/companion/core.c
>   create mode 100644 drivers/spi/companion/protocol-manager.c
>   create mode 100644 drivers/spi/companion/protocol-manager.h
>   create mode 100644 drivers/spi/companion/protocol.h
>   create mode 100644 drivers/spi/companion/queue-manager.c
>   create mode 100644 drivers/spi/companion/queue-manager.h
>   create mode 100644 include/linux/companion.h
> 
