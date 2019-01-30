Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAC7C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEC82084A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fwwwynzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfA3NJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:09:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52538 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfA3NJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:09:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so21566011wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Fj2vKToOJdUki9ETE0myuXN939Uj0I9/W45Kn73SWBY=;
        b=FwwwynzimGkfg+EjeCFbX5UuIuomOjdc/wd16vwAOKJXw8KXYtJbrvt0gqUqkiKRuK
         VLfTIxrYzZLshBVBYX+NZb/wUXrbsUXt971C72NZn/uhmm0nghCo8xnO2EpFj5TB5Sm7
         0GXLg95K/2hjGvpW4Utfxq4uNWW4NvIqRJo3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Fj2vKToOJdUki9ETE0myuXN939Uj0I9/W45Kn73SWBY=;
        b=nexlyu1z82jL/YJC/Jwf6eWclxiu7wwVU/TFE1OKZpagevDYw11+Ymqczm7EVuN5A3
         Ab3r2sEvy1tly9CkePqjd8kTvZHqU85ZEo7oz3osQpfL26Mggc1Ls9lfVekSmX58u4QF
         x7nVDYAAqqZKhLJcnu1D5gMQLHiQKGUMisXTmzb2RJkBoewvIYcc3ACbjvIgwmM40Vc/
         IG344K9f0UugtxghL09VTSmTuiLbVpy1TGiDT64xoL1iFbRWRcvcHSoEicoMzK6HF+Kv
         WCTYOtwli6dkmelCir/XE5ZOOINMN6a46EXVy2kd9LPTk53Rml4yAX5HSoT2rF4ePRjF
         mdug==
X-Gm-Message-State: AJcUuke4XWzX41qld+VfuxIL4ITGd/zvhu9+rQOZNBTzf/n6+8hOYfBr
        lywxl6EoSlwg9zOZghsJbCpqWw==
X-Google-Smtp-Source: ALg8bN4ZFJsNstz6EH3g6TwG5I78RvrdHBezQRViABdsz2SGSMLTvVghClFqkd6uuehTzXm5vQJqcQ==
X-Received: by 2002:a1c:b70b:: with SMTP id h11mr26402713wmf.72.1548853769758;
        Wed, 30 Jan 2019 05:09:29 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id h2sm1329943wrv.87.2019.01.30.05.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:09:29 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:09:27 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        linux-i2c@vger.kernel.org, Stable <stable@vger.kernel.org>
Subject: Re: [PATCH] mfd: Fix I2C_DESIGNWARE_PLATFORM dependencies
Message-ID: <20190130130927.GD4701@dell>
References: <20190121141128.5283-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190121141128.5283-1-jarkko.nikula@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, Jarkko Nikula wrote:

> INTEL_SOC_PMIC, INTEL_SOC_PMIC_CHTWC and MFD_TPS68470 select the
> I2C_DESIGNWARE_PLATFORM without its dependencies making it possible to see
> warning and build error like below:
> 
> WARNING: unmet direct dependencies detected for I2C_DESIGNWARE_PLATFORM
>   Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ACPI [=y] && COMMON_CLK [=n] || !ACPI [=y])
>   Selected by [y]:
>   - MFD_TPS68470 [=y] && HAS_IOMEM [=y] && ACPI [=y] && I2C [=y]=y
> 
> /usr/bin/ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_resume':
> i2c-designware-platdrv.c:(.text+0x62): undefined reference to `i2c_dw_prepare_clk'
> /usr/bin/ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_suspend':
> i2c-designware-platdrv.c:(.text+0x9a): undefined reference to `i2c_dw_prepare_clk'
> /usr/bin/ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_probe':
> i2c-designware-platdrv.c:(.text+0x41c): undefined reference to `i2c_dw_prepare_clk'
> /usr/bin/ld: i2c-designware-platdrv.c:(.text+0x438): undefined reference to `i2c_dw_read_comp_param'
> /usr/bin/ld: i2c-designware-platdrv.c:(.text+0x545): undefined reference to `i2c_dw_probe'
> /usr/bin/ld: i2c-designware-platdrv.c:(.text+0x727): undefined reference to `i2c_dw_probe_slave'
> 
> Fix this by making above options to depend on I2C_DESIGNWARE_PLATFORM
> being built-in. I2C_DESIGNWARE_PLATFORM is a visible symbol with
> dependencies so in general the select should be avoided.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: acebcff9eda8 ("mfd: intel_soc_pmic: Select designware i2c-bus driver")
> Fixes: de85d79f4aab ("mfd: Add Cherry Trail Whiskey Cove PMIC driver")
> Fixes: 9bbf6a15ce19 ("mfd: Add support for TPS68470 device")
> Cc: Stable <stable@vger.kernel.org> # v4.14+
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/mfd/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
