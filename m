Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842E9C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F9020652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F9020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbeJFDsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:48:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34913 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeJFDsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:48:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id j9-v6so14003740otl.2;
        Fri, 05 Oct 2018 13:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dgWf3C6YYXPiqscAiM4zGkRksjQAUTy8JzvxuXPZlXI=;
        b=DoshpxlOql4/namXbp1pSVMTN7r6UUNm+W+An0tVVzGeMLnyC6zjZs1CIHv8cJjr3H
         30M0TZwKTAC4JzOZcUGK2yeX3i8FDqDuH+e0J14wjghOYGzi/93XwBBmmTvxjpFRt3nF
         p93BYhGmIN0gt98f0RP9t58Muvt143qEXiKOp2q9ilk4yw2NVY8oIxqVV4v9Bd7takWG
         9/cPwUySNsYV5qHwTCgqPoDBJxOwj/yuPkUEaFu3WmCMj75B61UntqULyElL+Whzb1r2
         dlH7wssoQrHOiCF5b0aCMZ1vQxNAS8kQSfpdiw2nFFPzz/FBOgJdMNoXLhqAAeJAAhY8
         nT3A==
X-Gm-Message-State: ABuFfoiKh98FgN+kNMbgiEDjoZ3YM/kRBOpf2eE/0CXtvDyj1+MnWlEG
        NJryHLqGRMmvulqfMw39NA==
X-Google-Smtp-Source: ACcGV62J82F4yowiLKSsb2HXJoJ+F98AagvZ1qnNdtflvkjjw4ZC6H2LifuvDXV5nUsmjOdSC4aSVQ==
X-Received: by 2002:a9d:6e5:: with SMTP id 92mr450599otx.241.1538772464711;
        Fri, 05 Oct 2018 13:47:44 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j83-v6sm2441030oih.18.2018.10.05.13.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:47:44 -0700 (PDT)
Date:   Fri, 5 Oct 2018 15:47:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: vadc: Update example to include
 unit address for node 'usb-id-nopull'
Message-ID: <20181005204743.GA17135@bogus>
References: <20181004001432.21218-1-mka@chromium.org>
 <20181004001432.21218-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004001432.21218-2-mka@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 05:14:31PM -0700, Matthias Kaehlcke wrote:
> The node has a reg property, therefore its name should include a unit
> address.
> 
> Also change the name from 'usb_id_nopull' to 'usb-id-nopull' to follow
> DT conventions.

This is ADC channels? If so, then DT convention would really be 
"adc@...". 

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v4:
> - patch added to the series
> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> index d0c188e5c922..ff7aa5038ba6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> @@ -112,7 +112,7 @@ Example:
>  		io-channel-ranges;
>  
>  		/* Channel node */
> -		usb_id_nopull {
> +		usb-id-nopull@VADC_LR_MUX10_USB_ID {
>  			reg = <VADC_LR_MUX10_USB_ID>;

Defines are generally used when there's not well defined numbering such 
as clock ids. Interrupts and addresses are generally well defined and 
don't need defines.

>  			qcom,decimation = <512>;
>  			qcom,ratiometric;
> -- 
> 2.19.0.605.g01d371f741-goog
> 
