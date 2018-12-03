Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0A3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25862087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25862087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeLCRXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:23:00 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35342 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbeLCRXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:23:00 -0500
Received: by mail-ed1-f68.google.com with SMTP id x30so11473304edx.2;
        Mon, 03 Dec 2018 09:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eLe7hs6zK3nWa9FKvIs4EFvCkDLHitkC5GX4jfkvnAg=;
        b=aEsLAKhT0xCNkWKER6zzzjoW/uxcPqGnvb3CT2un4gW2imp4beFZnAUhw1V23Lkp3G
         y1TcH0u3daEWgNqOaZjwnXZF9jQfCiaSuUEWOYj0oVj2H6epbDaJkVYL/HBta+hXE7mV
         8xMZbriMXcNGs6Hlva3mvNLqCgCJzkX7YeOQ5wfw3H5k9eGU73QCzJQe4eFXpDUF9yjf
         UuXOSlKGyg4WYLUkDqvHS8wcJCRajUWceVfdFfDbdvArzOvo5RwKmnzNeDtNwmOnr0kx
         gi7SmPyS448FfC+UPnQMhoJhV4GCGHQr7g5K6UVP9Fr8QgLfi7LoCSbMn9smFGLfiDx7
         HtOA==
X-Gm-Message-State: AA+aEWZbRc2AZuU2cOAkf0oeWjsUPvfYh69hJSdMW1m3qCW01ME0iGOp
        dUG97oNlAnN/2tg58aGP/Ro=
X-Google-Smtp-Source: AFSGD/UVFb/g3/KZkTEIhhqIhgyuc7N4aD7jHiNnsxXKWL4NjRzfuHJALxsLkY0LM/kemHFLT5czdg==
X-Received: by 2002:a05:6402:1299:: with SMTP id w25mr14506777edv.237.1543857774456;
        Mon, 03 Dec 2018 09:22:54 -0800 (PST)
Received: from kozik-lap ([178.38.170.116])
        by smtp.googlemail.com with ESMTPSA id g3sm4129579edc.63.2018.12.03.09.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 09:22:53 -0800 (PST)
Date:   Mon, 3 Dec 2018 18:22:51 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 5/5] arm: dts: exynos4: opp-suspend in DMC and leftbus
Message-ID: <20181203172251.GA15124@kozik-lap>
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143135eucas1p165fe6183ae90de7906f9683cb41ff4c1@eucas1p1.samsung.com>
 <1543847475-7600-6-git-send-email-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1543847475-7600-6-git-send-email-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:31:15PM +0100, Lukasz Luba wrote:
> Mark the state for devfreq device while entring suspend/resume process.
> 
> The patch is based on earlier work by Tobias Jakobi.
> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210.dtsi | 2 ++
>  arch/arm/boot/dts/exynos4412.dtsi | 2 ++
>  2 files changed, 4 insertions(+)

Thanks, applied with some minor commit msg changes. In general, please
take care about title prefix (git log --oneline
arch/arm/boot/dts/exynos*) and always explain why you are doing this.
You just mentioned "what" but that is pretty obvious by looking at
commit contents. The commit msg should answer why these should be marked
as opp-suspend and why these values were chosen.

The cover letter just briefly describes "issue with devfreq devices' frequency
during suspend/resume"... but what issue?

Best regards,
Krzysztof

> 
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index b6091c2..4429b72 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -298,6 +298,7 @@
>  			opp-400000000 {
>  				opp-hz = /bits/ 64 <400000000>;
>  				opp-microvolt = <1150000>;
> +				opp-suspend;
>  			};
>  		};
>  
> @@ -367,6 +368,7 @@
>  			};
>  			opp-200000000 {
>  				opp-hz = /bits/ 64 <200000000>;
> +				opp-suspend;
>  			};
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index 51f72f0..908c0c4 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -432,6 +432,7 @@
>  			opp-400000000 {
>  				opp-hz = /bits/ 64 <400000000>;
>  				opp-microvolt = <1050000>;
> +				opp-suspend;
>  			};
>  		};
>  
> @@ -520,6 +521,7 @@
>  			opp-200000000 {
>  				opp-hz = /bits/ 64 <200000000>;
>  				opp-microvolt = <1000000>;
> +				opp-suspend;
>  			};
>  		};
>  
> -- 
> 2.7.4
> 
