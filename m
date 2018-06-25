Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A29C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F3126051
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F3126051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934952AbeFYTGO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:06:14 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34942 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754632AbeFYTGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:06:12 -0400
Received: by mail-yb0-f195.google.com with SMTP id x15-v6so2322110ybm.2;
        Mon, 25 Jun 2018 12:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d17PyWwF2nkJNKkN8i2G4Xoz61+WEPDo5jKNsPHfwyQ=;
        b=THfHH9Ewxu8c4dpr0qw1oa20p+JZn+c/455VhdrjvriUMSbB9wtRlt1NVxv4MO257/
         d7axCSwDmR+nD/d0RLrv9BoFJ7OO183eQY5N27hEj+FsuYbsOljofVUW7eYUyJKarA3M
         r8MYNtHOFjrnegfD1NTBGSs1kzgJmpvcud+DqRpDLgL854PsJuMI+rQp4MMIPNmeARjY
         LMJAN5NonOjqthw1Slu8HNxZZOf2iAwN1n34bCjBWEvhFcRAcp+rY1EIS5UbZGAj/8mc
         jhI8f3RwPH3q4u+iLvgX03VPnDTRmZaDiDn+0OdrvNhtKSlAGyu/RuE6dzUCSIb091A8
         aHtg==
X-Gm-Message-State: APt69E0CyOBHDZgQGY/qsY2E9sB8GtbcySMwwVUPMvH6/c1x7B3j64TU
        1YJBbRMEiH5KlpL/TxXcGg==
X-Google-Smtp-Source: ADUXVKJvuKBJ565Jrzp9MxHe1xaf1bRd3cfQxZT3Qcpc9hMfhQMs0NxlVaJxDCSeN8+Jd7Dx+XJEaQ==
X-Received: by 2002:a25:7002:: with SMTP id l2-v6mr6701797ybc.489.1529953571376;
        Mon, 25 Jun 2018 12:06:11 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id j128-v6sm2394968ywf.9.2018.06.25.12.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 12:06:10 -0700 (PDT)
Date:   Mon, 25 Jun 2018 13:06:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vinod.koul@linaro.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: rng: Add new compatible qcom,prng-v2
Message-ID: <20180625190609.GA3586@rob-hp-laptop>
References: <20180619095430.26358-1-vkoul@kernel.org>
 <20180619095430.26358-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619095430.26358-2-vkoul@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 03:24:29PM +0530, Vinod Koul wrote:
> Later qcom chips support v2 of the prng, so add new compatible
> qcom,prng-v2 for this.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
>  Documentation/devicetree/bindings/rng/qcom,prng.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rng/qcom,prng.txt b/Documentation/devicetree/bindings/rng/qcom,prng.txt
> index 8e5853c2879b..03fd218bd21a 100644
> --- a/Documentation/devicetree/bindings/rng/qcom,prng.txt
> +++ b/Documentation/devicetree/bindings/rng/qcom,prng.txt
> @@ -2,7 +2,8 @@ Qualcomm MSM pseudo random number generator.
>  
>  Required properties:
>  
> -- compatible  : should be "qcom,prng"
> +- compatible  : should be "qcom,prng" for 8916 etc
> +              : should be "qcom,prng-v2" for 8996 and later

Either use SoC specific compatibles or convince me 'v2' is a meaningful 
and specific enough version. Some other QC IP has x.y.z versioning for 
example.

>  - reg         : specifies base physical address and size of the registers map
>  - clocks      : phandle to clock-controller plus clock-specifier pair
>  - clock-names : "core" clocks all registers, FIFO and circuits in PRNG IP block
> -- 
> 2.14.4
> 
