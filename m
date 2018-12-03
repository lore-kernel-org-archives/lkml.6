Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0543BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34812145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aC3IXOAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34812145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeLCK4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:56:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39462 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeLCK4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:56:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so11635947wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=l2kACyTLlnky72VuJi3usWmYZJ7HnRjEIHeShkctvj0=;
        b=aC3IXOAaa0Br54QtaSR0lHmm6hcUCSZ5vnAtKCmCHhSRyh3S4VYpheioL0AMt+NNX/
         smGcpIsBKpd2T8uYnm+5f8Uusc9WsSqr8+hJ9752Z5h5a4tQDx9fP8lMt1cG3UR2wBLa
         VUdpinVFE8RpnoHOmuF4c+T5q7T8LS7qdhjBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l2kACyTLlnky72VuJi3usWmYZJ7HnRjEIHeShkctvj0=;
        b=QxcorSe8IsoYMP1aBc6almyqBUWRsYruz04JpF2nFhd3WkNfjsO7rLeMCivYCWH7sa
         rzWIzj/LzfjUpg9Oaq6eeucC783sWxcH5G9ZVogjG32qL+3ZLtAEzHyJN0op61SD16Y5
         aPW8AjppVmk2bWnwNcZ3+sc9Zp7efX9lqpMdlJqsjm/fS3k3zaIg5oPFoeaZWaVmCttR
         KyNBHm1MrVi0TegL4mvc4tqm7RkOUZM2aT0xOLquxcdAYadLYY6osFxZwg1XdO5gT5IO
         Mru0fLLm23zH5/WA4i+kK/e1qDJT4PHyK09QZYwleKidNNBKHXxtSS+VdMNY1CAqj8ms
         ZnMA==
X-Gm-Message-State: AA+aEWZcoOVYFlqVwZJcR66rQYPucC39b2UgX0Up8U2Zz9oBBa/lhoVy
        YFHl2KzepGl6qaAqSAd1QAXo6A==
X-Google-Smtp-Source: AFSGD/Uj/ikT0OYsduOPw46TB4ABITfaufHJ3i93PBdKWYnH7gOwg0XVXxu4HpI29b9m83E/iHhwkw==
X-Received: by 2002:adf:be0f:: with SMTP id n15mr14090433wrh.267.1543834580502;
        Mon, 03 Dec 2018 02:56:20 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id k135sm9244919wmd.42.2018.12.03.02.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 02:56:19 -0800 (PST)
Date:   Mon, 3 Dec 2018 10:56:18 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 5/8] mfd / platform: cros_ec: move device sysfs
 attributes to its own driver.
Message-ID: <20181203105618.GG26661@dell>
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-6-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181127121849.23975-6-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Enric Balletbo i Serra wrote:

> The entire way how cros debugfs attibutes are created is broken.
> cros_ec_sysfs should be its own driver and its attributes should be
> associated with the sysfs driver not the mfd driver.
> 
> The patch also adds the sysfs documentation.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3:
> - Do not print ec_platform name as is with dev_err is enough.
> 
> Changes in v2:
> - Create the attributes directly instead of use the attach/detach callbacks.
> 
>  .../ABI/testing/sysfs-class-chromeos          | 32 +++++++++++++++++
>  drivers/platform/chrome/Kconfig               | 14 ++++++--
>  drivers/platform/chrome/Makefile              |  3 +-
>  drivers/platform/chrome/cros_ec_sysfs.c       | 36 ++++++++++++++++++-

>  drivers/mfd/Kconfig                           |  1 -
>  drivers/mfd/cros_ec_dev.c                     |  7 +---
>  include/linux/mfd/cros_ec.h                   |  3 --

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
