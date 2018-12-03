Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FEEC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC45720848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6QP5nhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC45720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbeLCKz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:55:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50276 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCKz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:55:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so2800634wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mhsftx8stEzs6m/AQpPm3CnEVLNEWXhw9y3jS9cM77o=;
        b=Z6QP5nhFrwO7iATCVUTPlL2/iIMQj/miKirJkkI8l3gHC8R3pHHGnHGK+QWgITCfGF
         8dl/2MGejmNYCWinuaEWfV88rMH4GFQTqK+Lql1EpAEI98rclOb4xPGi7ajsfHpiRnGv
         SkhrudttFvST7YcIh2rf+dZ14BKABf7spZCWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mhsftx8stEzs6m/AQpPm3CnEVLNEWXhw9y3jS9cM77o=;
        b=MiyXPSKQ2cCdL461vjQfzzzvsOg+HO7VefZodzbZOn+VU7bWAhw87pIUFhMENnLrUb
         r9rtjSsyGSqZTfAt7xVH1JgSeO2DqhUsjRizMRzRlKJ6WpOSQhvXpNo1Y3sJNZlZQH7h
         GkHgFy9ouQB0NjgbLjmhtfOacINawqaTADhVsHgk6Vh/LQ80g3pTGanYR2n6YY6RaeeJ
         kxRCH9RczCQZpOFLtGShoo6UkHRB0JgyUv+ktIGv1lHGXntG9T2qLSt+7XKUPz1CT7hr
         LzdKuWBbkzJWeM2TuHj7MIF8wkfd+0aVQQOc10JHIWJ1W16mAESvxnAm7P+F3/G+AjFb
         grPQ==
X-Gm-Message-State: AA+aEWbhY2KREje7xwsMHm1A+XXo9myTH+k//wihOg0IKeR+ibRBK5tB
        xLT/zHwa1FOUfdn9PIASmtAOEQ==
X-Google-Smtp-Source: AFSGD/U0rg0Pk8gI56Gh90S1YIfNy+/8j4M4zC9gWkXdFPYVIRC21f6nRSskKXaoIJHjK19O87+1ag==
X-Received: by 2002:a7b:c142:: with SMTP id z2mr8317207wmi.102.1543834525818;
        Mon, 03 Dec 2018 02:55:25 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id j8sm9035079wmd.0.2018.12.03.02.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 02:55:24 -0800 (PST)
Date:   Mon, 3 Dec 2018 10:55:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 4/8] mfd / platform: cros_ec: move debugfs attributes
 to its own driver.
Message-ID: <20181203105523.GF26661@dell>
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-5-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181127121849.23975-5-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Enric Balletbo i Serra wrote:

> The entire way how cros debugfs attibutes are created is broken.
> cros_ec_debugfs should be its own driver and its attributes should be
> associated with a debugfs driver not the mfd driver.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3: None
> Changes in v2:
> - Add a "default MFD_CROS_EC_CHARDEV" in Kconfig for this.
> - Remove the checks for missing debug_info, are not needed now.
> - Remove a comment that no longer applies.
> 
>  drivers/platform/chrome/Kconfig           | 11 ++++
>  drivers/platform/chrome/Makefile          |  4 +-
>  drivers/platform/chrome/cros_ec_debugfs.c | 62 +++++++++++++++--------

>  drivers/mfd/cros_ec_dev.c                 | 41 +--------------
>  include/linux/mfd/cros_ec.h               |  6 ---

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
