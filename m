Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CDF08C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3AD208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J55ho4mT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3AD208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936072AbeFNUlJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:41:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45684 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755261AbeFNUlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HCfdbjNMsnF7jj4II6CnH2d48lqTf6RSIK2XVhW1NuE=; b=J55ho4mTCwaxTHyoCn4fIeQZFK
        DOoENUROaBAlaOYkf7pURzzTPmU0QgmxSeW4lCNTf46/5CrmTZdodRhA0e7UvukoYVCCLFjCZxAHQ
        ZdHTC+KzwL8TCPLGI5mW/Ipn1KUy8w7wd5EO8ZqBX78uLDI6m1qmOKhSa4G4QWP9bFnHrNw1JqmDc
        ALaCaYAXB3zo0R9wpLn3nGgNvOkn8UCgw/rnXkV3HzBV0WfvtawgutbklJEKbFLuAe538t7r7cSLh
        iB940mm4haKWkn3jg6mNx2UsmyBIAsC+JYYEtZZfJVK9PE92orQBNlJ5gc1lWJ4BUWZ+J1gsUmqpl
        VSghU1WA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTZ3G-0007oi-Pn; Thu, 14 Jun 2018 20:41:02 +0000
Subject: Re: [PATCH v8 02/10] firmware: xilinx: Add Zynqmp firmware driver
To:     Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, michal.simek@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jolly Shah <jollys@xilinx.com>
References: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
 <1529000862-11510-3-git-send-email-jollys@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7cd908ac-a0cc-3fd0-702f-d36a4e325a68@infradead.org>
Date:   Thu, 14 Jun 2018 13:40:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529000862-11510-3-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 11:27 AM, Jolly Shah wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
> 

Hi,

> diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
> new file mode 100644
> index 0000000..cce4e4f
> --- /dev/null
> +++ b/drivers/firmware/xilinx/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Kconfig for Xilinx firmwares
> +
> +menu "Zynq MPSoC Firmware Drivers"
> +	depends on ARCH_ZYNQMP
> +
> +config ZYNQMP_FIRMWARE
> +	bool "Enable Xilinx Zynq MPSoC firmware interface"
> +	help
> +	  Firmware interface driver is used by different to

used by different <what>?  Missing something there.

> +	  communicate with the firmware for various platform
> +	  management services.
> +	  Say yes to enable ZynqMP firmware interface driver.
> +	  In doubt, say N

	  If in doubt, say N.

> +
> +endmenu


-- 
~Randy
