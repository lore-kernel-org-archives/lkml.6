Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349A7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E9C21738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXgkxlDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfBTBYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:24:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41197 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfBTBYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:24:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id d25so2717966pfn.8;
        Tue, 19 Feb 2019 17:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0wcuu8pFpKTszJEohnrtlCo6Hnm3ADzjbzmlfA1RzL0=;
        b=hXgkxlDToLlYUTdigEzBs4P5EPPG/8/WOqiQ5QZSHHE4zrUUJ9B7+j5cN9KGM6ED49
         c14pb23M4qjnDCB+fX570/ccUH4gzRtcx0k3CSiolYNld1CyElvCPArOVNUQS4/lGtH2
         V9II5KhlOhlhAllYMeogBnsCs4MZf0JOJaL64iR7KDYRK6iftASjGspmX/g8U1j3PMm/
         HgWm664nRwWS1m36VgeaQZOxdkWY6K14uMSBofMQjcP/Q5TTsiN3326a+1hKGrHPX189
         WgShoEHr+F2BMLGTv2keVGd5aytvGRk0JwwJICCXuNhd6Pe2ACpgLc06bnj+Yxv2KWjN
         qnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0wcuu8pFpKTszJEohnrtlCo6Hnm3ADzjbzmlfA1RzL0=;
        b=mzo7yUNKUcdbZaafgxgzoRtjvc+Gcead67WbQ+q7uSlTh9zrZMKC5e8x/QG6r7HFCz
         umKIbQYURr0r8jky/4Bwv/sv6cbn0ymiuweY+bbX7hLv6YEOIeOxuFQtYRqYCuuZHdMx
         TiOXmzNwiFmkMwLXa4BolE0DqvfFO8w/AAaZilxIvPxMzUAd5OpnAinK6u1gUOZxhEy3
         Eh5cK7zJx7SMQe2ONUDkj3/p69O5zhC3/3nYYcPs9emtG4w2LcRkK7Gh8FLQ5hEw3++h
         hzZxhzK8B7/Mxv42inq+FcrxPF/koZ4gS9vHDveqNWm1LS+tAWz54d/1X8588q0gw14M
         Vrzg==
X-Gm-Message-State: AHQUAuaAwjcnSnFJRqXXnCR2OGVb0uS/oG7kthwXogzvl44p9B20R5iC
        Nw4HfxabukJ8LpHM2/MUAe8=
X-Google-Smtp-Source: AHgI3Ib+3xAlF2JlCeOW+aECzHmelcHQYwBrYo0ZRbodYtHxdx2VF+ai8mjwsPyqLpHkJKsQ9I6xmg==
X-Received: by 2002:a63:235c:: with SMTP id u28mr26999763pgm.400.1550625872595;
        Tue, 19 Feb 2019 17:24:32 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id c5sm30633184pfa.40.2019.02.19.17.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 17:24:31 -0800 (PST)
Date:   Tue, 19 Feb 2019 17:24:29 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 03/12] arm64: dts: msm8916: thermal: Add sensor for
 modem
Message-ID: <20190220012428.GF2811@localhost.localdomain>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
 <b7a640640775f91956baebbd37a36201f93b78f8.1550493113.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a640640775f91956baebbd37a36201f93b78f8.1550493113.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 06:05:17PM +0530, Amit Kucheria wrote:
> On platforms that have a modem, sensor 0 monitors the modem.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 9e598ab438a1..9e4a82e5e0b4 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -278,7 +278,13 @@
>  					type = "critical";
>  				};
>  			};
> +		};
> +
> +		modem-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
>  
> +			thermal-sensors = <&tsens 0>;

A thermal zone with no trips no cooling? Please check the thermal.txt
binding for the required properties.

>  		};
>  
>  	};
> -- 
> 2.17.1
> 
