Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBD8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EC2208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EC2208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbeGKCKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:10:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:47050 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732348AbeGKCJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:09:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 231F1AD3C;
        Wed, 11 Jul 2018 02:08:03 +0000 (UTC)
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
To:     Helmut Tschemernjak <helmut@helios.de>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?Q?Konstantin_B=c3=b6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>, contact@snootlab.com,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        lora@radioshuttle.de, Alexander Graf <agraf@suse.de>,
        =?UTF-8?Q?Michal_Kube=c4=8dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Hasnain Virk <Hasnain.Virk@arm.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <487df785-ddf5-ed81-a253-6afb7f2de811@datenfreihafen.org>
 <5aac9ea5-484c-1b3b-8058-50e11e8d7a9a@helios.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <23213cab-dc87-118c-1750-cd30d60ce9f8@suse.de>
Date:   Wed, 11 Jul 2018 04:07:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <5aac9ea5-484c-1b3b-8058-50e11e8d7a9a@helios.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Helmut,

Am 05.07.2018 um 12:43 schrieb Helmut Tschemernjak:
> I put the kernel support for the SX1276 LoRa chip in question. I don’t
> think that this kind of device should be in the Linux kernel.

Thanks for sharing your opinion.

> Here are a few facts to consider:
> - A LoRa transaction is very slow  (e.g. SF7 needs about 210 ms, for
> SF12 6280 ms) for 12 bytes user data with acknowledge.

Where do you see a problem? If you look at my SX1276 patch, you will
find that it queues a work item for the transmission (asynchronously)
and has an interrupt handler to get notified of the TX interrupt. It
surely won't get quicker in userspace - and as you point out, we're not
speaking about DPDK performance here, so no need for polling.

> - There are many different implementations for the antenna switch,
> switching between receiving/sending, PA-BOOST, 433, 868/915 MHz. (I know
> SX1276 Heltec ESP32, SX1276 Murata, RFM95-(1276), SX1276 Heltec
> STM32-L4) they are all different regarding this.

Yes, and as demonstrated with this patch series, the kernel is well able
to handle this variety of interfaces. I would say better than userspace!

As noted, I've tested both 868 MHz and 433 MHz modules. My SX1276 driver
uses the Device Tree (radio-frequency) to configure the driver when this
was a property of the module. RN2483 by contrast supports two, so a
netlink interface was suggested to configure this at runtime.

> - The LoRa chip device ID is only 8-bit which is not sufficient for
> larger networks, e.g. our RadioShuttle protocol uses compressed 32-bit
> device IDs.

What does that have to do with anything? The whole reason that you're
CC'ed on this patchset is to make sure that you or someone else can
implement your custom protocol on top of the APIs being proposed. So
my-protocol-is-better-than-theirs is no argument against this project.

The way I understand LoRa and thus designed the struct sockaddr_lora is
that there is no ID involved for LoRa at all - it is essentially a
broadcast. The 8-byte (not 8-bit) EUIs only come into play for LoRaWAN
AFAIU. Am I missing anything?

LoRaWAN, RadioShuttle, RadioHead and LR Base all have their own ways of
addressing - the question here is how to model that in Linux, whether as
one PF_LORA with different protocol options and a growing union
lora_addr inside sockaddr_lora covering all of them, or a protocol
family (requiring global number allocation) for each one of them.

> - The chip can do MTU sizes up to 2048 bytes, most protocols use less
> than 250 bytes.

How would 2048 bytes work? The FIFO buffer fits a maximum of 256 bytes.

IIRC the recommended MTU is also restricted by the airtime, i.e. SF,
bandwidth, preamble and other factors...

Some UART based modules allow a maximum of 64 bytes.

> - Applications do on-the-fly channel and spreading factor switching
> which makes it more difficult for the configuration.

That's exactly the question of how to implement individual options -
Device Tree would be fixed for the system's hardware, netlink would be
user-configurable for the whole network device, whereas socket options
would be per socket/application, and ioctls might be yet another
implementation layer.

> - The chip supports Lora modulation as well as  FSK, GFSK, MSK, GMSK,
> and OOK modulation, for some use cases the other modulations are of
> interest, e.g. to communicated with other devices.

Yes, therefore I raised it in the cover letter as open point 5).

> - Power saving modes, like sleep, suspend may be required for battery
> operation.

The Linux kernel can deal with that much better than userspace. There's
pm hooks that one could implement. And SX1276 returns to standby mode
whenever an operation such as TX is completed. In sleep mode not all
settings get preserved, so they would need to be saved in the private
struct and restored on resume.

> - Cad detection is very flexible and can be differently used.
> 
> - LoRa preamble may be different depending on the protocol used.
> 
> - The new Lora chip SX1262 / 68 (successor of the SX1276) has different
> hardware and all different registers, it is driver incompatible with the
> SX1276. It needs an entire new driver.

Not unexpected, same as SX1301 being different. As this series shows,
multiple drivers can easily be implemented as necessary.

> - The device is not multi-process capable (only a single process can
> communicate with it).

How is that different from other half-duplex network interfaces? The
driver needs to take care of appropriate locking of its operations, and
the socket subsystem should make sure packets get queued accordingly.

> - There are SX1276 LoRa modules with a build-in protocol (LoRaWAN and
> RAW) via a serial connection only, again complete different API compared
> the SX1276 chip. Software updates for this devices are difficult.

Drivers for such modules are already demonstrated in this series.

> - I am even convinced that the LoRaWAN protocol with the concentrator
> concept is not good, the peer to peer communication and a standard MQTT
> gateway (what we do) is way more flexible.

Your opinion in all honors, LoRaWAN is an open specification, whereas
yours is closed. So whatever benefits yours may have, that way you're
unlikely to make LoRaWAN go away. People are rolling out LoRaWAN
gateways, and therefore the question is not which protocol is more
flexible but rather how all of them can be enabled equally for those
that want to use them.

> For all this reasons, I feel a user level driver task implementation is
> way more flexible. I did a lot of work/enhancements on the SX1276 link
> level driver from Semtech, it is available and maintained on mbed.org
> and supports mbed-os, Arduino and is prepared for Linux.
> https://os.mbed.com/users/Helmut64/code/SX1276GenericLib/
> 
> Protocols e.g. our RadioShuttle LoRa peer to peer protocol or the
> LoRaWAN protocol can run on top of the SX1276GenericLib. We may should
> focus on such a driver library getting supported for multiple OS's (Win,
> Linux, mbed, Ardino, etc.)
> 
> Again I feel a Linux kernel device driver for the SX1276 chip make
> little sense for me.

Well, feel free to use spidev if you prefer. As I pointed out, the Linux
spi maintainers don't seem to share your view - instead of white-listing
chipsets for concrete kernel drivers (as you appear to suggest here)
they rather black-list chipsets to be "allowed" to use spidev if all
else fails.

Having already done part of the implementation work, for me the question
is not whether to do a kernel driver but how to do it properly, keeping
all corner cases in mind, such as non-standard protocols like yours.
It's great that you're writing an Open Source library for mbed, but its
name indicates that it offers no abstraction like proposed here.

I'll drop you from v2 then, to not bother you about this Linux kernel
implementation anymore.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
