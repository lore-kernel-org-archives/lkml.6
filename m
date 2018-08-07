Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1E4C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EE121537
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZPf7U6uT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EE121537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbeHGHdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 03:33:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35891 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732468AbeHGHdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 03:33:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id h12-v6so7260704pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 22:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j4lUFitZJ32dyX9bKf1ZktjdBuKGA9WxGO8EoLj5DgE=;
        b=ZPf7U6uTiLAvtBq+o4smJ2hcWi1PafyLLRNquX5Sfk1cjm6wnVsOScRLr1eLsqILUw
         Ar+Qi8y2M+rduG38fhimKZDSGoDjSLnypRpefJSIQ/EmAZ4W+OjkgtVJwltqemGnhxqb
         hePNbxWTe212MG+ipbvdsJGY1OAC5025SRI3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j4lUFitZJ32dyX9bKf1ZktjdBuKGA9WxGO8EoLj5DgE=;
        b=tBVUbbNlLrwwF03Km2sXjZKSZQRcXuD5AJEPV+/3x8DqECgImwy41Q+YrcQ/YYTQpO
         WjIkKctKhIe+Z1m66stpYpXjmIodoaaqAGTm1UyprYkjhZBo424EUsZDIvLiyBIMVhL4
         NLfXA0tqn1iP3HMjLXRN05n5KIYi7DEt3jQApxFkChWERW4S9eld3y7KnVHRoXRIx1Bu
         G71PCmS8T76+WhIp8F5iqgv5mlEE6hTuy2/7q7zVpX/2x54VUAYbGNbZYCXcXLnGmQTr
         phVbl3Eti+w8r/XPlkVh40oVGvrqsKuvwja72TnODifnkpgdv9Jk8Khe8Yaw2gFcQkFs
         yr0A==
X-Gm-Message-State: AOUpUlF1Ue5VADgmhaiC1qqDV81Kvh3b2uiWSUHV0zQHYlNSDVZtxqPb
        LJt64xjyengIFtPHn6BTJjeR9g==
X-Google-Smtp-Source: AAOMgpfzfjpcJhPrzjfD5sGwRcB3egRzVg14wBh803ufD1U+copbSiIm1ZZ53GuMpfsT3tWEjgzqjQ==
X-Received: by 2002:a62:4898:: with SMTP id q24-v6mr19937120pfi.58.1533619237983;
        Mon, 06 Aug 2018 22:20:37 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n83-v6sm821923pfk.19.2018.08.06.22.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 22:20:37 -0700 (PDT)
Date:   Mon, 6 Aug 2018 22:23:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V4 3/8] backlight: qcom-wled: Add new properties for
 PMI8998
Message-ID: <20180807052355.GA23866@tuxbook-pro>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-4-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531131741-19971-4-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Jul 03:22 PDT 2018, Kiran Gunda wrote:
> diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
[..]
>  - qcom,num-strings
>  	Usage:        optional
>  	Value type:   <u32>
>  	Definition:   #; number of led strings attached;
> -		      value from 1 to 3. default: 2
> -		      This property is supported only for PM8941.
> +		      value: For PM8941 from 1 to 3.
> +			     For PMI8998 from 1 to 4.
[..]
> +- qcom,enabled-strings
> +	Usage:        optional
> +	Value tyoe:   <u32 array>
> +	Definition:   Array of the WLED strings numbered from 0 to 3. Each
> +		      string of leds are operated individually. Specify the
> +		      list of strings used by the device. Any combination of
> +		      led strings can be used.
[..]
>  
>  Example:
>  
> @@ -99,4 +146,5 @@ pm8941-wled@d800 {
>  	qcom,switching-freq = <1600>;
>  	qcom,ovp = <29>;
>  	qcom,num-strings = <2>;
> +	qcom,enabled-strings = <0x00 0x01>;

Nit. I would assume that specifying qcom,num-strings = <2> implies that
the first 2 strings are used, so one would not also specify
qcom,enabled-strings.

(And you should use decimal for natural numbers)


Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
