Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4E7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD94320851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxwAWU8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD94320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbeKTLZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:25:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33021 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbeKTLZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:25:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so151916lfc.0;
        Mon, 19 Nov 2018 16:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m3xtSWFe6yH84IBjhTRuS0BH5P2f4B2dZH/KnDAhNtI=;
        b=WxwAWU8n8/2fVPDcLooGycGPE/MPKOzVUUgGOUbGBTYc4cpnZF5XE8PT4mEuUb3vVY
         uXogpLPPn6FgUDj0GixcdvVU7op9L+PVps9aLavQXxW76wZyU9xEwoKInxEw1cjKI7ms
         5ADPFT7FRyeXtmZsN+pBqUpSoMZSL+CyPhYmg+RiA+TIazSY9X+h6hkEn4jaqBnZ8tCa
         xJ27hOPViDWfdNa83VHwcjwW1EmhRdHQXC+7qtMiT5dIZVZOzJIYrq7M2A9Br5F6tfhN
         nko7IvKcR7jdLexaSaKX3WXWTre1NAsu9rOf5vNGnp0EPa+5ID7xvRqvlS2OHxqW5bwv
         HQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m3xtSWFe6yH84IBjhTRuS0BH5P2f4B2dZH/KnDAhNtI=;
        b=IzNRHGZ1xwxGB6GIhTCLSD2u9YBXhH815gxJJmPekDyzghrbZBgXYrifL6GG1plXDS
         iH3Ld0rwCnj+YsAi5CnLJ4sTAHeoxo+Q+NT1P30taXwslMPR8j3qxQ58Qd2tnuoUKzsp
         +SITmgJa4potkB+xon4Z0e9GGwj3sjOdwASpIiLqOx8MkBoUJgdgakgq18PgTJDpU8Fe
         syfbM102+X9QVkGFUJPey1JPk2r79ZTi8yYGy7dxFUlPXEseB17YURwtkkvB13/YB/Yd
         cHCJBoC4hgO7Rgxb8M8NgqkgGvK5Zil59C5mXZbVGGvQxyXt29yuN4yYccmyqq6IbJac
         CKeg==
X-Gm-Message-State: AGRZ1gIO8kkP1XQzVbGFjYGhK0YNCas3N94q/NICb5yaji+h6XMCrcEk
        O/39rEn620wXGgEt9vLpphgaMBi3
X-Google-Smtp-Source: AJdET5dxafNGLrmcfuzm5Tr62ZS641MVW8VdcrEMazAwzJvzeatV3mzuEi7pSQCU6rHWUn0MobrnBA==
X-Received: by 2002:ac2:4215:: with SMTP id y21mr5814546lfh.6.1542675537150;
        Mon, 19 Nov 2018 16:58:57 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.googlemail.com with ESMTPSA id k14sm5797101lfc.70.2018.11.19.16.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 16:58:56 -0800 (PST)
Subject: Re: [PATCH 7/7] regulator: core: Remove loop disabling supplies in
 regulator_force_disable()
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, evgreen@chromium.org,
        swboyd@chromium.org, ryandcase@chromium.org,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20181120002654.1891-1-dianders@chromium.org>
 <20181120002654.1891-7-dianders@chromium.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3c226e1e-f707-c005-8c46-c0445f60a9a8@gmail.com>
Date:   Tue, 20 Nov 2018 03:58:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120002654.1891-7-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.2018 3:26, Douglas Anderson wrote:
> In regulator_force_disable() there was a strange loop that looked like:
> 
>   while (rdev->open_count--)
>     regulator_disable(rdev->supply);
> 
> I'm not totally sure what the goal was for this loop, but it seems
> wrong to me.  If anything I think maybe we should have been looping
> over our use_count, but even that might be a little strange.  For now
> let's just remove the code and we can add something back in if someone
> can explain what's expected.
> 
> Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")

Seems this "fixes" tag is incorrect, isn't it? The "ww_mutex" patch didn't touch this code.


> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/regulator/core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 2eda87520832..963081aba17a 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -2738,10 +2738,6 @@ int regulator_force_disable(struct regulator *regulator)
>  
>  	regulator_unlock_dependent(rdev, &ww_ctx);
>  
> -	if (rdev->supply)
> -		while (rdev->open_count--)
> -			regulator_disable(rdev->supply);
> -
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(regulator_force_disable);
> 

