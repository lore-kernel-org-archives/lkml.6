Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3F5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20B520879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O1caCinB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PsjIvzxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfAJEBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:01:31 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49430 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfAJEBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:01:30 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A28A960907; Thu, 10 Jan 2019 04:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547092889;
        bh=N9H1sx42g3rxO59H/0N4S6TYPOpQjBM6AxrYEqytgOU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=O1caCinBFZXn15hSjum91QMMtnBq+YMhWNSNpUmn/biUjSkcHQr+blufI7pN8rvjQ
         iUkTv8aYZYRxaFDjaSq2Fjx5b/Nh6jgQhNpv3NomwKF6nzXKddpzlLpG2xZv92ZNBg
         Qt9afOC0UwSUutFiTPWlaAF2pwbRhTk0iHjAofXU=
Received: from [10.79.129.94] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6804E60863;
        Thu, 10 Jan 2019 04:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547092887;
        bh=N9H1sx42g3rxO59H/0N4S6TYPOpQjBM6AxrYEqytgOU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PsjIvzxEWbw68LYEMyHQaPZSlVfulD+lUC9IMEYrrZUEKzTmKp9yeOdvKBUFH3BOZ
         ymxXiISNW0NiZ1wffoxOvLQwTSEzNlZsclHTkpRe1r+VTQ6fHK/YKiHQ737QidwKDZ
         ayCKhm3Z2k9YvMJdKjzT03LCVEsE2hp6HfTd3yII=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6804E60863
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v10 0/9] Add power domain driver for corners on
 msm8996/sdm845
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com
References: <20190110035852.5666-1-rnayak@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <60bec538-3ad5-a618-ba04-ee2430a248ea@codeaurora.org>
Date:   Thu, 10 Jan 2019 09:31:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190110035852.5666-1-rnayak@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, sent the v10 out by mistake instead of v11, please ignore.

On 1/10/2019 9:28 AM, Rajendra Nayak wrote:
> Changes in v10:
> * Updated level bindings to include opp-level as an
> optional property using operating-points-v2, no new
> compatible for the OPP table
> * Updated the dev_pm_opp_get_level() helper as per
> suggestions from Viresh
> 
> Changes in v9:
> * Updated qcom-opp bindings to be generic and usable across other SoCs
> with similar needs (Like MediaTek)
> * Removed the simple_opp_to_performance_state() helper and added a
> dev_pm_opp_of_get_level() helper instead
> * Rebased on 5.0-rc1
> 
> Changes in v8:
> * Patch 01/10: Bindings updated to mention opp-hz is optional
> * Patch 02/10: Fixed #power-domain-cells
> * All dependencies for 'Patch 10/10' are on their way to 4.21 via the pm tree
> 
> Changes in v7:
> * Rebased on Andy's for-next, and used the updated cmd_db_read_aux_data()
> * Other minor fixes, all in 'PATCH 06/10' as suggested by Stephen
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
> Rajendra Nayak (9):
>    dt-bindings: opp: Introduce opp-level bindings
>    OPP: Add support for parsing the 'opp-level' property
>    dt-bindings: power: Add qcom rpm power domain driver bindings
>    soc: qcom: rpmpd: Add a Power domain driver to model corners
>    soc: qcom: rpmpd: Add support for get/set performance state
>    arm64: dts: msm8996: Add rpmpd device node
>    soc: qcom: rpmhpd: Add RPMh power domain driver
>    arm64: dts: sdm845: Add rpmh powercontroller node
>    soc: qcom: rpmhpd: Mark mx as a parent for cx
> 
>   Documentation/devicetree/bindings/opp/opp.txt |   5 +
>   .../devicetree/bindings/power/qcom,rpmpd.txt  | 145 +++++++
>   arch/arm64/boot/dts/qcom/msm8996.dtsi         |  34 ++
>   arch/arm64/boot/dts/qcom/sdm845.dtsi          |  51 +++
>   drivers/opp/core.c                            |  18 +
>   drivers/opp/of.c                              |   5 +-
>   drivers/opp/opp.h                             |   2 +
>   drivers/soc/qcom/Kconfig                      |  18 +
>   drivers/soc/qcom/Makefile                     |   2 +
>   drivers/soc/qcom/rpmhpd.c                     | 402 ++++++++++++++++++
>   drivers/soc/qcom/rpmpd.c                      | 317 ++++++++++++++
>   include/dt-bindings/power/qcom-rpmpd.h        |  39 ++
>   include/linux/pm_opp.h                        |   7 +
>   13 files changed, 1044 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>   create mode 100644 drivers/soc/qcom/rpmhpd.c
>   create mode 100644 drivers/soc/qcom/rpmpd.c
>   create mode 100644 include/dt-bindings/power/qcom-rpmpd.h
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
