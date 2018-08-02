Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0F9C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E268821473
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DLS8VB9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E268821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeHBKZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:25:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52714 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeHBKZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:25:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so1506360wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iurhmWpHLki665DmppB6rufNwf3IqT+4+IAdfLtEEGE=;
        b=DLS8VB9+V3Wp//ya510JIy4nwHr81mPOsVjTqKkEnhUQYIMnkDHQF4txAspgQ1dw//
         E5aNDRgUr7BY+nBbAYmSh20Z4a85TCVqG1gkpS3nFBuAtEAU2ECoHyyZESXext93s54J
         fgynEdGvizinupuzj2N1ApfBNuVgRIbVCgDP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iurhmWpHLki665DmppB6rufNwf3IqT+4+IAdfLtEEGE=;
        b=ly6P8FxeEc1AnZ0wp3J8ZvLLUe5n78dpLRrKXlSGNhKxVqTzT8V7fS4ThbKLc5M7F6
         r5X/emWeOAM2Au8qemw4qjfUN7u3n/iD4DvI5rx/y26mQNHrSjf5Q7F9k+yZvSljvEkC
         G+TbYRxtt2Xyyxhg95Ch2ZqDcQHFlJnF44AJAzcS7+wVHxayYZkP3jqlt6gL3YieUNBV
         +98ibX/i1H1WcYYce/xveBk/UVuZ6VstzzgpxXde/luqEPNEEXKkMv/O6ZNagqwppkhr
         +yxbVhwsReX6LV6GPNYUvj/I+Zu67Pwk0O2p/Tc6xajkG3JT/SPwfZUbdSvG436P2pa4
         1Bqw==
X-Gm-Message-State: AOUpUlFlJPWx/yw9y4cT7aBl1oLHo6SasgNUzejyw/hD89AX99y8zADM
        ACuv6zL/6PkBxGoqu+zpxyYrHA==
X-Google-Smtp-Source: AAOMgpdhB7NyCOM1+stxOM9cmNePDdOwCz7cwnN2ZrtWr+ZOpvDhF3uvrwuSFHHPdfOXBbsPSKY3Xw==
X-Received: by 2002:a1c:6d94:: with SMTP id b20-v6mr1346109wmi.28.1533198908673;
        Thu, 02 Aug 2018 01:35:08 -0700 (PDT)
Received: from dell ([95.149.160.4])
        by smtp.gmail.com with ESMTPSA id q16-v6sm1214559wmq.25.2018.08.02.01.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 01:35:08 -0700 (PDT)
Date:   Thu, 2 Aug 2018 09:35:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, eballetbo@gmail.com,
        linus.walleij@linaro.org, mazziesaccount@gmail.com,
        dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, broonie@kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v11 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180802083506.GO4662@dell>
References: <cover.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
 <77184f651e5cefb112f1061bc682b759f88144c6.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77184f651e5cefb112f1061bc682b759f88144c6.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018, Matti Vaittinen wrote:

> ROHM BD71837 PMIC MFD driver providing interrupts and support
> for three subsystems:
> - clk
> - Regulators
> - input/power-key
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/mfd/Kconfig              |  13 ++
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/rohm-bd718x7.c       | 208 ++++++++++++++++++++++++
>  include/linux/mfd/rohm-bd718x7.h | 332 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 554 insertions(+)
>  create mode 100644 drivers/mfd/rohm-bd718x7.c
>  create mode 100644 include/linux/mfd/rohm-bd718x7.h

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
