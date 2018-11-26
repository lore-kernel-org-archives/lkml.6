Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9063EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD1B20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="I1Uy7Yni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD1B20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeK0INU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:13:20 -0500
Received: from vern.gendns.com ([98.142.107.122]:44130 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeK0INU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bYgKJeDA7aSpR+sZJZ56Wdt9BKfYK39U4SpJTItz79s=; b=I1Uy7YnitVKPWX2yOBUzwlduEf
        GKHByPiINf6FDXflwcL3N/cV1AHEObM0r4zBOzcnMQ2U/esp0u9IB340Hn7sphyjtKHgiKwQcYB1Q
        VUOq/+WjOO2/ewvzLF5Gim6nZa6pXogkHVjkpmmhvTtRSzK3daFld9FTsw1CcCAxUXNIHxV4NBgvs
        5Kf2HVZWiATECqMsFvAmYjsEujF3FN/NoO2Sm3k6MmzWO7siCl8ioitqmthanN5SzIBb2H8k6hsT9
        afuSFnEaTkS028W5yTYSPHLWUHi+ZmDVkEARJ8WT4F9i6iHUVOQV4OQ+c2Vb4KRplDX/8f1IjyFos
        mhJ07kHg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:44830 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gROFY-0002QK-TH; Mon, 26 Nov 2018 16:17:00 -0500
Subject: Re: [PATCH 08/17] soc: ti: pruss: Add a PRUSS irqchip driver for
 PRUSS interrupts
To:     Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc:     robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-9-git-send-email-rogerq@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <af2f8ce3-923b-aa27-59b2-2ebb848c28c9@lechnology.com>
Date:   Mon, 26 Nov 2018 15:17:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542886753-17625-9-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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

On 11/22/18 5:39 AM, Roger Quadros wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The Programmable Real-Time Unit Subsystem (PRUSS) contains an
> interrupt controller (INTC) that can handle various system input
> events and post interrupts back to the device-level initiators.
> The INTC can support upto 64 input events with individual control
> configuration and hardware prioritization. These events are mapped
> onto 10 interrupt signals through two levels of many-to-one mapping
> support. Different interrupt signals are routed to the individual
> PRU cores or to the host CPU.
> 
> The PRUSS INTC platform driver manages this PRUSS interrupt
> controller and implements an irqchip driver to provide a Linux
> standard way for the PRU client users to enable/disable/ack/
> re-trigger a PRUSS system event. The system events to interrupt
> channels and host interrupts relies on the mapping configuration
> provided through a firmware resource table for now. This will be
> revisited and enhanced in the future for a better interface. The
> mappings will currently be programmed during the boot/shutdown
> of the PRU.

Does this mapping table take up space in the PRU IRAM or DRAM? If
so, that can be a problem on the AM18xx because it has such limited
resources - every byte counts.

Perhaps one way to simplify the mapping is to take out one of the
two levels of mapping. All of the TRMs say that it is highly
recommended to have a 1:1 mapping from channels to host interrupts.
This part of the mapping could just be hard-coded in this driver.
Then the mapping tables would just effectively mapping PRU system
events to host interrupts.

> 
> The PRUSS INTC module is reference counted during the interrupt
> setup phase through the irqchip's irq_request_resources() and
> irq_release_resources() ops. This restricts the module from being
> removed as long as there are active interrupt users.
> 
> The driver currently supports the AM335x SoC.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   drivers/soc/ti/Makefile     |   2 +-
>   drivers/soc/ti/pruss.h      |  29 +++
>   drivers/soc/ti/pruss_intc.c | 572 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 602 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/soc/ti/pruss_intc.c
> 

...

> diff --git a/drivers/soc/ti/pruss_intc.c b/drivers/soc/ti/pruss_intc.c
> new file mode 100644
> index 0000000..dde054b
> --- /dev/null
> +++ b/drivers/soc/ti/pruss_intc.c
> @@ -0,0 +1,572 @@

...

> +int pruss_intc_configure(struct pruss *pruss,
> +			 struct pruss_intc_config *intc_config)
> +{
> +	struct device *dev = pruss->dev;
> +	struct pruss_intc *intc = to_pruss_intc(pruss);
> +	int i, idx, ret;
> +	s8 ch, host;
> +	u64 sysevt_mask = 0;
> +	u32 ch_mask = 0;
> +	u32 host_mask = 0;
> +	u32 val;
> +
> +	if (!intc)
> +		return -EINVAL;
> +
> +	mutex_lock(&intc->lock);
> +
> +	/*
> +	 * configure channel map registers - each register holds map info
> +	 * for 4 events, with each event occupying the lower nibble in
> +	 * a register byte address in little-endian fashion
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(intc_config->sysev_to_ch); i++) {
> +		ch = intc_config->sysev_to_ch[i];
> +		if (ch < 0)
> +			continue;
> +
> +		/* check if sysevent already assigned */
> +		if (intc->config_map.sysev_to_ch[i] != -1) {

Perhaps define a macro for -1 so we know what it means?
