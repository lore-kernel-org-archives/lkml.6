Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2264DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3812082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LsZ2fG0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3812082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeLDKdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:33:32 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47762 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDKdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:33:32 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB4AXPe3025010;
        Tue, 4 Dec 2018 04:33:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543919605;
        bh=H2iXpJSpQ0UjsXZqHgkmt2nVNGFevjLxN21m78QUBFw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LsZ2fG0lSbiiiMpAqkQT0kFPVn4CRJq5ziU/NHyyXdPOPLWnSLacUhgVyFyMhg82L
         HYFD3eql7pkxc2HB0LdEX/73s96LA8gYJCi+4EayIlB7sIoDqfjhEA0lfC/QYrEI9l
         W3xgUIz/pxA/eOuLcRs50vjdEma0Xjw8hAvoGgfI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB4AXPwp093986
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Dec 2018 04:33:25 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 4
 Dec 2018 04:33:25 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 4 Dec 2018 04:33:25 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB4AXMt0019832;
        Tue, 4 Dec 2018 04:33:22 -0600
Subject: Re: [PATCH V3 0/3] Add support for using external dma in SDHCI
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1543908270-13953-1-git-send-email-zhang.chunyan@linaro.org>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <4871e35d-08e4-9199-08bc-f80f83349020@ti.com>
Date:   Tue, 4 Dec 2018 16:06:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543908270-13953-1-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunyan,

On 04/12/18 12:54 PM, Chunyan Zhang wrote:
> Currently the generic SDHCI code in the Linux kernel supports the SD
> standard DMA integrated into the host controller but does not have any
> support for external DMA controllers implemented using dmaengine meaning
> that custom code is needed for any systems that use a generic DMA
> controller with SDHCI which in practice means any SDHCI controller that
> doesn't have an integrated DMA controller so we should have this as a
> generic feature.
> 
> There are already a number of controller specific drivers that have dmaengine
> code, and some could use sdhci.c actually, but needed to implement mmc_ops->request()
> in their specific driver for sending command with external dma using dmaengine
> framework, with this patchset, them will take advantage of the generic support.
> TI's omap controller is the case as an example.
> 
> Any comments are very appreciated.
> 

Following your comments, I added dmas in dra7.dtsi as shown in the patch
below.

https://pastebin.ubuntu.com/p/J4F3xWZv5c/

This time the MMC devices enumerate successfully but I see a bunch of

[  108.135736] omap-dma-engine 4a056000.dma-controller: t2_desc[10]
allocation failed

messages when I try to run a short ltp test.

https://pastebin.ubuntu.com/p/WvRSkxBPpv/

Thanks,
Faiz
