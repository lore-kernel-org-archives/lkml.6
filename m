Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2F0C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D63205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D63205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wwwdotorg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeJWACS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 20:02:18 -0400
Received: from avon.wwwdotorg.org ([104.237.132.123]:50602 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeJWACS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 20:02:18 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Oct 2018 20:02:18 EDT
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 989871C01F5;
        Mon, 22 Oct 2018 09:33:25 -0600 (MDT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.1 at avon.wwwdotorg.org
Subject: Re: [RFC PATCH v2 09/17] ARM: dts: tegra20: harmony: Setup voltage
 regulators for DVFS
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-10-digetx@gmail.com>
From:   Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <a1b4cd27-858c-de53-8ae2-b1aee689475f@wwwdotorg.org>
Date:   Mon, 22 Oct 2018 09:33:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181021205501.23943-10-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/18 2:54 PM, Dmitry Osipenko wrote:
> Set min/max regulators voltage and add CPU node that hooks up CPU with
> voltage regulators.

> diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts

> -				sm0 {
> +				core_vdd_reg: sm0 {
>   					regulator-name = "vdd_sm0,vdd_core";
> -					regulator-min-microvolt = <1200000>;
> -					regulator-max-microvolt = <1200000>;
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1300000>;
> +					regulator-coupled-with = <&rtc_vdd_reg>;
> +					regulator-coupled-max-spread = <150000>;
>   					regulator-always-on;
>   				};

How do you know for sure that these increased ranges are safe (high end) 
and stable (low end) for this particular board? IIRC the safe/legal 
range depends on the chip SKU, and to be honest I have no idea which SKU 
is present on Harmony... For public boards like Colibri I imagine 
there's enough information out there to tell what will work, but maybe 
not our internal boards like Harmony, unless you checked our ancient 
downstream kernels?
