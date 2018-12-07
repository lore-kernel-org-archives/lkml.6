Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30EFC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8641520838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8641520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeLGIvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:51:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:3451 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbeLGIvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:51:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 00:51:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="99434673"
Received: from kbi-mobl.ccr.corp.intel.com ([10.249.170.84])
  by orsmga008.jf.intel.com with ESMTP; 07 Dec 2018 00:51:21 -0800
Message-ID: <1544172678.29332.23.camel@intel.com>
Subject: Re: [PATCH v4 0/2] driver: thermal: Move some drivers into subdirs
From:   Zhang Rui <rui.zhang@intel.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     edubezval@gmail.com, sfr@canb.auug.org.au,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Date:   Fri, 07 Dec 2018 16:51:18 +0800
In-Reply-To: <cover.1544165234.git.amit.kucheria@linaro.org>
References: <cover.1544165234.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

applied. But please do remember to send the patches to linux-pm mailing
list next time so that I can catch them via patchwork.

thanks,
rui

On 五, 2018-12-07 at 12:25 +0530, Amit Kucheria wrote:
> (Apologies for the build failure. My scripts to enable these configs
> and
> build-test them failed. They've been fixed now)
> 
> Move the various drivers for Intel platforms into their own subdir.
> Also
> consolidate Qualcomm drivers into the qcom subdir.
> 
> This cleans up the directory making it easier to find things.
> 
> There is no great time to send patches that move files around. So
> here's an
> attempt to sneak it into 4.21 before everything else.
> 
> This was generated and compile-tested against 4.20-rc4. If you would
> like
> me to try again a bit later, I'm happy to do so.
> 
> Changes since v3:
> - Fix build failure on QCOM_SPMI_TEMP_ALARM
> 
> Changes since v2:
> - Rebased on top of 4.20-rc4
> 
> Changes since v1:
> - Removed a stray character that snuck into the Makefile
> - Added Acks
> - Rebased to v4.19-rc6
> 
> 
> Amit Kucheria (2):
>   drivers: thermal: Move various drivers for intel platforms into a
>     subdir
>   drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom subdir
> 
>  drivers/thermal/Kconfig                       | 94 +--------------
> ----
>  drivers/thermal/Makefile                      | 10 +-
>  drivers/thermal/intel/Kconfig                 | 77 +++++++++++++++
>  drivers/thermal/intel/Makefile                | 12 +++
>  .../{ => intel}/int340x_thermal/Kconfig       |  0
>  .../{ => intel}/int340x_thermal/Makefile      |  0
>  .../int340x_thermal/acpi_thermal_rel.c        |  0
>  .../int340x_thermal/acpi_thermal_rel.h        |  0
>  .../int340x_thermal/int3400_thermal.c         |  0
>  .../int340x_thermal/int3402_thermal.c         |  0
>  .../int340x_thermal/int3403_thermal.c         |  0
>  .../int340x_thermal/int3406_thermal.c         |  0
>  .../int340x_thermal/int340x_thermal_zone.c    |  0
>  .../int340x_thermal/int340x_thermal_zone.h    |  0
>  .../processor_thermal_device.c                |  0
>  .../{ => intel}/intel_bxt_pmic_thermal.c      |  0
>  .../thermal/{ => intel}/intel_pch_thermal.c   |  0
>  .../thermal/{ => intel}/intel_powerclamp.c    |  0
>  .../{ => intel}/intel_quark_dts_thermal.c     |  0
>  .../thermal/{ => intel}/intel_soc_dts_iosf.c  |  0
>  .../thermal/{ => intel}/intel_soc_dts_iosf.h  |  0
>  .../{ => intel}/intel_soc_dts_thermal.c       |  0
>  .../{ => intel}/x86_pkg_temp_thermal.c        |  0
>  drivers/thermal/qcom/Kconfig                  | 11 +++
>  drivers/thermal/qcom/Makefile                 |  1 +
>  .../thermal/{ => qcom}/qcom-spmi-temp-alarm.c |  2 +-
>  26 files changed, 108 insertions(+), 99 deletions(-)
>  create mode 100644 drivers/thermal/intel/Kconfig
>  create mode 100644 drivers/thermal/intel/Makefile
>  rename drivers/thermal/{ => intel}/int340x_thermal/Kconfig (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/Makefile (100%)
>  rename drivers/thermal/{ =>
> intel}/int340x_thermal/acpi_thermal_rel.c (100%)
>  rename drivers/thermal/{ =>
> intel}/int340x_thermal/acpi_thermal_rel.h (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3400_thermal.c
> (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3402_thermal.c
> (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3403_thermal.c
> (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3406_thermal.c
> (100%)
>  rename drivers/thermal/{ =>
> intel}/int340x_thermal/int340x_thermal_zone.c (100%)
>  rename drivers/thermal/{ =>
> intel}/int340x_thermal/int340x_thermal_zone.h (100%)
>  rename drivers/thermal/{ =>
> intel}/int340x_thermal/processor_thermal_device.c (100%)
>  rename drivers/thermal/{ => intel}/intel_bxt_pmic_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/intel_pch_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/intel_powerclamp.c (100%)
>  rename drivers/thermal/{ => intel}/intel_quark_dts_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.c (100%)
>  rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.h (100%)
>  rename drivers/thermal/{ => intel}/intel_soc_dts_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/x86_pkg_temp_thermal.c (100%)
>  rename drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c (99%)
> 
