Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBBBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20FD20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoPalzHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20FD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbeKTLLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:11:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36354 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbeKTLLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:11:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so151082ljk.3;
        Mon, 19 Nov 2018 16:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1CZATfpfoGixZRfOLfOxe9DR/zdbpCy1xUQAiKTJRqU=;
        b=IoPalzHbqlCzrFgwurzIXMKMJ64BYvPWMbRCGbJH+m5/wRWD8kii9orXvhKimHh/ws
         XD78s3A6mNalZyz3YZS7iYh6HOH2O1+8pE8CVMfQkm840FCwtUZisd1/wj+vq1zbR05U
         ccNs2aq8yEomIqkkgO8HtZRiAzTgYiDyx/+Pvs5YSiaWKLC6PjNYb8BbUgIWJsKVrPME
         yDZpmQnncj1yh9aLQuaeOPLjWn1qPyUJ6MluSKnMW8Z1EuOMNmvDGiMXsb+2wUNYRYp5
         VmcWzeigwSZBywpbBetFMMcoKzqg2/8+XOpVF3O3az5nKla6Bgr5WdIDkwRE2dWO/j/M
         sXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1CZATfpfoGixZRfOLfOxe9DR/zdbpCy1xUQAiKTJRqU=;
        b=XhK61yEtfFTAPWlFH+rvqp14QfI3Ae8LaDAHFphbbJeRBZuvqQOQtQh6a/YsJ4lpv3
         vWXcTtjdF94SsgzNLX/h3VgmNmUZ2pDC+ytbhhINWBwhvUTh4G16/tsJyl43Bbk7zD/K
         h57H/I0bDvxbVVrKK5sJKTP80XJ9tvHFfFxekY/W+xhWC+nkhrRtI5LRCS7BSR01ongB
         te+s5SqLnC0lGbtDiU1rm+JBMDi+yqKDj8TFONxRzIh1wsFBHGRd+Ds0ks3mBUtmd6tx
         xOEE+owUcWkCKE12dLiOzJ7EF4D1fjxhWAGc6i5nAdef32HY1JEgBBfLK9vzmMAnB+kt
         DDSg==
X-Gm-Message-State: AGRZ1gLKqXKPBfOKsAlMMYHD1GPsyQ+IyQqUUKuhz8ywhLrmusbYOvGU
        /8MHkgSIszSjnnc7TKCUTt+ZG8dh
X-Google-Smtp-Source: AJdET5fgiBT7tr991C0ASaRRpoHEyeo16JKZfC7Je2EFQ21Blkb/Ln38GkUIh6+K4JME4oXm98Ejgw==
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr12941964ljs.118.1542674720748;
        Mon, 19 Nov 2018 16:45:20 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.googlemail.com with ESMTPSA id u11sm4200528lfb.85.2018.11.19.16.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 16:45:20 -0800 (PST)
Subject: Re: [PATCH 3/7] regulator: core: Don't double-disable supplies in
 regulator_disable_deferred()
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, evgreen@chromium.org,
        swboyd@chromium.org, ryandcase@chromium.org,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20181120002654.1891-1-dianders@chromium.org>
 <20181120002654.1891-3-dianders@chromium.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5b95059a-055e-ac5d-61f9-dbd14d5592a6@gmail.com>
Date:   Tue, 20 Nov 2018 03:45:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120002654.1891-3-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.2018 3:26, Douglas Anderson wrote:
> In the commit f8702f9e4aa7 ("regulator: core: Use ww_mutex for
> regulators locking") disabling of the supply was moved into
> _regulator_disable().  That means regulator_disable_work() shouldn't
> be disabling since that double-disables the supply.
> 
> Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/regulator/core.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 0052bbc8c531..63a8af1e2256 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -2703,16 +2703,6 @@ static void regulator_disable_work(struct work_struct *work)
>  		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
>  
>  	regulator_unlock_dependent(rdev, &ww_ctx);
> -
> -	if (rdev->supply) {
> -		for (i = 0; i < count; i++) {
> -			ret = regulator_disable(rdev->supply);
> -			if (ret != 0) {
> -				rdev_err(rdev,
> -					 "Supply disable failed: %d\n", ret);
> -			}
> -		}
> -	}
>  }
>  
>  /**
> 

Good catch!

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
