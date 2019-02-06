Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0171AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D25218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y4h2CNEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbfBFPFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:05:31 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34822 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfBFPF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:05:29 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16F4YFU025733;
        Wed, 6 Feb 2019 09:04:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549465474;
        bh=OgI1ItJnz4nSzrNhMwkgert7dzVMZwObN4pCOHrB6u0=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=Y4h2CNEZjC9qbn7H2KUdfmtA4U41P23XyX++QxDQuYJfBjHIafAWtHrGk+P3PZ9ez
         oFla0JQaOt/R4y68RCMl/wQbNrX0JN8gY7ixm+PBZpJkfH0z4x/xiFlN4U8Hr7AY2I
         YFu4Vj7DQmiXALu97/mqwZXK3BBhrAW5HaRC9qvA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16F4YoL099600
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 09:04:34 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 09:04:33 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 09:04:33 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16F4TSG003665;
        Wed, 6 Feb 2019 09:04:30 -0600
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     Tony Lindgren <tony@atomide.com>,
        Murali Karicheri <m-karicheri2@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <20190204163312.GI5720@atomide.com> <5C5959DB.2090608@ti.com>
 <f1b689cc-5d1b-0333-7a1c-cb6d58169e12@ti.com> <5C59AEA3.1080400@ti.com>
 <124e9f09-fb60-071d-e2ba-ec6f7fb3955c@ti.com>
 <20190205161945.GS5720@atomide.com>
CC:     <s-anna@ti.com>, <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <david@lechnology.com>, <nsekhar@ti.com>, <t-kristo@ti.com>,
        <nsaulnier@ti.com>, <jreeder@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C5AF77D.8020007@ti.com>
Date:   Wed, 6 Feb 2019 17:04:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190205161945.GS5720@atomide.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/02/19 18:19, Tony Lindgren wrote:
> * Murali Karicheri <m-karicheri2@ti.com> [190205 16:13]:
>> On 02/05/2019 10:41 AM, Roger Quadros wrote:
>>> What I'm suggesting here is that kernel remoteproc driver should have nothing to do
>>> with the other PRU's data RAM.
>>>
>>> The application driver if needs both PRUs then it can obviously access both DRAMs
>>> as it has a phandle to both PRUs.
>>>
>> That should be fine.
> 
> That sounds good to me too.
> 
> For dts, yeah please allocate the resources for the modules
> where the resources belong to on the PRUSS internal interconnect :)
> Devices can move around on the interconnect between SoCs and the
> modules can get swapped or added.

If you take a look at "Figure 30-1. PRU-ICSS Overview" in 
http://www.tij.co.jp/jp/lit/ug/spruhz7h/spruhz7h.pdf

You can see that DRAM0 and DRAM1 are not part of PRU. That means
they shouldn't be in the PRU node then.

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
