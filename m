Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED99C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FE9218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="s+2FS3Sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbeLSPtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:49:01 -0500
Received: from vern.gendns.com ([98.142.107.122]:58232 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730378AbeLSPtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OV7MAgH/hXckmRn+/Iii5R6ZoG/EtHJdPsW8j8aio30=; b=s+2FS3SgHsaPYR4jjUNrMIgBBn
        v+eQ5wRvK5SITCU8kWTPrIuUeeRpdM3fSNPe58B7kT1xrQzs/Fy1EHzeHndB5xPF+dQ0lRWPczyPG
        kB7O7Vv/6U3rFTeXsfvO7TMIXoUZpB1Y+0hvNb63NO4YPtMaidLrGG5Lty+cpxZEmglfOerN+yIBN
        rFBMNP/nUedwZ2SWp8TEExpQtzOpKX7zer8pDqRxeiQAr0SoagZkMT4kXVRWBi2Nr1UwjmIF+lqEH
        UbB4DKeOxvRIQEZnXo5niUjHEFiueoBBsTDNl6R4Q+L9/iB6xvmMuk19jWJc5Gga3Y3+QFNa0zt2L
        XeP6hGWQ==;
Received: from d4258d44.rev.sefiber.dk ([212.37.141.68]:58377 helo=gerda-5.local)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gZe40-0006lP-2A; Wed, 19 Dec 2018 10:47:12 -0500
Subject: Re: [PATCH 05/16] remoteproc/pru: Add pru-specific debugfs support
To:     Roger Quadros <rogerq@ti.com>, Mark Brown <broonie@kernel.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, tony@atomide.com,
        robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com,
        jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-6-git-send-email-rogerq@ti.com>
 <d0e227e3-39dc-dfc8-b94c-3d9d072f6562@lechnology.com>
 <5BFFBCAC.9000004@ti.com> <5C191770.9090804@ti.com>
 <20181219123812.GC8130@sirena.org.uk> <5C1A670E.9020904@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <6ebcd7a6-6c85-0312-0651-fb4fbfc25e55@lechnology.com>
Date:   Wed, 19 Dec 2018 16:48:52 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5C1A670E.9020904@ti.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/19/18 4:43 PM, Roger Quadros wrote:
> On 19/12/18 14:38, Mark Brown wrote:
>> On Tue, Dec 18, 2018 at 05:51:12PM +0200, Roger Quadros wrote:
>>
>>> We could combine control and debug into one iomap and use
>>> 2 regmap ranges. But this is really working around the
>>> regmap_mmio limitation of not being able to use more than one ioremaps.
>>
>>> Mark, any suggestions?
>>
>> If they're separate regions why not create separate regmaps for them?
>>
> 
> I tried that but only the first regmap shows up in debugfs.
> 
> e.g.
> 
> +
> +       pru->ctrl_regmap = devm_regmap_init_mmio(dev, pru->iomem_regions[PRU_IOMEM_CTRL].va,
> +                                                &pru_regmap_config);
> +       if (IS_ERR(pru->ctrl_regmap)) {
> +               ret = PTR_ERR(pru->ctrl_regmap);
> +               dev_err(dev, "CTRL regmap init failed: %d\n", ret);
> +               goto free_rproc;
> +       }
> +
> +
> +       pru->debug_regmap = devm_regmap_init_mmio(dev, pru->iomem_regions[PRU_IOMEM_DEBUG].va,
> +                                                 &pru_debug_regmap_config);
> +       if (IS_ERR(pru->debug_regmap)) {
> +               ret = PTR_ERR(pru->debug_regmap);
> +               dev_err(dev, "DEBUG regmap init failed: %d\n", ret);
> +               goto free_rproc;
>          }
> 
> 
> Did I do something wrong or we just need to enhance regmap_debugfs.c?

Do you assign the name field in pru_regmap_config and 
pru_debug_regmap_config?
