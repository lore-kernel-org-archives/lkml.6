Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A80C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D8221A38
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkXRjJ3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D8221A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbeHGHqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 03:46:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33659 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeHGHqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 03:46:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so7999145pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 22:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9oukoeaMGlTaN/s6XELHNxkvUP229E/0x8HKXrfyqxI=;
        b=gkXRjJ3iTbY+qwcvVbSha8AcnIio4nVGZH+SK/MxcWGS3SKJBhaZbco/nXs6TptWPk
         pW5ohQlrDMyRhY4RxAJ7NKm/rdG3l4rygEgli/CezyZzqFCpSbPTKg/Xb1Z8Xi6wyPun
         Bp/iUWJstIk/Ql0wga7ry75oS44Z5UwpcT1VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9oukoeaMGlTaN/s6XELHNxkvUP229E/0x8HKXrfyqxI=;
        b=g4Xf2pFraLKJxuR3Z/H8ml09SjYr1Z2KoMrH/AE51ml7tkCR2XmDXMXlc1sYiF9tJS
         OkkG2uRiSlAH9m33mtkQkj9cMfeYsSdBeER4dqL8vaPnW8x6ViNJP+w0SrCheR5M88wB
         oNFm4F2eQOTHtx/UWNvVYanIaZMV2SFCLEw4eTuFRhvupgSCeD2Ojoh2v5G+vAwbM+Xm
         VFrNmmeLtWYOgEQ3NHIn7lR+WudMmAFbP6ED7D+FzoFi15Jj1xu7Fh0cctOkc4+JlEyy
         nX/FM6kGuDAe1IkPq4YaDJ2Lgk2D+EJul0CXkIWcaHmLGj6F5Q4Kqr0TgcYx4TEZyu/+
         Ig4A==
X-Gm-Message-State: AOUpUlETYeaLBxk3QlEWxFyos5/Tjl4XXKIPNpkQoCG+iRyHPLivDx90
        X/MgfTh6Gx5vVKvw6/ib+5HpOw==
X-Google-Smtp-Source: AAOMgpc+aLEOTgrLdVKtoi38K4TjaFBqRrVDOIyNfnWhaY41kd9iMDybSR3GKpydLxKRNPZjP7ylsQ==
X-Received: by 2002:aa7:88d3:: with SMTP id p19-v6mr14731010pfo.160.1533620027804;
        Mon, 06 Aug 2018 22:33:47 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n80-v6sm959476pfb.95.2018.08.06.22.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 22:33:47 -0700 (PDT)
Date:   Mon, 6 Aug 2018 22:37:05 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V4 5/8] backlight: qcom-wled: Restructure the driver for
 WLED3
Message-ID: <20180807053705.GB23866@tuxbook-pro>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-6-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531131741-19971-6-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Jul 03:22 PDT 2018, Kiran Gunda wrote:
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
[..]
> @@ -365,6 +434,15 @@ static int wled_configure(struct wled *wled, struct device *dev)
>  
>  	cfg->num_strings = cfg->num_strings + 1;
>  
> +	string_len = of_property_count_elems_of_size(dev->of_node,
> +						     "qcom,enabled-strings",
> +						     sizeof(u32));
> +	if (string_len > 0)
> +		rc = of_property_read_u32_array(dev->of_node,
> +						"qcom,enabled-strings",
> +						wled->cfg.enabled_strings,

qcom,enabled-strings is listed as optional, but without it we will end
up with qcom,num-strings zeros in an array.  Initialize
wled->cfg.enabled_strings to 0,1,2,3 and the driver will be backwards
compatible.

I also think that if you do qcom,enabled-strings = <0, 1, 2>; there's no
need to also specify qcom,num-strings = <3>; and we can just use
string_len for num_strings.

> +						sizeof(u32));
> +
>  	return 0;
>  }

Regards,
Bjorn
