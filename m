Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E398ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470E8208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470E8208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbeGMOTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:19:05 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1553 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbeGMOTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:19:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b48b1330000>; Fri, 13 Jul 2018 07:03:31 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 13 Jul 2018 07:04:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 13 Jul 2018 07:04:17 -0700
Received: from [10.21.132.122] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 13 Jul
 2018 14:04:15 +0000
Subject: Re: REGRESSION: [PATCH] mmc: tegra: Use sdhci_pltfm_clk_get_max_clock
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
References: <1528126540-27004-1-git-send-email-avienamo@nvidia.com>
 <CAPDyKFoip8gFssftJKzVHD9PAk+j=Z1CTo=0uY9cGASzW8VRJg@mail.gmail.com>
 <1531446183.5479.14.camel@toradex.com>
 <20180713155541.286425e9@dhcp-10-21-25-168>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <cd24b840-3509-1c03-373b-85026c01b0f7@nvidia.com>
Date:   Fri, 13 Jul 2018 15:04:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180713155541.286425e9@dhcp-10-21-25-168>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/07/18 13:55, Aapo Vienamo wrote:
> This happens because sdhci_pltfm_clk_get_max_clock() does not actually
> return the maximum clock rate but the current one, leading to smaller
> clock rates on some platforms. I'll send a patch that fixes this for
> sdhci-tegra. Although this raises the question whether the current
> behaviour of sdhci_pltfm_clk_get_max_clock() is desirable or not.

Agree. There is something not right here. 

Cheers,
Jon

-- 
nvpublic
