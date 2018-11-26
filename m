Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACF4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9F720663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9F720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeKZStp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:49:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:63323 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbeKZStp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:49:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2018 23:56:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,281,1539673200"; 
   d="scan'208";a="282962762"
Received: from zhilingd-mobl1.ccr.corp.intel.com ([10.255.30.26])
  by fmsmga005.fm.intel.com with ESMTP; 25 Nov 2018 23:56:21 -0800
Message-ID: <1543218973.2126.8.camel@intel.com>
Subject: Re: [PATCH v2 0/2] driver: thermal: Move some drivers into subdirs
From:   Zhang Rui <rui.zhang@intel.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Mon, 26 Nov 2018 15:56:13 +0800
In-Reply-To: <CAHLCerNFabr5-+b8U=ouLBidGJo+e+aDVW9ZyOQy9edJB3cERw@mail.gmail.com>
References: <cover.1538638640.git.amit.kucheria@linaro.org>
         <CAHLCerMaJKaXD0pTdtMCK6C__WW-pXQ0AfY9L26dDT56szvz6A@mail.gmail.com>
         <CAHLCerNFabr5-+b8U=ouLBidGJo+e+aDVW9ZyOQy9edJB3cERw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 五, 2018-11-23 at 00:17 +0530, Amit Kucheria wrote:
> On Fri, Oct 26, 2018 at 2:21 PM Amit Kucheria <amit.kucheria@linaro.o
> rg> wrote:
> > 
> > 
> > Hi Rui,
> > 
> > On Thu, Oct 4, 2018 at 1:22 PM Amit Kucheria <amit.kucheria@linaro.
> > org> wrote:
> > > 
> > > 
> > > Move the various drivers for Intel platforms into their own
> > > subdir. Also
> > > consolidate Qualcomm drivers into the qcom subdir.
> > > 
> > > This cleans up the directory making it easier to find things.
> > Any comments on these changes?
> Rui? Eduardo?
> 
the patches were not sent to linux-pm mailing list, and that's why I
overlooked this patch set in patchwork.

thanks,
rui
> > 
> > > 
> > > There is no great time to send patches that move files around,
> > > but I'm told
> > > that towards the end of the merge window is nicer. So here's an
> > > attempt to
> > > sneak it into 4.20 after everything else and hoping that these
> > > files won't
> > > change after 4.19-rc6. :-)
> > > 
> > > This was generated and compile-tested against 4.19-rc6. If you
> > > would like
> > > me to try again a bit later, I'm happy to do so.
> > > 
> > > Changes since v1:
> > > - Removed a stray character that snuck into the Makefile
> > > - Added Acks
> > > - Rebased to v4.19-rc6
> > > 
> > > Amit Kucheria (2):
> > >   drivers: thermal: Move various drivers for intel platforms into
> > > a
> > >     subdir
> > >   drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom
> > > subdir
> > > 
> > >  drivers/thermal/Kconfig                       | 94 +----------
> > > --------
> > >  drivers/thermal/Makefile                      | 10 +-
> > >  drivers/thermal/intel/Kconfig                 | 77
> > > +++++++++++++++
> > >  drivers/thermal/intel/Makefile                | 12 +++
> > >  .../{ => intel}/int340x_thermal/Kconfig       |  0
> > >  .../{ => intel}/int340x_thermal/Makefile      |  0
> > >  .../int340x_thermal/acpi_thermal_rel.c        |  0
> > >  .../int340x_thermal/acpi_thermal_rel.h        |  0
> > >  .../int340x_thermal/int3400_thermal.c         |  0
> > >  .../int340x_thermal/int3402_thermal.c         |  0
> > >  .../int340x_thermal/int3403_thermal.c         |  0
> > >  .../int340x_thermal/int3406_thermal.c         |  0
> > >  .../int340x_thermal/int340x_thermal_zone.c    |  0
> > >  .../int340x_thermal/int340x_thermal_zone.h    |  0
> > >  .../processor_thermal_device.c                |  0
> > >  .../{ => intel}/intel_bxt_pmic_thermal.c      |  0
> > >  .../thermal/{ => intel}/intel_pch_thermal.c   |  0
> > >  .../thermal/{ => intel}/intel_powerclamp.c    |  0
> > >  .../{ => intel}/intel_quark_dts_thermal.c     |  0
> > >  .../thermal/{ => intel}/intel_soc_dts_iosf.c  |  0
> > >  .../thermal/{ => intel}/intel_soc_dts_iosf.h  |  0
> > >  .../{ => intel}/intel_soc_dts_thermal.c       |  0
> > >  .../{ => intel}/x86_pkg_temp_thermal.c        |  0
> > >  drivers/thermal/qcom/Kconfig                  | 11 +++
> > >  drivers/thermal/qcom/Makefile                 |  1 +
> > >  .../thermal/{ => qcom}/qcom-spmi-temp-alarm.c |  0
> > >  26 files changed, 107 insertions(+), 98 deletions(-)
> > >  create mode 100644 drivers/thermal/intel/Kconfig
> > >  create mode 100644 drivers/thermal/intel/Makefile
> > >  rename drivers/thermal/{ => intel}/int340x_thermal/Kconfig
> > > (100%)
> > >  rename drivers/thermal/{ => intel}/int340x_thermal/Makefile
> > > (100%)
> > >  rename drivers/thermal/{ =>
> > > intel}/int340x_thermal/acpi_thermal_rel.c (100%)
> > >  rename drivers/thermal/{ =>
> > > intel}/int340x_thermal/acpi_thermal_rel.h (100%)
> > >  rename drivers/thermal/{ =>
> > > intel}/int340x_thermal/int3400_thermal.c (100%)
> > >  rename drivers/thermal/{ =>
> > > intel}/int340x_thermal/int3402_thermal.c (100%)
> > >  rename drivers/thermal/{ =>
> > > intel}/int340x_thermal/int3403_thermal.c (100%)
> > >  rename drivers/thermal/{ =>
> > > intel}/int340x_thermal/int3406_thermal.c (100%)
> > >  rename drivers/thermal/{ =>
> > > intel}/int340x_thermal/int340x_thermal_zone.c (100%)
> > >  rename drivers/thermal/{ =>
> > > intel}/int340x_thermal/int340x_thermal_zone.h (100%)
> > >  rename drivers/thermal/{ =>
> > > intel}/int340x_thermal/processor_thermal_device.c (100%)
> > >  rename drivers/thermal/{ => intel}/intel_bxt_pmic_thermal.c
> > > (100%)
> > >  rename drivers/thermal/{ => intel}/intel_pch_thermal.c (100%)
> > >  rename drivers/thermal/{ => intel}/intel_powerclamp.c (100%)
> > >  rename drivers/thermal/{ => intel}/intel_quark_dts_thermal.c
> > > (100%)
> > >  rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.c (100%)
> > >  rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.h (100%)
> > >  rename drivers/thermal/{ => intel}/intel_soc_dts_thermal.c
> > > (100%)
> > >  rename drivers/thermal/{ => intel}/x86_pkg_temp_thermal.c (100%)
> > >  rename drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c (100%)
> > > 
> > > --
> > > 2.17.1
> > > 
