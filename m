Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CEA20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfAQNlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:41:39 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:26656 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfAQNli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:41:38 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id C25C113F854;
        Thu, 17 Jan 2019 14:41:16 +0100 (CET)
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845: Expand soc bus address range
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>
References: <20190116064906.22791-1-bjorn.andersson@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <38c47c17-b86e-500a-e8c1-74d8944c6f9a@free.fr>
Date:   Thu, 17 Jan 2019 14:41:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116064906.22791-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2019 07:49, Bjorn Andersson wrote:

> DMA addresses for devices on the soc bus must be constrained to the 36
> address bits that the bus provides.  When no IOMMU is present then this
> is easy--DMA addresses are just physical addresses and physical
> addresses are (by definition) within the address bits of the bus.  When
> an IOMMU is present, however, DMA addresses are virtual addresses.
> Despite these addresses being virtual, however, they are still
> constrained by the 36 address bits of the bus.
> 
> Unless dma-ranges is specified, which causes bus_dma_mask to be set, DMA
> allocations for devices on the platform_bus will use all 48 address bits
> available by the ARM SMMU. Causing addresses to be truncated on the bus.
> 
> This patch increases the #size-cells to 2, in order to be able to define
> dma-ranges describe the 36 bit DMA capability of the bus, and bumps

Seems like you changed your mind mid-sentence? :-)

> While touching all reg properties, addresses are padded to 8 digits.
