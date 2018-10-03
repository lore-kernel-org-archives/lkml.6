Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D1DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A172089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNzpwQLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A172089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeJDAcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:32:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35037 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeJDAcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:32:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so7096751wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g+O+OFij2my0awpdYPqPJMt3Sgs+WM1e3rQ7IgVxQjU=;
        b=WNzpwQLSgW9LgNpo+xTFTuhI6lh3VnCEouA3jvWpYgByRzjUCSjh3YgfZto7sJIFcl
         kPWtoWBb42VPAk8+6EuZuC0HkBLxqi26xrkJJSxcPffabsTvkmAPhebSfcHeoty9mcpL
         Tyf0rVLYKzxsHrKB0L0h5CBNU/Ldy6CCG2IWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g+O+OFij2my0awpdYPqPJMt3Sgs+WM1e3rQ7IgVxQjU=;
        b=pmzRhpr9o04EL5MDNYnjBwu3fOV9dxfBQ/bbdA6hrOiwfjHht+oCBFmv0vf5amMKE9
         uFmfmy7MxmmEv7sxAsalmI2Lbn2wL+uM4S46u2OBc8WLarGSqR8zEsR+AjGlCHlNperA
         oHBW4XECZAshaqg1Hmh7S/a2eOnV06wbGVV5u3sq3HWN+LsltRwO2E92pVc63TwGJ0Fh
         66TppXsX9WumanLNcdec/EKHCVTu5DFqiRF81i4kI8H7Coi7laE9/bMOeKDTZnoBNpnB
         HEFea4n/nymGXQlXtO4bifMTu6KLZWn5u9uA754XpsjKag/7nzja42+UO7ukUrNEsag9
         NSNA==
X-Gm-Message-State: ABuFfojVfcyjm0Zq2/mbrQs5Wl0dOStsbH4nu3kW4MG2gwKXSehWs2ut
        KcChXnBUC5q5ogJy6Fp8qTI7lw==
X-Google-Smtp-Source: ACcGV61NWv3dXQ09ahbI357+DojMtOt8r9v4XMPlnIZlIwukPGkSEyXZzIXSNkvS1WLL3Im/rI5RlA==
X-Received: by 2002:adf:e607:: with SMTP id p7-v6mr2138250wrm.254.1538588577473;
        Wed, 03 Oct 2018 10:42:57 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 143-v6sm3229157wmv.6.2018.10.03.10.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 10:42:56 -0700 (PDT)
Subject: Re: [PATCH v2] nvmem: lpc18xx_eeprom: remove unused variable
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <greg@kroah.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20181003072430.20966-1-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e51fd8aa-50bc-569b-4523-fc34ab0f5355@linaro.org>
Date:   Wed, 3 Oct 2018 18:42:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181003072430.20966-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/10/18 08:24, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Remove a variable that's no longer used from lpc18xx_eeprom_remove().
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
> v1 -> v2:
> - added the Reported-by tag
> 
>   drivers/nvmem/lpc18xx_eeprom.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
> index b42dbaddb419..66cff1e2147a 100644
> --- a/drivers/nvmem/lpc18xx_eeprom.c
> +++ b/drivers/nvmem/lpc18xx_eeprom.c
> @@ -255,7 +255,6 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
>   static int lpc18xx_eeprom_remove(struct platform_device *pdev)
>   {
>   	struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
> -	int ret;
>   
>   	clk_disable_unprepare(eeprom->clk);
>   
> 
