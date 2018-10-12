Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96227C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519852086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFVxDgQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519852086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeJLQij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:38:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41011 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeJLQij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:38:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id x12-v6so12573013wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QGeoJV7gu7WaFyfI/1Oaokiyqa43XmL1dR4uevu90yA=;
        b=VFVxDgQNhfVB2QqIWWFnru0mJLNWJb5uenS8kdCrMZ4TeC9XMxkXhqMxtRorLd/z7S
         4fpVCzfevz5YgqEv8k6VjCYyUO36aga678LH4T21LoQHAZKhi3rXEvhePIcxzJLfevae
         gFwCUVfCRogIdqrIokhI4olz/b0cQdFEyRK9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QGeoJV7gu7WaFyfI/1Oaokiyqa43XmL1dR4uevu90yA=;
        b=mbHKjdqDUPm1cZPkRngZeTJp707kfxdyWQR+otakE2gu/Sb0nkMrejdHsXHziHSqT/
         mpf6l6cDX75dztEmljrVHQvrP4EMc7AYb+OUDOdgZMiaYfvhBf3nD12PTtO2d1H5fEFM
         RMFq26t7YHkXdNOnY6YwqypaNHYXTTF2LB4jg9oA7fLpoUQwd/rQEzJcR5ifLJcGjoSD
         +SspQpJeqGnfJpfP6miyKTyozJqTqyVrcv57fhWrci0zTiCszcDcd85mxWWACWAe/wms
         e/oSu7Bfb3vJ0Q0ETefKpHNKIjdcgvgMTBRAnbUfxpRIHCn1hWXDM3AWUJhLfedTn+1f
         vA9g==
X-Gm-Message-State: ABuFfoghaIpCrSBMFyQSp7i7wbXR8uXbk9BMaevnDy3YwjIPkooq8aVQ
        pOmlD7J4oq3U8jaV3vRaDy9J6Q==
X-Google-Smtp-Source: ACcGV62DQN5oSsK0Zs6BQVaYfq6Fjqmo9IiyGagLoKFxdWJQbEpeWpM3mrElPtmvyp9FV/WdlCsCGw==
X-Received: by 2002:adf:8523:: with SMTP id 32-v6mr4692047wrh.72.1539335230602;
        Fri, 12 Oct 2018 02:07:10 -0700 (PDT)
Received: from dell (89-145-231-171.xdsl.murphx.net. [89.145.231.171])
        by smtp.gmail.com with ESMTPSA id i7-v6sm569224wrb.30.2018.10.12.02.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 02:07:09 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:07:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 2/9] dt-bindings: ti-lmu: Remove LM3697
Message-ID: <20181012090707.GY4939@dell>
References: <20181011165123.32198-1-dmurphy@ti.com>
 <20181011165123.32198-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181011165123.32198-3-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018, Dan Murphy wrote:

> Remove support for the LM3697 LED device
> from the ti-lmu.  The LM3697 will be supported
> via a stand alone LED driver.

What's with the odd 50 char line wrapping?

> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/mfd/ti-lmu.txt        | 26 +------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)

For the code:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
