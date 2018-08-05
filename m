Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E44C4646F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F509217CC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F509217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbeHECOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 22:14:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:38980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729690AbeHECOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 22:14:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0E05AFC0;
        Sun,  5 Aug 2018 00:11:29 +0000 (UTC)
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
To:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
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
        Alexander Graf <agraf@suse.de>,
        =?UTF-8?Q?Michal_Kube=c4=8dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Pieter Robyns <pieter.robyns@uhasselt.be>,
        Hasnain Virk <Hasnain.Virk@arm.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-wpan <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Daniele Comel <dcomel@mipot.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
Date:   Sun, 5 Aug 2018 02:11:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jian-Hong,

Am 03.07.2018 um 17:11 schrieb Jian-Hong Pan:
> 2018-07-01 19:07 GMT+08:00 Andreas Färber <afaerber@suse.de>:
>> 2) PF_LORA is used with SOCK_DGRAM here. The assumption is that RAW mode
>>    would be DGRAM plus preamble plus optional checksum.
> 
> Is the preamble added by the hardware itself here or software here?

That depends on the driver. For SX127x and any SX127x based modules it
is added by hardware and a SOCK_RAW seems impossible. If you were to use
some SDR hardware, it would need to be done by software and might either
be done in the device driver for SOCK_DGRAM or by user with a SOCK_RAW.
Right now I don't see a practical use case for the latter. (CC Pieter)

>> 3) Only the transmit path is partially implemented already. The assumption
>>    is that the devices should go into receive mode by default and only
>>    interrupt that when asked to transmit.
> 
> If it goes with LoRaWAN spec., end devices should be in idle (or
> called standby mode) by default.  Unless the device is asked to be in
> transmitting or receiving timing slot.

Whatever the LoRaWAN spec says, in practice struct net_device_ops has an
ndo_start_xmit hook but no ndo_start_recv. All drivers that I've checked
start receiving via interrupts after ndo_open has set things up.

LoRa radio channels being half-duplex, we'd need to stop receiving in
ndo_start_xmit and re-start receiving in the TX interrupt handler AFAIU.
Yes, it's ugly - one reason I haven't implemented RX in sx1276 yet.

Are you suggesting to have dgram's recvmsg trigger the RX state somehow?
It gets access to the net_device and could access dev.h struct lora_priv
that we might extend to contain a LoRa-specific start_recv callback. And
probably rename it more uniquely to lora_dev_priv while at it.

The only other alternative I can think of would be to require the user
to perform some netlink operation, possibly wrapped in some lora_ API,
to actively put the device into receive mode. Doesn't sound desirable.

>> 4) Some hardware settings need to be supplied externally, such as the radio
>>    frequency for some modules, but many others can be runtime-configured,
>>    such as Spreading Factor, Bandwidth, Sync Word, or which antenna to use.
>>    What settings should be implemented as socket option vs. netlink layer
>>    vs. ioctl vs. sysfs? What are the criteria to apply?
> 
> - We can have a pre-defined table according to LoRaWAN Regional Parameters.
> - Device driver declares the hardware's capability, for example
> frequency, TX power.  And then registers as a LoRaWAN compatible
> device.

That sounds like a layering violation. We rather need to expose all
these tunable parameters individually at the LoRa layer, allowing the
LoRaWAN layer to configure them as it pleases. Not the other direction.
That still leaves my above question 4) open of how to implement each.

The use case I have in mind is this: User A opens a LoRaWAN socket and
using maclorawan sends a packet P1. Here the LoRaWAN Regional Parameters
and LoRaWAN Sync Word need to be applied.
User B then opens a pure LoRa socket and transmits a packet P1' with
different Sync Word, SF, BW, CR, etc.
Afterwards user A wants to send another packet P2 via LoRaWAN - this
needs to use the same LoRaWAN settings as before, not those used for
LoRa in between. Therefore I was thinking about socket-level options, as
netlink operations would be device-wide, with undesired side-effects.

Obviously in that scenario not both users can receive at the same time.

If there was a way to start receiving only when a user performs such a
socket operations, even this could be implemented - if incompatible
reception can get detected and if the packet gets delivered to both,
LoRa being broadcast.

> - LoRaWAN module handle the requests from upper layer or MAC commands
> from a gateway (netlink layer), than uses the pre-defined interface
> functions to set the parameters.
> 
> LoRaWAN module will export the operation functions interface.
> 
>> 5) Many of the modules support multiple modes, such as LoRa, LoRaWAN and FSK.
>>    Lacking a LoRaWAN implementation, I am currently switching them into LoRa
>>    mode at probe time wherever possible. How do we deal with that properly?
> 
> - There are data rate tables defined in LoRaWAN Regional Parameters.
> Those contain which data rate uses LoRa mode or FSK mode.

That's missing my point, I fear. Independently of what LoRaWAN does, the
user needs to be able to send on the physical layer from a selection of
LoRa, GFSK, FSK, OOK, GMSK and MSK.
Supposedly Wireless M-Bus and IEEE 802.15.4 can be implemented via those
according to the SX1276 datasheet.

This opens a can of worms...

SX127x has a single channel, so I don't think there should be six
network interfaces lora0, gfsk0, fsk0, ook0, gmsk0 and msk0 exposed to
the user.
Having a lora0 interface speak non-LoRa modulations may be confusing,
but since the chip is sold as LoRa transceiver it might be acceptable.

SX130x has 8+2 channels, with IF9 dedicated to GFSK/FSK. It appears to
use one FIFO for receiving (up to 16 packets) and can only transmit one
packet at a time. So I think this should be one lora0 interface, too.

With a view to supporting non-LoRa RF chipsets such as Si4xxx (GFSK,
FSK, OOK) or nRF905 and nRF24L01+ (both GFSK) at a later date, I don't
think those modulations should be some netlink option on a PF_LORA
interface but cleanly distinguished as ETH_P_GFSK or something.
For example, the Chistera Pi HAT has both an RFM95W and an RFM22 module.

The next question arising is how the user would create such an skb. Just
like I was hesitant about PF_LORAWAN originally, I'd like to avoid
polluting the PF_ number space for each of these. Maybe have one PF_FSK
as equivalent to PF_LORA and then have either a socket option or
sockaddr field to select the modulation variants? Not sure how exactly
those others differ from each other, that's why I tried to postpone the
FSK topic and to focus on LoRa first - b) below.

At this point we could also argue whether we need a PF_LORA at all or
rather just some generic PF_RADIO with lots of options stored in its
sockaddr.
One criteria will be whether we need multiple protocol options per
modulation type or just one. For LoRa that was the dgram vs. raw
discussion; for FSK/OOK I read packet mode vs. continuous mode in SX127x
but not obvious if that affects the protocol or just the device driver.

Getting back to your point, the data rate selection at LoRaWAN layer
needs to determine how an skb gets passed between device driver and MAC.


Another aspect FSK touches on is interactions with other subsystems. For
example, how an sx1276 802.15.4 implementation for FSK/OOK (or LoRa, as
you mentioned in your slides) would best interact with ieee802154 and
mac802154 code when not done as standalone implementation. Or how to
deal with SigFox on the same module as LoRaWAN - not aware of any kernel
subsystem for SigFox. By comparison, on-module BLE sounds slightly
easier, since it uses a separate antenna.
(Haven't seen LoRa plus NB-IoT yet, to name the other LPWAN technology.)

> - LoRaWAN should handle the data rate changing requests and then calls
> the corresponding operation functions.  Of course, the hardware's
> capability registered before should also be under consideration at the
> same time.
> 
>>   a) Is there any precedence from the Wifi world for dynamically selecting
>>      between our own trusted Open Source implementation vs. hardware/firmware
>>      accelerated and/or certified implementations?
>>
>>   b) Would a proof of concept for FSK (non-LoRa) modes be required for
>>      merging any LoRa driver for chipsets that support both? Or is there any
>>      facility or design guidelines that would allow us to focus on LoRa and
>>      LoRaWAN and leave non-LoRa radio modes to later contributors?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
