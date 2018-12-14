Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6E5C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D0C2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2D21m7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbeLNW3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:29:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50826 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeLNW3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:29:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so7093517wmd.0;
        Fri, 14 Dec 2018 14:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uAaP4jVStVp4MUgrxkDDuXre0XdfMO7PrAfUyw0/N34=;
        b=c2D21m7leRBVex++bCFf7t7X3A3WKuHXnOtFoopw9TByr2p/o5/48IUd0aLSvytUhG
         qgVF2RWmlBB8KwHhmWitNMqMkmgk+pyes3aH5Pkg7KrVY315WoUFjnh1oJCnCwAE+NJ2
         RMvAewDCL41t1Qt//EvMh5P83pX4YfDc47vJxILTh4hEQ7qfQdWpUpFAJC7gAAix+xR+
         EWLOS8XFVXycL7vlKYqQEWSHSK2LFSIoIv5Lg6Xv8/LhrcVJB1aHTxlHvxMYoJ19r3uR
         3c1eb1p2JD2OpYIgrpOsar/BVaO6vdC4R6/1vJQhsHVHvycjpOrnutS3Dq3PXUjEKlEA
         ZWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uAaP4jVStVp4MUgrxkDDuXre0XdfMO7PrAfUyw0/N34=;
        b=Wff3IvQf7y72TjdI4ViEmr2C2jdGXGcNuq0BvsXnHE9z9/stLd4cKcqRbuCyQRJJu+
         YONayfSm9WqWqSrf7m409lTE3I86bGVZXRx5ryiLMhEiVflEBj/0pA2W1s0SEa/UjKMm
         8ZoHAbwPE3o5jRN7/y+QhDQm4GgK2LMLF1FwCuEqJSTiRP9GR5nfANHpcvyTZE5vg8Pe
         CKfOiLbQI8i95CUDf7XLg3Cubpd0WawJ5+EqVp8q+tvR/suz93i3PAPlB705LV3lJRu6
         c35ex2alJs5olpJSHs8Rc9lyU5BjAn3cGlMvoUxwJbZLp8CJkFxlXutpMRM9WQ3sZBYU
         ur1A==
X-Gm-Message-State: AA+aEWbxB8QboWKi99GiUsf4csOU80TMlLbjRWDH+54uxlQOKro6yl6m
        TbPg2yVzAT3nRrZHI5VLPYrllAHw
X-Google-Smtp-Source: AFSGD/W1E1t2xDMHR+ArhLPP1DnN+0ZJbTugoHN8h1LVU1jtILWkgKkxC/rQqngsfHXOJDtrhRBahQ==
X-Received: by 2002:a1c:de57:: with SMTP id v84mr4443721wmg.55.1544826572483;
        Fri, 14 Dec 2018 14:29:32 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id c7sm11260619wre.64.2018.12.14.14.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 14:29:31 -0800 (PST)
Subject: Re: [PATCH] clk: vc5: Initialize src in vc5_mux_set_parent()
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Alexey Firago <alexey_firago@mentor.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org
References: <20181214214959.162744-1-sboyd@kernel.org>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <c1065c2f-3e7e-e2c4-a9f5-e672e86beb43@gmail.com>
Date:   Fri, 14 Dec 2018 23:29:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181214214959.162744-1-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/2018 10:49 PM, Stephen Boyd wrote:
> It seems that it may be possible to get to the regmap update call
> without ever initializing this variable, so just set it to 0 to be safe.
> 
> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Alexey Firago <alexey_firago@mentor.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk-versaclock5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
> index 5b393e711e94..026f76276933 100644
> --- a/drivers/clk/clk-versaclock5.c
> +++ b/drivers/clk/clk-versaclock5.c
> @@ -246,7 +246,7 @@ static int vc5_mux_set_parent(struct clk_hw *hw, u8 index)
>  	struct vc5_driver_data *vc5 =
>  		container_of(hw, struct vc5_driver_data, clk_mux);
>  	const u8 mask = VC5_PRIM_SRC_SHDN_EN_XTAL | VC5_PRIM_SRC_SHDN_EN_CLKIN;
> -	u8 src;
> +	u8 src = 0;
>  
>  	if ((index > 1) || !vc5->clk_mux_ins)
>  		return -EINVAL;

Can you rather change the else { } branch in that function such that it does

 if (vc5->clk_mux)ins == ...)
  ...
 else if (...)
  ...
+ else
+  return -EINVAL;

The last bit would assure the function would fail in case the
clk_mux_ins == 0, which can happen if someone builds a setup without any
clock into connected to the VC5 (which would not work hardware-vise).

-- 
Best regards,
Marek Vasut
