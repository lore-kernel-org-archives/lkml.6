Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LWrHJffDGltbJwAAmS7hNA
	; Fri, 08 Jun 2018 17:59:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AAE0F607E4; Fri,  8 Jun 2018 17:59:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/JsT6qF"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 13D256074D;
	Fri,  8 Jun 2018 17:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13D256074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752886AbeFHR7R (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:59:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53397 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752623AbeFHR7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:59:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id x6-v6so4742322wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8f0UHoPalfG0TV+1mLVmPOIkCDGI2yfZrvi+KTR7MwA=;
        b=M/JsT6qF5vDgyMDch86pBDApWvxLC62p3ZmPLuA5DPj4pVzlW0DKsdDz9W78YxbW8r
         VRGg3O1B2S9ldaWBBQCIRIedJEe6f9w9PXv5pnb50BGXkWt9Gk1kiAALkOhkBfBkNIMe
         oyydoSiB1wtTevRMMKGj3DVfuZrWjV7fXuZzmxFs+5eRuKc6sbywgBZZi9sHL9eDBRSD
         oaW8lSSipCGHLjrNTHdS/1ie6kj4QJ+Aun7dMZAlPg3bX8hQ+ck1e+8Ts0i90I+3wXc4
         YyTJmUFrZdG0ONy+sMdlsj+bEPTudX/87RtndMXG3a/0rACDEqxqIY3PBLL1j4GK9xXS
         +OLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8f0UHoPalfG0TV+1mLVmPOIkCDGI2yfZrvi+KTR7MwA=;
        b=CyzEXL4XRdV3n+Dhv8hm2R4CFtSBBIW89Bw3sV91KCjJQAQxgRjQH/tUabg5clrHFD
         G5B94rMKSZZJUfjAhnpsw7NKPmrcK+XqCbAnVaQnfOSiQK6EVclldrIe9hyfNf6gEkcX
         PpEZrGO4tcGLIUacos65Rg1Reump3bJIInl/YBFdYNY+D/qNOjiFultOAqKmixUE6V2H
         uUYUrxtywnpo4kmBi3F3LfWBy1m3ZuDQ2FzH6svON4olkWoascXzMjVnLTTmQqT5sCUL
         DC645dBV6dwa8lZm7iVueDA/AOaco9T/HHU9LDdKFC83eG6Z/k8Tbvm3ci3PN3sDAAns
         NX4g==
X-Gm-Message-State: APt69E1icNWMnCjvSvRjLkTkh9UFomK5EYczRj8zb+EK6VFGZiZjDoGg
        FQ/iPFrNSNCwYyLVS0VwC//PzETz
X-Google-Smtp-Source: ADUXVKKF91ZV449jjL2O6FubJnx1vnhIWvYHHT2cEK/z8NytCTD30Y/AsZBz4RUcDvF7EBFS84Df3g==
X-Received: by 2002:a50:d08e:: with SMTP id v14-v6mr7984560edd.182.1528480749795;
        Fri, 08 Jun 2018 10:59:09 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id i22-v6sm5832479edq.83.2018.06.08.10.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 10:59:08 -0700 (PDT)
Subject: Re: [PATCH] phy: phy-brcm-usb-init: Fix power down USB 3.0 PHY when
 XHCI reenabled
To: Jaedon Shin <jaedon.shin@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Al Cooper <alcooperx@gmail.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20180608061015.5399-1-jaedon.shin@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <859be807-ab10-eae6-4e91-222e69c92a5e@gmail.com>
Date: Fri, 8 Jun 2018 10:59:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608061015.5399-1-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 11:10 PM, Jaedon Shin wrote:
> Unset is required to enable USB 3.0 PHY when XHCI reenabled in response
> to setting PHY3_IDDQ_OVERRIDE in uninit().
> 
> Fixes: cd6f769fdea7 ("phy: phy-brcm-usb-init: Power down USB 3.0 PHY when XHCI disabled")
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

This does look valid, Al, can you review this as well? Thanks!

> ---
>  drivers/phy/broadcom/phy-brcm-usb-init.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
> index 1b7febc43da9..29d2c3b1913a 100644
> --- a/drivers/phy/broadcom/phy-brcm-usb-init.c
> +++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
> @@ -962,6 +962,10 @@ void brcm_usb_init_xhci(struct brcm_usb_init_params *params)
>  {
>  	void __iomem *ctrl = params->ctrl_regs;
>  
> +	USB_CTRL_UNSET(ctrl, USB30_PCTL, PHY3_IDDQ_OVERRIDE);
> +	/* 1 millisecond - for USB clocks to settle down */
> +	usleep_range(1000, 2000);
> +
>  	if (BRCM_ID(params->family_id) == 0x7366) {
>  		/*
>  		 * The PHY3_SOFT_RESETB bits default to the wrong state.
> 


-- 
Florian
