Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8C9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9973A20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J3bu4Msy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qp5K92Ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9973A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeH3Kf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:35:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43726 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbeH3Kfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:35:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 10E8C60600; Thu, 30 Aug 2018 06:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535610920;
        bh=J5ikX7DG97wn7WR92syvhnXLj1Oj6bms8knGYMFOsTU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=J3bu4Msybn0dBrML2sWDuJISU+fbNgD9BXXexrZrKMJcnOGxg17igUk9/agZyI/hL
         2p6pB46tx7m1k4sE2Kcbm875coSdo98rbA5k56yqFT2jH6WwS+lCzdFIs5dpNT+Xx5
         Fg8QM6Fb37LsG1n7qqTUMlQIFmoZBlb7GNBbCqi4=
Received: from [10.79.128.159] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 088FB60388;
        Thu, 30 Aug 2018 06:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535610919;
        bh=J5ikX7DG97wn7WR92syvhnXLj1Oj6bms8knGYMFOsTU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Qp5K92AknU3WnaI8GpLyzw7isq704fLEpM/TjVZ+IXuqlxiATnYFq6sD1cuQW/QdL
         t5a9lrkgB+oy/4hf72l1YcNnjEyclkpsMLzcEV8Iief0reCHt3qFhKL8NuJgHf2rS4
         Iz9H+59P4BKf+4JY/NlZA93qAEOh3Z0jSfrTL9pY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 088FB60388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v4 0/6] Add power domain driver for corners on
 msm8996/sdm845
To:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180627045234.27403-1-rnayak@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <91ece266-025b-0b70-6563-5041b70f84b8@codeaurora.org>
Date:   Thu, 30 Aug 2018 12:05:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180627045234.27403-1-rnayak@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/2018 10:22 AM, Rajendra Nayak wrote:
> Changes in v4:
> * Included the patch to add qcom-opp bindings (dropped accidentally in v3)
> * merged the patches to add bindings for rpm and rpmh, added consumer binding example
> * Made the drivers built in, removed .remove
> * Added better description in changelog for PATCH 6/6
> * Updated rpmhpd_aggregate_corner() based on Davids feedback
> * rpmhpd_set_performance_state() returns max corner, in cases where its called
> with an INT_MAX
> * Dropped the patch to max vote on all corners at init, the patch did not
> work anyway, and it shouldn't be needed now

These patches have been out on the list for a while (8 weeks).
I haven't seen any further comments from anyone, except on PATCH 2/6
by Rob. I requested Rob to provide his Ack if he is fine with the bindings.

Can we plan to pull these in for 4.20?

> 
> Changes in v3:
> * Bindings split into seperate patches
> * Bindings updated to remove duplicate OPP table phandles
> * DT headers defining macros for Power domain indexes and OPP levels
> * Optimisations to use rpmh_write_async() whereever applicable
> * Fixed up handling of ACTIVE_ONLY/WAKE_ONLY/SLEEP voting for RPMh
> * Fixed the vlvl to hlvl conversions in set_performance
> * Other minor fixes based on review of v2
> * TODO: This series does not handle the case where all VDD_MX votes
> should be higher than VDD_CX from APPs, as pointed out
> by David Collins in v2. This needs support at genpd to propogate performance
> state up the parents, if we model these as Parent/Child to handle the
> interdependency.
> 
> Changes in v2:
> * added a power domain driver for sdm845 which supports communicating to RPMh
> * dropped the changes to sdhc driver to move over to using OPP
> as there is active discussion on using OPP as the interface vs
> handling all of it in clock drivers
> * Other minor binding updates based on review of v1
> 
> With performance state support for genpd/OPP merged, this is an effort
> to model a power domain driver to communicate corner/level
> values for qualcomm platforms to RPM (Remote Power Manager) and RPMh.
> 
> Rajendra Nayak (6):
>    dt-bindings: opp: Introduce qcom-opp bindings
>    dt-bindings: power: Add qcom rpm power domain driver bindings
>    soc: qcom: rpmpd: Add a Power domain driver to model corners
>    soc: qcom: rpmpd: Add support for get/set performance state
>    arm64: dts: msm8996: Add rpmpd device node
>    soc: qcom: rpmhpd: Add RPMh Power domain driver
> 
>   .../devicetree/bindings/opp/qcom-opp.txt      |  25 ++
>   .../devicetree/bindings/power/qcom,rpmpd.txt  | 146 +++++++
>   arch/arm64/boot/dts/qcom/msm8996.dtsi         |  34 ++
>   drivers/soc/qcom/Kconfig                      |  18 +
>   drivers/soc/qcom/Makefile                     |   2 +
>   drivers/soc/qcom/rpmhpd.c                     | 406 ++++++++++++++++++
>   drivers/soc/qcom/rpmpd.c                      | 340 +++++++++++++++
>   include/dt-bindings/power/qcom-rpmpd.h        |  39 ++
>   8 files changed, 1010 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
>   create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>   create mode 100644 drivers/soc/qcom/rpmhpd.c
>   create mode 100644 drivers/soc/qcom/rpmpd.c
>   create mode 100644 include/dt-bindings/power/qcom-rpmpd.h
> 
