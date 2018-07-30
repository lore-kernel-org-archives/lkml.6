Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5D6C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D30120894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0+XyJjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D30120894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbeGaAaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:30:22 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39901 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeGaAaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:30:21 -0400
Received: by mail-pl0-f66.google.com with SMTP id m1-v6so6203870plt.6;
        Mon, 30 Jul 2018 15:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F5MzJ9EXhzbr/hoFSUaiJlIhuHxcYWGO7SaD6kkyNuc=;
        b=C0+XyJjfSfuIsPThSJzGFpaDViZlI3trtct0TtgC21MwRUCKljdha0z5NW8JEf0SNa
         mgF1GpYPwAYbo4lSNqsfTZww2+BrYjMsiYYNyQzc1KCuVCJCuRWM8is9/IJirvFmc59a
         +0CKUtY75K9ZxM1iKS/AvN46ABSpSZh/gSLs042s8cL978w/qzgcfSzj7eOX2MK+LlvM
         RIa056SNjlRc4SCCF9Pw884yj89EShMwRr5VX8VOG4izoDytdv2fzOKXr+364doUhO7s
         6RnRjYiipECMxtFyWi+jzTO1DENJU5ulAQ5UhfcJrU/fa0VEbg77W9I7B8XWUMzQ0oQ1
         1OtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F5MzJ9EXhzbr/hoFSUaiJlIhuHxcYWGO7SaD6kkyNuc=;
        b=fVHYN/SsaRAZAKJqHZZ8AhiDoIaVmSJywHaNYS46IVjvE8TAmNJ4XwFWEQiD+yoo+p
         i5wJ23ZKKw0+B/Ipy3EDm67Jn9fTPY7W+ZCXCQdh3TKDeDvK4Rnxes/gMdBEMH3f9HqP
         wCSu8BdHFPd8Zd+cmKJdop5rb7h8cdvqe6K+w76tKefT2rwqSeEzhzhbw4lKtfcli8vE
         hamUu4kIhdgegSrBKJgSlIZCd4vYMPoPHOJFLt28n1LCnsJM+scxhNSHzXe/J8Gyv0U5
         GlPuxWgcyfOY7XLOZKVjZZM/goT3HzvFJsCoKcw41zS8aBaKw12JAvnVkFy2REfsCTG2
         mQnQ==
X-Gm-Message-State: AOUpUlEwABdHtfYOv31V6NaqOYApCgZlUnG1MKTT/jNv6jqMvc8hO54V
        yaW2kbiD33p+fF2tPTP0nEU=
X-Google-Smtp-Source: AAOMgpdbIg6ggqwlOnyx6hkK1Whe+d7S4/iQhi3Ep+iveQER3jWmNYtSzqrDfNsfLIN0srkqQoVCHg==
X-Received: by 2002:a17:902:7683:: with SMTP id m3-v6mr17806815pll.255.1532991189299;
        Mon, 30 Jul 2018 15:53:09 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id i62-v6sm19198968pge.66.2018.07.30.15.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 15:53:08 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] net: phy: Add pm support to Broadcom iProc mdio
 mux driver
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
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-8-git-send-email-arun.parameswaran@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <8d732031-c5e8-d6ea-5b61-3b9baf79796f@gmail.com>
Date:   Mon, 30 Jul 2018 15:53:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532726613-6483-8-git-send-email-arun.parameswaran@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/2018 02:23 PM, Arun Parameswaran wrote:
> Add support for suspend and resume to the Broadcom iProc mdio
> mux driver.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> ---
>  drivers/net/phy/mdio-mux-bcm-iproc.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
> index 51d1003..d89dce0 100644
> --- a/drivers/net/phy/mdio-mux-bcm-iproc.c
> +++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
> @@ -290,6 +290,33 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int mdio_mux_iproc_suspend(struct device *dev)
> +{
> +	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
> +
> +	if (md->core_clk)
> +		clk_disable_unprepare(md->core_clk);

Since you are assigning md->core_clk to NULL in case clk_get() returned
an error, checking for md->core_clk is not necessary since the Linux
common clock framework perform that NULL check already.
-- 
-- 
Florian
