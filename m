Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAFFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B06B205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvYqhRT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfBTBtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:49:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45635 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfBTBtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:49:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id r14so11336129pls.12;
        Tue, 19 Feb 2019 17:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LUhDa3uN2wxB/HADTU0/R4cCXg9H9iwrwjDmvSrH0Q0=;
        b=nvYqhRT/u/hJHEynvgIjJQx+QhcdwoYxGklUT596617wSi8i2rvtvTPZa8/Ctb6cIC
         dpF5+rl6yAMRzT+8z6E2n19N4cYqefNjWwTkibz//nxbDfL2AbV9eo8fKFJJle9M100w
         zkliSla8j+qfLTOitjJ+ZhCnliT16DlMnKGBek7zyS0KHYUwsExUigblSdOWBVGdaoNt
         68APhDCx2Y+8GaJpenr+3CtZfBVRVZVOlPw7no0rTcwoKEvvfZ9mkSVyz33A1EsmU9PN
         syD/Wvp/rdYd1uEp0DfyNuCOEtJigkCqn8J5RMrYKzpAH8oKiNzivlrs3lkchDQ3XAxe
         Iegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LUhDa3uN2wxB/HADTU0/R4cCXg9H9iwrwjDmvSrH0Q0=;
        b=WNENwnRf17ussg9CrXNnftd/zo8//HroAaUfM5ctZE++6hi61jflPA5lWmN+MiSAPl
         fG33Ma7YGv6/YTtvJwKitXLZPvoNNlImkYSXvqli12sceH/Qq1cbrIioMvKq7yeQw5UC
         CeP9lPHOrQhz3igbTwMShB8aGuxSC4W/d+R3wPtlbw/jRRwZluc8pkE+DZYPq/Tm0P29
         MDNK9kLIryT+mntmJ9jmcrhG8w0Pr+kApRjViICB9DdEmfhX1Xv+OmIOaX3i5MyKfjtv
         gBJVnRMg3kSD7hNKsVcFc7ClzOQyeKyoTJJKPxP29hmIqXfVr7TiHxdqexwo/BFB7qKE
         gsGw==
X-Gm-Message-State: AHQUAubL8a6qRefuKc/Nqx7e7cG5/NoFLJWEuSnmYQlXlzFxvv+gKjUP
        +4jwE8iojpBvdnZETI4vDIk=
X-Google-Smtp-Source: AHgI3IaEnR3xRPW956HLD5t0IqZ0pl254mvd4qcsQLBVw6PR49MUMYNAme8PlMCyB80ZdBTSsfiwaw==
X-Received: by 2002:a17:902:b181:: with SMTP id s1mr4685302plr.321.1550627352065;
        Tue, 19 Feb 2019 17:49:12 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id b26sm29806808pfe.91.2019.02.19.17.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 17:49:11 -0800 (PST)
Subject: Re: [PATCH v3] of: unittest: unflatten device tree on UML when
 testing
To:     Brendan Higgins <brendanhiggins@google.com>, robh+dt@kernel.org,
        mcgrof@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190219235422.256847-1-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <3ebcb18e-ffe3-95e5-07b4-950271e3c076@gmail.com>
Date:   Tue, 19 Feb 2019 17:49:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190219235422.256847-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/19 3:54 PM, Brendan Higgins wrote:
> UML supports enabling OF, and is useful for running the device tree
> tests, so add support for unflattening device tree blobs so we can
> actually use it.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/of/unittest.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 84427384654d5..98f0dfc91c2a3 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -2514,6 +2514,10 @@ static int __init of_unittest(void)
>  	int res;
>  
>  	/* adding data for unittest */
> +
> +	if (IS_ENABLED(CONFIG_UML))
> +		unittest_unflatten_overlay_base();
> +
>  	res = unittest_data_add();
>  	if (res)
>  		return res;
> 


Reviewed-by: Frank Rowand <frank.rowand@sony.com>
