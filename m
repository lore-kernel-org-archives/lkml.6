Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F88C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DE720658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DE720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbeIKBCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:02:38 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40499 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbeIKBCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:02:38 -0400
Received: by mail-oi0-f66.google.com with SMTP id l202-v6so42672132oig.7;
        Mon, 10 Sep 2018 13:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ox1tNDQlT0zHgXKL0oY/nhejzZ/RkcQzbonEu9+KPks=;
        b=gN9uwcO4GvWvNc1ebOQxOSqI+IYxjJyBxpFDmn6Se5Djf2anUXEbB2yfcWGuhBkcFF
         aaPNebvmSnh99cbmjKl+uONkHFRJv83SJcaZ9Ry4Q5WAQ/QVaDKAx+1MWmhqkDR3HoKJ
         qmcRF52GiL5oomTE2/tIxa4A5ISntnUgwoeKk/L8E4C7egBeN1KyieTcRyzHcW9QYiTY
         YjnDsFD8WBl08BPnCr1QMCRZLkwimlhCb0xez+dHaVAQPrQxQQuFFyMB8BlYtDjGWGh5
         MBI1jJCNp04swbhFKMg7S3K+Ppp2XbrDz4F71vp1+EW60iudaEzZYmGV4LhAVGibrAgq
         Qs7A==
X-Gm-Message-State: APzg51CFv3pgU8+tE8RUYPnHC75jNbAsgjAqJZKfUEZJrxOY7mytmFSv
        vDau202W0ctq1/7BGV8NLw==
X-Google-Smtp-Source: ANB0VdbHGo8BdU/HuZWllceQH+7CgcWCCET3VQCRRsGE/tnlLFJ3BxRW82hVjfgX7hSKLtL9WiQjBA==
X-Received: by 2002:aca:6087:: with SMTP id u129-v6mr21631119oib.99.1536610014243;
        Mon, 10 Sep 2018 13:06:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q63-v6sm18647429oia.54.2018.09.10.13.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 13:06:53 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:06:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lee.jones@linaro.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 10/13] ASoC: dt-bindings: Add WCD9335 MBHC specific
 properties
Message-ID: <20180910200652.GA20896@bogus>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-11-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904102500.30318-11-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 11:24:57AM +0100, Srinivas Kandagatla wrote:
> This patch add new bindings required to support MBHC
> (Multi Button Headset Control) block in the codec.
> This block is used for jack insert/removal detection,
> headset type detection and 8 button press/release events.
> 
> All these properties are very much specific to board.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd9335.txt           | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
> index 5d6ea66a863f..4d56c3ca9fa8 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
> @@ -55,6 +55,26 @@ Required properties with SLIMbus Interface:
>  	Value type: <string>
>  	Definition: Must contain "mclk", "mclk2" and "slimbus" strings.
>  
> +- qcom,mbhc-vthreshold:

Needs unit suffix.

> +	Usage: Optional, only required if headset button support required.
> +	Value type: <u32 array>
> +	Definition: Must contain an array of 8 threshold voltages in mV for
> +		 8 buttons detection on headset.
> +
> +- qcom,hphl-jack-type-normally-open:
> +	Usage: Optional, only required if headset button support required.

It's not required if the pin is NC, right?

> +	Value type: <boolean>
> +	Definition: present if hphl pin on jack is a NO (Normally Open).
> +		If not specified, then its assumed that hphl pin on jack
> +		is NC (Normally Closed).

Is the not specified case the more common case? If not, it should be.

> +
> +- qcom,gnd-jack-type-normally-open:
> +	Usage: Optional, only required if headset button support required.

Same here.

> +	Value type: <boolean>
> +	Definition: present if gnd pin on jack is NO (Normally Open).
> +		 If not specified, then its assumed that gnd pin on
> +		 jack is NC  (Normally Closed).
> +
>  - vdd-buck-supply:
>  	Usage: required
>  	Value type: <phandle>
> -- 
> 2.18.0
> 
