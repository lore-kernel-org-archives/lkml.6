Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCB2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695CC2173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfAHL6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:58:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:46512 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfAHL6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:58:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2019 03:58:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,454,1539673200"; 
   d="scan'208";a="310008870"
Received: from yingmaol-mobl.ccr.corp.intel.com ([10.255.28.233])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jan 2019 03:58:08 -0800
Message-ID: <1546948685.2072.95.camel@intel.com>
Subject: Re: [PATCH v6 07/11] drivers: thermal: int3406_thermal: Make PCI
 dependency explicit
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sinan Kaya <okaya@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Jan 2019 19:58:05 +0800
In-Reply-To: <CAJZ5v0gst1ZDgG-uP9GUUB1ziPnqhfArio3um=wCQjfbeH2_iw@mail.gmail.com>
References: <20190105100606.6673-1-okaya@kernel.org>
         <20190105100606.6673-8-okaya@kernel.org>
         <CAJZ5v0gst1ZDgG-uP9GUUB1ziPnqhfArio3um=wCQjfbeH2_iw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 一, 2019-01-07 at 12:19 +0100, Rafael J. Wysocki wrote:
> On Sat, Jan 5, 2019 at 11:06 AM Sinan Kaya <okaya@kernel.org> wrote:
> > 
> > 
> > After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built
> > without
> > CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> > satisfied implicitly through dependencies on CONFIG_ACPI have to be
> > specified directly. Need CONFIG_PCI to be set in order to be able
> > to use
> > this driver.
> > 
> > Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without
> > CONFIG_PCI set")
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > ---
> >  drivers/thermal/intel/int340x_thermal/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig
> > b/drivers/thermal/intel/int340x_thermal/Kconfig
> > index 0582bd12a239..fba1976d5f8d 100644
> > --- a/drivers/thermal/intel/int340x_thermal/Kconfig
> > +++ b/drivers/thermal/intel/int340x_thermal/Kconfig
> > @@ -31,7 +31,7 @@ if INT340X_THERMAL
> > 
> >  config INT3406_THERMAL
> >         tristate "ACPI INT3406 display thermal driver"
> > -       depends on ACPI_VIDEO
> > +       depends on ACPI_VIDEO && PCI
> >         help
> >           The display thermal device represents the LED/LCD display
> > panel
> >           that may or may not include touch support. The main
> > function of
> > --
> Rui, any objections here?  And for the [11/11]?

CONFIG_INT3406_THERMAL depends on CONFIG_INT340X_THERMAL, so IMO, patch
11 is sufficient.

thanks,
rui
