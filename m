Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GpgjNTsBGVu1GwAAmS7hNA
	; Thu, 07 Jun 2018 09:56:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C0128607DC; Thu,  7 Jun 2018 09:56:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="qvycfyae"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 21CA86063F;
	Thu,  7 Jun 2018 09:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21CA86063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=hartkopp.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932523AbeFGJ4H (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:56:07 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:28695 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753397AbeFGJ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:56:06 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jun 2018 05:56:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1528365364;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=e2cJbJap2IzSAHassnHTCpr6JA2UcyDpj2zahvze0PM=;
        b=qvycfyaewk0jzjFWeA1q0DFDxKC+NwMdNyNWtyCCzrnlhyazwQy2aZppw3rJo+P303
        fQSEz2ulatTvPCHvtyayUFYq55iGyqvgMncwKMykhdd5ELUFqJOX2VucAgvUMYAMdhH/
        OTJopuORk6Z9ECmDR7VzUcswk3t9w0giXPCE2oOZgA3wTaE9HXWMsDjy0qvhZ/Ug1dNB
        RAAc7KoXOfz97cN7e0+I+M8PE+Nd62HC7gMxQ977uskU4UA04QnWP//SdDKWDwqKR540
        jdEAFxUkyQCWt3luqhMkJAkt67csMIiB9pNVjx7Enq+z2A5Q2Jj5Cb36z1o5UnnwjhU4
        2nUA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1rHLMalyLi1fNpX87/zI="
X-RZG-CLASS-ID: mo00
Received: from [10.180.29.82]
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id j0912bu579nwDuu
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 7 Jun 2018 11:49:58 +0200 (CEST)
Subject: Re: [PATCH 0/5] can: enable multi-queue for SocketCAN devices
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
References: <e8c47bca2ea64b5ab900f4f1e98bb405@de.bosch.com>
From: Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <bb1b5a1c-9f62-a35b-040f-d212d88ffa6c@hartkopp.net>
Date: Thu, 7 Jun 2018 11:49:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e8c47bca2ea64b5ab900f4f1e98bb405@de.bosch.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/07/2018 10:06 AM, Jonas Mark (BT-FIR/ENG1) wrote:
> Hi Oliver,
> 
>>> The driver suite consists of three separate drivers. The following
>>> diagram illustrates the dependencies in layers.
>>>
>>>              /dev/companion       SocketCAN                User Space
>>> -------------------------------------------------------------------
>>>            +----------------+ +---------------+
>>>            | companion-char | | companion-can |
>>>            +----------------+ +---------------+
>>>            +----------------------------------+
>>>            |          companion-spi           |
>>>            +----------------------------------+
>>>            +----------------------------------+
>>>            |     standard SPI subsystem       |
>>>            +----------------------------------+          Linux Kernel
>>> -------------------------------------------------------------------
>>>                  | | | |      | |                            Hardware
>>>               CS-+ | | |      | +-BUSY
>>>               CLK--+ | |      +---REQUEST
>>>               MOSI---+ |
>>>               MISO-----+
>>>
>>> companion-spi
>>>      core.c: handles SPI, sysfs entry and interface to upper layer
>>>      protocol-manager.c: handles protocol with the SPI HW
>>>      queue-manager.c: handles buffering and packets scheduling
>>>
>>> companion-can
>>>      makes use of multi-queue support and allows to use tc to configure
>>>      the queuing discipline (e.g. mqprio). Together with the SO_PRIORITY
>>>      socket option this allows to specify the FIFO a CAN frame shall be
>>>      sent to.
>>>
>>> companion-char
>>>      handles messages to other undisclosed functionality beyond CAN.
> 
>>>    .../devicetree/bindings/spi/bosch,companion.txt    |   82 ++
>>>    drivers/char/Kconfig                               |    7 +
>>>    drivers/char/Makefile                              |    2 +
>>>    drivers/char/companion-char.c                      |  367 ++++++
>>>    drivers/net/can/Kconfig                            |    8 +
>>>    drivers/net/can/Makefile                           |    1 +
>>>    drivers/net/can/companion-can.c                    |  694 ++++++++++++
>>
>> Please place the companion driver in
>>
>> drivers/net/can/spi/companion.c
>>
>> It also makes more sense in the Kconfig structure.
>>
>> Probably this naming scheme also makes sense for
>>
>> linux/drivers/char/spi/companion.c
>>
>> then ...
>>
>> If not it should be named at least
>>
>> drivers/char/companion-spi.c
>>
>> or
>>
>> drivers/char/spi-companion.c
> 
> We intentionally left out the spi in the driver path / name because
> only the drivers/spi/companion/* driver knows that that it is connected
> to SPI. The others (drivers/net/can/companion-can.c and
> drivers/char/companion-char.c) only know the API. This could also be
> supplied by a driver which talks to the Companion via a different
> interface. Actually, we started with a UART connection but switched to
> SPI due to latency issues.

Ok, got it.

> Should we still change it?

At least I would then vote for

drivers/char/companion.c
drivers/net/can/companion.c

instead of

drivers/char/companion-char.c
drivers/net/can/companion-can.c

as you would have companion-users in different driver subsystems that 
are already clearly referenced by their path.

The modules itself should still be named with companion-can of course 
(as-is right now).

Btw.

+#define DRIVER_NAME     "bosch,companion-can"

+static const struct can_bittiming_const companion_can_bittiming_const = {
+	.name      = "bosch,companion",


Is there any reason why it's not only "companion-can" or "companion"?
The fact that the driver is provided by Bosch is visible in the source code.

Best regards,
Oliver


> 
>>>    drivers/net/can/dev.c                              |    8 +-
>>>    drivers/spi/Kconfig                                |    2 +
>>>    drivers/spi/Makefile                               |    2 +
>>>    drivers/spi/companion/Kconfig                      |    5 +
>>>    drivers/spi/companion/Makefile                     |    2 +
>>>    drivers/spi/companion/core.c                       | 1189 ++++++++++++++++++++
>>>    drivers/spi/companion/protocol-manager.c           | 1035 +++++++++++++++++
>>>    drivers/spi/companion/protocol-manager.h           |  348 ++++++
>>>    drivers/spi/companion/protocol.h                   |  273 +++++
>>>    drivers/spi/companion/queue-manager.c              |  146 +++
>>>    drivers/spi/companion/queue-manager.h              |  245 ++++
>>>    include/linux/can/dev.h                            |    7 +-
>>>    include/linux/companion.h                          |  258 +++++
>>>    20 files changed, 4677 insertions(+), 4 deletions(-)
>>>    create mode 100644
>> Documentation/devicetree/bindings/spi/bosch,companion.txt
>>>    create mode 100644 drivers/char/companion-char.c
>>>    create mode 100644 drivers/net/can/companion-can.c
>>>    create mode 100644 drivers/spi/companion/Kconfig
>>>    create mode 100644 drivers/spi/companion/Makefile
>>>    create mode 100644 drivers/spi/companion/core.c
>>>    create mode 100644 drivers/spi/companion/protocol-manager.c
>>>    create mode 100644 drivers/spi/companion/protocol-manager.h
>>>    create mode 100644 drivers/spi/companion/protocol.h
>>>    create mode 100644 drivers/spi/companion/queue-manager.c
>>>    create mode 100644 drivers/spi/companion/queue-manager.h
>>>    create mode 100644 include/linux/companion.h
> 
> Greetings,
> Mark
> 
> Building Technologies, Panel Software Fire (BT-FIR/ENG1)
> Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY | www.boschsecurity.com
> 
> Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118
> Aufsichtsratsvorsitzender: Stefan Hartung; Geschäftsführung: Gert van Iperen, Andreas Bartz, Thomas Quante, Bernhard Schuster
> 
