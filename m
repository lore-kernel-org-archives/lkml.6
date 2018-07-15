Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCD0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10AF2124D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEo+LsqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10AF2124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeGOOrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 10:47:05 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43030 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeGOOrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 10:47:05 -0400
Received: by mail-pf0-f193.google.com with SMTP id j26-v6so541720pfi.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ytZxXmHywrNx9Td9mVJdAjmYvn/Mn9cnSmWh34DCKjY=;
        b=dEo+LsqZl87bbTR7cQvJAVnUT0ZDMDMznYAdiQQz0Jfbxvb7yhrcszUfjbovEYpQKf
         x7E0l7nBf/AdM+lWjxMQMT9aqsPL6Xh6VKTn7QCCgZ7pVl4WGQUzLeMU49yBmEjoAJrK
         bTdx463S3JLpd46L2o04vPxijEiLqkmVh6MGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ytZxXmHywrNx9Td9mVJdAjmYvn/Mn9cnSmWh34DCKjY=;
        b=Lxwm25qH60GO2xLdYV9P3b740n8ogdCzEKuEnJrUsfXlppZLIwAqKsh6hJfygflN1S
         4OcAJES3Ima/B9wE//sM3DaZY0K8CiE5fo0eq30TaSDUZcN4sFGRkb9tNx94bOQzE55w
         yqneMAHkTD5v16E+6enjRVITAY/JWeAFZS5AG8ky3GTRNyMgB5tjOKbnCCXEqJfuSvUn
         LSMTvZ9xNeArHF4p5udzImwd3GEEhZAC5gf4NcWMSn/o4kjXkwpGGuiIMacWSUchQWYp
         FWyRuuBXP7U6UfoEm2fQd+TzlDTkwIqfvdgw7zM2JZEXagQtLhCktUUxK4RhxfFmRbwd
         MPtg==
X-Gm-Message-State: AOUpUlFkflJmL3Bz4G9pxs4c0TUhBT/4RwwVFn41M6AXf5EjufmUfm8P
        1KTDrmGdvfHWeYjDsbj3pk8u3kpjBg==
X-Google-Smtp-Source: AAOMgpetpRbpEsLcx+x3iLX8Harm/OLvVc8mqdjMnk3l/ZIcMSfzBR0G/9Plgqd/izY0yT+KCb32cQ==
X-Received: by 2002:a63:ee4e:: with SMTP id n14-v6mr1564455pgk.159.1531664637566;
        Sun, 15 Jul 2018 07:23:57 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:71c5:dcf2:1082:c344:2c7e:f99b])
        by smtp.gmail.com with ESMTPSA id p11-v6sm62865212pfj.72.2018.07.15.07.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 07:23:56 -0700 (PDT)
Date:   Sun, 15 Jul 2018 19:53:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     afaerber@suse.de, sboyd@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux@cubietech.com,
        support@cubietech.com, catalin.marinas@arm.com,
        mturquette@baylibre.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        darren@cubietech.com, robh+dt@kernel.org,
        jeff.chen@actions-semi.com, pn@denx.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mp-cs@actions-semi.com
Subject: Re: [PATCH v4 0/5] Add clock driver for Actions S700 SoC
Message-ID: <20180715142345.GB9980@Mani-XPS-13-9360>
References: <20180715123145.16975-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715123145.16975-1-sravanhome@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravanan,

On Sun, Jul 15, 2018 at 02:31:40PM +0200, Saravanan Sekar wrote:
> Changelog v4:
> - dt-bindings use absolute numbering for clocks
> - Patch re-oredering
> 
> Changelog v3:
> - Splitted uart clock DTS changes into separate patch
> - Splitted REGMAP Kconfig selection into separate patch
> - General naming convention as "Actions Semi" in dt-binding documentation
> - Patch re-oredering
> - Cleanup and fixed review findings
> 
> Changelog v2:
> Fixed 0 day compilation warning
> Modified existing dts Actions S900 clock bindings common to Actions
> Soc family
> 

Usually Changelog comes at the end of cover letter.

> This patchset adds clock support for Actions Semi OWL series S700 SoC
> with relevant clock bindings and device tree info. 
> 

Nit: Since we agreed to use the family name as Owl everywhere, the above
instance should be changed accordingly.

> Changed the UART clock using CMU instance and changes are tested in
> cubieboard7
> 
> Thanks and regards,
> Saravanan,
> Parthiban
> 
> *** BLURB HERE ***

Please remove the above line.

Thanks,
Mani

> 
> Saravanan Sekar (5):
>   clk: actions: Add REGMAP as dependency
>   dt-bindings: clock: Add S700 support for Actions Semi Soc's
>   clk: actions: Add S700 SoC clock support
>   arm64: dts: actions: Enable clock controller for S700
>   arm64: dts: actions: Set UART clock reference from CMU
> 
>  ...tions,s900-cmu.txt => actions,owl-cmu.txt} |  20 +-
>  .../boot/dts/actions/s700-cubieboard7.dts     |   8 +-
>  arch/arm64/boot/dts/actions/s700.dtsi         |  14 +
>  drivers/clk/actions/Kconfig                   |  14 +
>  drivers/clk/actions/Makefile                  |   1 +
>  drivers/clk/actions/owl-s700.c                | 610 ++++++++++++++++++
>  include/dt-bindings/clock/actions,s700-cmu.h  | 118 ++++
>  7 files changed, 769 insertions(+), 16 deletions(-)
>  rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,owl-cmu.txt} (67%)
>  create mode 100644 drivers/clk/actions/owl-s700.c
>  create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h
> 
> -- 
> 2.18.0
> 
