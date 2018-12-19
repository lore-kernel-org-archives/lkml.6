Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7BBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF3220449
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ONwGzWfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbeLSPoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:44:08 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41706 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbeLSPoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:44:08 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJFhFKI051101;
        Wed, 19 Dec 2018 09:43:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545234195;
        bh=Zw/0n+fUcbC7Z0GjFbsk5XY79G/el4H8B/5jktqCFcY=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=ONwGzWfH2dX7RR60w7qlUP0JSR/aqA2H0GitWYB8FfKvj3Y22ZQznTAu6igTPlloY
         pPhxTACPUWR69QBna+lfWWNdq2+N0NnVOV7lsFeGEiiEckOgoSDU87avaBANhS2AnJ
         v2Yb2E3ARr8kWgaZ8o9ihmfxRkV0mSmL+hfmw74E=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJFhFPY097815
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 09:43:15 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 09:43:15 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 09:43:15 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJFhAGY028924;
        Wed, 19 Dec 2018 09:43:11 -0600
Subject: Re: [PATCH 05/16] remoteproc/pru: Add pru-specific debugfs support
To:     Mark Brown <broonie@kernel.org>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-6-git-send-email-rogerq@ti.com>
 <d0e227e3-39dc-dfc8-b94c-3d9d072f6562@lechnology.com>
 <5BFFBCAC.9000004@ti.com> <5C191770.9090804@ti.com>
 <20181219123812.GC8130@sirena.org.uk>
CC:     David Lechner <david@lechnology.com>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <tony@atomide.com>,
        <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C1A670E.9020904@ti.com>
Date:   Wed, 19 Dec 2018 17:43:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20181219123812.GC8130@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/18 14:38, Mark Brown wrote:
> On Tue, Dec 18, 2018 at 05:51:12PM +0200, Roger Quadros wrote:
> 
>> We could combine control and debug into one iomap and use
>> 2 regmap ranges. But this is really working around the
>> regmap_mmio limitation of not being able to use more than one ioremaps.
> 
>> Mark, any suggestions?
> 
> If they're separate regions why not create separate regmaps for them?
> 

I tried that but only the first regmap shows up in debugfs.

e.g.

+
+       pru->ctrl_regmap = devm_regmap_init_mmio(dev, pru->iomem_regions[PRU_IOMEM_CTRL].va,
+                                                &pru_regmap_config);
+       if (IS_ERR(pru->ctrl_regmap)) {
+               ret = PTR_ERR(pru->ctrl_regmap);
+               dev_err(dev, "CTRL regmap init failed: %d\n", ret);
+               goto free_rproc;
+       }
+
+
+       pru->debug_regmap = devm_regmap_init_mmio(dev, pru->iomem_regions[PRU_IOMEM_DEBUG].va,
+                                                 &pru_debug_regmap_config);
+       if (IS_ERR(pru->debug_regmap)) {
+               ret = PTR_ERR(pru->debug_regmap);
+               dev_err(dev, "DEBUG regmap init failed: %d\n", ret);
+               goto free_rproc;
        }


Did I do something wrong or we just need to enhance regmap_debugfs.c?

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
