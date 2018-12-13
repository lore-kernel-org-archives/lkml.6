Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8B6C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8346720873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cYxErLkQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gpWUjhrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8346720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbeLMEQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:16:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50418 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeLMEQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:16:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 52F2B602FA; Thu, 13 Dec 2018 04:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544674575;
        bh=q0d7ZLVv3KgCTqORuRMQbQNJcuthRabwCTf7cLeUEKw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cYxErLkQyEIio8r4rRTO3eIOX/vF8/gcXMqDj1bOpQb/Fa7dByhMqoiZ39nvTLo9d
         hPf7X5ytegZn3ydCzm95yv5Vim1yitxWkmnvZb3IVRUdxp6lDscXTnzPsG0HXPxkqf
         HL2q2tAaSrZPfbqDpwxq+N1ZioTrs5Hf2wMveY/Y=
Received: from [10.79.128.154] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99264602F8;
        Thu, 13 Dec 2018 04:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544674574;
        bh=q0d7ZLVv3KgCTqORuRMQbQNJcuthRabwCTf7cLeUEKw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gpWUjhrpfZk3PHBZDuhyC0/QZVEjVkY5RFBGP/ttzlQazNDYN+RwZ2F7e5tAXP5XR
         BL0lGeQIh6DGYgrR+RbCFRO/2jtsVP/fBeZ/kaGiu4+eRiEgvWYPvWTlWyX9T1Jwlz
         a+QdtGWprv3utU4Nq2AnAxPi0hKMuxF62J/BrgGM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99264602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v7 00/10] Add power domain driver for corners on
 msm8996/sdm845
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181212092131.13046-1-rnayak@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <e6b30187-b982-f26c-a0da-c5532108a332@codeaurora.org>
Date:   Thu, 13 Dec 2018 09:46:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212092131.13046-1-rnayak@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Changes in v7:
> * Rebased on Andy's for-next, and used the updated cmd_db_read_aux_data()
[]..

Hey Andy, just wanted to let you know that this series (v7) is now
well reviewed/ack'ed and ready to land (except for the last 3 patches)
Patch 08/10 will need to go via Ulf/Rafael and Patch 09/10 depends on it
for compilation, also Patch 10/10 has other dependencies which need to
land via the power tree.

So Patch 01/10 to 07/10 from this series are good to be pulled in,
whenever you think is the right time, I am guessing its probably
too late for 4.21?

Thanks,
Rajendra

> 
> Changes in v6:
> * OPP binding updates for qcom,level reviewed by Rob
> * DT bindings for rpmpd and rpmhpd updated to specify the
> OPP tables as child nodes of the power-controller itself
> * Removed some module specific remains from the drivers,
> now that they can only be built-in
> * Added a simple_opp_to_performance_state() helper
> 
> Changes in v5:
> * First 6 patches are unchanged
> * Patch 7/8 adds the DT node for rpmh power-controller on sdm845 and the
> corresponding OPP tables for it to describe the performance states
> * Patch 8/8 adds a parent/child relationship across mx/cx and mx_ao/cx_ao
> as needed on sdm845 platform. This patch is dependent on the series from
> Viresh [1] which adds support to propogate performance states across the
> power domain hierarchy which is still being reviewed
> 
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
> [1] https://lkml.org/lkml/2018/11/26/333
> 
> Rajendra Nayak (10):
>    dt-bindings: opp: Introduce qcom-opp bindings
>    dt-bindings: power: Add qcom rpm power domain driver bindings
>    soc: qcom: rpmpd: Add a Power domain driver to model corners
>    soc: qcom: rpmpd: Add support for get/set performance state
>    arm64: dts: msm8996: Add rpmpd device node
>    soc: qcom: rpmhpd: Add RPMh power domain driver
>    arm64: dts: sdm845: Add rpmh powercontroller node
>    PM / Domains: Add a simple_opp_to_performance_state() helper
>    soc: qcom: rpmpd: Use simple_opp_to_performance_state() helper
>    soc: qcom: rpmhpd: Mark mx as a parent for cx
> 
>   .../devicetree/bindings/opp/qcom-opp.txt      |  25 ++
>   .../devicetree/bindings/power/qcom,rpmpd.txt  | 146 +++++++
>   arch/arm64/boot/dts/qcom/msm8996.dtsi         |  34 ++
>   arch/arm64/boot/dts/qcom/sdm845.dtsi          |  51 +++
>   drivers/base/power/domain.c                   |  17 +
>   drivers/soc/qcom/Kconfig                      |  18 +
>   drivers/soc/qcom/Makefile                     |   2 +
>   drivers/soc/qcom/rpmhpd.c                     | 402 ++++++++++++++++++
>   drivers/soc/qcom/rpmpd.c                      | 317 ++++++++++++++
>   include/dt-bindings/power/qcom-rpmpd.h        |  39 ++
>   include/linux/pm_domain.h                     |   9 +
>   11 files changed, 1060 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
>   create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>   create mode 100644 drivers/soc/qcom/rpmhpd.c
>   create mode 100644 drivers/soc/qcom/rpmpd.c
>   create mode 100644 include/dt-bindings/power/qcom-rpmpd.h
> 
