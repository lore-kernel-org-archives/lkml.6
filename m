Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39D4C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8E32172F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8E32172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeH0JTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 05:19:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35213 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeH0JTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 05:19:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so11281433ljg.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 22:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JCyIVjn02BCwLfHzoNkeibsbnxSpFtBAsaG9DiieFu4=;
        b=WTbUMulRrrxSKTb7n5wtW0wsi0plHrqrhceHZmy8FUwL5qG6TzM1qKV6H0a06oY7l4
         Lhu/NtLXK2uIXiy9mChMAftrwplXWDxFkGJBL9HxqLdJUELSSNozr6K2oXpLeJ9lSDRO
         CqhtYjBw+XDwdaPqO0kVTcf/WeRlK9a9hk2d8wt8qlqSUdQR2XM7U6RfMzW0gP12uC8U
         p7ykaaqmlj0ktOrq+ve0FYO2WmGjK7vM1gMD90LIgsn0um/3MghWpha4jGIzjJQy/O00
         UBGuUBtF8EkBBYWtyOQdDYxIPUuSyzSb4lqNTzmft4fdWFqUHN76VPZ/DM3WZ0f1Yu8d
         Zvdg==
X-Gm-Message-State: APzg51ColaUbV1eDk+bGyB9WqfTaYS0LbUMfL87Q2UEE2xaObOwxU87r
        xGN3sus/TdkdlRvjPgzAxto=
X-Google-Smtp-Source: ANB0VdZ02rgJyEKjPsJq1JEa6assCH0TAuIbWB089aSCIJviOr7kHuuR0dreNonWoETTFha8RIIsmA==
X-Received: by 2002:a2e:9698:: with SMTP id q24-v6mr6425313lji.35.1535348078714;
        Sun, 26 Aug 2018 22:34:38 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id l1-v6sm2539243lji.41.2018.08.26.22.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Aug 2018 22:34:37 -0700 (PDT)
Date:   Mon, 27 Aug 2018 08:34:30 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: bd71837: Remove duplicate assignment for
 n_voltages of LDO2
Message-ID: <20180827053430.GA2448@localhost.localdomain>
References: <20180824111612.24622-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824111612.24622-1-axel.lin@ingics.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Axel,

On Fri, Aug 24, 2018 at 07:16:12PM +0800, Axel Lin wrote:
> Set it once is enough.
> Also move n_voltages close to volt_table for better readability.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/bd71837-regulator.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd71837-regulator.c
> index 0f8ac8dec3e1..9b5e1297902f 100644
> --- a/drivers/regulator/bd71837-regulator.c
> +++ b/drivers/regulator/bd71837-regulator.c
> @@ -388,10 +388,9 @@ static const struct regulator_desc bd71837_regulators[] = {
>  		.ops = &bd71837_ldo_regulator_nolinear_ops,
>  		.type = REGULATOR_VOLTAGE,
>  		.volt_table = &ldo_2_volts[0],
> +		.n_voltages = ARRAY_SIZE(ldo_2_volts),
>  		.vsel_reg = BD71837_REG_LDO2_VOLT,
>  		.vsel_mask = LDO2_MASK,
> -		.n_voltages = ARRAY_SIZE(ldo_2_volts),
> -		.n_voltages = BD71837_LDO2_VOLTAGE_NUM,
>  		.enable_reg = BD71837_REG_LDO2_VOLT,
>  		.enable_mask = BD71837_LDO_EN,
>  		.owner = THIS_MODULE,
> -- 
> 2.17.1
> 

This is how it should have been in the first place!

Br,
	Matti Vaittinen
