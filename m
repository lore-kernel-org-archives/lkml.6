Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61B1C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F86F20844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ppU/kB0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F86F20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbeGZOWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:22:46 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:56162 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbeGZOWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:22:46 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id DEE995C19DE;
        Thu, 26 Jul 2018 15:05:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1532610355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0G+GpxMk0BT6hCUHaC/Lmmw8jaXlg8cl+mqEXI/m9c=;
        b=ppU/kB0XM/NmZD0meHsJj3OW/qzaNJ1U3klSJ2zV5r1BtEh8sNq34wSsf3swCAWVI6k1Lg
        cIZ2hxPm3Z1sf1S2BM/QjIgS5Za0BHOmDv5keCFh+Hw24UtXJrvBIcSiv/134TCGajQhtN
        qCHSy2n3tV3vQkFYeJn2Jee2MUbzZ88=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Jul 2018 15:05:55 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH v2 02/10] dt-bindings: mmc: tegra: Add nvidia,only-1-8-v
 property
In-Reply-To: <1532607560-11253-3-git-send-email-avienamo@nvidia.com>
References: <1532607560-11253-1-git-send-email-avienamo@nvidia.com>
 <1532607560-11253-3-git-send-email-avienamo@nvidia.com>
Message-ID: <484a31bdaad6d76b4fbb7d6fa80cbb8d@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-2.99 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[13];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.89)[99.54%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.2018 14:19, Aapo Vienamo wrote:
> Add a property to mark controllers which operate at a 1.8 V fixed I/O
> voltage.
> 
> This feature of the hardware needs to be signaled this way because it
> cannot be probed at runtime or reliably derived from other properties.

Is this really needed? Can we not use vqmmc to determine which voltage
the controller runs on?

There is already some precedence in the SDHCI core to determine which
voltage levels are supported:
https://lkml.org/lkml/2018/7/5/342

--
Stefan

> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 90c214d..95010cf 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -45,6 +45,8 @@ Optional properties for Tegra210 and Tegra186:
>    for controllers supporting multiple voltage levels. The order of names
>    should correspond to the pin configuration states in pinctrl-0 and
>    pinctrl-1.
> +- nvidia,only-1-8-v : The presence of this property indicates that the
> +  controller operates at a 1.8 V fixed I/O voltage.
>  
>  Example:
>  sdhci@700b0000 {
