Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C1FC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D032086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BA7D4Zjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D032086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388863AbeKGKIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:08:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388556AbeKGKIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P8TEXG+2HNiTU+qge99unCeb7IP+IT+5XA6dtRT8XxY=; b=BA7D4Zjqvwb3u5IoajHABVsqy
        DMgCclKri7/XZJnSeP6Ow/KfD31nnGoD7wDrel2YA6w6pVfnWSw9nYCAnyZvrSqK88P4RhfS+spOe
        rwRPaAX66cAPukXKyXOrYjLaO5lgvgUB02af5eD1QwZupfnaCDvHGD08uZUFqlg0YB7eeU3eBu9JN
        LgsNKIyrQ11/ASBcwVMjY72UUkUSDsaW+sAIgrFzHIedqXCBkaDpvI20JX0LFU61eGfEaSrdXsWud
        H7LO3oB6XrSAUma42Kr1vr1YrdEQxfSCXn472RXq7+2V9kDHhJpcnl9CjC8pN+qLd70fs+oP7Za3M
        A2/5inc+Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKBtP-0006Y4-DL; Wed, 07 Nov 2018 00:40:23 +0000
Subject: Re: [RFC PATCH 12/12] soc: qcom: ipa: build and "ipa_i.h"
To:     Alex Elder <elder@linaro.org>, davem@davemloft.net, arnd@arndb.de,
        bjorn.andersson@linaro.org, ilias.apalodimas@linaro.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        syadagir@codeaurora.org, mjavid@codeaurora.org, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-13-elder@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cebe0d3c-4a24-60a4-88c8-5195a5d0da4b@infradead.org>
Date:   Tue, 6 Nov 2018 16:40:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107003250.5832-13-elder@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

On 11/6/18 4:32 PM, Alex Elder wrote:
> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
> new file mode 100644
> index 000000000000..f8ea9363f532
> --- /dev/null
> +++ b/drivers/net/ipa/Kconfig
> @@ -0,0 +1,30 @@
> +config IPA
> +	tristate "Qualcomm IPA support"
> +	depends on NET
> +	select QCOM_QMI_HELPERS
> +	select QCOM_MDT_LOADER
> +	default n
> +	help
> +	  Choose Y here to include support for the Qualcomm IP
> +	  Accelerator (IPA), a hardware block present in some
> +	  Qualcomm SoCs.  The IPA is a programmable protocol
> +	  processor that is capable of generic hardware handling
> +	  of IP packets, including routing, filtering, and NAT.
> +	  Currently the IPA driver supports only basic transport
> +	  of network traffic between the AP and modem, on the
> +	  Qualcomm SDM845 SoC.
> +
> +	  If unsure, say N.
> +
> +config IPA_ASSERT
> +	bool "Enable IPA assertions"
> +	depends on IPA
> +	default y
> +	help
> +	 Incorporate IPA assertion verification in the build.  This
> +	 cause various design assumptions to be checked at runtime,

	 causes

> +	 generating a report (and a crash) if any assumed condition
> +	 does not hold.  You may wish to disable this to avoid the
> +	 overhead of checking.
> +
> +	 If unsure doubt, say "Y" here.


-- 
~Randy
