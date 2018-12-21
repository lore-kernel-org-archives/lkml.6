Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D4FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF6921906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHt0u4mO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389921AbeLUKmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:42:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43990 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387641AbeLUKmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:42:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so4716833wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mAtp5c+TuQv/n4xrRqKvadlhKP80qAdoimAqxu30Goc=;
        b=SHt0u4mO+p7IX3QDIjrQ1BEpmvC/mMwy85GdSmHyxMTkHa7LzA9mjwqPXWV0Shy8+N
         qcMrTaa5a7IoUbSc//IS7PeBsexFomtGgD9FuQA7ox486aMRN/EvIvINKHpZoz7b4Ygn
         TJVURg5wEAv2OzuNHPdGBapRe2LftOpKL0bsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mAtp5c+TuQv/n4xrRqKvadlhKP80qAdoimAqxu30Goc=;
        b=UyemL31t9/hDQI6DsB7hzTgVcCE0uviaEOdtCdUQcKNkKYMc1XlZMjkGSl9jfKRzCH
         6s30rGAx69uv6XfZt8fQr1+HakdyDnS0bXlGmdskz8A9i5ubpuO/e1HVbomtL3QdrUHT
         rtDcqIXQ3bqqWrQ89R0CfPJkeu17FOWkBby2yNt3J98QUFUTl5M487LBf9KS1U+SfWyp
         0gGsYqKVzKbXGUq19cjtu2fzRX5WRxB7nKa0Cpl4MAqq35/tvNKsp/N+IDrg2p/OSi4H
         O1ABFVIhMPOrSacYlblxgZB+3fNRT4W9pxIMcn89PvepCOvrjMbKFzAQK/TkZRFehhJf
         ajRg==
X-Gm-Message-State: AJcUukfhQD3mHVSD8lznwj3qddYgq+qGgRZfDkEBAYwGQg636qq5wb3/
        ydbsjlGAwukb+WNXbIC+HtkpBw==
X-Google-Smtp-Source: ALg8bN7v9Vw2+R3QXTA6qNCZlBDkZHF5FIKNgt6Db9t7Z78rXRg7A+Gwfaux6H/MRiHOwJu3RhvUqQ==
X-Received: by 2002:adf:f984:: with SMTP id f4mr2057888wrr.234.1545388973022;
        Fri, 21 Dec 2018 02:42:53 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id q185sm13291719wmg.14.2018.12.21.02.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 02:42:52 -0800 (PST)
Date:   Fri, 21 Dec 2018 10:42:50 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch,
        thierry.reding@gmail.com,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/8] mfd: stmpe: preparations for STMPE ADC driver
Message-ID: <20181221104250.GM13248@dell>
References: <20181212130649.15146-1-dev@pschenker.ch>
 <20181212130649.15146-3-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181212130649.15146-3-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018, Philippe Schenker wrote:

> This prepares the MFD for the STMPE ADC driver. This commit introduces
> devicetree settings that are used by the ADC and adds an init function.
> Common ADC settings that are shared with the touchscreen driver can now
> reside in the overlying MFD.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> I moved now all enables back to the subdevices. The disable of ADC
> block is now done at remove of mfd. I know this is not particularly
> right, the right way to do this would be with a refcounter.
> 
> But I don't know how to implement this in this driver. If someone does
> not agree to disable adc in remove of mfd, please give me some advice
> in how to do it with refcounter.
> 
> Changes in v4:
>  - New patch: split mfd changes into this precursor patch
>  - Export the added stmpe811_adc_commmon_init function
>  - Disabling adc when mfd is removed
> 
> Changes in v3: None
> Changes in v2:
>  - Move code to setup ADC to MFD device, as it is used by both drivers
>    adc and touchscreen
> 
>  drivers/mfd/Kconfig       |  3 +-
>  drivers/mfd/stmpe.c       | 68 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stmpe.h | 10 ++++++
>  3 files changed, 80 insertions(+), 1 deletion(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
