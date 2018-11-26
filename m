Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3781CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE8620873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="VUUYWzdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE8620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeK0IOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:14:51 -0500
Received: from vern.gendns.com ([98.142.107.122]:44480 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbeK0IOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L2Bekuf7cXVrlQCTmKuWDb8U/26BhIKBXgdAMtTZuJQ=; b=VUUYWzdjVlzIEA3MgH6mKuUuSM
        KIkkxSKAL4hiPNTWlCF9Vrds3jT993oxj1DiK0rXBSQHbtTleNfZBtYpd0DmEIkj/v9794qf7y/UB
        xSB7Nzy5EYKeX5qcY8StWuNOGUNjPRajo/EG3yf6Lm8HP0LkbZKVMB977c0T1W7JlyJN1MqfwQJzn
        jcvjNI9qQ3k655VezCJ2ORT6aiSGSYUiG48UGa6uSqlkAuoas2jPyANx3IRKW7p0giI1us8LbWuxb
        Foixc7zY7YdBCMA7L7dV63trWm8cQSQ8uusQ6m3Wb0D1KtLI4h+KUyvH2lpd3FnzB5GuQ6HbKAcm/
        h76jg9Xg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:44860 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gROH1-0002dG-M9; Mon, 26 Nov 2018 16:18:31 -0500
Subject: Re: [PATCH 13/17] soc: ti: pruss: export
 pruss_intc_configure/unconfigure APIs
To:     Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc:     robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-14-git-send-email-rogerq@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <dffe2d51-7970-95c9-b608-1cfbd3c004f9@lechnology.com>
Date:   Mon, 26 Nov 2018 15:19:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542886753-17625-14-git-send-email-rogerq@ti.com>
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
> The PRU remoteproc driver will need to configure the
> Interrupt controller based on the application specific
> interrupt map.
> 
> Export pruss_intc_configure() and pruss_intc_unconfigure()
> to linux/pruss.h

Do we really need a patch just to move things around in header
files and make these public? It seems like this could have just
been done in the first place when these functions were introduced.

> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   drivers/soc/ti/pruss.h | 21 -------------------
>   include/linux/pruss.h  | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 56 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/soc/ti/pruss.h b/drivers/soc/ti/pruss.h
> index 45de1be..ce3f96a 100644
> --- a/drivers/soc/ti/pruss.h
> +++ b/drivers/soc/ti/pruss.h

...

> +/**
> + * pruss_intc_configure() - configure the PRUSS INTC
> + * @pruss: the pruss instance
> + * @intc_config: PRU core-specific INTC configuration
> + *
> + * Configures the PRUSS INTC with the provided configuration from
> + * a PRU core. Any existing event to channel mappings or channel to
> + * host interrupt mappings are checked to make sure there are no
> + * conflicting configuration between both the PRU cores. The function
> + * is intended to be used only by the PRU remoteproc driver.

If this can only be used by the remoteproc driver, then how are other
drivers supposed to configure the interrupt mapping?


> + *
> + * Returns 0 on success, or a suitable error code otherwise
> + */
> +int pruss_intc_configure(struct pruss *pruss,
> +			 struct pruss_intc_config *intc_config);
> +
> +/**
> + * pruss_intc_unconfigure() - unconfigure the PRUSS INTC
> + * @pruss: the pruss instance
> + * @intc_config: PRU core specific INTC configuration
> + *
> + * Undo whatever was done in pruss_intc_configure() for a PRU core.
> + * It should be sufficient to just mark the resources free in the
> + * global map and disable the host interrupts and sysevents.

I don't understand the second sentence of this comment. Perhaps it needs
more explanation.

> + */
> +int pruss_intc_unconfigure(struct pruss *pruss,
> +			   struct pruss_intc_config *intc_config);
> +
