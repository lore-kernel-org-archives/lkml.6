Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C97C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CF120836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pjrk9iUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CF120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754393AbeFSXBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:01:41 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39312 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754355AbeFSXBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:01:34 -0400
Received: by mail-pl0-f65.google.com with SMTP id f1-v6so633677plt.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 16:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2tRWqv3bhuafptk56bsp0irZ1e27IAIhbIjpiveIpfQ=;
        b=Pjrk9iUqXhPdYxiitaEiKyWHAqNv+clYXDKVrVm+fwKUoQ+IgJXUz8VkVr8a+z1uwe
         +0Mn1AD8ox4d4MxHZrwE5lOSXVaNcMkv4Y4rLOvxoEV0LTf/n630syuZkJ7bAMN1xLBi
         E+oMPiJU0OMIUq/l1OUEBoRbFEOxLFJ0uEC10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2tRWqv3bhuafptk56bsp0irZ1e27IAIhbIjpiveIpfQ=;
        b=oKsqTdWtu3Hzd2kKXTt3T32OY0+3wH2rPPeLUycr4ApSq6F9sBCcevnX3ZzY2Gw05V
         gdRd3IAGDWkvWDHYmDb+MASBPoZMtx6AiPpfmaoAo2qc/wIFVd3VY1Xkwb2XzkLeWiVn
         5Huw4vYUHHzHwvvV2yYap7euui7KQOn158cnrCkEDbKbb8cD0UyEW0oEkNF1KyXkXyYI
         YYAz3d6+VWtsOyZcK00lgDV+D06NvH214UB4Ad12S5mb1hkRf2SP/6CGcn2ScbSHOYLX
         qUZ/tO481pHLacu6hMYU/SDDfqKsS3LrcjjSWtijcWbpgVYiy/Kjh1wE3mDEEXkrG+D3
         t2mw==
X-Gm-Message-State: APt69E34OP95oMuV4psIOCI0HTL8lqjv3Qb8QM7Z4d/+1s6WLpBDP5Un
        3/RgalVvCJTzsrGQRPGVPF69Dw==
X-Google-Smtp-Source: ADUXVKLwM0lyIXrSgx2puR3ZVOfRTZT8sOMuVv1WY7tfBodSapA7wdL7HHz+Uu2MHc37R1Dxe3bGSA==
X-Received: by 2002:a17:902:5a09:: with SMTP id q9-v6mr20727267pli.300.1529449293649;
        Tue, 19 Jun 2018 16:01:33 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p2-v6sm725409pgq.14.2018.06.19.16.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 16:01:32 -0700 (PDT)
Date:   Tue, 19 Jun 2018 16:03:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V3 3/7] backlight: qcom-wled: Add new properties for
 PMI8998
Message-ID: <20180619230351.GG15126@tuxbook-pro>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-4-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529406822-15379-4-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Jun 04:13 PDT 2018, Kiran Gunda wrote:
> diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
[..]
>  - qcom,num-strings
>  	Usage:        optional
>  	Value type:   <u32>
>  	Definition:   #; number of led strings attached;
> -		      value from 1 to 3. default: 2
> -		      This property is supported only for PM8941.
> +		      value: For PM8941 from 1 to 3. default: 2
> +			     For PMI8998 from 1 to 4. default: 4
[..]
> +- qcom,enabled-strings
> +	Usage:        optional
> +	Value tyoe:   <u32 array>
> +	Definition:   Array of the WLED strings numbered from 0 to 3. Each
> +		      string of leds are operated individually. Specify the
> +		      list of strings used by the device. Any combination of
> +		      led strings can be used.
> +		      for pm8941: Default values are [00 01].
> +		      for pmi8998: Default values are [00 01 02 03].

I would suggest omitting the defaults, as we can see in several places
in this document we end up having to update the document with new
defaults for each platform.

Also, per the defaults of the optional qcom,num-strings these are
already the defaults...

[..]
> +pmi8998-wled@d800 {
> +	compatible = "qcom,pmi8998-wled";
> +	reg = <0xd800 0xd900>;
> +	label = "backlight";
> +
> +	interrupts = <3 0xd8 2 IRQ_TYPE_EDGE_RISING>,
> +		     <3 0xd8 1 IRQ_TYPE_EDGE_RISING>;
> +	interrupt-names = "short", "ovp";
> +	qcom,current-limit-microamp = <25000>;
> +	qcom,current-boost-limit = <805>;
> +	qcom,switching-freq = <1600>;
> +	qcom,ovp-millivolt = <29600>;
> +	qcom,num-strings = <4>;
> +	qcom,enabled-strings = <0x00 0x01 0x02 0x03>;

Please omit the pmi8998 example as well, there's no real benefit of
adding similar examples for each platform.

Regards,
Bjorn
