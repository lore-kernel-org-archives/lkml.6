Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0872C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC952070D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545341842;
	bh=dZdo+MRhpcP+xwDV78ysDPWkHssEANn6w2bSh9KvBIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RRm+/+gFyOaz3uJOX1uM/pO7oSZRlxGZyUsuVbvDTKyIfx3BI0SzAfZTlnJLtlBKV
	 7sT0/zNo6SD8kPeoLCWfqQp+uivgDrNEPddny80vZmmkM23L80lNnploMACF3mX60y
	 9/7jHXMn+9Wq8cjQzXgeKEBkzZcAWDC4VfrFPZiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389977AbeLTVhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:37:21 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37601 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbeLTVhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:37:20 -0500
Received: by mail-oi1-f196.google.com with SMTP id y23so3145396oia.4;
        Thu, 20 Dec 2018 13:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AxaU7zrSWX0fc6SAAGFXliyhUgi/Gs4msHYZMlxcnWk=;
        b=Jcd2KLQrxC/einHV9Of0vC0NcRRS2lBH9zWxIkqS2UcC+XWwpJQ0hbzb64EdIEou/L
         oJeFgxe2bL16wXhznCWOJVvb1ug00gd8e0hYKkk0yhrqHazmXRxhSKMhFO5zFk8AcSEP
         GWbKyp+fRlANXgrcVKZhG/aMlCCCLbz0ktB5gxg8dMAXm3byD0e8FrqBCqkkxRawBg/F
         e+UkqAk/9v5sMZhAtI93RgZTmwOZskAAEAGcXlNliuFKUzfxScjFsyy5D3hpNanDcIyg
         H1BHCEX7wuTgNLTzfFMVRpdPFuTFRAoX5jjswU4mxoMvXtZJomSHuEpg+vv7eB+FszLw
         8bmQ==
X-Gm-Message-State: AA+aEWZsNBfNM+W/hjJfgvNbYFGbOLpkBM80xHPG7KFYItDWTG/817sA
        FEXQNL10FhUUHaSY6N+sVQ==
X-Google-Smtp-Source: AFSGD/Vf/DktaMqCOXHukHpteFCFgM10KmSvObZxBOJ6Y5xehWpYzXb4iUuipNfn5aGRnBWKemZqtQ==
X-Received: by 2002:aca:52d4:: with SMTP id g203mr305385oib.14.1545341838608;
        Thu, 20 Dec 2018 13:37:18 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id n185sm10461267oih.18.2018.12.20.13.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:37:17 -0800 (PST)
Date:   Thu, 20 Dec 2018 15:37:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com,
        bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 04/13] dt-bindings: mailbox: qcom: Add clock-name
 optional property
Message-ID: <20181220213714.GA8965@bogus>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-5-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545039990-19984-5-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 10:46:21 +0100, Jorge Ramirez-Ortiz wrote:
> When the APCS clock is registered (platform dependent), it retrieves
> its parent names from hardcoded values in the driver.
> 
> The following commit allows the DT node to provide such clock names to
> the platform data based clock driver therefore avoiding having to
> explicitly embed those names in the clock driver source code.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../bindings/mailbox/qcom,apcs-kpss-global.txt      | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
