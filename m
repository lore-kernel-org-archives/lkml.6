Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF751C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FDD218AE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfAAOEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 09:04:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:53323 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfAAOEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 09:04:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2019 06:04:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,427,1539673200"; 
   d="scan'208";a="104731564"
Received: from dliu15-mobl5.ccr.corp.intel.com ([10.249.175.141])
  by orsmga006.jf.intel.com with ESMTP; 01 Jan 2019 06:04:41 -0800
Message-ID: <1546351479.2077.1.camel@intel.com>
Subject: Re: [PATCH v5 0/3] Stingray thermal driver support
From:   Zhang Rui <rui.zhang@intel.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Date:   Tue, 01 Jan 2019 22:04:39 +0800
In-Reply-To: <3c05a1f1-5041-ebb7-27e5-0a2321314b0a@broadcom.com>
References: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
         <b6e02875-784f-4908-a985-5ee7e3df3ac6@gmail.com>
         <CABe79T4mpnbkaTCerYegmc1+uY4idOVOxCVDqHramk3fYipiCA@mail.gmail.com>
         <3c05a1f1-5041-ebb7-27e5-0a2321314b0a@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 一, 2018-12-31 at 14:15 -0800, Florian Fainelli wrote:
> 
> On 04/12/2018 19:17, Srinath Mannam wrote:
> > 
> > Hi,
> > 
> > Could you please provide your feedback to this patch series?
> Rui or Eduardo can we get either one of you to review the thermal
> driver
> parts of this patch series? Why do we constantly have to chase people
> to
> respond in this specific subsystem?
> 
Eduardo, can you please take a look at this patch series?

thanks,
rui
> > 
> > 
> > Regards,
> > Srinath.
> > On Thu, Nov 8, 2018 at 3:45 AM Florian Fainelli <f.fainelli@gmail.c
> > om> wrote:
> > > 
> > > 
> > > 
> > > 
> > > On 10/16/2018 8:11 AM, Srinath Mannam wrote:
> > > > 
> > > > These patches adds the stingray thermal driver and its
> > > > corresponding DT nodes with documentation.
> > > Can we get feedback from the thermal maintains whether this is
> > > acceptable or not?
> > > 
> > > > 
> > > > 
> > > > Changes from v4
> > > >   - Addressed Rob Herring comments on DT parameters and
> > > >     thermal driver architecture.
> > > >   - Removed brcm,max-crit-temp DT parameter
> > > >   - Changed driver to thermal sensor registration model.
> > > >   - Added trip DT properties.
> > > > 
> > > > Changes from v3
> > > >   - Addressed Daniel lezcano comments.
> > > >   - Elaborated commit description of thermal driver patch.
> > > >   - Added brcm,max-crit-temp DT parameter.
> > > > 
> > > > Changes from v2:
> > > >   - All stingray TMON DT nodes are combine together into
> > > > single.
> > > >     Temperature registers are combined into one mem resource.
> > > >     brcm,tmon-mask parameter has available TMONs mask value.
> > > >   - All available TMONs are initialized together in single
> > > >     instance of driver probe call.
> > > > 
> > > > Changes from v1:
> > > >   - Fixed auto build sparce warning.
> > > > 
> > > > Pramod Kumar (3):
> > > >   dt-bindings: thermal: Add binding document for SR thermal
> > > >   thermal: broadcom: Add Stingray thermal driver
> > > >   arm64: dts: stingray: Add Stingray Thermal DT support.
> > > > 
> > > >  .../bindings/thermal/brcm,sr-thermal.txt           | 105
> > > > ++++++++++++++++
> > > >  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  89
> > > > +++++++++++++
> > > >  drivers/thermal/Kconfig                            |   3 +-
> > > >  drivers/thermal/broadcom/Kconfig                   |   9 ++
> > > >  drivers/thermal/broadcom/Makefile                  |   1 +
> > > >  drivers/thermal/broadcom/sr-thermal.c              | 138
> > > > +++++++++++++++++++++
> > > >  6 files changed, 344 insertions(+), 1 deletion(-)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> > > >  create mode 100644 drivers/thermal/broadcom/sr-thermal.c
> > > > 
> > > --
> > > Florian
