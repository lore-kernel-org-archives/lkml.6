Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20409C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98B62084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAa3BWqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98B62084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeJZR1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:27:25 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42485 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeJZR1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:27:25 -0400
Received: by mail-ua1-f66.google.com with SMTP id w12so131796uam.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sHawCZLUaNKPl5AAP18hK5nsqSUmyG4yQe93YGM803s=;
        b=YAa3BWqZ0O+OTsroyCHN+X8P5O9xg+U1BS1ZTzK1GkSoda3M91h5Ni4MMEht0mDeUF
         60ccNtn2v4ryNLzop7MrALZIHBLjPh/BIxXqC75PJPzd1z2B/VcKgYKUUbF9Zs7dCBrV
         lrKepuYuPMd4Bnl5Vd1pose+GtIFLGFIt4iyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHawCZLUaNKPl5AAP18hK5nsqSUmyG4yQe93YGM803s=;
        b=Z59qvN0GPh5aZk0Z3fFPgi3qV0tnxRW37L/Vdw7k/+STf2+KFPjPpN83zVJhkiX3XH
         7UA0gJg9A6ERQmWeO0wPa0aMdsda9f8cdYylqe3hHgIdiw60Ehd2r61uu3P7UObVubII
         tPLZWlSCXCO3j4c5Dfyxaz9L6ukjCXgP2wCwJQACod6EBuWpNNdWMAghgxpJ847+8yrd
         +PoLAL4XrnwoSXJC/7sD0ryuBF7037Qcy/Df5KdlIjjiH4VPIPl7txs3HqMdrLzkf1PE
         a+Fi+/FrBxcrCY6djT4TFarUY0qdDqdgvhpr1KbT2nQUxPfREPKyYlU1phzm2LNLqcLw
         qwzQ==
X-Gm-Message-State: AGRZ1gJBNTdnB6HUjJ70bvbvjMNqsTv6dcYeVympEtuCYfrYN/eSCBOe
        MW0ZekQK5YDOm69Oh4GI8oM9rx8ToE0NlIEoMIfZMhpi
X-Google-Smtp-Source: AJdET5fgoeDB/bKsHYZSxckzjbFxWaflT1QAnFWnvcgqFwEkX0V0EtxJS394HvXHqOWOP+f4y9iRFrN2A55OeeJ5O8E=
X-Received: by 2002:ab0:6282:: with SMTP id z2mr1148752uao.2.1540543873475;
 Fri, 26 Oct 2018 01:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538638640.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1538638640.git.amit.kucheria@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 26 Oct 2018 14:21:02 +0530
Message-ID: <CAHLCerMaJKaXD0pTdtMCK6C__WW-pXQ0AfY9L26dDT56szvz6A@mail.gmail.com>
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

Hi Rui,

On Thu, Oct 4, 2018 at 1:22 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> Move the various drivers for Intel platforms into their own subdir. Also
> consolidate Qualcomm drivers into the qcom subdir.
>
> This cleans up the directory making it easier to find things.

Any comments on these changes?

> There is no great time to send patches that move files around, but I'm told
> that towards the end of the merge window is nicer. So here's an attempt to
> sneak it into 4.20 after everything else and hoping that these files won't
> change after 4.19-rc6. :-)
>
> This was generated and compile-tested against 4.19-rc6. If you would like
> me to try again a bit later, I'm happy to do so.
>
> Changes since v1:
> - Removed a stray character that snuck into the Makefile
> - Added Acks
> - Rebased to v4.19-rc6
>
> Amit Kucheria (2):
>   drivers: thermal: Move various drivers for intel platforms into a
>     subdir
>   drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom subdir
>
>  drivers/thermal/Kconfig                       | 94 +------------------
>  drivers/thermal/Makefile                      | 10 +-
>  drivers/thermal/intel/Kconfig                 | 77 +++++++++++++++
>  drivers/thermal/intel/Makefile                | 12 +++
>  .../{ => intel}/int340x_thermal/Kconfig       |  0
>  .../{ => intel}/int340x_thermal/Makefile      |  0
>  .../int340x_thermal/acpi_thermal_rel.c        |  0
>  .../int340x_thermal/acpi_thermal_rel.h        |  0
>  .../int340x_thermal/int3400_thermal.c         |  0
>  .../int340x_thermal/int3402_thermal.c         |  0
>  .../int340x_thermal/int3403_thermal.c         |  0
>  .../int340x_thermal/int3406_thermal.c         |  0
>  .../int340x_thermal/int340x_thermal_zone.c    |  0
>  .../int340x_thermal/int340x_thermal_zone.h    |  0
>  .../processor_thermal_device.c                |  0
>  .../{ => intel}/intel_bxt_pmic_thermal.c      |  0
>  .../thermal/{ => intel}/intel_pch_thermal.c   |  0
>  .../thermal/{ => intel}/intel_powerclamp.c    |  0
>  .../{ => intel}/intel_quark_dts_thermal.c     |  0
>  .../thermal/{ => intel}/intel_soc_dts_iosf.c  |  0
>  .../thermal/{ => intel}/intel_soc_dts_iosf.h  |  0
>  .../{ => intel}/intel_soc_dts_thermal.c       |  0
>  .../{ => intel}/x86_pkg_temp_thermal.c        |  0
>  drivers/thermal/qcom/Kconfig                  | 11 +++
>  drivers/thermal/qcom/Makefile                 |  1 +
>  .../thermal/{ => qcom}/qcom-spmi-temp-alarm.c |  0
>  26 files changed, 107 insertions(+), 98 deletions(-)
>  create mode 100644 drivers/thermal/intel/Kconfig
>  create mode 100644 drivers/thermal/intel/Makefile
>  rename drivers/thermal/{ => intel}/int340x_thermal/Kconfig (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/Makefile (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/acpi_thermal_rel.c (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/acpi_thermal_rel.h (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3400_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3402_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3403_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3406_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int340x_thermal_zone.c (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int340x_thermal_zone.h (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/processor_thermal_device.c (100%)
>  rename drivers/thermal/{ => intel}/intel_bxt_pmic_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/intel_pch_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/intel_powerclamp.c (100%)
>  rename drivers/thermal/{ => intel}/intel_quark_dts_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.c (100%)
>  rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.h (100%)
>  rename drivers/thermal/{ => intel}/intel_soc_dts_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/x86_pkg_temp_thermal.c (100%)
>  rename drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c (100%)
>
> --
> 2.17.1
>
