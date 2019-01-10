Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEE0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA22A20657
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbcY+sZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfAJG06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:26:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43584 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfAJG06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:26:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so4847111pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 22:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AJLZyiuwozSilcJHEfPtty3E19jURDLTPlHh9adfgAU=;
        b=KbcY+sZpinw4d2obh3P7Eh7C8SZrCgNSbqNR1TXaH53fmQleLmLCNqZ0Y5zQ+5qe4v
         I4XVAgGUnmpTwra/mm8YqfZZVYl7eALSZlriuMmLElXHUH2cGWNoHzbY9JD1u3m1OJn4
         c+JSvXEB/8XcZ2iXGFXNMpC2xaF0P07zO/0oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AJLZyiuwozSilcJHEfPtty3E19jURDLTPlHh9adfgAU=;
        b=fHfO0WA2h4bdDhd42WeH+ilkBcypsYyFbrUOOLaEbhUdGHrm0i6D8WvywHh4TQ2NcP
         N2714Vnj0LNdEyEnJdTSsf7I4p5wiBL3XzRpl+KJaMiq0FDlrE1fby9jsabUS99TX+cf
         k+FeZL13AjzB2fV+WwZxuzhouK/0zNny/MXnluaSlpgDvUC9w5jUzpdPksqRTovf+9dT
         aWoGGrk717iNzcNo/ImevVnpFqqdQqzNR4ob3YMFmXpajPnW0njKpTpUwu35RtSkfDR5
         pL90p5ctTlGo2gjeyV3qZk5G4/P3FxHknZDE71HplK4mCkG4g5A4w0nhXZ8Iko6D7Y4F
         QNeQ==
X-Gm-Message-State: AJcUukcSyR7CnqyfYFRdC4rUafGajt3mUTJyInHYbYg6n4dX5ixeF7Y6
        rzVAKitwxpYx0srBi7MCbbcM3Q==
X-Google-Smtp-Source: ALg8bN7KxC/9mJdJNHPZcR44Zn0snuWIMEYLSIEjKTvXzpb7whxoceCur9DnAeRgQiPrIPlOwU27Zg==
X-Received: by 2002:a65:6148:: with SMTP id o8mr8231871pgv.451.1547101617494;
        Wed, 09 Jan 2019 22:26:57 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id v89sm111673671pfk.12.2019.01.09.22.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 22:26:56 -0800 (PST)
Date:   Thu, 10 Jan 2019 11:56:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     andy.gross@linaro.org, robh@kernel.org, sboyd@kernel.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com
Subject: Re: [PATCH v11 1/9] dt-bindings: opp: Introduce opp-level bindings
Message-ID: <20190110062654.3ukmgorqdw5tist5@vireshk-i7>
References: <20190110040209.6028-1-rnayak@codeaurora.org>
 <20190110040209.6028-2-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110040209.6028-2-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-01-19, 09:32, Rajendra Nayak wrote:
> Add opp-level as an additional property in the OPP node to describe
> the performance level of the device.
> 
> On some SoCs (especially from Qualcomm and MediaTek) this value
> is communicated to a remote microprocessor by the CPU, which
> then takes some actions (like adjusting voltage values across various
> rails) based on the value passed.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index c396c4c0af92..76b6c79604a5 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -129,6 +129,9 @@ Optional properties:
>  - opp-microamp-<name>: Named opp-microamp property. Similar to
>    opp-microvolt-<name> property, but for microamp instead.
>  
> +- opp-level: A value representing the performance level of the device,
> +  expressed as a 32-bit integer.
> +
>  - clock-latency-ns: Specifies the maximum possible transition latency (in
>    nanoseconds) for switching to this OPP from any other OPP.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
