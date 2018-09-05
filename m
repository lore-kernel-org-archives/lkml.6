Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA49BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7E620857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1dwLo5e0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7E620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeIEV4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbeIEV4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:56:39 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C10A12075E;
        Wed,  5 Sep 2018 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536168331;
        bh=wHxiIf3BcwEJT5pXnFZNlBH2StUzBRZit4b/WBWQixo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1dwLo5e0ErrnzjwI0QwBuqF/6BImYS87Ukl00LIOgVssJuIhd/1zUqQYa2S8P9igP
         Jw+YQRQU0DcnZE4hn6+EZkPZQ2q4iCDWrCdLoZhWS+8sAJv7dCIFyt1+bRvnqTXb1K
         JN6alNaMrE0A/sCzxjPUuKoyOJRtVDwKHVpt85Gg=
Date:   Wed, 5 Sep 2018 12:25:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 2/2] pci: dwc: add UniPhier PCIe host controller support
Message-ID: <20180905172529.GO107892@bhelgaas-glaptop.roam.corp.google.com>
References: <1536114731-28630-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1536114731-28630-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536114731-28630-3-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow capitalization conventions for subject.

On Wed, Sep 05, 2018 at 11:32:11AM +0900, Kunihiko Hayashi wrote:
> This introduces specific glue layer for UniPhier platform to support
> PCIe host controller that is based on the Designware PCIe Core, and
> this driver supports Root Complex (host) mode.

s/Designware/DesignWare/
s/Core/core/

> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> new file mode 100644
> index 0000000..13ce02e
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -0,0 +1,464 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// PCI-express host controller driver for UniPhier SoCs
> +// Copyright 2018 Socionext Inc.
> +// Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Use /* ... */ comments except for the SPDX line.

