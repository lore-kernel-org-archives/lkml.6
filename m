Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93758C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645CF20818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645CF20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeKJC1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:27:55 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34332 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeKJC1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:27:55 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA9GjrG0058956;
        Fri, 9 Nov 2018 10:45:53 -0600
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA9GjrEX117796
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Nov 2018 10:45:53 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 9 Nov
 2018 10:45:52 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 9 Nov 2018 10:45:52 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA9GjoKV028352;
        Fri, 9 Nov 2018 10:45:50 -0600
Subject: Re: [PATCH] arm64: dts: k3-am65-wakeup: Fix wakeup_uart reg address
To:     Nishanth Menon <nm@ti.com>, "Vutla, Lokesh" <lokeshvutla@ti.com>
CC:     "R, Vignesh" <vigneshr@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20180927050146.17847-1-vigneshr@ti.com>
 <8dc7a5d5-3e21-c2be-fde1-3f2bc6396bec@ti.com>
 <20181107210059.j2wd4v2uawsjniol@kahuna>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <b75e5f48-f4db-5de0-8c28-45ec065b88da@ti.com>
Date:   Fri, 9 Nov 2018 18:45:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107210059.j2wd4v2uawsjniol@kahuna>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 23:00, Nishanth Menon wrote:
> On 10:10-20181005, Vutla, Lokesh wrote:
>>
>>
>> On Thursday 27 September 2018 10:31 AM, Vignesh R wrote:
>>> cbass_wakeup interconnect which is the parent of wakeup_uart node
>>> defines address-cells=1 and size-cells=1, therefore fix up reg property
>>> of wakeup_uart node accordingly. Otherwise, this UART instance fails to
>>> probe if enabled.
>>>
>>> Fixes: 4201af2544b3 ("arm64: dts: ti: am654: Add uart nodes")
>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>
>> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> 
> Tero:
> 
> Could we pick this up for rc2? looks like $subject might be good to fix
> up to:
> arm64: dts: ti: k3-am65-wakeup: Fix wakeup_uart reg address
> instead of
> arm64: dts: k3-am65-wakeup: Fix wakeup_uart reg address
> 
> could be fixed locally.
> 

Thanks, queued up for 4.20-rc.

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
