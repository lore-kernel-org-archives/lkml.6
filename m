Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290F3C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0C520C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MX9S+bVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0C520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbeJAVcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:32:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39739 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbeJAVcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:32:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so14314447wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1qcOH2X3RPQ7wNpXQ9IjhlHCvlNcfdOe+AxPA/yfeZY=;
        b=MX9S+bVJwekHGPnntM30HtIt6yH/4DtEhjHZn1SvAevnykghi/p55h0OhJB4sO1qDO
         uFFgTi+dDA5V4Zr3ZKOA/jHRrDl0XAct6q0DgoY/KfLm4h4mg0Hjqy5f8zS55gPw/4Ph
         LENHZOwicCQXe5Yi8pAVHYorMTo28WVa0vZuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1qcOH2X3RPQ7wNpXQ9IjhlHCvlNcfdOe+AxPA/yfeZY=;
        b=JII1sUz8Hi/c4zt6wci+ZUiwXEn1+P2AAqhVN87arw8YPwvf15/rRPHogW2jgyA9cx
         Jz/zApww38sY+HgB3Bl7X+48NTOhCAgUYrINII8Kfq8Sisa8Y/K+HKw8KhW/r3HxOg/A
         MWUPfJvrjykva+kv4/5sWj2peRDoTTLgVmJtQEnhafbfs9w6nsE4JMHD3qHoBTxzLT5d
         8TGNN4R83oDzdHKhdJvSMPzXTe+gkFTQ5Oravrh/T0R8y5kLj47itNsIN8pdiDQqzmHz
         MmHJRWQBr/fjSOHWFambDei2OU+B4M/fdor5IdH6yov3u55mvcz3KDlfZMLznuzRgpIl
         WOgQ==
X-Gm-Message-State: ABuFfohFez91+dXDEPxAzHPO8b6JWTMSOjP2u9h980mztyKOq0VO/o5x
        yZtFxaIUHHIekaiApWoJwJOhvg==
X-Google-Smtp-Source: ACcGV63ldD0B41e3LY2JkM0cjnjfiBzIjCgz2kbNZWh5RlMInh8rOTv5uQFHXAcRyOqRJgU+vXYWnw==
X-Received: by 2002:adf:8523:: with SMTP id 32-v6mr7791716wrh.72.1538405668461;
        Mon, 01 Oct 2018 07:54:28 -0700 (PDT)
Received: from [192.168.0.41] (3.230.136.77.rev.sfr.net. [77.136.230.3])
        by smtp.googlemail.com with ESMTPSA id x186-v6sm21104978wmx.24.2018.10.01.07.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 07:54:27 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] driver: thermal: Move some drivers into subdirs
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        mka@chromium.org, rui.zhang@intel.com, linux-pm@vger.kernel.org
References: <cover.1538141538.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <71d28a39-dcd2-2217-57b3-b2c3e6b77ec2@linaro.org>
Date:   Mon, 1 Oct 2018 16:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cover.1538141538.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2018 18:36, Amit Kucheria wrote:
> Move the various drivers for Intel platforms into their own subdir. Also
> consolidate Qualcomm drivers into the qcom subdir.
> 
> This cleans up the directory making it easier to find things.
> 
> There is no great time to send patches that move files around, but I'm told
> that towards the end is nicer. So here's an attempt to sneak it into 4.20
> after everything else and hoping that these files won't change after
> 4.19-rc4. :-) 
> 
> This was compile-tested and generated against 4.19-rc4. If you would like
> me to try another time, I'm happy to do so.

I think it is a good idea organize the drivers per vendor directories.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


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


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

