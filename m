Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D8B50C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BDD208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BDD208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935465AbeFMRet (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:34:49 -0400
Received: from foss.arm.com ([217.140.101.70]:50332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934979AbeFMRes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:34:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D58AF1435;
        Wed, 13 Jun 2018 10:34:47 -0700 (PDT)
Received: from [10.1.206.36] (e113632-lin.cambridge.arm.com [10.1.206.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27F7E3F25D;
        Wed, 13 Jun 2018 10:34:46 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: hikey: Define wl1835 power capabilities
To:     Ryan Grachek <ryan@edited.us>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>
References: <20180613151305.17240-1-ryan@edited.us>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <521dd38a-29b8-5670-4296-84b300921b3d@arm.com>
Date:   Wed, 13 Jun 2018 18:34:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613151305.17240-1-ryan@edited.us>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/06/18 16:13, Ryan Grachek wrote:
> These properties are required for compatibility with runtime PM.
> Without these properties, MMC host controller will not be aware
> of power capabilities. When the wlcore driver attempts to power
> on the device, it will erroneously fail with -EACCES.
> 

I don't have a hikey620 to test this, but the hikey960 is suffering from the
same issue (see [1]). I added these properties to the dwmmc2 node of the
hikey960 (see snippet) and wlan0 does show up. Would you mind sending a
similar patch for that board ?

Thanks !

Valentin

[1]: https://lkml.org/lkml/2018/6/12/930

--->8

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 85aadf1b..c706f70 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -613,6 +613,8 @@
        vmmc-supply = <&wlan_en>;
        ti,non-removable;
        non-removable;
+       cap-power-off-card;
+       keep-power-in-suspend;
        #address-cells = <0x1>;
        #size-cells = <0x0>;
        status = "ok";
