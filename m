Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2214EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E465821906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NzpH4Yx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389976AbeLUKok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:44:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43160 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731433AbeLUKoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:44:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so4722358wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zRoUutFyDfmmemUAmzDJJAZ6OSaaWsvU2Qbe6YNb/MI=;
        b=NzpH4Yx+q1SR83CISQliyRkRkuyrq2tWVoPIV6YKXViCfcpv8w62zHPOWnkR2b4C+Q
         LWNVc6wJqYbNw0Bjdf48mEgvnI+ZexT5+Ugy6/LIGCR/ACzBWad3ju+/CZIqj6PQ86w6
         JePcJ6aiJHI/klZWApHf57Y5BZFxfOxcvEESw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zRoUutFyDfmmemUAmzDJJAZ6OSaaWsvU2Qbe6YNb/MI=;
        b=rqQHH+sNQeFpOYVRhYrqyyAFVGPc7/nSEItM10q3FQLKeQR/Tbgx2Wfuequw3yCY7y
         g214O4IYMtsu6V3vkNKFVrvy1/efzcENUN09TeDsjpp9rPw6Bdx3Ura2u3ByjsJOzX2e
         Cr5TY8s74JfGlICYXq/PefdmLtNVr0SRT+dDxfOWH2q1qSjbqIeJnmxpB0UnWzhw+rNH
         lMIWuY7dVKdZ+0MQhNW0ALnUd7Yc8MNCqcy0yui7uHL1lFpgML95secCM9XONzjvxhM3
         drQUIHmzsoFhA3ONGJIathXt486yW5q6O/pGah9eIGxAo661n76poewXfEoTXKxCJYfj
         w4rA==
X-Gm-Message-State: AJcUukeyBNoTT7q/uXuh+4WLWKknAMo0m4eBV7pptVr9W9f60gwCe1Ji
        h6kdnPqWe6MVGrGIeKN9Zxm0uA==
X-Google-Smtp-Source: ALg8bN7AaQbZwqto2+O+rcOjgeZw9aeAjk9+OOHkbLCvgNoWs7b0Ua544OtlK3Bjx6RFu9/SD2Mz/Q==
X-Received: by 2002:adf:f3c6:: with SMTP id g6mr2012309wrp.111.1545389077318;
        Fri, 21 Dec 2018 02:44:37 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id n5sm14696152wrr.94.2018.12.21.02.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 02:44:36 -0800 (PST)
Date:   Fri, 21 Dec 2018 10:44:34 +0000
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
Message-ID: <20181221104434.GN13248@dell>
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

Set looks okay.

Please submit a [RESEND] with all the Acks you've collected.

And next time, please make sure you author a 0th (cover-letter) patch.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
