Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21DAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A97C206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SsovpyWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394266AbfBNDCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:02:49 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59858 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfBNDCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:02:47 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1E31nq6101958;
        Wed, 13 Feb 2019 21:01:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550113309;
        bh=A7XQA3zt2a28hBXMVTS8u2FtpxkkhqNkmyEQdwc6VDs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SsovpyWy1EbGaHyGQMDKeb1xzKmQ1pG13+4ehqtLgZ3unBqdMnh3gKoLN9rWQ4Yuw
         XoU53H9SIF93ITq9xEkAS/rHqZgOeTftTjfBLoTuNyLCeRq0avwme0ZU2+ivndH9SN
         p5p1M91IlAJGrWuOJEeiOCYlrUYNd3eQyZN6xVcA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1E31ndR008092
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 21:01:49 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 21:01:49 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 21:01:49 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1E31mth024051;
        Wed, 13 Feb 2019 21:01:48 -0600
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>
CC:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <david@lechnology.com>, <nsekhar@ti.com>, <t-kristo@ti.com>,
        <nsaulnier@ti.com>, <jreeder@ti.com>, <m-karicheri2@ti.com>,
        <woods.technical@gmail.com>, <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <20190204163312.GI5720@atomide.com> <5C5959DB.2090608@ti.com>
 <20190205164132.GT5720@atomide.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <03273340-6477-4276-a0a9-938325c2242c@ti.com>
Date:   Wed, 13 Feb 2019 21:01:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205164132.GT5720@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 10:41 AM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [190205 09:40]:
>> On 04/02/19 18:33, Tony Lindgren wrote:
>>>
>>> 	shrdram2: memory@10000 {
>>> 		device_type = "memory";
>>> 		reg = <0x10000 0x3000>;
>>> 	};
>>
>> Shared RAM is not so straight forward. Both PRU firmwares and both application drivers
>> might need to read/write here. The area split is decided by firmware design and there
>> is no hardware protection to prevent from stomping on each others toes.
>>
>> We need a carveout based memory allocator at least I think that can do a
>> allocate(base_offset, size); into shared RAM.
>>
>> This could be used by pru_rproc driver at firmware load time and by application drivers
>> at initialization time.
>>
>> Thoughts?
> 
> That sounds sane to me :)
> 
>>> If the ti,pruss-gp-mux-sel and ti,pru-interrupt-map are
>>> firmware configuration options, maybe leave them out of
>>> the dts completely and make the app-node optional.
>>
>> Yes the app-node is optional. I will mention it.
>>
>> No, ti,pruss-gp-mux-sel and ti,pru-interrupt-map are not firmware options.
>> But these settings are application/firmware specific.
>>
>> ti,pru-interrupt-map specifies the configuration to be used for the INTC interrupt
>> controller.
> 
> OK. So just to see if we have a standard solution available already..
> It sounds a bit similar to what we're doing with omap-wakeupgen.c
> and stacked interrupts? I wonder if something similar might help
> here?
> 
>> ti,pruss-gp-mux-sel is used to configure this register.
>> "Table 30-20. PRUSS_GPCFG0" in http://www.tij.co.jp/jp/lit/ug/spruhz7h/spruhz7h.pdf
>> "29:26 PR1_PRU0_GP_MUX_SEL"
>>
>> It configures how the pins from the PRUSS module are routed internally
>> to the various modules.

Actually, that's not entirely accurate. This is an internal pinmux (not
controllable per pin, but rather dictates a different sets of groups of
pins at the PRUSS boundary, which are then again multiplexed at the SoC
level using the standard padconf/pinmux. It is a single register per
core into which you can set some values between 0 through 4 IIRC
(unfortunately the values are also not uniform across the various SoCs).

regards
Suman

>>
>> see "30.2.1 PRU-ICSS I/O Interface"
>> and "Table 30-1. PRU-ICSS1 I/O Signals"
> 
> Well these are external signals for PRUSS processor (although not
> necessarily external signals for the SoC). So why not handle them
> with a standard pinctlr binding with #pinctrl-cells?
> 
> Sure it may not even be the Linux pinctrl framework running on the
> main SoC handling these pins, but after all you're describing
> hardware for a processor. Maybe Linus W has some comments on this?
> 
> Regards,
> 
> Tony
> 

