Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31094C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E8B20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLWmOomL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E8B20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387959AbeHAU1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:27:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37998 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387618AbeHAU1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:27:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so8304615pfh.5;
        Wed, 01 Aug 2018 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cMGv6HIv+8fIXjftzc5RafosjzHXxwJg9TaV91GDe7o=;
        b=gLWmOomLyfVJspSl8jCWonbb6G6P3NpkcU1M9GY1WrGjnovMuH7Vrn9XWtNctg5Gjs
         lIfsHpgOagsfoKhlbxzYm1HDSIAMF3Wlh2BIDQ1sh6ciPviZ6E/rRD1k2NO8I4zP6Bul
         SSTJGNg7FS78ixbSCeMOcKSLHAqT/MGEYlw9qWX8HqVg4+3w0FnBzvecE6Kp6tbNO9Mj
         HcBWNDW0ZuhCdEI5VzakAXilXuk+0otRh69ueSpD5hsCXCWB7OV36jXAI8DxcjphOZBI
         Wi01H9fwowDdaWxxhidNJnYs7eIuyI1hWmnmm5Cl8alabFRU8sdYqDDaiDiK/s4C6Aen
         azcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cMGv6HIv+8fIXjftzc5RafosjzHXxwJg9TaV91GDe7o=;
        b=hVfyUg52CzHrTKHsxqgC2wUSTQvSPJoNRN+CJ6SyI6zNLeUUa3kQQcRDxpq//WFAhr
         cGesrXR44qZppxw61MbeLN4i+jWL5K5k89UOa/gkPBMrC//oFWWe+83vQxhMsdX4NDSO
         1OR4QXcS6JTrZXxlJae1ljVnUTmk8OyUzZnB1giX2gCv/JZCiNOtZzNVCZ0WGLANc4Zh
         sAPKQbObNfRLB7iJX/UyF9Ds2ogy3XQ2H6j0jP9WaAWL6P8e17nH5lLmRDSyKoU2j1XK
         2J6g4zN1w6RcMH2E/ORBIrMZY3LTxAPyyQa+a2YizLECg3SAVpJ57UcJZSe/n7rIz+IG
         zKBg==
X-Gm-Message-State: AOUpUlGLjU4+ZoNPirGRgIkJRUm3H1kLWsnPeou53hK3lOz84vTteJCy
        FGopvc0mPotGH0LX+O9yR6gL6XOz
X-Google-Smtp-Source: AAOMgpdDAetMghEDHsBM79P3Pn5PUgg0asL0lk8COK2fI5yxOVuWU+tx4YfQpuu9a3tU6fdzsdrOHw==
X-Received: by 2002:a62:5dd7:: with SMTP id n84-v6mr28219833pfj.68.1533148838618;
        Wed, 01 Aug 2018 11:40:38 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id z90-v6sm35016657pfk.85.2018.08.01.11.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 11:40:37 -0700 (PDT)
Subject: Re: [PATCH v3 7/8] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
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
 <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <0cc6db4f-7008-0ad3-58d7-9e93060f152f@gmail.com>
Date:   Wed, 1 Aug 2018 11:40:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 10:56 AM, Arun Parameswaran wrote:
> Add support to configure the internal rate adjust register based on the
> core clock supplied through device tree in the Broadcom iProc mdio mux.
> 
> The operating frequency of the mdio mux block is 11MHz. This is derrived
> by dividing the clock to the mdio mux with the rate adjust register.
> 
> In some SoC's the default values of the rate adjust register do not yield
> 11MHz. These SoC's are required to specify the clock via the device tree
> for proper operation.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> ---

[snip]

>  static int iproc_mdio_wait_for_idle(void __iomem *base, bool result)
> @@ -204,6 +225,20 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> +	md->core_clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(md->core_clk)) {
> +		if (PTR_ERR(md->core_clk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		md->core_clk = NULL;

I would simplify this a bit:

	if (IS_ERR(md->core_clk) && PTR_ERR(md->core_clk) == -EPROBE_DEFER)
		return PTR_ERR(md->core_clk);
	else
		md->core_clk = NULL;

	rc = clk_prepare_enable(md->core_clk);

and continue that way.

> +	} else {
> +		rc = clk_prepare_enable(md->core_clk);
> +		if (rc) {
> +			dev_err(&pdev->dev, "failed to enable core clk\n");
> +			return rc;
> +		}
> +	}
> +
>  	bus = md->mii_bus;
>  	bus->priv = md;
>  	bus->name = "iProc MDIO mux bus";
> @@ -217,7 +252,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  	rc = mdiobus_register(bus);
>  	if (rc) {
>  		dev_err(&pdev->dev, "mdiomux registration failed\n");
> -		return rc;
> +		goto out_clk;
>  	}
>  
>  	platform_set_drvdata(pdev, md);
> @@ -237,6 +272,8 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  
>  out_register:
>  	mdiobus_unregister(bus);
> +out_clk:
> +	clk_disable_unprepare(md->core_clk);
>  	return rc;
>  }
>  
> @@ -246,6 +283,7 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
>  
>  	mdio_mux_uninit(md->mux_handle);
>  	mdiobus_unregister(md->mii_bus);
> +	clk_disable_unprepare(md->core_clk);
>  	platform_set_drvdata(pdev, NULL);
>  
>  	return 0;
> 


-- 
Florian
