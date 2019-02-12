Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2B5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A1021B68
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lZrd3vNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbfBLVHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:07:01 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40701 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732333AbfBLVHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:07:01 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so198659oth.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IHJdLSns6Umt7qLO7lIOnG29bobGtsVLzGx5kUC2fjo=;
        b=lZrd3vNRDYFQBv+r2/nmrsbbUPCgQXGPfIF8AP1+EmZ93mU+CXJvtHOshBHIxP1fTp
         F22rGmPhFe85mTDBfxSw8Tsvclpk97cKf+4RSQiN+BavYUk+Vxl8KKZMUJT4U/AP+4V6
         soqfMz8l/+dM5r7EeGVvKxrXc263lOWj8V+jnmC7KI8SgVbFeixhPIMvYFBvx7rsi0Yz
         pustjyv88hd4GUc4JMZ3adptKHPN7BkFoXMOR2hzmzz3uri2x9vTuVqp8AvSaZ5OXhHf
         KtjoPUcvZkb7zhfZZWQoGYn3qlUZ2T7h8BpymWoF1pm9AeIkehlH5K2A+BuWrYu7Y0dJ
         Asmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IHJdLSns6Umt7qLO7lIOnG29bobGtsVLzGx5kUC2fjo=;
        b=ZoJyuTX3CjeQg8KL+SxhjhDsRhgzxri0pc8NmHWhK+VmCTj1WpVGf0CgPg3R93Uuxn
         UCaHuKBRu34QehwK9tdGrhUY428mzQjvt9U/zJcmESPwCtptPdPoJxSh6btyd3PF7vrD
         U/9JGykn/W3eb9r2NSanRPJ/0qT18Yfs58MU10mQTAKyzF/S5O94w85z4GY7hy8GbvRh
         21Gr2oCPFvTtzVnYfo3A3ASnkRweT5fFgFYiEK/68gmFpggximYxkv+Vz4sqBxiJAcvI
         Lky9q5soTiyfWQF2hU/YPQ0PMbQxDgsuxL15pPphD2wOleiYYOBifV7i8D1XvRAUoZ2p
         meUA==
X-Gm-Message-State: AHQUAua03U4o2u91MHOjmsrx62RmHr+5R0RBc20ianqnTbguRVzc0nKt
        p0XfDjgWtE2BGirjr5OFz16WLQ==
X-Google-Smtp-Source: AHgI3Ib+R9ZvfJctrZHEIG2J9VExeNDX1YEkSwZOGuvAfmKVK3ryFxWFzw01IQXfaeKfQBdjR34nog==
X-Received: by 2002:a05:6830:10d2:: with SMTP id z18mr5561682oto.321.1550005620499;
        Tue, 12 Feb 2019 13:07:00 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net. [107.207.74.175])
        by smtp.gmail.com with ESMTPSA id w202sm2577219oie.48.2019.02.12.13.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:06:59 -0800 (PST)
Date:   Tue, 12 Feb 2019 15:06:56 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] arm64: dts: msm8996: fix blsp2_uart1 4-pin pinconfig
Message-ID: <20190212210656.GA6642@hector.attlocal.net>
References: <20181220161750.12587-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220161750.12587-1-johan@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 05:17:50PM +0100, Johan Hovold wrote:
> Fix "gpiio5" typo in the (currently unused) blsp2_uart1 4-pin sleep
> config.
> 
> Fixes: 22e6789f9493 ("arm64: dts: msm8996: add blsp2_uart1 pinctrl")
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
> index c5c42e94f387..1d1f7f91739a 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
> @@ -139,7 +139,7 @@
>  		};
>  
>  		pinconf {
> -			pins = "gpio4", "gpiio5", "gpio6", "gpio7";
> +			pins = "gpio4", "gpio5", "gpio6", "gpio7";
>  			drive-strength = <2>;
>  			bias-disable;
>  		};

I took one in slightly older than this one.  However, it doesn't have the fixes
line.


commit ff10032fb309d0baa0b79e28009bf154de08d341
Author: Jakob Wuhrer <jakobwuhrer@airmail.cc>
Date:   Fri Dec 14 18:01:30 2018 +0100

    arm64: dts: qcom: Correct "gpiio" typo in msm8996-pins

    gpiio5 is missspelt in msm8996-pins.dtsi, fix that.

    Signed-off-by: Jakob Wuhrer <jakobwuhrer@airmail.cc>
    Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
    Signed-off-by: Andy Gross <andy.gross@linaro.org>


Regards,

Andy
