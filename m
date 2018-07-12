Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A95AC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA06520883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="wfsCdYy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA06520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbeGLITQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:19:16 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:55898 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeGLITQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:19:16 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 4BB925C21A1;
        Thu, 12 Jul 2018 10:10:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1531383027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S748qoIXaQfwOIuBiFJPrEGMD08pcJ6w6ExG8TD2iFc=;
        b=wfsCdYy4LNnRX9x9X3LLLCPvRFpO8MM7fZdK4IpyHO136t/s2mboocKIFkvy+RBqd7PW8j
        G6Jgu30dOhrr6aOAgPQs+fbfYbvBQGlWB5HbC2KB8bl9HW3nfBV3t4NUkOvWE4iYPM+mp1
        VGlZeIimvuZh4g4761TXCcKbeskW6vM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Jul 2018 10:10:23 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     fabio.estevam@nxp.com, haibo.chen@nxp.com, aisheng.dong@nxp.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mmc: sdhci-esdhc-imx: disable clocks before
 changing frequency
In-Reply-To: <20180712080650.13878-1-stefan@agner.ch>
References: <20180712080650.13878-1-stefan@agner.ch>
Message-ID: <1e00d6df032983bd588b068d30b48cea@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-1.38 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-1.28)[89.89%];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         TO_DN_NONE(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.2018 10:06, Stefan Agner wrote:
> In the uSDHC case (e.g. i.MX 6) clocks only get disabled if frequency
> is set to 0. However, it could be that the stack asks for a frequency
> change while clocks are on. In that case the function clears the
> divider registers (by clearing ESDHC_CLOCK_MASK) while the clock is
> enabled! This causes a short period of time where the clock is
> undivided (on a i.MX 6DL a clock of 196MHz has been measured).
> 
> For older IP variants the driver disables clock by clearing some bits
> in ESDHC_SYSTEM_CONTROL.
> 
> Make sure to disable card clock before changing frequency for uSDHC
> IP variants too.

Ignore this patch, its a duplicate.

I should not have pressed Ctrl-C while git send-email is working :-)

--
Stefan

> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 85fd5a8b0b6d..acacd8481473 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -708,14 +708,14 @@ static inline void esdhc_pltfm_set_clock(struct
> sdhci_host *host,
>  	int div = 1;
>  	u32 temp, val;
>  
> +	if (esdhc_is_usdhc(imx_data)) {
> +		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> +		writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> +			host->ioaddr + ESDHC_VENDOR_SPEC);
> +	}
> +
>  	if (clock == 0) {
>  		host->mmc->actual_clock = 0;
> -
> -		if (esdhc_is_usdhc(imx_data)) {
> -			val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> -			writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> -					host->ioaddr + ESDHC_VENDOR_SPEC);
> -		}
>  		return;
>  	}
