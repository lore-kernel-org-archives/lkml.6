Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA609C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586562173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586562173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbeHCKkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:40:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:55974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728442AbeHCKkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:40:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 488C1ADBA;
        Fri,  3 Aug 2018 08:44:47 +0000 (UTC)
Subject: linux-lora.git and LoRaWAN (was: [RFC net-next 00/15] net: A socket
 API for LoRa)
To:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc:     Ben Whitten <Ben.Whitten@lairdtech.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?Q?Konstantin_B=c3=b6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
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
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "seth.forshee@canonical.com" <seth.forshee@canonical.com>,
        Jon Ortego <Jon.Ortego@imst.de>,
        Daniele Comel <dcomel@mipot.com>, Powen Ko <powenk@looptek.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <BY1PR02MB11147C7443AB9623D6B65798E75A0@BY1PR02MB1114.namprd02.prod.outlook.com>
 <e08cdcfb-207f-bd73-2afd-f775810b72b7@suse.de>
 <BY1PR02MB11143134B9ABAC9C9929A9C4E7530@BY1PR02MB1114.namprd02.prod.outlook.com>
 <CAC=mGzg0uP6ddm-kjev6JAH=GrKX9bT6s2canFOjKsC4rCcVAQ@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 xsFNBE6W6ZQBEAC/BIukDnkVenIkK9O14UucicBIVvRB5WSMHC23msS+R2h915mW7/vXfn+V
 0nrr5ECmEg/5OjujKf0x/uhJYrsxcp45nDyYCk+RYoOJmGzzUFya1GvT/c04coZ8VmgFUWGE
 vCfhHJro85dZUL99IoLP21VXEVlCPyIngSstikeuf14SY17LPTN1aIpGQDI2Qt8HHY1zOVWv
 iz53aiFLFeIVhQlBmOABH2Ifr2M9loRC9yOyGcE2GhlzgyHGlQxEVGFn/QptX6iYbtaTBTU0
 c72rpmbe1Nec6hWuzSwu2uE8lF+HYcYi+22ml1XBHNMBeAdSEbSfDbwc///8QKtckUzbDvME
 S8j4KuqQhwvYkSg7dV9rs53WmjO2Wd4eygkC3tBhPM5s38/6CVGl3ABiWJs3kB08asUNy8Wk
 juusU/nRJbXDzxu1d+hv0d+s5NOBy/5+7Pa6HeyBnh1tUmCs5/f1D/cJnuzzYwAmZTHFUsfQ
 ygGBRRKpAVu0VxCFNPSYKW0ULi5eZV6bcj+NAhtafGsWcv8WPFXgVE8s2YU38D1VtlBvCo5/
 0MPtQORqAQ/Itag1EHHtnfuK3MBtA0fNxQbb2jha+/oMAi5hKpmB/zAlFoRtYHwjFPFldHfv
 Iljpe1S0rDASaF9NsQPfUBEm7dA5UUkyvvi00HZ3e7/uyBGb0QARAQABzSJBbmRyZWFzIEbD
 pHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+wsF7BBMBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgID
 AQIeAQIXgAUCTqGJnQIZAQAKCRD6LtEtPn4BPzetD/4rF6k/HF+9U9KqykfJaWdUHJvXpI85
 Roab12rQbiIrL4hVEYKrYwPEKpCf+FthXpgOq+JdTGJ831DMlTx7Ed5/QJ9KAAQuhZlSNjSc
 +FNobJm7EbFv9jWFjQC0JcOl17Ji1ikgRcIRDCul1nQh9jCdfh1b848GerZmzteNdT9afRJm
 7rrvMqXs1Y52/dTlfIW0ygMA2n5Vv3EwykXJOPF6fRimkErKO84sFMNg0eJV9mXs+Zyionfi
 g2sZJfVeKjkDqjxy7sDDBZZR68I9HWq5VJQrXqQkCZUvtr6TBLI+uiDLbGRUDNxA3wgjVdS2
 v9bhjYceSOHpKU+h3H2S8ju9rjhOADT2F5lUQMTSpjlzglh8IatV5rXLGkXEyum4MzMo2sCE
 Cr+GD6i2M3pHCtaIVV3xV0nRGALa6DdF7jBWqM54KHaKsE883kFH2+6ARcPCPrnPm7LX98h2
 4VpG984ysoq6fpzHHG/KCaYCEOe1bpr3Plmmp3sqj0utA6lwzJy0hj5dqug+lqmg7QKAnxl+
 porgluoY56U0X0PIVBc0yO0dWqRxtylJa9kDX/TKwFYNVddMn2NQNjOJXzx2H9hf0We7rG7+
 F/vgwALVVYbiTzvp2L0XATTv/oX4BHagAa/Qc3dIsBYJH+KVhBp+ZX4uguxk4xlc2hm75b1s
 cqeAD87BTQROlumUARAAzd7eu+tw/52FB7xQZWDv5aF+6CAkoz7AuY4s1fo0AQQDqjLOdpQF
 bifdH7B8SnsA4eo0syfs+1tZW6nn9hdy1GHEMbeuvdhNwkhEfYGDYpSue7oVxB4jajKvRHAP
 VcewKZIxvIiZ5aSp5n1Bd7B0c0C443DHiWE/0XWSpvbU7fTzTNvdz+2OZmGtqCn610gBqScv
 1BOiP3OfLly8ghxcJsos23c0mkB/1iWlzh3UMFIGrzsK3sZJ/3uRaLYFimmqqPlSwFqx3b0M
 1gFdHWKfOpvQ4wwP5P10xwvqNXLWC30wB1QmJGD/X8aAoVNnGsmEL7GcWF4cLoOSRidSoccz
 znShE+Ap+FVDD6MRyesNT4D67l792//B38CGJRdELtNacdwazaFgxH9O85Vnd70ZC7fIcwzG
 yg/4ZEf96DlAvrSOnu/kgklofEYdzpZmW+Fqas6cnk6ZaHa35uHuBPesdE13MVz5TeiHGQTW
 xP1jbgWQJGPvJZ+htERT8SZGBQRb1paoRd1KWQ1mlr3CQvXtfA/daq8p/wL48sXrKNwedrLV
 iZOeJOFwfpJgsFU4xLoO/8N0RNFsnelBgWgZE3ZEctEd4BsWFUw+czYCPYfqOcJ556QUGA9y
 DeDcxSitpYrNIvpk4C5CHbvskVLKPIUVXxTNl8hAGo1Ahm1VbNkYlocAEQEAAcLBXwQYAQIA
 CQUCTpbplAIbDAAKCRD6LtEtPn4BPzA6D/9TbSBOPM99SHPX9JiEQAw4ITCBF2oTWeZQ6RJg
 RKpB15lzyPfyFbNSceJp9dCiwDWe+pzKaX6KYOFZ5+YTS0Ph2eCR+uT2l6Mt6esAun8dvER/
 xlPDW7p88dwGUcV8mHEukWdurSEDTj8V3K29vpgvIgRq2lHCn2wqRQBGpiJAt72Vg0HxUlwN
 GAJNvhpeW8Yb43Ek7lWExkUgOfNsDCTvDInF8JTFtEXMnUcPxC0d/GdAuvBilL9SlmzvoDIZ
 5k2k456bkY3+3/ydDvKU5WIgThydyCEQUHlmE6RdA3C1ccIrIvKjVEwSH27Pzy5jKQ78qnhv
 dtLLAavOXyBJnOGlNDOpOyBXfv02x91RoRiyrSIM7dKmMEINKQlAMgB/UU/6B+mvzosbs5d3
 4FPzBLuuRz9WYzXmnC460m2gaEVk1GjpidBWw0yY6kgnAM3KhwCFSecqUQCvwKFDGSXDDbCr
 w08b3GDk40UoCoUq9xrGfhlf05TUSFTg2NlSrK7+wAEsTUgs2ZYLpHyEeftoDDnKpM4ghs/O
 ceCeyZUP1zSgRSjgITQp691Uli5Nd1mIzaaM8RjOE/Rw67FwgblKR6HAhSy/LYw1HVOu+Ees
 RAEdbtRt37A8brlb/ENxbLd9SGC8/j20FQjit7oPNMkTJDs7Uo2eb7WxOt5pSTVVqZkv7Q==
Organization: SUSE Linux GmbH
Message-ID: <6dda350b-66ab-b5ab-41ed-319b27e4e28c@suse.de>
Date:   Fri, 3 Aug 2018 10:44:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAC=mGzg0uP6ddm-kjev6JAH=GrKX9bT6s2canFOjKsC4rCcVAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jian-Hong,

Am 02.08.2018 um 09:52 schrieb Jian-Hong Pan:
> 2018-07-18 19:28 GMT+08:00 Ben Whitten <Ben.Whitten@lairdtech.com>:
>>> 1) PF_LORA/AF_LORA and associated identifiers are
>>> proposed to represent
>>>    this technology. While for an SX1276 [...] it
>>> might work to
>>>    layer LoRaWAN as a protocol option for PF_LORA and
> add
>>> LoRaWAN address
>>>    fields to the union in my sockaddr_lora, how would that
>>> work for devices
>>>    that only support LoRaWAN but not pure LoRa? Do we
>>> need both AF_LORA and
>>>    AF_LORAWAN, or just a separate ETH_P_LORAWAN or
>>> ARPHRD_LORAWAN?
[...]
>>> Meanwhile my attempt to play with netlink during SUSE
>>> Hackweek has been
>>> going slow and I could use some guidance or a volunteer to
>>> contribute: I
>>> have a bare skeleton of registration, commands, attributes
>>> and multicast
>>> groups, but no plan yet how to connect that to the actual
>>> drivers to
>>> query or apply the settings...
>>
>> Happy to help, I will be starting from zero on netlink but I can contribute my existing work incorporating Marks comments for sx1301 etal.
>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/li
>>> nux-lora.git/tree/net/lora/netlink.c?h=lora-next
> 
> Is this the repository used for the LoRa subsystem now?!!!
> If it is, than great!

Yes, my linux-lora.git contains this RFC patchset (modulo SX1276 fixes
spotted by kbuild bot) plus a new serdev driver for another module and
ongoing work by Ben and me for refactoring SX1301. It's monitored by the
0-day test service (kbuild bot).

As this patchset was an RFC and does not have any Acked-bys from
maintainers, the tree does not have a for-next branch integrated into
linux-next on basis of 4.18-rc1, but instead (like my personal GitHub
tree before) has a lora-next branch that rebases as patch queue on top
of linux-next for now.

The intent is to allow collaboration on getting things into a state that
I can later submit a clean (squashed) RFC v2 for review, with all issues
raised for this v1 addressed.

For contributing patches to my linux-lora.git I suggest to use
--subject-prefix="PATCH lora-next" to distinguish from net-next.
And I just realize I should add a MAINTAINERS entry in my tree to make
sure patches CC me, too. (I do monitor netdev for patches with subject
"lora", but chances are someone might omit that.)

> As the previous mails, I am trying to implement the LoRaWAN
> specification as the soft MAC as the MAC layer over LoRa PHY.
> This is the the talk about LoRaWAN class module I gave in Netdev Conf
> https://www.slideshare.net/chienhungpan/lorawan-class-module-and-subsystem
> 
> The expectation is:
> 
> socket APIs:
> send and receive the data
> ------------------------------------------------------------
> LoRaWAN class module implements MAC:
> append the header/footer, encryption/decryption, timing slot and MAC commands
> ------------------------------------------------------------
> LoRa device drivers:
> send and receive the messages for MAC layer
> ------------------------------------------------------------
> LoRa devices

Thanks for sharing your slides. We seem to be in alignment for the
abstract concept above. The devil is in the implementation details. ^.-

> Is it possible that combine the LoRaWAN class module I implemented?

Yes, as stated in this cover letter, I would love if you could help
merge your LoRaWAN implementation with my driver framework. Comparing
802.15.4 and 802.11, I think MAC code should go into net/maclorawan/ and
then is a fairly independent module, with you as maintainer.

> I start from the simplest class A end device's behavior, especially
> the timing slot.
> Also the encryption/decryption for uplink/downlink data messages.
> I can send it as patches.
> 
> However, I have 2 problems right now.
> 1. Which Address and Protocol Family should we use?  PF_LORA or PF_LORAWAN?

That was one of the questions I raised above. I now think we need both.
I'm not yet too deep into LoRaWAN, but from the AT command interfaces
I've seen there's confirmed and unconfirmed transmission modes that with
PF_LORAWAN might be mapped to SOCK_STREAM and SOCK_DGRAM. Or do you see
a way of doing both on a single PF_LORA SOCK_LORAWAN socket?

> 2. To test the LoRaWAN class module, adding more procedures in LoRa
> device drivers to register as a LoRaWAN device is needed.

No, I don't think so. There are (at least) two types of devices, LoRaWAN
and LoRa devices. The SX1276 is a pure LoRa device and thus should only
expose a LoRa network device. It'll be the task of the maclorawan module
to translate between the two layers, not the business of the device
driver; SX1276 should receive a ready-to-send LoRa skb. For Ethernet,
PF_INET and PF_INET6 don't need separate devices either, both use eth0.

What I do think we need is your struct lora_hw, maybe renamed to
lora_phy. That could be the missing piece for registration of the device
drivers with nllora module?
Note that similarly we'll also need an nllorawan module that needs to
work both with your maclorawan and with some of my device drivers that
implement the MAC in an MCU.

Additionally I've been looking into socket options at PF_LORA dgram
layer for some radio options, but discarded that again for lack of
precedence. Basically I wondered whether we could allow to choose SF,
bandwidth, etc. on socket level and then apply those settings before
sending one packet rather than expecting a global netlink operation that
affects all sockets for that interface.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
