Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA42C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9194A2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O+aQakRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbeLXJBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:01:43 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46760 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLXJBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:01:43 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBO91Xmu051517;
        Mon, 24 Dec 2018 03:01:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545642093;
        bh=3qCmFMy57zbMuCLV+oCHsMyJzu2I7lIVANOMMzFX3Mg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=O+aQakRR5/nQqxlhkOOHlOPLyTemY18zID3EO3FMET0r+e8mh4+9glB/pqVNVLkrx
         rNvwYSUzPwiBnXJfbwkV6gmbX1H5VpsdQcWMwhQuVnAXSPWNIrSbO0cfotWrjzEAN/
         UUsTTz/caOMVyDhETA6wzvo7kSlLd0dQi0OW0vwc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBO91X5m056025
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Dec 2018 03:01:33 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 24
 Dec 2018 03:01:33 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 24 Dec 2018 03:01:32 -0600
Received: from [172.22.217.62] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBO91Pen000488;
        Mon, 24 Dec 2018 03:01:26 -0600
Subject: Re: [PATCH 2/2] mfd: tps65218.c: Add input voltage options
To:     Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>
CC:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1545120356-7749-3-git-send-email-Christian.Hohnstaedt@wago.com>
 <20181221110128.GO13248@dell> <20181223164030.GQ6707@atomide.com>
 <20181224063241.GB4846@dell>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <c2ea051b-072e-51e0-ec60-aa1ca9f63ab6@ti.com>
Date:   Mon, 24 Dec 2018 14:31:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181224063241.GB4846@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/24/2018 12:02 PM, Lee Jones wrote:
> On Sun, 23 Dec 2018, Tony Lindgren wrote:
> 
>> * Lee Jones <lee.jones@linaro.org> [181221 11:01]:
>>> On Tue, 18 Dec 2018, Christian Hohnstaedt wrote:
>>>
>>>> These options apply to all regulators in this chip.
>>>>
>>>> strict-supply-voltage:
>>>>    Set STRICT flag in CONFIG1
>>>> under-voltage-limit:
>>>>    Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
>>>> under-voltage-hysteresis:
>>>>    Select 200mV or 400mV UVLOHYS in CONFIG2
>>>>
>>>> Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
>>>> ---
>>>>   drivers/mfd/tps65218.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 46 insertions(+)
>>>
>>> This needs a close review by Tony and any of the other OMAP guys.
>>
>> Adding Keerthy to Cc, he's probably the best person to review these
>> changes.

Thanks Tony.

> 
> But you've dropped the patch, so all he has it a commit log to review?
> 
Lee Jones,

I am subscribed to linux-omap so i have the patch. I will review them.

Thanks,
Keerthy
