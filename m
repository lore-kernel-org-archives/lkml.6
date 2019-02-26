Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB559C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2A0213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KgMusNK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfBZGrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:47:19 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41394 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfBZGrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:47:19 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1Q6l9PK075212;
        Tue, 26 Feb 2019 00:47:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551163629;
        bh=lHys8r8YTIirGUfpTY+lj0y6FbgtuKT078ZPzJvwOiM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KgMusNK+nPJe9oZJMkYFKl4qqWnB+aHhWNi3Q08rCqtf0d9TFFoEBm28aGewG8Bq/
         /PpmcUpG2anlyBhFrbK26AqvrmEA+Ala7iEGhx1m/zNDFwxjyCU4J11SWSUw37ofEj
         CJVAzUIwl6ZGd9aUYptTpUAgTLVA8h/pS4h4MSEg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1Q6l9vi068590
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 00:47:09 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 26
 Feb 2019 00:47:08 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 26 Feb 2019 00:47:08 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1Q6l4qh029207;
        Tue, 26 Feb 2019 00:47:05 -0600
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
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <236a3ac2-5988-9150-4a53-4a33a45d595e@ti.com>
Date:   Tue, 26 Feb 2019 12:20:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVP0h-xvJaW1HaMrhozwhR484x0owc6XX63JT-59N08Fag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming Lei,

On 26/02/19 7:11 AM, Ming Lei wrote:
> On Mon, Feb 25, 2019 at 9:14 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
>>
>> Hi Naresh,
>>
>> + Commit authors.
>>
>> On 19/02/19 6:38 PM, Faiz Abbas wrote:
>>> Hi Naresh,
>>>
>>> On 18/02/19 6:57 PM, Naresh Kamboju wrote:
>>>> Do you see this error on am57xx-evm running Linux next 20190218 ?
>>>> I have tested on multiple devices and found this error.
>>>> Please find the full boot log [1].
>>>> Am i missing any pre required configs [2] ?
>>>>
>>>> [    5.620263] mmc1: ADMA error
>>>> [    5.623266] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
>>>> [    5.629740] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
>>>> [    5.636215] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x0000ffff
>>>> [    5.642690] mmc1: sdhci: Argument:  0x002cec70 | Trn mode: 0x00000033
>>>> [    5.649162] mmc1: sdhci: Present:   0x01f00000 | Host ctl: 0x00000010
>>>> [    5.655634] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>>>> [    5.662108] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
>>>> [    5.668582] mmc1: sdhci: Timeout:   0x0000000c | Int stat: 0x00000000
>>>> [    5.675055] mmc1: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
>>>> [    5.681529] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>>> [    5.688002] mmc1: sdhci: Caps:      0x21e90080 | Caps_1:   0x00000f77
>>>> [    5.694474] mmc1: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
>>>> [    5.700949] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffef
>>>> [    5.707423] mmc1: sdhci: Resp[2]:   0x0f5903ff | Resp[3]:  0xd04f0132
>>>> [    5.713896] mmc1: sdhci: Host ctl2: 0x00000004
>>>> [    5.718364] mmc1: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xab868218
>>>>
>>>
>>> I see this as well on my setup. Trying to bisect now. Will keep you posted.
>>
>>
>> Reverting the following commit fixes this.
>> commit 07173c3ec276cbb18dc0e0687d37d310e98a1480
>> Author: Ming Lei <ming.lei@redhat.com>
>> Date:   Fri Feb 15 19:13:20 2019 +0800
>>
>>     block: enable multipage bvecs
>>
>>     This patch pulls the trigger for multi-page bvecs.
>>
>>     Reviewed-by: Omar Sandoval <osandov@fb.com>
>>     Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Hi,
> 
> Thanks for your report & bisect.
> 
> Could you test the following patch?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.1/block&id=8f4e80da764ec1ca44c83f3e17dbc9bf0209bccc
> 
> Or  simply run the latest -next?

That didn't fix it for me. Still see ADMA error.

[   13.126186] mmc0: ADMA error
[   13.129084] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[   13.135552] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
[   13.142019] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000000
[   13.148485] mmc0: sdhci: Argument:  0x00000089 | Trn mode: 0x00000033
[   13.154952] mmc0: sdhci: Present:   0x00000000 | Host ctl: 0x00000012
[   13.161418] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
[   13.167885] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
[   13.174351] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
[   13.180817] mmc0: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
[   13.187282] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[   13.193748] mmc0: sdhci: Caps:      0x25e90080 | Caps_1:   0x00000f77
[   13.200215] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
[   13.206682] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x3b377f80
[   13.213148] mmc0: sdhci: Resp[2]:   0x5b590000 | Resp[3]:  0x400e0032
[   13.219613] mmc0: sdhci: Host ctl2: 0x00000000
[   13.224073] mmc0: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xae857288
[   13.230538] mmc0: sdhci: ============================================

Full Log:

https://pastebin.ubuntu.com/p/4yGqgJCGZQ/

Thanks,
Faiz
