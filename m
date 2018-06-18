Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C182CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72718208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BR4Uo+DA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72718208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754761AbeFRFtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 01:49:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39973 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753760AbeFRFtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 01:49:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id n5-v6so13041195wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 22:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8g0AKcEhteGjD2j26njqMl6S39jFe6MEKYzcmetNbuc=;
        b=BR4Uo+DAWEZpKn4qe+R+75IBuzLovya8gPgt1A7L2QoQAWE83esIoNjy/YcY7DpQSL
         NEPVAMO+tp3IGVFy3kPtk1xTuzbto3mX8NvEu+lK+AIi5Ju+vhM3W85s2s00lXi4kpUS
         NTAbJdza1HqSQt2kAb/lMqbmMx0OOEQQ14yuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8g0AKcEhteGjD2j26njqMl6S39jFe6MEKYzcmetNbuc=;
        b=lycd3mH2BLo5LAX1JHykn4eP3OqiaA1VbXybgTEqB06H/4wqvgYz2YTHK0D13J2zqr
         0QhEhVN2Wie75xDLP8n5hba54THWjrz85cwLcc6SZE2O3JNLbmXR1EiW4gt4HuOahqKz
         1XdwoD7s09gcOhjshwlq9e7PDY8ucBXn0/p1DEvElS+tEzZ1R/LBkhpLSneuZfyoupBl
         C2vWmCKNBZ4LzoTcrZr4PQ4P155FefFwrQuKe+00bbjlJ7DDvDB1CxXRAt81Ty/6ns66
         DeBYUHkr10WLk3hpBcew54Xc9oB6bYSh8KDWJaVgKFYjk5n3yrjc+ThiXEiG7hh+L06L
         k0Zg==
X-Gm-Message-State: APt69E0ZIwLua0AilgfPfiQxT1iPn5joyPpfCBvZtT2q7GHVTQajljxf
        z/uMtw0ehrqkpka21DLpTvt5FQ==
X-Google-Smtp-Source: ADUXVKKKXnmNTM8L4uzfDX2FolIwIPaDzfBoS6izjWBHoHwgApZ4XylYHFLYcAB52GapIJsKGL6Zog==
X-Received: by 2002:a1c:b18a:: with SMTP id a132-v6mr6908081wmf.18.1529300953032;
        Sun, 17 Jun 2018 22:49:13 -0700 (PDT)
Received: from dell ([95.149.160.78])
        by smtp.gmail.com with ESMTPSA id w2-v6sm11587242wrn.77.2018.06.17.22.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 22:49:12 -0700 (PDT)
Date:   Mon, 18 Jun 2018 06:49:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 23/26] devicetree: fix a series of wrong file
 references
Message-ID: <20180618054910.GB31141@dell>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
 <266e5f874b36aa83f3327879d85921fab52d5461.1529079120.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <266e5f874b36aa83f3327879d85921fab52d5461.1529079120.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018, Mauro Carvalho Chehab wrote:

> As files got renamed, their references broke.
> 
> Manually fix a series of broken refs at the DT bindings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../devicetree/bindings/input/rmi4/rmi_2d_sensor.txt |  2 +-
>  Documentation/devicetree/bindings/mfd/sun6i-prcm.txt |  2 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  .../devicetree/bindings/pci/hisilicon-pcie.txt       |  2 +-
>  Documentation/devicetree/bindings/pci/kirin-pcie.txt |  2 +-
>  .../devicetree/bindings/pci/pci-keystone.txt         |  4 ++--
>  .../devicetree/bindings/sound/st,stm32-i2s.txt       |  2 +-
>  .../devicetree/bindings/sound/st,stm32-sai.txt       |  2 +-
>  MAINTAINERS                                          | 12 ++++++------
>  8 files changed, 14 insertions(+), 14 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
