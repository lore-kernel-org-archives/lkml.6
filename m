Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085D7ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 18:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD915208EA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 18:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD915208EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeGOShv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 14:37:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:52400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbeGOShv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 14:37:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B1F11ADFB;
        Sun, 15 Jul 2018 18:14:03 +0000 (UTC)
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
To:     Ben Whitten <Ben.Whitten@lairdtech.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        Jon Ortego <Jon.Ortego@imst.de>,
        "contact@snootlab.com" <contact@snootlab.com>,
        Brian Ray <brian.ray@link-labs.com>,
        "lora@globalsat.com.tw" <lora@globalsat.com.tw>,
        Alexander Graf <agraf@suse.de>,
        =?UTF-8?Q?Michal_Kube=c4=8dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Hasnain Virk <Hasnain.Virk@arm.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wireless@vger.kernel.org, seth.forshee@canonical.com
References: <20180701110804.32415-1-afaerber@suse.de>
 <BY1PR02MB11147C7443AB9623D6B65798E75A0@BY1PR02MB1114.namprd02.prod.outlook.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <e08cdcfb-207f-bd73-2afd-f775810b72b7@suse.de>
Date:   Sun, 15 Jul 2018 20:13:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <BY1PR02MB11147C7443AB9623D6B65798E75A0@BY1PR02MB1114.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-wireless + Stefan + Seth

Am 11.07.2018 um 17:21 schrieb Ben Whitten:
>> This patchset is clearly not ready for merging, but is being
>> submitted for
>> discussion, as requested by Jiri, in particular of the design
>> choices:
>>
>> 1) PF_LORA/AF_LORA and associated identifiers are
>> proposed to represent
>>    this technology. While for an SX1276 - case a) above - it
>> might work to
>>    layer LoRaWAN as a protocol option for PF_LORA and add
>> LoRaWAN address
>>    fields to the union in my sockaddr_lora, how would that
>> work for devices
>>    that only support LoRaWAN but not pure LoRa? Do we
>> need both AF_LORA and
>>    AF_LORAWAN, or just a separate ETH_P_LORAWAN or
>> ARPHRD_LORAWAN?
>>
>> 2) PF_LORA is used with SOCK_DGRAM here. The
>> assumption is that RAW mode
>>    would be DGRAM plus preamble plus optional checksum.
>>
>> 3) Only the transmit path is partially implemented already.
>> The assumption
>>    is that the devices should go into receive mode by default
>> and only
>>    interrupt that when asked to transmit.
>>
>> 4) Some hardware settings need to be supplied externally,
>> such as the radio
>>    frequency for some modules, but many others can be
>> runtime-configured,
>>    such as Spreading Factor, Bandwidth, Sync Word, or which
>> antenna to use.
>>    What settings should be implemented as socket option vs.
>> netlink layer
>>    vs. ioctl vs. sysfs? What are the criteria to apply?
>>
>> 5) Many of the modules support multiple modes, such as
>> LoRa, LoRaWAN and FSK.
>>    Lacking a LoRaWAN implementation, I am currently
>> switching them into LoRa
>>    mode at probe time wherever possible. How do we deal
>> with that properly?
>>
>>   a) Is there any precedence from the Wifi world for
>> dynamically selecting
>>      between our own trusted Open Source implementation
>> vs. hardware/firmware
>>      accelerated and/or certified implementations?
>>
>>   b) Would a proof of concept for FSK (non-LoRa) modes be
>> required for
>>      merging any LoRa driver for chipsets that support both?
>> Or is there any
>>      facility or design guidelines that would allow us to focus
>> on LoRa and
>>      LoRaWAN and leave non-LoRa radio modes to later
>> contributors?
> 
> Down the line I think we should also plan for a CRDA style regdb somewhere in the path for raw LoRa transceivers operating as softMAC, much like with WiFi.

Yes, I had raised the topic of wireless-regdb for Stefan's conference -
currently it seems to only cover 2.4 GHz, 5 GHz and 60 GHz. Not sure if
we can easily extend that to cover 433 MHz, 868 MHz, 915 MHz and 923 MHz
bands or whether we'd just need something similar... Is 802.15.4 able to
share this database with Wifi?

An argument to share with Wifi might be that Semtech's SX1280 and SX1281
2.4 GHz transceivers claim to support LoRa modulation, too. Having two
different regulatory DBs interact with LoRa drivers seems a bad idea,
and duplicating 2.4 GHz into a new DB doesn't sound appealing either.

https://www.semtech.com/products/wireless-rf/24-ghz-transceivers

Meanwhile my attempt to play with netlink during SUSE Hackweek has been
going slow and I could use some guidance or a volunteer to contribute: I
have a bare skeleton of registration, commands, attributes and multicast
groups, but no plan yet how to connect that to the actual drivers to
query or apply the settings...

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-lora.git/tree/net/lora/netlink.c?h=lora-next

> LoRa radios used in Gateway devices are typically relatively high power (capable of 27dBm) and operate in bands with certain restrictions, eg the EU has keep out areas within 868MHz for alarms and SRD devices must abide by certain duty cycle restrictions, there are also maximum powers to consider for sub-bands. (ETSI EN 300 220-2 V3.2.1, Bands K, L, M, N, P, Q)

> The certified AT style modules will (should) already have this regulatory data baked in so it only applied to situations where we drive the transceivers directly, but it wouldn't hurt to check that the frequency being asked to transmit on doesn't spill into a restricted band.

Some do have configuration options that will need to be set or checked.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
