Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07B3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2BF218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACeDVPG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbeLUJJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:09:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37519 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeLUJJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:09:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so4905846wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lg6ichzFk8wIExz6Pe5kNBRiJn7EfeWsfNM6dOqrNMw=;
        b=ACeDVPG0UKxarsO69o8oD8PMhHwCrUPmV0Zu8b9NFF50oSO0RAF/rXgtl0rj6z3lbH
         rv0hq0b6HIeXRJnvK3A1ptfNyygew/UzQJNnvFExpUeliDLRKClR2TkKlC5mQW2uwgYi
         FInZy3a7UFaqXukLpImlbdEhy2RnWyKBcPO9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lg6ichzFk8wIExz6Pe5kNBRiJn7EfeWsfNM6dOqrNMw=;
        b=Vmxm9bmniNsPWtgzKTpDvd3bRRfRcjL3dO66N4CKbkkdkCJtmWBJ0TBjnB/L0Aj+Ve
         qn3plmSGaNPKG16BHjKLUv7hBUYL8wWNKfp+G2BnF72FTmtgGd73MPFLBUmTOeyvT1d/
         5ChsKAbUKfqlcjX5QCum5hE08gxdTgSfBUuGFI/zTxooj12djP7B2R4UsKNuiMsZ1sTU
         HTCCiOURYl6Qbqbhd0LsxyRpDflhOjQRKvDhZn08MlvcuYX2lUUUvoDrjYNLeIHMQt0O
         41037oq08FQZUVTMv3gtp6D8WZ7/NsLNeQ/4ROh2bFnk24PhAM08HuwYFwLnoZXXyMdz
         ifSA==
X-Gm-Message-State: AA+aEWaLBRF+ddrsb7tQ0yoE4bDntNPn9lUfoxtCXuixEE2COVws/EWS
        vA818iMe2ASq1RYXggph4tGS9g==
X-Google-Smtp-Source: AFSGD/UWQ3Y4ELWeIEycQxRDxuMGqT1x/TcP/wA0x5KpkOZXqJeWU02Vj7tHzurFGISBKc1MASQgGw==
X-Received: by 2002:a1c:b607:: with SMTP id g7mr2026934wmf.97.1545383355158;
        Fri, 21 Dec 2018 01:09:15 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id s16sm8749977wrt.77.2018.12.21.01.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 01:09:14 -0800 (PST)
Date:   Fri, 21 Dec 2018 09:09:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org
Subject: Re: [PATCH v5 2/7] mfd / platform: cros_ec: move lightbar attributes
 to its own driver
Message-ID: <20181221090912.GT4497@dell>
References: <20181212173402.27086-1-enric.balletbo@collabora.com>
 <20181212173402.27086-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181212173402.27086-3-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018, Enric Balletbo i Serra wrote:

> The entire way how cros sysfs attibutes are created is broken.
> cros_ec_lightbar should be its own driver and its attributes should be
> associated with a lightbar driver not the mfd driver. In order to retain
> the path, the lightbar attributes are attached to the cros_class.
> 
> The patch also adds the sysfs documentation.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> ---
> 
> Changes in v5: None
> Changes in v4:
> - Use <ec-device-name> instead <cros-ec> in documentation.
> 
> Changes in v3:
> - Removed unneded check for ec_dev.
> 
> Changes in v2:
> - Removed the two exported functions to attach/detach to the cros_class.
> - Use dev_warn instead of dev_err when adding the lightbar.
> 
>  ...sfs-class-chromeos-driver-cros-ec-lightbar | 74 +++++++++++++++
>  drivers/mfd/cros_ec_dev.c                     | 24 ++---
>  drivers/mfd/cros_ec_dev.h                     |  6 --

>  drivers/platform/chrome/Kconfig               | 11 +++
>  drivers/platform/chrome/Makefile              |  3 +-
>  drivers/platform/chrome/cros_ec_lightbar.c    | 95 ++++++++++++++-----
>  include/linux/mfd/cros_ec.h                   |  1 -

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
