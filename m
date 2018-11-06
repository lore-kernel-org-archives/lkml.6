Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93EBC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425D820869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425D820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbeKFQ7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:59:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:42050 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387461AbeKFQ7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 11:59:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 23:34:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,470,1534834800"; 
   d="scan'208";a="278681621"
Received: from dgao1-mobl1.ccr.corp.intel.com ([10.255.30.243])
  by fmsmga006.fm.intel.com with ESMTP; 05 Nov 2018 23:34:41 -0800
Message-ID: <1541489678.2124.71.camel@intel.com>
Subject: Re: [PATCH v2 00/17] thermal: enable+check sensor after its setup
 is finished
From:   Zhang Rui <rui.zhang@intel.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
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
Date:   Tue, 06 Nov 2018 15:34:38 +0800
In-Reply-To: <ba5bc790-6809-e0e3-58fb-757c8c617181@samsung.com>
References: <CGME20181017155314epcas2p4a5aa24978b36354a2ccb2f9b0fb6f0f6@epcas2p4.samsung.com>
         <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
         <1541387097.2124.9.camel@intel.com>
         <ba5bc790-6809-e0e3-58fb-757c8c617181@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bartlomiej,

On 一, 2018-11-05 at 17:35 +0100, Bartlomiej Zolnierkiewicz wrote:
> On 11/05/2018 04:04 AM, Zhang Rui wrote:
> > 
> > Hi, Bartlomiej,
> Hi Rui,
> 
> > 
> > Interesting, I'm about to bring this issue to Linux Plumber
> > Conference
> > this year for discussion, and I'm also proposing a solution to fix
> > the
> > issues, but only with thermal core part finished yet.
> > can you please take a look at it?
> > https://patchwork.kernel.org/project/linux-pm/list/?series=38181
> Thank you for the patches but they seem to be far from being
> a complete solution for issues fixed by my patchset.

Right, as I said, this is a draft patch to illustrate my idea for those
issues. And it is not targeting for upstream.

>  Even
> thermal core part is not finished yet as it doesn't provide
> a way to register disabled sensors for DT thermal drivers (only
> for platform ones)..

we need sequential change of of_thermal to set tzp->disable
in of_parse_thermal_zones.

> 
> Why not simply apply my patchset now and incrementally work
> on top of it to implement fixes for issues your patchset is
> addressing?

The main concern is that, as you point out, we have too many private
mode implementation, and I'm looking for the possibility to handle them
in the thermal core framework.

> 
> My patchset may not be a perfect solution but IMO it is good
> enough and it has been practically ready since v1 posted in
> April (v2 fixes all issues requested by Eduardo's review from
> September)..

I'm not against doing this, as long as it fixes something and doesn't
break the others.
But, I still have a couple of comments about your patches, and let me
comment in lines.

thanks,
rui
> 
> > 
> > thanks,
> > rui
> > 
> > On 三, 2018-10-17 at 17:52 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > Hi,
> > > 
> > > [devm]_thermal_zone_of_sensor_register() is used to register
> > > thermal sensor by thermal drivers using DeviceTree. Besides
> > > registering sensor this function also immediately:
> > > 
> > > - enables it:
> > > 
> > >   tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED)
> > >   (->set_mode is set to of_thermal_set_mode() in of-thermal.c)
> > > 
> > > - checks it (indirectly by using of_thermal_set_mode()):
> > > 
> > >   thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> > >   (which in turn ends up using ->get_temp method).
> > > 
> > > For many DT thermal drivers this causes a problem because:
> > > 
> > > - [devm]_thermal_zone_of_sensor_register() need to be called in
> > >   order to obtain data about thermal trips which are then used to
> > >   finish hardware sensor setup (only after which ->get_temp can
> > >   be used)
> > > 
> > > There is also related issue for DT thermal drivers that support
> > > IRQ (i.e. exynos and rockchip ones):
> > > 
> > > - sensor hardware should be enabled only after IRQ handler is
> > >   requested (because otherwise we might get IRQs that we can't
> > >   handle)
> > > 
> > > - IRQ handler needs tzd structure which is obtained from
> > >   [devm_]thermal_zone_of_sensor_register()
> > > 
> > > - after [devm_]thermal_zone_of_sensor_register() call core
> > >   thermal code assumes that sensor is enabled and ready to use
> > >   (i.e. that IRQ handler has been requested and sensor hardware
> > >   has been enabled)
> > > 
> > > In order to fix all abovementioned issues sensor registration,
> > > enable and check operations are separated in the core DT thermal
> > > code and corresponding DT thermal drivers are modified to do
> > > sensor
> > > setup correctly.
> > > 
> > > Changes since v1:
> > > - rebased on the current -next kernel (next-20181015)
> > > - enhanced patch descriptions and cover letter
> > > - renamed thermal_zone_device_toggler() to
> > > thermal_zone_set_mode()
> > > - converted thermal_zone_set_mode() to use enum
> > > thermal_device_mode
> > > - added CONFIG_THERMAL=n stubs for thermal_zone_set_mode() and
> > >   thermal_zone_device_check()
> > > - fixed uses of [devm]_thermal_zone_of_sensor_register() outside
> > > of
> > >   drivers/thermal/
> > > - changed ordering between patch #2 and #3 in order to add all
> > >   needed core helpers first before fixing sensor setup code
> > > - changed ordering between patch #3 and #4 in order to simplify
> > > them
> > > - renamed patch #3 to "thermal: separate sensor enable and check
> > >   operations"
> > > - renamed patch #4 to "thermal: separate sensor registration and
> > >   enable+check operations"
> > > 
> > > Best regards,
> > > --
> > > Bartlomiej Zolnierkiewicz
> > > Samsung R&D Institute Poland
> > > Samsung Electronics
> > > 
> > > 
> > > Bartlomiej Zolnierkiewicz (17):
> > >   thermal: add thermal_zone_set_mode() helper
> > >   thermal: add thermal_zone_device_check() helper
> > >   thermal: separate sensor enable and check operations
> > >   thermal: separate sensor registration and enable+check
> > > operations
> > >   thermal: bcm2835: enable+check sensor after its setup is
> > > finished
> > >   thermal: brcmstb: enable+check sensor after its setup is
> > > finished
> > >   thermal: hisi_thermal: enable+check sensor after its setup is
> > > finished
> > >   thermal: qcom: tsens: enable+check sensor after its setup is
> > > finished
> > >   thermal: qoriq: enable+check sensor after its setup is finished
> > >   thermal: rcar_gen3_thermal: enable+check sensor after its setup
> > > is
> > >     finished
> > >   thermal: rockchip_thermal: enable+check sensor after its setup
> > > is
> > >     finished
> > >   thermal: exynos: enable+check sensor after its setup is
> > > finished
> > >   thermal: tegra: enable+check sensor after its setup is finished
> > >   thermal: ti-soc-thermal: enable+check sensor after its setup is
> > >     finished
> > >   thermal: uniphier: enable+check sensor after its setup is
> > > finished
> > >   thermal: zx2967: enable+check sensor after its setup is
> > > finished
> > >   thermal: warn on attempts to read temperature on disabled
> > > sensors
> > > 
> > >  drivers/acpi/thermal.c                             |  5 +--
> > >  drivers/ata/ahci_imx.c                             | 10 ++++--
> > >  drivers/hwmon/hwmon.c                              |  5 +++
> > >  drivers/hwmon/ntc_thermistor.c                     |  4 +++
> > >  drivers/hwmon/scpi-hwmon.c                         |  4 +++
> > >  drivers/iio/adc/sun4i-gpadc-iio.c                  |  5 +++
> > >  drivers/input/touchscreen/sun4i-ts.c               |  8 ++++-
> > >  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  1 -
> > >  drivers/platform/x86/acerhdf.c                     |  6 +++-
> > >  drivers/regulator/max8973-regulator.c              |  6 ++--
> > >  drivers/thermal/armada_thermal.c                   |  3 ++
> > >  drivers/thermal/broadcom/bcm2835_thermal.c         |  3 ++
> > >  drivers/thermal/broadcom/brcmstb_thermal.c         |  3 ++
> > >  drivers/thermal/broadcom/ns-thermal.c              |  3 ++
> > >  drivers/thermal/da9062-thermal.c                   |  7 ++--
> > >  drivers/thermal/db8500_thermal.c                   |  5 ++-
> > >  drivers/thermal/hisi_thermal.c                     | 22 ++++--
> > > ----
> > > ---
> > >  drivers/thermal/imx_thermal.c                      |  3 +-
> > >  drivers/thermal/int340x_thermal/int3400_thermal.c  |  1 +
> > >  drivers/thermal/intel_bxt_pmic_thermal.c           |  3 +-
> > >  drivers/thermal/intel_soc_dts_iosf.c               |  3 +-
> > >  drivers/thermal/max77620_thermal.c                 |  6 ++--
> > >  drivers/thermal/mtk_thermal.c                      |  3 ++
> > >  drivers/thermal/of-thermal.c                       |  6 ++--
> > >  drivers/thermal/qcom-spmi-temp-alarm.c             |  5 ++-
> > >  drivers/thermal/qcom/tsens.c                       |  6 ++++
> > >  drivers/thermal/qoriq_thermal.c                    |  3 ++
> > >  drivers/thermal/rcar_gen3_thermal.c                |  7 ++--
> > >  drivers/thermal/rcar_thermal.c                     |  7 ++--
> > >  drivers/thermal/rockchip_thermal.c                 | 38
> > > +++++++++++-
> > > ----------
> > >  drivers/thermal/samsung/exynos_tmu.c               |  7 +++-
> > >  drivers/thermal/st/st_thermal_memmap.c             |  3 +-
> > >  drivers/thermal/tango_thermal.c                    |  5 +++
> > >  drivers/thermal/tegra/soctherm.c                   |  3 ++
> > >  drivers/thermal/tegra/tegra-bpmp-thermal.c         |  3 ++
> > >  drivers/thermal/thermal-generic-adc.c              |  3 ++
> > >  drivers/thermal/thermal_core.c                     | 14 ++++----
> > >  drivers/thermal/thermal_helpers.c                  | 32
> > > ++++++++++++++++++
> > >  drivers/thermal/thermal_sysfs.c                    | 17 ++++++
> > > ----
> > >  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  7 +++-
> > >  drivers/thermal/uniphier_thermal.c                 |  6 +++-
> > >  drivers/thermal/x86_pkg_temp_thermal.c             |  2 +-
> > >  drivers/thermal/zx2967_thermal.c                   |  3 ++
> > >  include/linux/thermal.h                            | 11 +++++++
> > >  44 files changed, 220 insertions(+), 87 deletions(-)
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
