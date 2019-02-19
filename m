Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3330C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08D42177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uBUgbLJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfBSN3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:29:37 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46176 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfBSN3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:29:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1JDTT6r019821;
        Tue, 19 Feb 2019 07:29:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550582969;
        bh=uSGLcLw3WfmS6I3OUZlPZEpTLAZgMO53rkcKc2hmCdw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uBUgbLJFqpantoRc+rYp3CI9XDTXr/oBc0ZkL3aUsU3XdNrH8Lq4NZ6whfPbwUTEh
         sBs8e4TBX+m4aJNhUQ38rQrS+QCCdKTn4BooDC7rdBqMfLWxx3ahAwcGVoH7b7OPy/
         Q8PlOJufePbLX5IG0Sz0J4pvM7vnbiM0ExislQ6E=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1JDTThN124776
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Feb 2019 07:29:29 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 19
 Feb 2019 07:29:28 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 19 Feb 2019 07:29:28 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1JDTPIU031945;
        Tue, 19 Feb 2019 07:29:25 -0600
Subject: Re: [PATCH v2 3/8] dt-bindings: sdhci-omap: Add properties for using
 external dma
To:     Rob Herring <robh@kernel.org>
CC:     Tony Lindgren <tony@atomide.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>, <kishon@ti.com>,
        <zhang.chunyan@linaro.org>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215192033.24203-4-faiz_abbas@ti.com>
 <20190215200718.GB15711@atomide.com>
 <2aa0f7e4-c880-ee88-2e88-dc2c3187f0c9@ti.com> <20190218201240.GA14067@bogus>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <60f2cc85-90dc-a15e-78bb-385213ca53c4@ti.com>
Date:   Tue, 19 Feb 2019 19:02:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218201240.GA14067@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 19/02/19 1:42 AM, Rob Herring wrote:
> On Mon, Feb 18, 2019 at 07:11:32PM +0530, Faiz Abbas wrote:
>> Hi Tony,
>>
>> On 16/02/19 1:37 AM, Tony Lindgren wrote:
>>> * Faiz Abbas <faiz_abbas@ti.com> [190215 19:18]:
>>>> From: Chunyan Zhang <zhang.chunyan@linaro.org>
>>>>
>>>> sdhci-omap can support both external dma controller via dmaengine
>>>> framework as well as ADMA which standard SD host controller
>>>> provides.
>>>
>>> Care to describe here also how to configure things for ADMA and
>>> instead of DMA? Just leave out dmas property?
>>>
>>
>> That's correct. If dmas property is populated, then use external DMA.
>> Otherwise use ADMA/SDMA depending on what you read from the CAPS register.
> 
> Then the properties should be optional.
> 

Will move it to optional in v3.

Thanks,
Faiz
