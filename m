Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2382C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931A521904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GPVCVZAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfBGPLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:11:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52972 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBGPLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:11:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so219210wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 07:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1Uwwg9nLiHV0sNyKWuMQpb+u5rQNp1/DEHna6HgOtUk=;
        b=GPVCVZAg+/LBCFmAt8FdqOl+kCQ7bzQRHivENkHLLDsXGkoXC4EQ14tXsuHiUqLykR
         a4hZ78G7aYUrskEfXf15t+Ex0JFQurVWskpEfIawYwZhZKzCj10cuWdfP9kCcoj/jIc4
         5N+SzUHnvujLph6chwQjom2J+G6jX9LZvy8aVMtq8gW8vOu9NwW1JW7+hI6hDfTmyNtt
         cgDdWcOl6p6Bx0ImZl0IiiFrGGQ/iF0HjIYEhqczWhJ2qB9WSajNlyLbdVB/WqHmoclr
         OGQmnluAvyYbyn3iXl780ufioptvQ8xSAukXxXcgSuz0/bCu+vPTUiGh9j4DcSGr32bl
         YHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1Uwwg9nLiHV0sNyKWuMQpb+u5rQNp1/DEHna6HgOtUk=;
        b=beQ+ad6+o+esvh1+NS+KpAesLI0+YOSBVgu1lEEDAmltagkFTD3MZg5C0b+ro9rc5K
         2+2w5EO0SVbVBZhGRsvyjgJA4LIwjqXjKWxMrSdxiAfhwk7BbWkpJ6yWJOwsq1s19HQ1
         KdxPRxh1FUbCuOwN9icET9vPztcEqsp/mxRl1zP5O0EnJVLuvxU8CIsEq/xbLpCLejGB
         3tNnzjPubIkGpZmCkgNzLJSJlXAoxbh0QxFSqRdJW2QTuBGkcrupe7XHS0QfmX41bEtA
         ZDRYN713c6JfA30aQSckVGMX2vpVyXuvHP3j88dCYuy/mIhprdvhNdql2wuaAb8+7lN1
         0ldA==
X-Gm-Message-State: AHQUAuYK2s15HrnhWVg9al/pKNa6MX6QxkpQNFg6uUWh4ulYZJiqvdKE
        ENoZqtvi6YYsnpPh2eHvXi3MPA==
X-Google-Smtp-Source: AHgI3IZrWNwrZmdcBEdPshlxOJzdBIXDneiPR4oAfp+6+6a8rdHXFSZimNdpaGcmEe/TgVWu5yhRmw==
X-Received: by 2002:a1c:ef11:: with SMTP id n17mr7733770wmh.112.1549552296549;
        Thu, 07 Feb 2019 07:11:36 -0800 (PST)
Received: from boomer.baylibre.com ([2a04:cec0:1103:b081:462c:a008:349b:2f3a])
        by smtp.gmail.com with ESMTPSA id z11sm37119374wmb.45.2019.02.07.07.11.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Feb 2019 07:11:35 -0800 (PST)
Message-ID: <8852692ccf2903e93459e3347a0a072d37e5a84c.camel@baylibre.com>
Subject: Re: [PATCH 0/2] clk: meson: Add G12A AO Clock + Reset Controller
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Feb 2019 16:11:33 +0100
In-Reply-To: <20190204091331.9298-1-narmstrong@baylibre.com>
References: <20190204091331.9298-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-04 at 10:13 +0100, Neil Armstrong wrote:
> This patchset add support for the Amlogic G12A SoC family Always-On
> clock and reset controller.
> 
> This adds support for clocks on the Always-On domain like :
> - Always-On UARTS & I2C Controllers
> - CEC Controllers
> - SARADC source and bus clock
> - Infrared Decoder/Encoder bus clock
> - USB 32K reference clock
> 
> This also adds resets lines for :
> - Always-On UARTS & I2C Controllers
> - SARADC, Infrared Decoder/Encoder
> 
> This patchset depends on the ("clk: meson: rework drivers dependencies")
> from Jerome Brunet at [1].
> 
> [1] https://lkml.kernel.org/r/20190201125841.26785-1-jbrunet@baylibre.com
> 
> Neil Armstrong (2):
>   dt-bindings: clk: add G12A AO Clock and Reset Bindings
>   clk: meson: Add G12A AO Clock + Reset Controller
> 
>  .../bindings/clock/amlogic,gxbb-aoclkc.txt    |   1 +
>  drivers/clk/meson/Kconfig                     |   2 +
>  drivers/clk/meson/Makefile                    |   2 +-
>  drivers/clk/meson/g12a-aoclk.c                | 448 ++++++++++++++++++
>  drivers/clk/meson/g12a-aoclk.h                |  15 +
>  include/dt-bindings/clock/g12a-aoclkc.h       |  43 ++
>  include/dt-bindings/reset/g12a-aoclkc.h       |  18 +
>  7 files changed, 528 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/meson/g12a-aoclk.c
>  create mode 100644 drivers/clk/meson/g12a-aoclk.h
>  create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
>  create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h

Nothing out the ordinary, just a minor comment on the bindings.

Acked-by: Jerome Brunet <jbrunet@baylibre.com>


