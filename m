Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2D3ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5020120825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5020120825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeKIBlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:41:13 -0500
Received: from foss.arm.com ([217.140.101.70]:44402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeKIBlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:41:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1511480D;
        Thu,  8 Nov 2018 08:05:04 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9033F3F5CF;
        Thu,  8 Nov 2018 08:05:02 -0800 (PST)
Date:   Thu, 8 Nov 2018 16:04:57 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/4] Documentation: bindings: Add missing Amlogic SCPI
 sensor bindings
Message-ID: <20181108160457.GA10953@e107155-lin>
References: <20181108135352.8459-1-jbrunet@baylibre.com>
 <20181108135352.8459-4-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108135352.8459-4-jbrunet@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 02:53:51PM +0100, Jerome Brunet wrote:
> amlogic,meson-gxbb-scpi-sensors is both the driver and DT but is not
> documented. Just add it to amlogic's scpi documentation
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic,scpi.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic,scpi.txt b/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
> index 7b9a861e9306..5ab59da052df 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
> +++ b/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
> @@ -17,4 +17,11 @@ Required sub-node properties:
>  - compatible : should be "amlogic,meson-gxbb-scp-shmem" for SRAM based shared
>  		memory on Amlogic GXBB SoC.
>  
> +Sensor bindings for the sensors based on SCPI Message Protocol
> +--------------------------------------------------------------
> +SCPI provides an API to access the various sensors on the SoC.
> +
> +Required properties:
> +- compatible : should be "amlogic,meson-gxbb-scpi-sensors".
> +

Not sure if it's worth mentioning the reason for being able to identify
amlogic,meson-gxbb sensors from generic scpi ones. IIRC it was for the
unit values of these sensors are different ? But I will leave that to
DT or platform maintainers' taste.

--
Regards,
Sudeep
