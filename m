Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CB8C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCC520672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="issLcm1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCC520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbeLCHLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:11:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34756 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeLCHLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:11:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so10920052wrw.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 23:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4GbBcrVQ1hMdFpT0/ZG5K3ZR9XdGo+EI9dB/QL8dm40=;
        b=issLcm1+qkl/fSBaNN0DURD3UqUdxAEqDOznoVgxJqXj5V4w0352SBOdZyUzoWjX95
         YwcpV7zpXlhTXPr1IasTetZETKjp9rAUY7TCeCQrsBsjFA4ZbWvS7d9vNIdJPwNYpzCt
         pEYV1RFi2OhuRftoc8ZtxQljAaR05heSrm3Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4GbBcrVQ1hMdFpT0/ZG5K3ZR9XdGo+EI9dB/QL8dm40=;
        b=bhqhmeLXlMPb5N6dpUdiuF7xyf4+ow2pR56EEze18FtENPaxG6Cfr0xoJN3rtrVfYc
         PJizTAaMLazwSNRqDBklvdDguHDRjzfQ4yy990KpGbccyPEnft0kXpwbZqNtgKfi1g00
         f8JvrJ/GjVQRuk/4ENfq+22fDI4B209OQK5hQ4QIsqz5g89OLTJzmVCOUB+S0gwH/ki2
         0ElKz+dQjKVaTkifY5S8rwkX+c/6OtN6vtCasMvMOTTYy4MyssJIhjL4AfVaySqMs1YZ
         DgBLKfVEmobpJlRd8Cs3kV+KLFqfufaBu0Af0xLuci+XiVuxJI549v2o4rqnkL3PE0nS
         sFww==
X-Gm-Message-State: AA+aEWYQ9UYxSal8LJc56oQgFHpUOiUUsTwSS7ARiI9Rsp2gS/O4CvHt
        AaP1El7zlujLcJer15YbpEy7eg==
X-Google-Smtp-Source: AFSGD/U8oLvsb409XdE/CQFpiJb9xYQlf/62EAyfWyIVQezdbUJS9Fvfrl5PhDh5LKPnq16pWUuoww==
X-Received: by 2002:adf:ae41:: with SMTP id u1mr12234688wrd.20.1543821108104;
        Sun, 02 Dec 2018 23:11:48 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id g198sm4931795wmd.23.2018.12.02.23.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 23:11:47 -0800 (PST)
Date:   Mon, 3 Dec 2018 07:11:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: Re: [PATCH v7 0/7] Introduce STPMIC1 PMIC Driver
Message-ID: <20181203071145.GA26661@dell>
References: <1543571742-17995-1-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543571742-17995-1-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018, Pascal PAILLET-LME wrote:

> The goal of this patch-set is to propose a driver for the STPMIC1 PMIC from 
> STMicroelectronics. 
> The STPMIC1 regulators supply power to an application processor as well as 
> to external system peripherals such as DDR, Flash memories and system
> devices. It also features onkey button input and an hardware watchdog.
> The STPMIC1 is controlled via I2C. 
> 
> Main driver is drivers/mfd/stpmic1 that handle I2C regmap configuration and
> irqchip. stpmic1_regulator, stpmic1_onkey and stpmic1_wdt need stpmic1 mfd
> as parent.
> 
> STPMIC1 MFD and regulator drivers maybe mandatory at boot time.
> 
> Pascal Paillet (7):
> changes in v7:
> * rebase on regul/for-next
> 
>   dt-bindings: mfd: document stpmic1
>   mfd: stpmic1: add stpmic1 driver
>   dt-bindings: input: document stpmic1 pmic onkey
>   input: stpmic1: add stpmic1 onkey driver
>   dt-bindings: watchdog: document stpmic1 pmic watchdog
>   watchdog: stpmic1: add stpmic1 watchdog driver
>   regulator: stpmic1: fix regulator_lock usage
> 
>  .../devicetree/bindings/input/st,stpmic1-onkey.txt |  28 +++
>  .../devicetree/bindings/mfd/st,stpmic1.txt         |  61 ++++++
>  .../bindings/watchdog/st,stpmic1-wdt.txt           |  11 ++
>  drivers/input/misc/Kconfig                         |  11 ++
>  drivers/input/misc/Makefile                        |   2 +
>  drivers/input/misc/stpmic1_onkey.c                 | 198 +++++++++++++++++++
>  drivers/mfd/Kconfig                                |  16 ++
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/stpmic1.c                              | 213 +++++++++++++++++++++

>  drivers/regulator/stpmic1_regulator.c              |   2 +-

Is it just Mark you're waiting on now?

>  drivers/watchdog/Kconfig                           |  12 ++
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/stpmic1_wdt.c                     | 139 ++++++++++++++
>  include/dt-bindings/mfd/st,stpmic1.h               |  50 +++++
>  include/linux/mfd/stpmic1.h                        | 212 ++++++++++++++++++++
>  15 files changed, 956 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
>  create mode 100644 drivers/input/misc/stpmic1_onkey.c
>  create mode 100644 drivers/mfd/stpmic1.c
>  create mode 100644 drivers/watchdog/stpmic1_wdt.c
>  create mode 100644 include/dt-bindings/mfd/st,stpmic1.h
>  create mode 100644 include/linux/mfd/stpmic1.h
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
