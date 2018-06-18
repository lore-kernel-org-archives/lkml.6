Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFECC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D242075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D242075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thebollingers.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936820AbeFRTv4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:51:56 -0400
Received: from resqmta-po-02v.sys.comcast.net ([96.114.154.161]:53876 "EHLO
        resqmta-po-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936284AbeFRTvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:51:54 -0400
Received: from resomta-po-01v.sys.comcast.net ([96.114.154.225])
        by resqmta-po-02v.sys.comcast.net with ESMTP
        id UzsofAqYhQNWZV0Bufj21A; Mon, 18 Jun 2018 19:51:54 +0000
Received: from thebollingers.org ([73.223.250.230])
        by resomta-po-01v.sys.comcast.net with ESMTPA
        id V0Brf30vGVGSOV0Btf1gtm; Mon, 18 Jun 2018 19:51:54 +0000
Date:   Mon, 18 Jun 2018 12:41:27 -0700
From:   Don Bollinger <don@thebollingers.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, brandon_chuang@edge-core.com,
        wally_wang@accton.com, roy_lee@edge-core.com,
        rick_burchett@edge-core.com, quentin.chang@quantatw.com,
        steven.noble@bigswitch.com, jeffrey.townsend@bigswitch.com,
        scotte@cumulusnetworks.com, roopa@cumulusnetworks.com,
        David Ahern <dsa@cumulusnetworks.com>,
        luke.williams@canonical.com, Guohan Lu <gulv@microsoft.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        don@thebollingers.org
Subject: Re: [PATCH] optoe: driver to read/write SFP/QSFP EEPROMs
Message-ID: <20180618194127.uaeqlo3dy35qs3ip@thebollingers.org>
References: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
 <496e06b9-9f02-c4ae-4156-ab6221ba23fd@amd.com>
 <20180612181109.GD12251@lunn.ch>
 <20180615022652.t6oqpnwwvdmbooab@thebollingers.org>
 <20180615075417.GA28730@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615075417.GA28730@lunn.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfF2B9Ti3wMK4ENwtQsiIgUpzsaO8K833EAIrsJZV14/qHr4WENJLMNL7kM1tkguI2/Iz8qY0H927aYriE3ZZoiupw77iz9J+V5pnz6S0gDHUOhZO1K0K
 oQ7gk7ajb0XD0IoM5ipm5we9ihnwMkX8U2ZcnkphF8c+EHm/3YDve7FxqFqVmZ0dPk1jz4SXvSIwGoe1CN+KFYiqrTOUYEXFmGSEPd3KG5F0oFx1XHkdakXN
 xBSBg7+zQ/V7XO0qFtS/d7gG/hwdqBcNX7lL7d/C+yoXx7FZ91Li2Os9qAQRcejWENkv7DekburBsgBz9L5L3Xq8F00OgXKjicVj4oU34Ah8lDTkoEu+OZdu
 szluLUKn4+dQiL2dfKARGHe0VzsDV+cap1h5n2KAQRMGNS9bnHeKsCye14u79w74z7T9gkldvOMKxOVY++MgWBNqM4hCovR9EVJowfPf39+A99AMDXxvZfsL
 vZ1jTukHVwjPyyDbIV9egKCezMNbo1mzLZsOrSVS8bXs8PQeNwWIrHACig3+NEep5tDcDPcA/GTBoSS5JSHqPixDfABnmU1t6GOzNind6a4rCDDXuu+z/yCF
 3DdBxKQMSQE174QuLn6o8ovuvhh8T8bVFC9jUMSi2WnKjo6HLge3xnVAKZNT+KadBfwNS25+z15kPCNYgLWBIIZ4eOkxGAfTIH6CQeKVD9wLRqplTx3ge5bO
 B8BRMlWKhW9CT/TE5FQUmL/rRpbSNDgyzjdIrk1qbAs29DiNpA3jsMxsuKpgKR+b13uUcSiX/DglfxrK0Bvv33956OshsgfUy0N9Mo130jXHXvVeWRMGiIST
 bWxyEGFPE2pN+OAXtcV2YMNWgh2nytQIJvMgymJeRJ7QEK9N6zKs/mU6ZKUT4g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 09:54:17AM +0200, Andrew Lunn wrote:
> > Actually this is better described by a third use case.  The target
> > switches are PHY-less (see various designs at
> > www.compute.org/wiki/Networking/SpecsAndDesigns). The AS5712 for example
> > says "The AS5712-54X is a PHY-Less design with the SFP+ and QSFP+
> > connections directly attaching to the Serdes interfaces of the Broadcom
> > BCM56854 720G Trident 2 switching silicon..."
> 
> We consider the SFP+ and QSFP+ as being the PHY. You need something to
> control that PHY. Either it is firmware running in the switch, or it
> is the Linux kernel, via PHYLINK.

Actually in the environment I'm working in (at least 3 different NOS
vendors, and 3 different switch vendors), the {Q}SFP devices are
controlled by a platform specific driver that pokes CPLD registers.  I'm
not sure where the actual control logic is, but it doesn't appear to use
any of the frameworks you are describing.

> 
> > The i2c bus is muxed from the CPU to all of the {Q}SFP devices, which
> > are set up as standard linux i2c devices
> > (/sys/bus/i2c/devices/i2c-xxxx).
> 
> Having a standard i2c bus driver is correct. This is what PHYLINK
> assumes. It knows about the different addresses the SFP uses on the
> i2c bus.

Great.  Then plugging optoe into it should be easy.

> 
> > There is no MDIO bus between the CPU and the {Q}SFP devices.
> 
> There is no physical MDIO bus for SFP devices. If the SFP module
> implements copper 1G, there is often MDIO tunnelled over i2c. PHYLINK
> knows how to do this, and will instantiate a normal Linux MDIO bus
> driver, and then you can use the Linux kernel copper PHY state
> machines as normal.
> 
> > And, there isn't actually 'a wish to expose' the EEPROM data to linux
> > (the kernel).  It turns out that none of the NOS partners I'm working
> > with use that data *in the kernel*.  It is all managed from user space.
> 
> Ah. O.K. We can stop here then.
> 
> If you are using Linux as a boot loader, i doubt you will find any
> network kernel developers who are willing to consider this driver. The

It isn't a boot loader.  It is the kernel that is running on the switch
when it is doing its switch thing.  The kernel hosts the drivers and the
switch SDK and all the apps that configure and manage the networking.

> kernel community as decided switchdev is how the Linux kernel supports

I'm sure switchdev works very well.  It is not being used in the
environment I am trying to support.  I've checked all 3 NOSs that have
adopted optoe, none of them have switchdev configured in their .config
file:

# CONFIG_NET_SWITCHDEV is not set

> switches. We are unlikely to add drivers for supporting user space
> drivers of switches.

That's not the request.  I'm offering an improved driver to access {Q}SFP
EEPROMs.  It can be easily called by your framework, so the sfp.c users
can also get improved access to the EEPROMs.

As designed it fits the need in the linux based community I'm
working with.  It is in production in two NOSs on three switches.  Less
complete variants of this driver are in production on all three NOSs
I've worked with, on dozens of platforms.  This is real code, that fits
a real need, and would like the benefits of being maintained as part of
the mainline kernel.

> 
> NACK.
> 
> 	Andrew
> 

Don
