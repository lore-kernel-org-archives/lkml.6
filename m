Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2442AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AB520863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gbWYGJzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfBAJB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:01:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52886 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfBAJB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:01:27 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1191FTc015742;
        Fri, 1 Feb 2019 03:01:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549011675;
        bh=PiupDYNLi+A2kRmNuT+YvLxvZQb8xgtifrYg3aYPY/Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gbWYGJzcSUzNWm2HV0G/GETu/N+d6iA+p6NzWFMslnq8avBeJS2gRlw533AxAo1G8
         BQ24M+lZ7WATtxziQq8mkrx17fmlZsSSd2B6S5q9xIEOMhfpaGgzGpgvDpXOGFAwW5
         wrAgQgJBNdu581IdH4Hr5OgBB2TuWMzIyKtcrs20=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1191Et8015512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Feb 2019 03:01:14 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 1
 Feb 2019 03:01:14 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 1 Feb 2019 03:01:14 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x119169M018121;
        Fri, 1 Feb 2019 03:01:11 -0600
Subject: Re: [PATCH v3 0/2] Support for eMMC in AM65x-evm
To:     Nishanth Menon <nm@ti.com>, Faiz Abbas <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>
References: <20190117094424.7683-1-faiz_abbas@ti.com>
 <d75a123b-9e97-a3d1-1e3c-41ef6942dffb@ti.com>
 <20190124124032.aqp4ctqkpozbttwl@kahuna>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <228cf5ac-b07e-bce7-6078-bbab94692d8d@ti.com>
Date:   Fri, 1 Feb 2019 11:00:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124124032.aqp4ctqkpozbttwl@kahuna>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2019 14:40, Nishanth Menon wrote:
> On 13:43-20190124, Faiz Abbas wrote:
>> Hi,
>>
>> On 17/01/19 3:14 PM, Faiz Abbas wrote:
>>> The following patches add eMMC support on TI's AM65x-evm.
>>>
>>> v3:
>>>   1. Fixed patch titles to only include eMMC
>>>   2. Added dma-coherent to the sdhci0 node.
>>>
>>> v2:
>>>   1. The SD card node is under debug for some usecases.
>>>      Only upstreaming eMMC support for now.
>>>   2. Rebased to latest mainline.
>>>   3. Removed status = "disabled" from dtsi patch
>>>   4. Fixed node name to not include '_'s
>>>
>>> Faiz Abbas (2):
>>>    arm64: dts: ti: k3-am654: Add Support for eMMC host controller
>>>    arm64: dts: ti: k3-am654-base-board: Add eMMC Support
>>>
>>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 14 +++++++++++
>>>   .../arm64/boot/dts/ti/k3-am654-base-board.dts | 25 +++++++++++++++++++
>>>   2 files changed, 39 insertions(+)
>>>
>>
>> Gentle ping.
> 
> 
> OK With me. Tero: are you publishing a next branch? could you
> pick this up please?
> 

Ok, queued up for 5.1.

I also pushed an am654-next branch to git.kernel.org. This is not 
tracked in linux-next yet though, I am not quite sure if anybody is 
doing any am654 testing with linux-next, and I only push DT patches via 
this branch anyway which are kind of special.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
