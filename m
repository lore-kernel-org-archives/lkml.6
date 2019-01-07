Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9E9C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C522089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfAGL3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:29:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:47262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726783AbfAGL3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:29:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C1861AE02;
        Mon,  7 Jan 2019 11:29:33 +0000 (UTC)
Subject: Re: [RFC net-next 11/15] net: lora: Add IMST WiMOD
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org, Jon Ortego <Jon.Ortego@imst.de>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org,
        "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-12-afaerber@suse.de>
 <53180657-d3f7-21ea-cbb5-cf591ee4755e@gmx.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <076ce794-036a-291a-0167-5f302f67f74f@suse.de>
Date:   Mon, 7 Jan 2019 12:29:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <53180657-d3f7-21ea-cbb5-cf591ee4755e@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heinrich,

+ linux-lpwan, - other vendors

Am 06.01.19 um 15:57 schrieb Heinrich Schuchardt:
> On 7/1/18 1:08 PM, Andreas Färber wrote:
>> The IMST WiMOD uses a SLIP based binary UART protocol. Two separate
>> firmwares are available. By default it ships with a LoRaWAN firmware.
>> The alternative firmware is a custom P2P addressing mode based on LoRa.
>>
>> Cc: Jon Ortego <Jon.Ortego@imst.de>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
>>  drivers/net/lora/Kconfig  |   8 +
>>  drivers/net/lora/Makefile |   3 +
>>  drivers/net/lora/wimod.c  | 597 ++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 608 insertions(+)
>>  create mode 100644 drivers/net/lora/wimod.c
>>
>> diff --git a/drivers/net/lora/Kconfig b/drivers/net/lora/Kconfig
>> index 940bd2cbe106..2e05caef8645 100644
>> --- a/drivers/net/lora/Kconfig
>> +++ b/drivers/net/lora/Kconfig
>> @@ -31,6 +31,14 @@ config LORA_SX1276
>>  	help
>>  	  Semtech SX1272/1276/1278
>>  
>> +config LORA_WIMOD
>> +	tristate "IMST WiMOD driver"
> 
> scripts/checkpatch.pl throws this warning:
> WARNING: please write a paragraph that describes the config symbol fully
> 
> IMST has multiple products related to "WiMOD":
> * WiMOD iC880A
> * WiMOD module iM871A
> * WSA01-iM880B - WiMOD Shield for Arduino
> * iM880B-L - Long Range Radio Module

True, and I notice that my wimod.c doesn't explain it either.

Similarly, in patch 12/15 USI is the name of its vendor (but that one
does mention the model in commit message, Kconfig help and header).

> 
> And IMST is not very consistent about what is called "WiMOD". So this
> leaves me clueless concerning what this Kconfig option is about. Please,
> provide a description.

So, do you actually have any of them? :) Otherwise the Kconfig symbol,
patch subject and cover letter all clearly indicate LoRa.

* iM871A is rather a Wireless M-Bus module - if you have it and are
interested in collaborating on a driver, let me know. Its HCI message
format looks slightly different, so it would need a separate driver.
Currently I only have access to multiple chipsets with pure FSK support
that one would need a Linux userspace/kernel implementation of wM-Bus
for, plus something to test against. Some LoRa gateway vendors have
expressed a need to consume the FSK support in SX1301 for wM-Bus; sx127x
might still be the easiest path to testing that, but FSK has not been an
implementation priority for me yet, more a design consideration.
Side note: A serdev driver like this might be used to implement also
(non-Wireless) M-Bus in kernel space, if desired.

* iC880A uses the sx130x SPI driver directly. You'll have a hard time
using this serdev driver with it... Please don't waste time commenting
on patch 15/15, it has largely been rewritten since and is under active
work on linux-lpwan list, still in preparation of an RFC v2 patchset.
https://lists.infradead.org/pipermail/linux-lpwan/
The sx130x driver is being tested with iC880A (and on RPi3B+ suffers
from the same clk_prepare() issue as RAK831 on Pine64+).

* iM880B, iM880B-L, iM881A and iM980A should hopefully be pretty much
compatible, and they were the only LoRa modules at the time of posting.
This driver had been tested with the Arduino Shield, using ArPi-600
adapter to Raspberry Pi pinout, connected to a Pine64+ board.

Sadly my Pine64+ board that this Arduino Shield was connected to had
stopped booting (and annoyingly not for the first time). Looks like it
damaged U-Boot somehow... (no serial output anymore)
Writing a new U-Boot onto the card or starting with a new image, I ran
into a U-Boot/TF-A issue related to UEFI that I've now reported:
https://bugzilla.opensuse.org/show_bug.cgi?id=1120869
I now have a new booting image again to continue this driver but need to
set up my test environment with DT Overlays and kernel tree again.

* I hope the new iM282A can work with the same driver - it uses LR-Base+
firmware, whereas iM880B ships with LR-LoRaWAN and has an optional
LR-Base firmware. I am hopeful to cover both with one self-detecting
driver, somehow. A difficulty with LR-Base/LR-Base+ is that it prepends
some custom addressing fields to the user-supplied data, so is not
really PF_LORA / ETH_P_LORA in the sense of this series.

=> This driver covers more than one model. At the moment only iM880B is
verified, iM282A TBD. If you have better naming suggestions let us know.

And if you have experience flashing firmware onto the Arduino Shield
using Linux/stm32flash, do let me know. I'll need that to test LR-Base.

> There are dozens of warnings given by scripts/checkpatch. Please, have a
> look at them.

Please take a look at the date of these patches: It is not helpful to
nitpick about early RFC patches from July now. If my linux-lora.git repo
still has that issue (which I'm sure it does, but you didn't mention you
checked!) then you're welcome to send a fix-up patch against that repo
to linux-lpwan list. Otherwise this is not a priority for me, given
current clk_prepare() lockups and other bigger issues under discussion!

The cover letter mentioned a number of big open socket questions, and so
did my ELCE 2018 presentation:

https://events.linuxfoundation.org/wp-content/uploads/2017/12/ELCE2018_LoRa_final_Andreas-Farber.pdf
https://www.youtube.com/watch?v=Jjel65sZO9M

The purpose of this RFC series was to discuss the _socket layer_ design
and how it would interface with different drivers. This driver didn't
expose any netdev yet, focusing on a PoC of its binary as opposed to AT
protocol. Therefore it is not ready for merging or for unfamiliar users.
Back then there was no LoRaWAN patchset yet (discussing how Jian-Hong's
and my work could be combined was one purpose of this RFC!), now we have
some preliminary constants and an early PF_LORAWAN socket implementation
staged that we can revisit this driver with.

It still carries two implementations for sending the HCI commands that
I'd be interested in feedback for deciding on which to pursue. Also the
receive path of all my serdev drivers could use some review and help.
This driver as-is is nowhere near merging, so please understand that
line length etc. warnings are the least of my concern for this WIP code.

Please don't forget to CC the new linux-lpwan mailing list on any reply
- it contains people for whom the netdev traffic simply is too much.

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
