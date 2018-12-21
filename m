Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163FDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E41218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0pMG+9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbeLUJIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:08:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43915 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbeLUJIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:08:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so4399674wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Waopk4QjO8yPcHQ79td8v7UwiG4yplhDOPMFZ0uxAYg=;
        b=Z0pMG+9xdjfsJcCTWhL6zmrzyUhUj7Ioj6JT0NMhu/9nvJXd7UK+P4msR5V5AbeMAX
         fXwga9Wszxqo9eGi6RhsU6WtHUK+VAAtWwEGBcpTxBXam5uxF70KIcq1OGOynGnC5UVY
         /SbV68JzPgmK0/OidxyKFq97JZ3VLnIinpZNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Waopk4QjO8yPcHQ79td8v7UwiG4yplhDOPMFZ0uxAYg=;
        b=B7wiCSKorIq+XqAQDIAMCfGzVZvDyQxfWf+lsxQMVEiZrm7k9SVLkEKS6iBKP/Dl7l
         ZGcFY/IwvBqIim2RI0GWL8VrlNPoOGBy4ueURY30DwSDClKX68ha1F2wxF46amqg4YtU
         GBhftV89tZhsP1lRdVXwmNXaRkOlkS8QOuIyNfHxtXzqv4ReIq4g21UOJY8kt+O/NjGi
         sOQ7052JqdzTKdjNzbzkGx6lK3mhmozZm+7y3xxsz3YYUdKInmiOaunmH+33MBdg8eaY
         ShAVRtG4APyLMf+QaPrugjQ9eClPjt4vWo5121aXk1zdIu+Xrq073jYHTELmak5x9EkR
         SzFQ==
X-Gm-Message-State: AJcUukfAIwxX2FrOybqv8FBSA1jdPhZn/fJPD4UV+eeUr2yTLrDGjoyg
        7ud1ZtwwDyXG30KXVzHYc+eQPQ==
X-Google-Smtp-Source: ALg8bN7nshBI/RCdw8qTi6nuFnBjuWnIqxLXBaNKrwjfBNiLS2l+rXVQYgKaxZqes/XxQtsVCS4OfA==
X-Received: by 2002:adf:82f1:: with SMTP id 104mr1709683wrc.131.1545383289419;
        Fri, 21 Dec 2018 01:08:09 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id g129sm10449342wmf.39.2018.12.21.01.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 01:08:08 -0800 (PST)
Date:   Fri, 21 Dec 2018 09:08:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org
Subject: Re: [PATCH v5 1/7] mfd / platform: cros_ec: use devm_mfd_add_devices
Message-ID: <20181221090807.GS4497@dell>
References: <20181212173402.27086-1-enric.balletbo@collabora.com>
 <20181212173402.27086-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181212173402.27086-2-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018, Enric Balletbo i Serra wrote:

> Use devm_mfd_add_devices() for adding cros-ec core MFD child devices. This
> reduces the need of remove callback from platform/chrome for removing the
> MFD child devices.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> ---
> 
> Changes in v5: None
> Changes in v4:
> - Added Reviewed-by tags.
> - Moved mfd_remove_devices to another patch, it's already queued in Lee's tree.
> - Removed patch 8 from the series, was a fix and it's already applied in current mainline.
> 
> Changes in v3:
> - Removed cros_ec_remove from include file.
> 
> Changes in v2:
> - Use devm only for the cros-ec core.
> 
>  drivers/mfd/cros_ec.c                 | 14 +++-----------
>  drivers/platform/chrome/cros_ec_i2c.c | 10 ----------
>  drivers/platform/chrome/cros_ec_lpc.c |  4 ----
>  drivers/platform/chrome/cros_ec_spi.c | 11 -----------
>  include/linux/mfd/cros_ec.h           | 10 ----------
>  5 files changed, 3 insertions(+), 46 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
