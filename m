Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B60C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B3221741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TAj9Pq1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeLTIqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:46:18 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53944 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbeLTIqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:46:18 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBK8jPGH038289;
        Thu, 20 Dec 2018 02:45:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545295525;
        bh=/aGQd8xmVZuD7Ma5Kr/9Tbe5obmiYPgBVqsFuXLB7js=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=TAj9Pq1K+2YbhMzHkmDjK2K8uUdJC2Z8wtoUQ8jH9uaA44sqF6IdthcTB3OqAnXYi
         D85MCeA8v2r30OtGc6nz/Omy3AaYluAKSU8iSX6ac2RApLa4ePA7LNTjiUmhieDLQE
         TjRTtf6gjLzPFRLnOxyjtTDNF/opS8Hx7bZ2AxxM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBK8jPEg111241
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Dec 2018 02:45:25 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 20
 Dec 2018 02:45:24 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 20 Dec 2018 02:45:24 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBK8jKRX009105;
        Thu, 20 Dec 2018 02:45:20 -0600
Subject: Re: [PATCH 05/16] remoteproc/pru: Add pru-specific debugfs support
To:     Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-6-git-send-email-rogerq@ti.com>
 <d0e227e3-39dc-dfc8-b94c-3d9d072f6562@lechnology.com>
 <5BFFBCAC.9000004@ti.com> <5C191770.9090804@ti.com>
 <20181219123812.GC8130@sirena.org.uk> <5C1A670E.9020904@ti.com>
 <6ebcd7a6-6c85-0312-0651-fb4fbfc25e55@lechnology.com>
 <20181219170725.GH8130@sirena.org.uk> <20181219171816.GE6707@atomide.com>
CC:     David Lechner <david@lechnology.com>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <bcousson@baylibre.com>, <ssantosh@kernel.org>, <s-anna@ti.com>,
        <nsekhar@ti.com>, <t-kristo@ti.com>, <nsaulnier@ti.com>,
        <jreeder@ti.com>, <m-karicheri2@ti.com>,
        <woods.technical@gmail.com>, <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C1B56A0.7050801@ti.com>
Date:   Thu, 20 Dec 2018 10:45:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20181219171816.GE6707@atomide.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/18 19:18, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [181219 17:07]:
>> On Wed, Dec 19, 2018 at 04:48:52PM +0100, David Lechner wrote:
>>> On 12/19/18 4:43 PM, Roger Quadros wrote:
>>
>>>> Did I do something wrong or we just need to enhance regmap_debugfs.c?
>>
>>> Do you assign the name field in pru_regmap_config and
>>> pru_debug_regmap_config?
>>
>> Yeah, you'll at least need to override the name since the default is to
>> use the name of the device and that'll result in two duplicates.

I hadn't set the name field and this was the issue. It is resolved now.
Thanks :)

> 
> Also combining IO regions often has a serious issue that the
> separate IO regions may not be in the same device (or same
> interconnect target module).
> 
> This means that flushing a posted write with a read-back for
> an IO region will only flush it for a single device and not
> the other(s). And this leads into hard to find bugs :)

Agree.

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
