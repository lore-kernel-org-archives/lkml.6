Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1E3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DD920824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSm+SKvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DD920824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392063AbeKWF1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 00:27:52 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40935 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388462AbeKWF1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 00:27:52 -0500
Received: by mail-vk1-f194.google.com with SMTP id v70so2196759vkv.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 10:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2nP8A6I/eolmd/qXMVHJb3nfTW/doYGd5QZ5izzC4M=;
        b=LSm+SKvXUVeCky077rxfup7q4qaz1QS4D4jf2FNIfcHlkDiFH+5j9UjL73eg6VNnK9
         2jkCkr8slO4BuBmC3VfNu1v5sultI7pj15KIwtiNoohqcbmMVFCnQwJFl0KscqqgHtnD
         kvVK62p+9Eu5e9Os6CAyux9LBa3ol92Ll0mPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2nP8A6I/eolmd/qXMVHJb3nfTW/doYGd5QZ5izzC4M=;
        b=I13VPQGkye7SulJKn4ef9t3nleGGQSJdi+BOWWaO887c41OfrISz020JKTNgOIWRd8
         XjPXSNqzYFXZl+bCfwy70BNbj2/fFEDYEnt7FmjIrtWDZhCfvplCBTQ19Ml4rBBlmZ1B
         AMUAf/HHTu6iEwduyub0G64Rj6R9sz1ax3qsGoisbxdQHYeGrBt6au68quZ5KsuJepqC
         E/CkTCgjgacgcjjTTPyuEXOop3Gsqz6H6MG6lsJ0N6HOQpEyBaKZdMFY8ap+NUS41cxl
         7KociR9W2J2J0zr4hTGjf3ZSwj5sJTrRDAk+9e4NGXB1QGUiJq0vJsPfX0VmN4I0C2tE
         2kSA==
X-Gm-Message-State: AA+aEWZu1EsE+GWJhUzO7AkXhqfWLNcjUwLgkG8tRzPa28tFGsRwyCig
        8uyp4GmuMQ2i3hPWRDesw6ysX8AB0p4HP7zDoWdG7oyo
X-Google-Smtp-Source: AFSGD/VPbOyx9RTf4XXpo4Omwgqpe6AgDLn7aY5CiaLXIBwls9CB0blwBJwtlL1zAo2eshDXB/NkyzxhR5Z2hvEfgk0=
X-Received: by 2002:a1f:a8c5:: with SMTP id r188mr5026173vke.44.1542912434070;
 Thu, 22 Nov 2018 10:47:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1538638640.git.amit.kucheria@linaro.org> <CAHLCerMaJKaXD0pTdtMCK6C__WW-pXQ0AfY9L26dDT56szvz6A@mail.gmail.com>
In-Reply-To: <CAHLCerMaJKaXD0pTdtMCK6C__WW-pXQ0AfY9L26dDT56szvz6A@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 23 Nov 2018 00:17:02 +0530
Message-ID: <CAHLCerNFabr5-+b8U=ouLBidGJo+e+aDVW9ZyOQy9edJB3cERw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] driver: thermal: Move some drivers into subdirs
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 2:21 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> Hi Rui,
>
> On Thu, Oct 4, 2018 at 1:22 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >
> > Move the various drivers for Intel platforms into their own subdir. Also
> > consolidate Qualcomm drivers into the qcom subdir.
> >
> > This cleans up the directory making it easier to find things.
>
> Any comments on these changes?

Rui? Eduardo?

> > There is no great time to send patches that move files around, but I'm told
> > that towards the end of the merge window is nicer. So here's an attempt to
> > sneak it into 4.20 after everything else and hoping that these files won't
> > change after 4.19-rc6. :-)
> >
> > This was generated and compile-tested against 4.19-rc6. If you would like
> > me to try again a bit later, I'm happy to do so.
> >
> > Changes since v1:
> > - Removed a stray character that snuck into the Makefile
> > - Added Acks
> > - Rebased to v4.19-rc6
> >
> > Amit Kucheria (2):
> >   drivers: thermal: Move various drivers for intel platforms into a
> >     subdir
> >   drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom subdir
> >
> >  drivers/thermal/Kconfig                       | 94 +------------------
> >  drivers/thermal/Makefile                      | 10 +-
> >  drivers/thermal/intel/Kconfig                 | 77 +++++++++++++++
> >  drivers/thermal/intel/Makefile                | 12 +++
> >  .../{ => intel}/int340x_thermal/Kconfig       |  0
> >  .../{ => intel}/int340x_thermal/Makefile      |  0
> >  .../int340x_thermal/acpi_thermal_rel.c        |  0
> >  .../int340x_thermal/acpi_thermal_rel.h        |  0
> >  .../int340x_thermal/int3400_thermal.c         |  0
> >  .../int340x_thermal/int3402_thermal.c         |  0
> >  .../int340x_thermal/int3403_thermal.c         |  0
> >  .../int340x_thermal/int3406_thermal.c         |  0
> >  .../int340x_thermal/int340x_thermal_zone.c    |  0
> >  .../int340x_thermal/int340x_thermal_zone.h    |  0
> >  .../processor_thermal_device.c                |  0
> >  .../{ => intel}/intel_bxt_pmic_thermal.c      |  0
> >  .../thermal/{ => intel}/intel_pch_thermal.c   |  0
> >  .../thermal/{ => intel}/intel_powerclamp.c    |  0
> >  .../{ => intel}/intel_quark_dts_thermal.c     |  0
> >  .../thermal/{ => intel}/intel_soc_dts_iosf.c  |  0
> >  .../thermal/{ => intel}/intel_soc_dts_iosf.h  |  0
> >  .../{ => intel}/intel_soc_dts_thermal.c       |  0
> >  .../{ => intel}/x86_pkg_temp_thermal.c        |  0
> >  drivers/thermal/qcom/Kconfig                  | 11 +++
> >  drivers/thermal/qcom/Makefile                 |  1 +
> >  .../thermal/{ => qcom}/qcom-spmi-temp-alarm.c |  0
> >  26 files changed, 107 insertions(+), 98 deletions(-)
> >  create mode 100644 drivers/thermal/intel/Kconfig
> >  create mode 100644 drivers/thermal/intel/Makefile
> >  rename drivers/thermal/{ => intel}/int340x_thermal/Kconfig (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/Makefile (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/acpi_thermal_rel.c (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/acpi_thermal_rel.h (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/int3400_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/int3402_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/int3403_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/int3406_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/int340x_thermal_zone.c (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/int340x_thermal_zone.h (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/processor_thermal_device.c (100%)
> >  rename drivers/thermal/{ => intel}/intel_bxt_pmic_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/intel_pch_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/intel_powerclamp.c (100%)
> >  rename drivers/thermal/{ => intel}/intel_quark_dts_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.c (100%)
> >  rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.h (100%)
> >  rename drivers/thermal/{ => intel}/intel_soc_dts_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/x86_pkg_temp_thermal.c (100%)
> >  rename drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c (100%)
> >
> > --
> > 2.17.1
> >
