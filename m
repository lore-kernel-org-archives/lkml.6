Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE937C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A05C2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joUjveaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfBGKgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:36:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40169 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfBGKge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:36:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so6105603wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 02:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sl9gmLvLUkVQTCmOsYeIup4YOxFEMp8Ofw/UybW+dyE=;
        b=joUjveaCTz44ND5vV0DxvCALsDMUsKZ73sx/gtAjS6rWyilQ/L21ibedK6aULN1Ea+
         EeHNOJD33UEzS2roXYDZOMcelmhoOOED4G54U/o1cvAxwN4HIt2dqGdB4kideRi+egT5
         17KoGlWOaK4xwW4Md0uywiBSAmyI70KWq7Apiofe1bgJDUvdX0AaDAUAhw4X+CCZY/zd
         bxSQvO6YFpwfXUywcUEL0KtjCiuDgafxbunJqqqoq+pPX4JuraLRIGNwNO/zvD0IsTtB
         M1erd6o0NzrsaE4Ka5qGyRCnPjDXEQvBYzfA0ZDCLJJNPuRzrDv04ywHCKFBtTd1kSSF
         Hwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sl9gmLvLUkVQTCmOsYeIup4YOxFEMp8Ofw/UybW+dyE=;
        b=p3h7chNfo8fkXli6Tnd7BcQMT4wZWk6AEQdaeVBPhbCQ1UJsPfUyJlpQMvbDCHZe7b
         PSOKCRQ2kuuNNgZ94PfLPBokTTuc6bclhR5eJW0Z/dJ7pLADAonjb2p0mzPOLXFC8LX6
         KbJ7b86GH0ku/03t79/8/RweUo2f2A6+FUf3TqMMV0OfNkpPW0HXPEupUBODwDhVYN6c
         RLYpjWbV+dUIW8FsUtJp+N95o60FBtEtrdD2ZFhIebjsR9am0pz5pczL8+Ncj5+DMTLr
         RgOqaK2hqQfy+KWr9Ef9QG7OReqXEm7H2r59uAD2JaUbYxt0WWM0Fa4uiGvXkomuQaV/
         F5VQ==
X-Gm-Message-State: AHQUAuaBquMaamiZj95ixlI7QWvCoSuZa/7HozxpYC2QUXt1XCvSiVzr
        CPkGg+KUO+N+e4HCSN3dk/R2dLlUkSea2A==
X-Google-Smtp-Source: AHgI3IZcD9540nQT5mjtsXU6+nimBPRBDEHKO6VzeFrIcbOLHKy/uURT93pCl9lZx1ERF2NAF7n1cA==
X-Received: by 2002:a1c:5656:: with SMTP id k83mr6924930wmb.125.1549535791923;
        Thu, 07 Feb 2019 02:36:31 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id z26sm1064110wml.44.2019.02.07.02.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 02:36:31 -0800 (PST)
Date:   Thu, 7 Feb 2019 10:36:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        gwendal@chromium.org, kernel@collabora.com, bleung@chromium.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] mfd: cros_ec_dev: Return number of bytes read with
 CROS_EC_DEV_IOCRDMEM
Message-ID: <20190207103629.GD20638@dell>
References: <20190206173959.23925-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190206173959.23925-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Feb 2019, Enric Balletbo i Serra wrote:

> From: Guenter Roeck <linux@roeck-us.net>
> 
> While ioctls normally return a negative error or 0 on success, this is not
> the case for CROS_EC_DEV_IOCXCMD in the cros_ec driver, which returns the
> number of bytes read instead. However, CROS_EC_DEV_IOCRDMEM in the same
> driver does not return the number of byte read on success. This is both
> inconsistent and problematic, since the amount of returned data can be
> dynamic. Have it return the number of data bytes for consistency.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Hi,
> 
> This patch was send long time ago and never landed to mainline [1]. This
> is a second attempt. Originally was made to apply on platform/chrome but
> after the recent changes we did it should go now throught the MFD
> subsystem. Without this patch userspace tools like ectool doesn't work
> as expected.
> 
> Best regards,
>  Enric
> 
> [1] https://lore.kernel.org/patchwork/patch/665211/
> 
> Changes in v2:
> - Adapt and rebase to current mainline.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
