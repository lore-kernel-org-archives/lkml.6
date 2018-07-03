Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE50C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA7D21A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="LIcOd9gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA7D21A89
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933740AbeGCPMo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:12:44 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43348 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933936AbeGCPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:11:45 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so4464720oib.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PH5USnvOkm+U4YsISSBqgeeh9s1G5/Id7P7vx/CTEnQ=;
        b=LIcOd9gv3NO/rsJH/pBfNaeRL3hlBwcBjpWItKC9nu6P2mdlPgMjfHroBo6+La4+hN
         uDz9zBN/4/iMdsEAxdGA//uo3PWv9vPUo1S0FCaK5oROmlJv7tjklZL3EoXtLFFJEa4H
         OMH/1KwLrAdelWqIjD9MxTYvXN0sixVI85zK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PH5USnvOkm+U4YsISSBqgeeh9s1G5/Id7P7vx/CTEnQ=;
        b=dyMwWJXLpeDEk6pSdokabQa5Bitvb81sF0NKjw+dBhgfUemnM4Ah73pl742ZHwS65f
         TSa+92rZwuimMZqbv+TFD+iy6dQ+Vdb4kAxTemiyD+//yag4z7yMA8naTcj2AZG6fylp
         qmhKCFYd+HSC/ghP8+/TZLtWlZkkRvs5ZZY+WkwCm59/RuVif5r0uTGAtP6TDcByiOt5
         ApP+9YbUBAkdRMkqPjwUFCyvm+68XIYOJcXlFh6EKeWbPpOg25eOaDlgWzssu+X5ZDsy
         170SXXP6TnFzTxiDlUt0W9ZmfcmbY44IgHC4Wl4nRrluxS9kcwrQTY/2D+FMh9KFtf9d
         uufQ==
X-Gm-Message-State: APt69E0TtWEfhvnMRRvYzPv1SxF4/uczWpX/J1gCbSN8Mp2rfeOnH6ja
        ePFszXTJxW3iDRrW9VsAh0Jw/Q==
X-Google-Smtp-Source: AAOMgpdTYx07UkFjhmaHm0/3ha8C2LptoAGsQis4G2wRZimBwhbpcQjv/UlmqRcZ5msOvy4k2ydDiA==
X-Received: by 2002:aca:5905:: with SMTP id n5-v6mr6592812oib.232.1530630704433;
        Tue, 03 Jul 2018 08:11:44 -0700 (PDT)
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id i17-v6sm891285otc.29.2018.07.03.08.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 08:11:44 -0700 (PDT)
Received: by mail-oi0-f47.google.com with SMTP id k81-v6so4481992oib.4;
        Tue, 03 Jul 2018 08:11:43 -0700 (PDT)
X-Received: by 2002:aca:4d56:: with SMTP id a83-v6mr19770202oib.205.1530630702912;
 Tue, 03 Jul 2018 08:11:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:1141:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 08:11:42 -0700 (PDT)
In-Reply-To: <20180701110804.32415-1-afaerber@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date:   Tue, 3 Jul 2018 23:11:42 +0800
X-Gmail-Original-Message-ID: <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
Message-ID: <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?Q?Michael_R=C3=B6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?Q?Konstantin_B=C3=B6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>, contact@snootlab.com,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        lora@radioshuttle.de, Alexander Graf <agraf@suse.de>,
        =?UTF-8?Q?Michal_Kube=C4=8Dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

First, thanks for your great jobs.  LoRaWAN module needs the
compatible devices drivers.
I will reply the message under the LoRaWAN specification.

2018-07-01 19:07 GMT+08:00 Andreas F=C3=A4rber <afaerber@suse.de>:
> Hello,
>
> LoRa is a long-range, low-power wireless technology by Semtech.
> Unlike other LPWAN technologies, users don't need to rely on infrastructu=
re
> providers and SIM cards and expensive subscription plans, they can set up
> their own gateways. Modules, adapters and evaluation boards are available
> from a large number of vendors.
>
> Many vendors also make available Open Source software examples on GitHub.
> But when taking a closer look, many of them combine licenses in ways that=
 are
> not redistributable. My reports have remained without response or solutio=
n.
>
> https://github.com/ernstdevreede/lmic_pi/issues/2
> https://github.com/Snootlab/lmic_chisterapi/issues/2
> https://github.com/Snootlab/lora_chisterapi/issues/2
>
> Another issue was that most such projects around the Raspberry Pi make us=
e of
> spidev to communicate with the Semtech chipsets from userspace. The Linux=
 spi
> maintainers have chosen to greet any such users of spidev with a friendly
> WARN_ON(), preferring in-kernel spi drivers and white-listing individual
> devices only.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/spi/spidev.c?h=3Dv4.17#n722
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/spi/spidev.c?h=3Dv4.17#n667
>
> Also I don't quite see the point in having userspace probe what SPI devic=
es
> are connected to a generic spidev driver when we have an easy Device Tree
> hardware description on arm/arm64 that could give us that info.
>
> I raised the topic during Q&A of a FOSDEM 2017 talk (cut off at the end
> of the video) but unfortunately found no one to collaborate on this.
>
> https://archive.fosdem.org/2017/schedule/event/lorawan/
>
> Instead of porting from wiringPi to a differently licensed GPIO library
> and dealing with seemingly unmaintained LoRaWAN code dumps, I started a
> spi kernel driver for SX1276 back in 2016. But obviously a kernel driver
> isn't too helpful without a userspace API to send and receive packets.
>
> This patchset, updated from 2017 and extended, is implementing kernel dri=
vers
> for various LoRa chipsets and modules. As API I'm proposing a PF_LORA soc=
ket
> implementation. Why? LoRa uses data packets with headers and checksums
> and differing MTUs and multiple protocols layered on top of it. Apart fro=
m
> simple headers for addressing used by RadioHead library and IMST's LoRa P=
2P
> protocol, the main use case (not implemented in this patchset) is expecte=
d
> to be LoRaWAN. And LoRaWAN has competing proprietary protocols, such as
> Link Labs' Symphony Link or GlobalSat M.O.S.T. or RadioShuttle, that migh=
t
> at some point want to adopt a standard API for their implementations, too=
.
>
> Ready-made LoRa hardware modules come in three flavors,
> a) with SPI access to the underlying Semtech chipsets, needing a software
>    implementation of e.g. LoRaWAN protocol stack (i.e., a soft MAC),
> b) with a custom, often UART based interface and a pre-certified LoRaWAN
>    protocol stack already integrated (i.e., hard/full MAC), and
> c) with a microcontroller that serves not only for the protocol stack but
>    also as application processor, not offering a ready-made interface.
>
> This patchset focuses on option a). An SX1276 based LoRaWAN stack appeare=
d
> to be the project of Jian-Hong Pan and is not included here.

Thanks, LoRaWAN module needs the compatible device drivers.

> This patchset also includes drivers for b), from text based AT commands t=
o
> a binary SLIP based HCI protocol.
> Hardware examples for c) are Murata CMWX1ZZABZ-078 and RAK813.
>
> This patchset is clearly not ready for merging, but is being submitted fo=
r
> discussion, as requested by Jiri, in particular of the design choices:
>
> 1) PF_LORA/AF_LORA and associated identifiers are proposed to represent
>    this technology. While for an SX1276 - case a) above - it might work t=
o
>    layer LoRaWAN as a protocol option for PF_LORA and add LoRaWAN address
>    fields to the union in my sockaddr_lora, how would that work for devic=
es
>    that only support LoRaWAN but not pure LoRa? Do we need both AF_LORA a=
nd
>    AF_LORAWAN, or just a separate ETH_P_LORAWAN or ARPHRD_LORAWAN?

The LoRaWAN module also register the LoRa device as a network device.
Will use the macros AF_LORAWAN, PF_LORAWAN, ARPHRD_LORAWAN and ETH_P_LORAWA=
N.

> 2) PF_LORA is used with SOCK_DGRAM here. The assumption is that RAW mode
>    would be DGRAM plus preamble plus optional checksum.

Is the preamble added by the hardware itself here or software here?

> 3) Only the transmit path is partially implemented already. The assumptio=
n
>    is that the devices should go into receive mode by default and only
>    interrupt that when asked to transmit.

If it goes with LoRaWAN spec., end devices should be in idle (or
called standby mode) by default.  Unless the device is asked to be in
transmitting or receiving timing slot.

> 4) Some hardware settings need to be supplied externally, such as the rad=
io
>    frequency for some modules, but many others can be runtime-configured,
>    such as Spreading Factor, Bandwidth, Sync Word, or which antenna to us=
e.
>    What settings should be implemented as socket option vs. netlink layer
>    vs. ioctl vs. sysfs? What are the criteria to apply?

- We can have a pre-defined table according to LoRaWAN Regional Parameters.
- Device driver declares the hardware's capability, for example
frequency, TX power.  And then registers as a LoRaWAN compatible
device.
- LoRaWAN module handle the requests from upper layer or MAC commands
from a gateway (netlink layer), than uses the pre-defined interface
functions to set the parameters.

LoRaWAN module will export the operation functions interface.

> 5) Many of the modules support multiple modes, such as LoRa, LoRaWAN and =
FSK.
>    Lacking a LoRaWAN implementation, I am currently switching them into L=
oRa
>    mode at probe time wherever possible. How do we deal with that properl=
y?

- There are data rate tables defined in LoRaWAN Regional Parameters.
Those contain which data rate uses LoRa mode or FSK mode.
- LoRaWAN should handle the data rate changing requests and then calls
the corresponding operation functions.  Of course, the hardware's
capability registered before should also be under consideration at the
same time.

>   a) Is there any precedence from the Wifi world for dynamically selectin=
g
>      between our own trusted Open Source implementation vs. hardware/firm=
ware
>      accelerated and/or certified implementations?
>
>   b) Would a proof of concept for FSK (non-LoRa) modes be required for
>      merging any LoRa driver for chipsets that support both? Or is there =
any
>      facility or design guidelines that would allow us to focus on LoRa a=
nd
>      LoRaWAN and leave non-LoRa radio modes to later contributors?
>
> As evident by the many questions, this is my first deep dive into the Lin=
ux
> net subsystem. It's also my first experiments with the new serdev subsyst=
em,
> so in particular the receive paths will need some review and optimization=
s.
>
> This patchset was developed and tested mainly as KMP, originally at
> https://github.com/afaerber/lora-modules. It was recently transformed int=
o a
> linux-next based tree, still mostly tested on our openSUSE Tumbleweed ker=
nel
> with a differing AF_LORA value below current AF_MAX limit.
>
> Some corresponding Device Tree Overlays have been collected here:
> https://github.com/afaerber/dt-overlays
>
> Only European models for 868 MHz and 433 MHz could be tested when availab=
le.

I can test 922-928 MHz in Taiwan.
But I need a workable LoRaWAN gateway first! XD

Cheers,
Jian-Hong Pan

> Thanks to all companies and people that have supported this project so fa=
r.
>
> Have a lot of fun!
>
> Cheers,
> Andreas
>
> Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Konstantin B=C3=B6hm <konstantin.boehm@ancud.de>
> Cc: Jan Jongboom <jan.jongboom@arm.com>
> Cc: Janus Piwek <jpiwek@arroweurope.com>
> Cc: Michael R=C3=B6der <michael.roeder@avnet.eu>
> Cc: Dollar Chen (=E9=99=B3=E7=BE=A9=E5=85=83) <dollar.chen@wtmec.com>
> Cc: Ken Yu (=E7=A6=B9=E5=87=AF) <ken.yu@rakwireless.com>
> Cc: Jon Ortego <Jon.Ortego@imst.de>
> Cc: contact@snootlab.com
> Cc: Ben Whitten <ben.whitten@lairdtech.com>
> Cc: Brian Ray <brian.ray@link-labs.com>
> Cc: lora@globalsat.com.tw
> Cc: lora@radioshuttle.de
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Michal Kube=C4=8Dek <mkubecek@suse.cz>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Steve deRosier <derosier@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-spi@vger.kernel.org
>
> Andreas F=C3=A4rber (15):
>   net: Reserve protocol numbers for LoRa
>   net: lora: Define sockaddr_lora
>   net: lora: Add protocol numbers
>   net: Add lora subsystem
>   HACK: net: lora: Deal with .poll_mask in 4.18-rc2
>   net: lora: Prepare for device drivers
>   net: lora: Add Semtech SX1276
>   net: lora: sx1276: Add debugfs
>   net: lora: Prepare EUI helpers
>   net: lora: Add Microchip RN2483
>   net: lora: Add IMST WiMOD
>   net: lora: Add USI WM-SG-SM-42
>   net: lora: Prepare RAK RAK811
>   net: lora: Prepare Semtech SX1257
>   net: lora: Add Semtech SX1301
>
>  drivers/net/Makefile                |   1 +
>  drivers/net/lora/Kconfig            |  72 ++++
>  drivers/net/lora/Makefile           |  32 ++
>  drivers/net/lora/dev.c              | 125 ++++++
>  drivers/net/lora/rak811.c           | 219 +++++++++++
>  drivers/net/lora/rn2483.c           | 344 +++++++++++++++++
>  drivers/net/lora/rn2483.h           |  40 ++
>  drivers/net/lora/rn2483_cmd.c       | 130 +++++++
>  drivers/net/lora/sx1257.c           |  96 +++++
>  drivers/net/lora/sx1276.c           | 740 ++++++++++++++++++++++++++++++=
++++++
>  drivers/net/lora/sx1301.c           | 446 ++++++++++++++++++++++
>  drivers/net/lora/usi.c              | 411 ++++++++++++++++++++
>  drivers/net/lora/wimod.c            | 597 +++++++++++++++++++++++++++++
>  include/linux/lora/dev.h            |  44 +++
>  include/linux/lora/skb.h            |  29 ++
>  include/linux/socket.h              |   4 +-
>  include/uapi/linux/if_arp.h         |   1 +
>  include/uapi/linux/if_ether.h       |   1 +
>  include/uapi/linux/lora.h           |  24 ++
>  net/Kconfig                         |   1 +
>  net/Makefile                        |   1 +
>  net/lora/Kconfig                    |  15 +
>  net/lora/Makefile                   |   8 +
>  net/lora/af_lora.c                  | 152 ++++++++
>  net/lora/af_lora.h                  |  13 +
>  net/lora/dgram.c                    | 297 +++++++++++++++
>  security/selinux/hooks.c            |   4 +-
>  security/selinux/include/classmap.h |   4 +-
>  28 files changed, 3848 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/net/lora/Kconfig
>  create mode 100644 drivers/net/lora/Makefile
>  create mode 100644 drivers/net/lora/dev.c
>  create mode 100644 drivers/net/lora/rak811.c
>  create mode 100644 drivers/net/lora/rn2483.c
>  create mode 100644 drivers/net/lora/rn2483.h
>  create mode 100644 drivers/net/lora/rn2483_cmd.c
>  create mode 100644 drivers/net/lora/sx1257.c
>  create mode 100644 drivers/net/lora/sx1276.c
>  create mode 100644 drivers/net/lora/sx1301.c
>  create mode 100644 drivers/net/lora/usi.c
>  create mode 100644 drivers/net/lora/wimod.c
>  create mode 100644 include/linux/lora/dev.h
>  create mode 100644 include/linux/lora/skb.h
>  create mode 100644 include/uapi/linux/lora.h
>  create mode 100644 net/lora/Kconfig
>  create mode 100644 net/lora/Makefile
>  create mode 100644 net/lora/af_lora.c
>  create mode 100644 net/lora/af_lora.h
>  create mode 100644 net/lora/dgram.c
>
> --
> 2.16.4
>
