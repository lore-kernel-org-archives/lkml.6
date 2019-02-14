Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AADC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5A721904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MEHedS4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394201AbfBNCsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:48:13 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56960 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732564AbfBNCsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:48:12 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1E2l3nl084946;
        Wed, 13 Feb 2019 20:47:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550112423;
        bh=2R9WcqTStpl+cXcD9pNMXIuf/C4nswy3x86MNOXCctU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MEHedS4B1rCo+aZbQpXZkkoaWvvLGnIY3UoGYy6VzHtwNQTwCol9IHXI9SMUzMebQ
         p9V1Yd5Jfw8T5wO+vUDuUKouoSsssYDqUA1akvQ1B5yTa5v7SVrrtKHyWUxmUiXifk
         a06ACeOQ4X0QR4nt66PwPMudMo9VCYjh4mzx8gzE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1E2l3jW121143
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 20:47:03 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 20:47:03 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 20:47:03 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1E2l2wR010889;
        Wed, 13 Feb 2019 20:47:02 -0600
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>,
        Murali Karicheri <m-karicheri2@ti.com>
CC:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <david@lechnology.com>, <nsekhar@ti.com>, <t-kristo@ti.com>,
        <nsaulnier@ti.com>, <jreeder@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <20190204163312.GI5720@atomide.com> <5C5959DB.2090608@ti.com>
 <f1b689cc-5d1b-0333-7a1c-cb6d58169e12@ti.com> <5C59AEA3.1080400@ti.com>
 <124e9f09-fb60-071d-e2ba-ec6f7fb3955c@ti.com>
 <20190205161945.GS5720@atomide.com> <5C5AF77D.8020007@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <90c359d8-c899-cf99-3c82-9d39f2b7765c@ti.com>
Date:   Wed, 13 Feb 2019 20:47:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5C5AF77D.8020007@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/19 9:04 AM, Roger Quadros wrote:
> 
> 
> On 05/02/19 18:19, Tony Lindgren wrote:
>> * Murali Karicheri <m-karicheri2@ti.com> [190205 16:13]:
>>> On 02/05/2019 10:41 AM, Roger Quadros wrote:
>>>> What I'm suggesting here is that kernel remoteproc driver should have nothing to do
>>>> with the other PRU's data RAM.
>>>>
>>>> The application driver if needs both PRUs then it can obviously access both DRAMs
>>>> as it has a phandle to both PRUs.
>>>>
>>> That should be fine.
>>
>> That sounds good to me too.
>>
>> For dts, yeah please allocate the resources for the modules
>> where the resources belong to on the PRUSS internal interconnect :)
>> Devices can move around on the interconnect between SoCs and the
>> modules can get swapped or added.
> 
> If you take a look at "Figure 30-1. PRU-ICSS Overview" in 
> http://www.tij.co.jp/jp/lit/ug/spruhz7h/spruhz7h.pdf
> 
> You can see that DRAM0 and DRAM1 are not part of PRU. That means
> they shouldn't be in the PRU node then.

Yes, they do not belong to a PRU, and should not be defined underneath
one. Both are accessible from both PRU cores, so it is upto the
application on how they can partition the usage.

regards
Suman

