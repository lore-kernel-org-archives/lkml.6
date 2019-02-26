Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BB0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113832173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cyI/OZav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfBZLbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:31:42 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48688 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfBZLbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:31:40 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1QBVVRm035187;
        Tue, 26 Feb 2019 05:31:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551180692;
        bh=okHp2H97RrpUUPMNbt8c4P55MjVZqWgISe0t45Rm1+I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cyI/OZavdF7SsjU6PjXv992tP5bHWYlkrh6CZAmQdgRUexs6wHlquHqiK3vgv77Ua
         ZsQfDylZW45IU4O6B9I+2WNoI11t/OD3py5OJ6N9aQ8CyaAW2f0oQwZ9YJuIStuP4C
         4nMN1GY07t8CqIFCNIn9/Aptn5ugh1uayMJGaBdI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1QBVVXq064030
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 05:31:31 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 26
 Feb 2019 05:31:31 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 26 Feb 2019 05:31:31 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1QBVRbf006222;
        Tue, 26 Feb 2019 05:31:27 -0600
Subject: Re: Linux-next 20190218: am57xx-evm: mmc1: ADMA error
To:     Ming Lei <tom.leiming@gmail.com>
CC:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
References: <CA+G9fYsmC5ckLXfQxSUn-tqxLZ4NofEyb9RA69Q07RUoxc79RQ@mail.gmail.com>
 <34c78d7f-cc3c-853d-b3fd-a70abdb66293@ti.com>
 <22ccca46-7390-1707-cfca-43b3577b79f2@ti.com>
 <CACVXFVP0h-xvJaW1HaMrhozwhR484x0owc6XX63JT-59N08Fag@mail.gmail.com>
 <236a3ac2-5988-9150-4a53-4a33a45d595e@ti.com>
 <CACVXFVNqtPnWHp+b0-ED70n1pcv9EkARKYWVKaWtFEEgh0N1XA@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <c6d72393-cf42-a4f6-06b3-589ca1f3de19@ti.com>
Date:   Tue, 26 Feb 2019 17:04:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVNqtPnWHp+b0-ED70n1pcv9EkARKYWVKaWtFEEgh0N1XA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/02/19 3:36 PM, Ming Lei wrote:
> On Tue, Feb 26, 2019 at 2:47 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
>>
>> Hi Ming Lei,
>>
>> On 26/02/19 7:11 AM, Ming Lei wrote:
>>> On Mon, Feb 25, 2019 at 9:14 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
>>>>
>>>> Hi Naresh,
>>>>
>>>> + Commit authors.
>>>>
>>>> On 19/02/19 6:38 PM, Faiz Abbas wrote:
>>>>> Hi Naresh,
>>>>>
>>>>> On 18/02/19 6:57 PM, Naresh Kamboju wrote:
>>>>>> Do you see this error on am57xx-evm running Linux next 20190218 ?
>>>>>> I have tested on multiple devices and found this error.
>>>>>> Please find the full boot log [1].
>>>>>> Am i missing any pre required configs [2] ?
>>>>>>
>>>>>> [    5.620263] mmc1: ADMA error
>>>>>> [    5.623266] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
>>>>>> [    5.629740] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
>>>>>> [    5.636215] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x0000ffff
>>>>>> [    5.642690] mmc1: sdhci: Argument:  0x002cec70 | Trn mode: 0x00000033
>>>>>> [    5.649162] mmc1: sdhci: Present:   0x01f00000 | Host ctl: 0x00000010
>>>>>> [    5.655634] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>>>>>> [    5.662108] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
>>>>>> [    5.668582] mmc1: sdhci: Timeout:   0x0000000c | Int stat: 0x00000000
>>>>>> [    5.675055] mmc1: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
>>>>>> [    5.681529] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>>>>> [    5.688002] mmc1: sdhci: Caps:      0x21e90080 | Caps_1:   0x00000f77
>>>>>> [    5.694474] mmc1: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
>>>>>> [    5.700949] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffef
>>>>>> [    5.707423] mmc1: sdhci: Resp[2]:   0x0f5903ff | Resp[3]:  0xd04f0132
>>>>>> [    5.713896] mmc1: sdhci: Host ctl2: 0x00000004
>>>>>> [    5.718364] mmc1: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xab868218
>>>>>>
>>>>>
>>>>> I see this as well on my setup. Trying to bisect now. Will keep you posted.
>>>>
>>>>
>>>> Reverting the following commit fixes this.
>>>> commit 07173c3ec276cbb18dc0e0687d37d310e98a1480
>>>> Author: Ming Lei <ming.lei@redhat.com>
>>>> Date:   Fri Feb 15 19:13:20 2019 +0800
>>>>
>>>>     block: enable multipage bvecs
>>>>
>>>>     This patch pulls the trigger for multi-page bvecs.
>>>>
>>>>     Reviewed-by: Omar Sandoval <osandov@fb.com>
>>>>     Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> Hi,
>>>
>>> Thanks for your report & bisect.
>>>
>>> Could you test the following patch?
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.1/block&id=8f4e80da764ec1ca44c83f3e17dbc9bf0209bccc
>>>
>>> Or  simply run the latest -next?
>>
>> That didn't fix it for me. Still see ADMA error.
>>
>> [   13.126186] mmc0: ADMA error
>> [   13.129084] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [   13.135552] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
>> [   13.142019] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000000
>> [   13.148485] mmc0: sdhci: Argument:  0x00000089 | Trn mode: 0x00000033
>> [   13.154952] mmc0: sdhci: Present:   0x00000000 | Host ctl: 0x00000012
>> [   13.161418] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>> [   13.167885] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
>> [   13.174351] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
>> [   13.180817] mmc0: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
>> [   13.187282] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>> [   13.193748] mmc0: sdhci: Caps:      0x25e90080 | Caps_1:   0x00000f77
>> [   13.200215] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
>> [   13.206682] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x3b377f80
>> [   13.213148] mmc0: sdhci: Resp[2]:   0x5b590000 | Resp[3]:  0x400e0032
>> [   13.219613] mmc0: sdhci: Host ctl2: 0x00000000
>> [   13.224073] mmc0: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xae857288
>> [   13.230538] mmc0: sdhci: ============================================
> 
> OK, I will write a debug patch to dump the sg data and see if it is
> generated as wrong.
> 
> BTW, which kind of failure can you find from the mmc dma error log?
> 

It looks like it only happens for some requests. More verbose log with
dma descriptor entries:

[   14.840865] mmc0: ADMA error
[   14.840869] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[   14.840874] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
[   14.840879] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000000
[   14.840884] mmc0: sdhci: Argument:  0x00000200 | Trn mode: 0x00000033
[   14.840889] mmc0: sdhci: Present:   0x00000000 | Host ctl: 0x00000012
[   14.840893] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
[   14.840898] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
[   14.840903] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
[   14.840908] mmc0: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
[   14.840912] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[   14.840917] mmc0: sdhci: Caps:      0x25e90080 | Caps_1:   0x00000f77
[   14.840922] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
[   14.840926] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x20050044
[   14.840931] mmc0: sdhci: Resp[2]:   0x53445531 | Resp[3]:  0x744a6055
[   14.840935] mmc0: sdhci: Host ctl2: 0x00000000
[   14.840939] mmc0: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xae857300
[   14.840943] mmc0: sdhci: ============================================
[   14.840950] mmc0: sdhci: be2c9004: DMA 0xab1bd000, LEN 0x1000, Attr=0x21
[   14.840956] mmc0: sdhci: 92173e21: DMA 0xab1bc000, LEN 0x1000, Attr=0x21
[   14.840962] mmc0: sdhci: c8a0cde4: DMA 0xab1bb000, LEN 0x1000, Attr=0x21
[   14.840967] mmc0: sdhci: 4bb03017: DMA 0xab1ba000, LEN 0x1000, Attr=0x21
[   14.840972] mmc0: sdhci: 2fb0d59e: DMA 0xab1b9000, LEN 0x1000, Attr=0x21
[   14.840978] mmc0: sdhci: c3024ff2: DMA 0xab1b8000, LEN 0x1000, Attr=0x21
[   14.840983] mmc0: sdhci: 0738188d: DMA 0xab179000, LEN 0x1000, Attr=0x21
[   14.840989] mmc0: sdhci: 78ecca83: DMA 0xab178000, LEN 0x1000, Attr=0x21
[   14.840994] mmc0: sdhci: 1432e5a9: DMA 0xab0d7000, LEN 0x1000, Attr=0x21
[   14.840999] mmc0: sdhci: 8a36c77c: DMA 0xab0d6000, LEN 0x1000, Attr=0x21
[   14.841005] mmc0: sdhci: b7196410: DMA 0xab0d5000, LEN 0x1000, Attr=0x21
[   14.841010] mmc0: sdhci: dcb25259: DMA 0xab0d4000, LEN 0x1000, Attr=0x21
[   14.841015] mmc0: sdhci: ef1e5d32: DMA 0xab0d3000, LEN 0x1000, Attr=0x21
[   14.841020] mmc0: sdhci: 0319c66c: DMA 0xab0d2000, LEN 0x1000, Attr=0x21
[   14.841026] mmc0: sdhci: 2e6b85d9: DMA 0xab0d1000, LEN 0x1000, Attr=0x21
[   14.841031] mmc0: sdhci: d4dd19da: DMA 0xab0d0000, LEN 0x1000, Attr=0x21
[   14.841036] mmc0: sdhci: 55cdc0f6: DMA 0xab27f000, LEN 0x1000, Attr=0x21
[   14.841041] mmc0: sdhci: a172f4f3: DMA 0xab27e000, LEN 0x1000, Attr=0x21
[   14.841046] mmc0: sdhci: ed27e53e: DMA 0xab27d000, LEN 0x1000, Attr=0x21
[   14.841051] mmc0: sdhci: c04971ce: DMA 0xab27c000, LEN 0x1000, Attr=0x21
[   14.841057] mmc0: sdhci: f43985d3: DMA 0xab27b000, LEN 0x1000, Attr=0x21
[   14.841062] mmc0: sdhci: b977bd17: DMA 0xab27a000, LEN 0x1000, Attr=0x21
[   14.841067] mmc0: sdhci: 8b74ee6f: DMA 0xab279000, LEN 0x1000, Attr=0x21
[   14.841072] mmc0: sdhci: 12e52bc8: DMA 0xab30d000, LEN 0xffff, Attr=0x21
[   14.841077] mmc0: sdhci: b39efa31: DMA 0xae857000, LEN 0x0001, Attr=0x21
[   14.841082] mmc0: sdhci: bc4b71f0: DMA 0xab31d000, LEN 0x3000, Attr=0x21
[   14.841087] mmc0: sdhci: 4cb5aa08: DMA 0xab2a8000, LEN 0x2000, Attr=0x21
[   14.841092] mmc0: sdhci: 5e717781: DMA 0xab12a000, LEN 0x2000, Attr=0x21
[   14.841098] mmc0: sdhci: 125d82b5: DMA 0xab2b4000, LEN 0x4000, Attr=0x21
[   14.841103] mmc0: sdhci: b33874b9: DMA 0xab148000, LEN 0x4000, Attr=0x21
[   14.841108] mmc0: sdhci: 9b0e47a5: DMA 0xab218000, LEN 0x8000, Attr=0x21
[   14.841113] mmc0: sdhci: 47ce17da: DMA 0xab2a0000, LEN 0x2000, Attr=0x21
[   14.841118] mmc0: sdhci: 97ea0d9f: DMA 0x00000000, LEN 0x0000, Attr=0x03

There is a big transfer of 0xffff length followed by a smaller transfer
of 0x1 (at address 0xae857000 above) and that is where it fails. This is
the same signature every time it happens.

Full Log:
https://pastebin.ubuntu.com/p/Rs4fzFbp4M/

Thanks,
Faiz
