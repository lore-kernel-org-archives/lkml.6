Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EADEC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2D220862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqEyD1mW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2D220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbeKFKJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:09:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35189 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeKFKJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 05:09:20 -0500
Received: by mail-pl1-f194.google.com with SMTP id n4-v6so5304053plp.2;
        Mon, 05 Nov 2018 16:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QQ+RvuNXRXMiXkyuHsrGRV9DsHN2uumOXTnYk1Y3LaY=;
        b=rqEyD1mWtHMWIcB724b+AhaG4b4ceoYD1onzzcOtn8aVY1czFuTLb9r9lsoHEZefLE
         5JPobVZ8Ga1Q5iWhNWWpv8vwF1GLhirS51qJ/jUEBxzv59fGzC0uACg/t+B/k6fzLY4e
         SyWFa2JBL3Mm6IRiY1KfHAcYh/gPHHgPQ0/N7dr6QkJki5Z8vT8nrYjRU68y2/mcT9Kt
         XAZd/SkJKaRSSUkihB/zV+2zF/yc+1TY9agz77Dn/abb7ogMg6frOff+kSurGxDwHhiB
         /qGMbEGTzdCsB/NohwjUfr1P3wQtvbc+ZtFrPgs/pLLeKwlNPpSyE6DkZjBrctxfQCXd
         SY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QQ+RvuNXRXMiXkyuHsrGRV9DsHN2uumOXTnYk1Y3LaY=;
        b=VpvjTjWgZwXQ+ddoK5gZBFzZit7SwHZ4qB1tZPPX+gRXFaTB/uy0mk6F5OmTRiQIjw
         zw1BAI61HOE6uIe7FwFlX11eAdhd+xry0x7EvnuZ+FJ8dtFO5T3HAYULdPBCmr8m5Jnn
         jaDsYBLV3vG7L1p0AwOEsGFTfHbJkR0ki9gRDehNbWRw5UAYDfjMGxCb977S2F+9i511
         VkAkDqQlUu8bXz4Gmy+kCHOWaKdeZIBW154SHHp1swjH8tQzV/xD26hVmkz0BD4/yr9E
         lAG0RCysORqs2DOveUghsg8/wTuLLGp3LY+OX+Hco1D4+G2ns2vg9dKeDnwlSb5NQ/Wh
         yw5Q==
X-Gm-Message-State: AGRZ1gI9gAGPMJtIJcgbtUqzU6Mq1AAJjGz62iH+tLKQwoO00oH5qyhx
        1d5SEtt/Jl79CEasfT8WhUw=
X-Google-Smtp-Source: AJdET5cZGBcUOODxhNvHWPvKTLkHque06iur8zozujYjRov2mbvbXCZ2G+loNcr/15XmXgO16S2FWg==
X-Received: by 2002:a17:902:654a:: with SMTP id d10-v6mr23184487pln.302.1541465212176;
        Mon, 05 Nov 2018 16:46:52 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id b18-v6sm39069863pgg.88.2018.11.05.16.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 16:46:51 -0800 (PST)
Date:   Mon, 5 Nov 2018 16:46:46 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit kucheria <amit.kucheria@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/17] thermal: enable+check sensor after its setup is
 finished
Message-ID: <20181106004645.GB6086@localhost.localdomain>
References: <CGME20181017155314epcas2p4a5aa24978b36354a2ccb2f9b0fb6f0f6@epcas2p4.samsung.com>
 <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
 <1541387097.2124.9.camel@intel.com>
 <ba5bc790-6809-e0e3-58fb-757c8c617181@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba5bc790-6809-e0e3-58fb-757c8c617181@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Mon, Nov 05, 2018 at 05:35:55PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> On 11/05/2018 04:04 AM, Zhang Rui wrote:
> > Hi, Bartlomiej,
> 
> Hi Rui,
> 
> > Interesting, I'm about to bring this issue to Linux Plumber Conference
> > this year for discussion, and I'm also proposing a solution to fix the
> > issues, but only with thermal core part finished yet.
> > can you please take a look at it?
> > https://patchwork.kernel.org/project/linux-pm/list/?series=38181
> 
> Thank you for the patches but they seem to be far from being
> a complete solution for issues fixed by my patchset. Even
> thermal core part is not finished yet as it doesn't provide
> a way to register disabled sensors for DT thermal drivers (only
> for platform ones)..
> 
> Why not simply apply my patchset now and incrementally work
> on top of it to implement fixes for issues your patchset is
> addressing?
> 
> My patchset may not be a perfect solution but IMO it is good
> enough and it has been practically ready since v1 posted in
> April (v2 fixes all issues requested by Eduardo's review from
> September)..

Rui, I agree with Bartlomiej here. I propose to create
a topic branch with both series, Bartlomiej's then yours. 

Feels to me that this is a wider change across multiple drivers, 
and across driver types, platform and of- based, so might be
better to avoid breakage.



> 
> > thanks,
> > rui
> > 
> > On 三, 2018-10-17 at 17:52 +0200, Bartlomiej Zolnierkiewicz wrote:
> >> Hi,
> >>
> >> [devm]_thermal_zone_of_sensor_register() is used to register
> >> thermal sensor by thermal drivers using DeviceTree. Besides
> >> registering sensor this function also immediately:
> >>
> >> - enables it:
> >>
> >>   tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED)
> >>   (->set_mode is set to of_thermal_set_mode() in of-thermal.c)
> >>
> >> - checks it (indirectly by using of_thermal_set_mode()):
> >>
> >>   thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> >>   (which in turn ends up using ->get_temp method).
> >>
> >> For many DT thermal drivers this causes a problem because:
> >>
> >> - [devm]_thermal_zone_of_sensor_register() need to be called in
> >>   order to obtain data about thermal trips which are then used to
> >>   finish hardware sensor setup (only after which ->get_temp can
> >>   be used)
> >>
> >> There is also related issue for DT thermal drivers that support
> >> IRQ (i.e. exynos and rockchip ones):
> >>
> >> - sensor hardware should be enabled only after IRQ handler is
> >>   requested (because otherwise we might get IRQs that we can't
> >>   handle)
> >>
> >> - IRQ handler needs tzd structure which is obtained from
> >>   [devm_]thermal_zone_of_sensor_register()
> >>
> >> - after [devm_]thermal_zone_of_sensor_register() call core
> >>   thermal code assumes that sensor is enabled and ready to use
> >>   (i.e. that IRQ handler has been requested and sensor hardware
> >>   has been enabled)
> >>
> >> In order to fix all abovementioned issues sensor registration,
> >> enable and check operations are separated in the core DT thermal
> >> code and corresponding DT thermal drivers are modified to do sensor
> >> setup correctly.
> >>
> >> Changes since v1:
> >> - rebased on the current -next kernel (next-20181015)
> >> - enhanced patch descriptions and cover letter
> >> - renamed thermal_zone_device_toggler() to thermal_zone_set_mode()
> >> - converted thermal_zone_set_mode() to use enum thermal_device_mode
> >> - added CONFIG_THERMAL=n stubs for thermal_zone_set_mode() and
> >>   thermal_zone_device_check()
> >> - fixed uses of [devm]_thermal_zone_of_sensor_register() outside of
> >>   drivers/thermal/
> >> - changed ordering between patch #2 and #3 in order to add all
> >>   needed core helpers first before fixing sensor setup code
> >> - changed ordering between patch #3 and #4 in order to simplify them
> >> - renamed patch #3 to "thermal: separate sensor enable and check
> >>   operations"
> >> - renamed patch #4 to "thermal: separate sensor registration and
> >>   enable+check operations"
> >>
> >> Best regards,
> >> --
> >> Bartlomiej Zolnierkiewicz
> >> Samsung R&D Institute Poland
> >> Samsung Electronics
> >>
> >>
> >> Bartlomiej Zolnierkiewicz (17):
> >>   thermal: add thermal_zone_set_mode() helper
> >>   thermal: add thermal_zone_device_check() helper
> >>   thermal: separate sensor enable and check operations
> >>   thermal: separate sensor registration and enable+check operations
> >>   thermal: bcm2835: enable+check sensor after its setup is finished
> >>   thermal: brcmstb: enable+check sensor after its setup is finished
> >>   thermal: hisi_thermal: enable+check sensor after its setup is
> >> finished
> >>   thermal: qcom: tsens: enable+check sensor after its setup is
> >> finished
> >>   thermal: qoriq: enable+check sensor after its setup is finished
> >>   thermal: rcar_gen3_thermal: enable+check sensor after its setup is
> >>     finished
> >>   thermal: rockchip_thermal: enable+check sensor after its setup is
> >>     finished
> >>   thermal: exynos: enable+check sensor after its setup is finished
> >>   thermal: tegra: enable+check sensor after its setup is finished
> >>   thermal: ti-soc-thermal: enable+check sensor after its setup is
> >>     finished
> >>   thermal: uniphier: enable+check sensor after its setup is finished
> >>   thermal: zx2967: enable+check sensor after its setup is finished
> >>   thermal: warn on attempts to read temperature on disabled sensors
> >>
> >>  drivers/acpi/thermal.c                             |  5 +--
> >>  drivers/ata/ahci_imx.c                             | 10 ++++--
> >>  drivers/hwmon/hwmon.c                              |  5 +++
> >>  drivers/hwmon/ntc_thermistor.c                     |  4 +++
> >>  drivers/hwmon/scpi-hwmon.c                         |  4 +++
> >>  drivers/iio/adc/sun4i-gpadc-iio.c                  |  5 +++
> >>  drivers/input/touchscreen/sun4i-ts.c               |  8 ++++-
> >>  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  1 -
> >>  drivers/platform/x86/acerhdf.c                     |  6 +++-
> >>  drivers/regulator/max8973-regulator.c              |  6 ++--
> >>  drivers/thermal/armada_thermal.c                   |  3 ++
> >>  drivers/thermal/broadcom/bcm2835_thermal.c         |  3 ++
> >>  drivers/thermal/broadcom/brcmstb_thermal.c         |  3 ++
> >>  drivers/thermal/broadcom/ns-thermal.c              |  3 ++
> >>  drivers/thermal/da9062-thermal.c                   |  7 ++--
> >>  drivers/thermal/db8500_thermal.c                   |  5 ++-
> >>  drivers/thermal/hisi_thermal.c                     | 22 ++++------
> >> ---
> >>  drivers/thermal/imx_thermal.c                      |  3 +-
> >>  drivers/thermal/int340x_thermal/int3400_thermal.c  |  1 +
> >>  drivers/thermal/intel_bxt_pmic_thermal.c           |  3 +-
> >>  drivers/thermal/intel_soc_dts_iosf.c               |  3 +-
> >>  drivers/thermal/max77620_thermal.c                 |  6 ++--
> >>  drivers/thermal/mtk_thermal.c                      |  3 ++
> >>  drivers/thermal/of-thermal.c                       |  6 ++--
> >>  drivers/thermal/qcom-spmi-temp-alarm.c             |  5 ++-
> >>  drivers/thermal/qcom/tsens.c                       |  6 ++++
> >>  drivers/thermal/qoriq_thermal.c                    |  3 ++
> >>  drivers/thermal/rcar_gen3_thermal.c                |  7 ++--
> >>  drivers/thermal/rcar_thermal.c                     |  7 ++--
> >>  drivers/thermal/rockchip_thermal.c                 | 38 +++++++++++-
> >> ----------
> >>  drivers/thermal/samsung/exynos_tmu.c               |  7 +++-
> >>  drivers/thermal/st/st_thermal_memmap.c             |  3 +-
> >>  drivers/thermal/tango_thermal.c                    |  5 +++
> >>  drivers/thermal/tegra/soctherm.c                   |  3 ++
> >>  drivers/thermal/tegra/tegra-bpmp-thermal.c         |  3 ++
> >>  drivers/thermal/thermal-generic-adc.c              |  3 ++
> >>  drivers/thermal/thermal_core.c                     | 14 ++++----
> >>  drivers/thermal/thermal_helpers.c                  | 32
> >> ++++++++++++++++++
> >>  drivers/thermal/thermal_sysfs.c                    | 17 ++++++----
> >>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  7 +++-
> >>  drivers/thermal/uniphier_thermal.c                 |  6 +++-
> >>  drivers/thermal/x86_pkg_temp_thermal.c             |  2 +-
> >>  drivers/thermal/zx2967_thermal.c                   |  3 ++
> >>  include/linux/thermal.h                            | 11 +++++++
> >>  44 files changed, 220 insertions(+), 87 deletions(-)
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
