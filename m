Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075FEC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C347B2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhrxAclS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C347B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbeJASsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:48:10 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55203 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbeJASsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:48:10 -0400
Received: by mail-it1-f193.google.com with SMTP id l191-v6so5288439ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mvQWpUWByAtFZ0uS5TN96o85tM2AzhZHOgFcHg5lgBI=;
        b=jhrxAclST+6AzFbAY+lNJa0/AtOqPCqi6PzawwZJp0ZmOW/qwJVSiTx6OAN/aD3kf9
         qZ8ikG7nkBbuv1oMwbGd4jISTlTsg+Iq3snANo7NYhGwZJvjzeIWWJXgVpQECbcMfzCI
         DOm4OzlFetRK0+2jx0mlPJtXP6TCMinRWrG2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mvQWpUWByAtFZ0uS5TN96o85tM2AzhZHOgFcHg5lgBI=;
        b=MyoCfU6WLKYCaWQgVHAZTg/dK5vSSJoVrz4FSygIfyHxvevMXyvu/8QOnXqyHXf8RN
         Wuxf6sK0oDLuQl1NvMDAlMVxh3wtxd5KOWb5OVV+/rb+UNwv4iVRKKxVSZ0NQNfP3WZB
         as33Rym4/KK24fagkw9QeyTxe3qkK5L3QsCQLMrE8IxnNpA57c/URbraeGxmwd9vph+4
         Zp1ujMk9+AAwXynVBplJPT00q/yk4m6xJnnCR5BHkBMBaVGv2tTNFowrW+0sfRFORRN/
         lQu3UafIU6QC9/tMhAONSkgpai0GF0jvin3METKLv94u3xfRrcx72Yyh9h/n5qdGm0MY
         R3Qg==
X-Gm-Message-State: ABuFfog7r9MxbTeTvKLXGAl/8FfZ0AbVpp0slbeWgImjSjVURMEY4kQX
        KKtNmFo1f+5PxFhU2cRf1k9ERTuG+Xw=
X-Google-Smtp-Source: ACcGV61NJ4vn+gx519lXo2eO4+oSNNRtBEIYyuqGfTOXAx+efEbJsdeq/Ww87sVJTP68Husr73KtVA==
X-Received: by 2002:a24:d507:: with SMTP id a7-v6mr10338247itg.7.1538395840370;
        Mon, 01 Oct 2018 05:10:40 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id w8-v6sm5324862itb.0.2018.10.01.05.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 05:10:39 -0700 (PDT)
Subject: Re: [PATCH] slimbus: ngd: QCOM_QMI_HELPERS has to be selected
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     bjorn.andersson@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20181001101116.27281-1-niklas.cassel@linaro.org>
From:   Alex Elder <elder@linaro.org>
Message-ID: <02cd4893-ff58-a1ee-bf60-44cc29c21dec@linaro.org>
Date:   Mon, 1 Oct 2018 07:10:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001101116.27281-1-niklas.cassel@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2018 05:11 AM, Niklas Cassel wrote:
> QCOM_QMI_HELPERS is a hidden kconfig, so the proper usage is
> to select it, not depend upon it.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/slimbus/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
> index 9d73ad806698..9cca2c3559f2 100644
> --- a/drivers/slimbus/Kconfig
> +++ b/drivers/slimbus/Kconfig
> @@ -22,8 +22,8 @@ config SLIM_QCOM_CTRL
>  
>  config SLIM_QCOM_NGD_CTRL
>  	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
> -	depends on QCOM_QMI_HELPERS
>  	depends on HAS_IOMEM && DMA_ENGINE
> +	select QCOM_QMI_HELPERS
>  	help
>  	  Select driver if Qualcomm's SLIMbus Satellite Non-Generic Device
>  	  Component is programmed using Linux kernel.
> 

