Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B79C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9592520841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETDWXnk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9592520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbeHAUZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:25:13 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40610 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732304AbeHAUZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:25:12 -0400
Received: by mail-qk0-f195.google.com with SMTP id c126-v6so13383488qkd.7;
        Wed, 01 Aug 2018 11:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7R9diKTCxKBXRKujOdAehWoOniwHGJ1eIcX3+Rd8fQo=;
        b=ETDWXnk3KMtCO0Q2YCqJD5nWr6xez3sMK3V7CSHMTbOZTFWoL7z1g+PKWp+cuaTy1n
         JZx3VTCKsHS5eVli8sNiehWjdnjyS/7OjIPAWfn//kKokXDOhSqIHwCjjryjK37I23Ry
         uLMrNNfnS+HYvqcTongtyqbAO44mv3DgcQD2uE0vSATFYXp1n8Q7Qn01cPGptvWdCHwQ
         90s8xE9AyKucTPHYY0E4/vMGF1hFfKeX25Afwl0rXAcYEmOBH5gwyyAmvsoQn4iB3IS9
         sc4UJYmDixHvWGKobgU4IHh1QGK8syaXrSYBNDg3ZKwgeDgcmFwafDPUgsP+fqR99Jf2
         215g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7R9diKTCxKBXRKujOdAehWoOniwHGJ1eIcX3+Rd8fQo=;
        b=Mwz8HA8/mZRd2p+GufXaT+JEocBrnvEaYGzkGS+ZujW0O0WSSs+QfNkYiOgi/KBQwo
         K+x0OTsRun3LrRSSdImO1q+/9AjrXdXj3VFjd0iMPJ/wtFeaiswSTtMBfslbwB/hsxGq
         dAHZWFktx0Uhf0KNj0WZ8GC8U0XA2T8+lGS0jW9QDoWKraAyUGitXvT05TYgPvpUrTwm
         NopP0j2joy+OVdqoC9BZrosRlGX6ujvSGIyeNOwi5SkYDUcorP3+wFShZAgclC47v7H/
         G65s3ENUiBydn2E/vkyoAVGdz2e+2w1gbMTlaQMr/f+QI5yKGH52l7KYXoHdUejGnyt+
         7wBA==
X-Gm-Message-State: AOUpUlEFdZngH8HuPDO07FWpNOQhmoEvUD1v7Soe00LzoGw3PETJcLQe
        dc1C1o5dy+NCD84VZ6O+cCE=
X-Google-Smtp-Source: AAOMgpfccdhOqIadcckvWn/D7GrlcB/efxZ9jpJxwIJZEgf7FoAjm2j6sJQw5TpKHoiw7HwmTX+r1w==
X-Received: by 2002:a37:7b45:: with SMTP id w66-v6mr25471603qkc.39.1533148687059;
        Wed, 01 Aug 2018 11:38:07 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id o26-v6sm15150636qtk.4.2018.08.01.11.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 11:38:05 -0700 (PDT)
Subject: Re: [PATCH v3 5/8] net: phy: Use devm api for mdio bus allocation in
 bcm iproc mdio mux
To:     Arun Parameswaran <arun.parameswaran@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533146186-8374-6-git-send-email-arun.parameswaran@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <e1adee03-3ee0-300c-af3e-32e52ef2965d@gmail.com>
Date:   Wed, 1 Aug 2018 11:37:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533146186-8374-6-git-send-email-arun.parameswaran@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 10:56 AM, Arun Parameswaran wrote:
> Use devm_mdiobus_alloc() instead of mdiobus_alloc() in the Broadcom
> iProc mdio mux driver.
> 
> Also, clear the driver data on error from probe or when remove() is
> called.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> ---
>  drivers/net/phy/mdio-mux-bcm-iproc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
> index c36ce4b..5640d78 100644
> --- a/drivers/net/phy/mdio-mux-bcm-iproc.c
> +++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
> @@ -198,7 +198,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  		return PTR_ERR(md->base);
>  	}
>  
> -	md->mii_bus = mdiobus_alloc();
> +	md->mii_bus = devm_mdiobus_alloc(&pdev->dev);
>  	if (!md->mii_bus) {
>  		dev_err(&pdev->dev, "mdiomux bus alloc failed\n");
>  		return -ENOMEM;
> @@ -217,7 +217,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  	rc = mdiobus_register(bus);
>  	if (rc) {
>  		dev_err(&pdev->dev, "mdiomux registration failed\n");
> -		goto out;
> +		return rc;
>  	}
>  
>  	platform_set_drvdata(pdev, md);
> @@ -226,6 +226,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  			   &md->mux_handle, md, md->mii_bus);
>  	if (rc) {
>  		dev_info(md->dev, "mdiomux initialization failed\n");
> +		platform_set_drvdata(pdev, NULL);

This is minor, but I don't think this is necessary, the core device
driver layer does that already.

>  		goto out_register;
>  	}
>  
> @@ -236,8 +237,6 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  
>  out_register:
>  	mdiobus_unregister(bus);
> -out:
> -	mdiobus_free(bus);
>  	return rc;
>  }
>  
> @@ -247,7 +246,7 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
>  
>  	mdio_mux_uninit(md->mux_handle);
>  	mdiobus_unregister(md->mii_bus);
> -	mdiobus_free(md->mii_bus);
> +	platform_set_drvdata(pdev, NULL);

Likewise.

>  
>  	return 0;
>  }
> 


-- 
Florian
