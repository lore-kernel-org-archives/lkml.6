Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421E1C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0353B213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0353B213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeJDNe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:34:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34093 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeJDNeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:34:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so7350420ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 23:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PF6hkwS/6KZafQP8NdaZtWsywcVegS7mj0D2PfRSjT0=;
        b=kK5g5wCBYNii+HjeCAjWOicPPzsunPg6hDPoWXpSAxq1SO3ZRRL9A5OR1FFuQO31OF
         DVqPd6SFMNfcr0G8a0/4JIAtc1Pmv1dqg+uCw6SVbQxn5mBnsUDrKAiPk8lSASxXb8GJ
         2Y8wQcIBEZNG1hNdP9MeTEq0QUNTgQKKlSe8l9mKdrv73xrSlZGDhIczMZMc8UNt8MuF
         D6FBg3e7h26iUKE5oFdhpj/rD3lCn403RMWdxWC2rntgPfpnPtw4tZhAL4RjkGhvVElN
         Wh6Xnfm5L3nCuFbhuueyhXWRGCBHSAlbaci8NOJykCqPyzTUW+teTvaaWV+Q1u3pUm3W
         PnVQ==
X-Gm-Message-State: ABuFfojhTnSfI5PwesiiozsqbKVrSSbGK7lxWGKBL9rq3xIEyRJ0gZ/Y
        qMdfKK094s+KFMjZ0UvEBa4=
X-Google-Smtp-Source: ACcGV61jVS2HVnO7MaM436Q6AK4WXoHSk36uw9nTGO+NzsNaho3PqsVsNEorIUNvC5IIwRSenjng5Q==
X-Received: by 2002:a2e:6c0c:: with SMTP id h12-v6mr941327ljc.112.1538635360659;
        Wed, 03 Oct 2018 23:42:40 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g68-v6sm845150lje.44.2018.10.03.23.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 23:42:39 -0700 (PDT)
Date:   Thu, 4 Oct 2018 09:42:22 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: bd718x7: Remove struct bd718xx_pmic
Message-ID: <20181004064222.GA2029@localhost.localdomain>
References: <20181003153246.26756-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003153246.26756-1-axel.lin@ingics.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Axel,

On Wed, Oct 03, 2018 at 11:32:46PM +0800, Axel Lin wrote:
> All the fields in struct bd718xx_pmic are not really necessary.
> Remove struct bd718xx_pmic to simplify the code.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> v2:
> Sorry, just update the subject line.
> 
>  drivers/regulator/bd718x7-regulator.c | 59 +++++++++------------------
>  1 file changed, 20 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
> index d2522d4e1505..3a47e0372e77 100644
> --- a/drivers/regulator/bd718x7-regulator.c
> +++ b/drivers/regulator/bd718x7-regulator.c
> @@ -15,13 +15,6 @@
>  #include <linux/regulator/of_regulator.h>
>  #include <linux/slab.h>
>  
> -struct bd718xx_pmic {
> -	struct bd718xx_regulator_data *rdata;
> -	struct bd718xx *mfd;
> -	struct platform_device *pdev;
> -	struct regulator_dev *rdev[BD718XX_REGULATOR_AMOUNT];
> -};

You should then also remove the references to struct bd718xx_pmic from
include/linux/mfd/rohm-bd718x7.h. Now we have there:

struct bd71837_pmic;
struct bd71837_clk;

struct bd71837 {
        struct device *dev;
        struct regmap *regmap;
        unsigned long int id;

        int chip_irq;
        struct regmap_irq_chip_data *irq_data;

        struct bd71837_pmic *pmic;
        struct bd71837_clk *clk;
};

Other than that - simplifications are always welcome.
Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

