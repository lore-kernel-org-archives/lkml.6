Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75050C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA13218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="STEMGwRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389918AbeLUKma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:42:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46496 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387699AbeLUKm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:42:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so4705821wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jaPzZAmw20h/qWuvV1XiTu1ISfjTnDosb69vOB2Vvf4=;
        b=STEMGwRYbuvD//O2x2Aywy9At/Nqrc7NeBa21vM2F8QOyk/iascOjlyYJpEd57rpR+
         Hz1RSP0F0h/IK72oipfG2EhO8emJyjAQ8wmyAJHeF4v1PGusHVOBdagyke6Gr6T9ZKHP
         wg8AACmXXnKOUNw4EYmVbZcpHeuuU8vEvKUtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jaPzZAmw20h/qWuvV1XiTu1ISfjTnDosb69vOB2Vvf4=;
        b=f6ie40LomHEFzsJKVsT2oeMKubBlTLWy/KmG2fWKQlmnkQ5PcBa2GwMk760ITG51tC
         jWM7wKXDQZ7jpK2OkD/C37oICx2tRX5GNfAzn+bEHgBsOmlFku5tCm8EUkw730tBMqTr
         FC/8wPPFpSevmoGQp4wA9wX5SMZk6uURfpAuAEnrTv0jZvQ4X7baDxfQHD2qQRiqWb0J
         H8ph8osQfOX1hhP12ymMyQYNvAfUUn7DDmze62fxJfdnsfKjQquIsy+px11J1kJf4Bek
         FhUpyw3uJYMa4NmjRCiApjpQbx+hHsmNGXv638sF36jTlCHPS9ECJwXfTShlvq//Rcqd
         NwyA==
X-Gm-Message-State: AJcUuke3qaDld1jFqyuKsAa+YbRqC+f0oWFQ78LY+ZomvEzZddty0iMy
        /2I2ABqQ4jSzfTc4RY3xYY89BA==
X-Google-Smtp-Source: ALg8bN6bfYSHICkT7dES6evQ/J/1jBK3MCV65/jrZP/FOrV50It5XIWXWV3zzCTO9s5JwJXh5rIK/w==
X-Received: by 2002:a5d:6105:: with SMTP id v5mr1960382wrt.63.1545388947209;
        Fri, 21 Dec 2018 02:42:27 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id v4sm11947083wme.6.2018.12.21.02.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 02:42:26 -0800 (PST)
Date:   Fri, 21 Dec 2018 10:42:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch,
        thierry.reding@gmail.com,
        Philippe Schenker <philippe.schenker@toradex.com>,
        devicetree@vger.kernel.org,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/8] dt-bindings: stmpe: reformatting parameter list
 and use tabs only
Message-ID: <20181221104224.GL13248@dell>
References: <20181212130649.15146-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181212130649.15146-1-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018, Philippe Schenker wrote:

> This patch reformats the parameter list for stmpe device in a
> table-style so it is more clear to read.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v4:
>  - New separate precursor patch for holding reformatting
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../bindings/input/touchscreen/stmpe.txt      | 52 ++++++++++++-------
>  .../devicetree/bindings/mfd/stmpe.txt         | 14 ++---
>  2 files changed, 41 insertions(+), 25 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
