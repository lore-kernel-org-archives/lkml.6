Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C23EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5F42087A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="quOZVBuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5F42087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeKSRnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 12:43:14 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41680 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeKSRnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 12:43:13 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAJ7Jk7D049873;
        Mon, 19 Nov 2018 01:19:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542611986;
        bh=ez9TOwBcgruEtqdRQ5Buz1bwQy/TipL3OySx6bXr2XM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=quOZVBuU+1b3StLrMnG2+KVxtTiLhBzIplCS9jn2k2/eiULGruZK0584EcUC/Oph1
         +TfGo4XdkE7AskaCPPZv2uudd/bUaY7B/4B/0J7xz5RxCB+s3pPAMzj3562yzt14Hk
         XpJAchMB1w/boD3WcK0vKIgeNlkLvdYs8GHflq4w=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAJ7JkSP029230
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 01:19:46 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 01:19:44 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 01:19:44 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAJ7JcJS009623;
        Mon, 19 Nov 2018 01:19:39 -0600
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions
To:     Nishanth Menon <nm@ti.com>, Vignesh R <vigneshr@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>
References: <20181113060111.16374-1-vigneshr@ti.com>
 <20181113060111.16374-2-vigneshr@ti.com>
 <20181117160502.dhlqbx5qnmdp5iog@kahuna>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <b8c1d975-2b4f-5530-2089-dc04c04f8d86@ti.com>
Date:   Mon, 19 Nov 2018 09:19:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181117160502.dhlqbx5qnmdp5iog@kahuna>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2018 18:05, Nishanth Menon wrote:
> On 11:31-20181113, Vignesh R wrote:
>> The dt-bindings header for TI K3 AM6 SoCs define a set of macros for
>> defining pinmux configs in human readable form, instead of raw-coded
>> hex values.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>   MAINTAINERS                      |  1 +
>>   include/dt-bindings/pinctrl/k3.h | 35 ++++++++++++++++++++++++++++++++
>>   2 files changed, 36 insertions(+)
>>   create mode 100644 include/dt-bindings/pinctrl/k3.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fa45ff36fde9..1574ad6d7ead 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2204,6 +2204,7 @@ S:	Supported
>>   F:	Documentation/devicetree/bindings/arm/ti/k3.txt
>>   F:	arch/arm64/boot/dts/ti/Makefile
>>   F:	arch/arm64/boot/dts/ti/k3-*
>> +F:	include/dt-bindings/pinctrl/k3.h
>>   
>>   ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
>>   M:	Santosh Shilimkar <ssantosh@kernel.org>
>> diff --git a/include/dt-bindings/pinctrl/k3.h b/include/dt-bindings/pinctrl/k3.h
>> new file mode 100644
>> index 000000000000..463d845a9b36
>> --- /dev/null
>> +++ b/include/dt-bindings/pinctrl/k3.h
>> @@ -0,0 +1,35 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * This header provides constants for pinctrl bindings for TI's K3 SoC
>> + * family.
>> + *
>> + * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
>> + */
>> +#ifndef _DT_BINDINGS_PINCTRL_TI_K3_H
>> +#define _DT_BINDINGS_PINCTRL_TI_K3_H
>> +
>> +#define PULLUDEN_SHIFT		(16)
>> +#define PULLTYPESEL_SHIFT	(17)
>> +#define RXACTIVE_SHIFT		(18)
>> +
>> +#define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
>> +#define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
>> +
>> +#define PULL_UP			(1 << PULLTYPESEL_SHIFT | PULL_ENABLE)
>> +#define PULL_DOWN		(0 << PULLTYPESEL_SHIFT | PULL_ENABLE)
>> +
>> +#define INPUT_EN		(1 << RXACTIVE_SHIFT)
>> +#define INPUT_DISABLE		(0 << RXACTIVE_SHIFT)
>> +
>> +/* Only these macros are expected be used directly in device tree files */
>> +#define PIN_OUTPUT		(INPUT_DISABLE | PULL_DISABLE)
>> +#define PIN_OUTPUT_PULLUP	(INPUT_DISABLE | PULL_UP)
>> +#define PIN_OUTPUT_PULLDOWN	(INPUT_DISABLE | PULL_DOWN)
>> +#define PIN_INPUT		(INPUT_EN | PULL_DISABLE)
>> +#define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
>> +#define PIN_INPUT_PULLDOWN	(INPUT_EN | PULL_DOWN)
> 
> 
> Thanks for reducing the combinations down to the minimum needed. We can
> worry about the DS and isolation bits when we have a real user for them.
> 
> Acked-by: Nishanth Menon <nm@ti.com>
> 
> Tero: v4.21-rc1 perhaps ?
> 

Yeah, looks fine, queueing up for 4.21.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
