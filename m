Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24EEC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E27206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvg9UXJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfAIVWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:22:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34976 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfAIVWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:22:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so9166615wrb.2;
        Wed, 09 Jan 2019 13:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HieqPFu/h0vY5Opn+/BucoOr9IvuvEBhl2J+ZDqVL98=;
        b=Gvg9UXJU4VZmhajJVpHYtUg4M4y+T5rsXYpGPSMkz/2MK4jnkPCyF69QM9yztnN97y
         K5o40mI1pI0WJl2u+akfM0Rx+ktmF+yVZL5U4ovJmqi3T1TS5xTTdVeGzaFZM2utAHLM
         VbQCY5J9bMg9qb2XJZVtJ4WwJ5jOabqhQPR+UWnuvCoVaBADGH06rvK5es5c+/OFOtcm
         UPBqZQSX7IHJRevccA/fzQhE3PqHqgM1Cebrgld0QaD9rKVJBozhRS4svfRldwI58Wkk
         HgoeN7BJIPznKVgP9qud8A+Y2R0qbbdHvpFEr+0JXKaZu11Sa6/Q6594BtnMp4jleqXN
         PmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HieqPFu/h0vY5Opn+/BucoOr9IvuvEBhl2J+ZDqVL98=;
        b=o/diphe18hs1oXgjHEi5bBXOU6VY+wqT/ZKz0OyyNhgYJ2SNN/Ipe5fwUE6EAJ2Twg
         z8PeqAHhAgyU3I2XEr7w4yoWcN90MWKddeV2W36Pi+4APfL+yBp8JuliJPWa4H9GEJ7w
         2iPyBRj74hRLxOF9xTtz3JD8mEOhcS4XV0Fadywo+vhgvLWM5nUOaBhe7j6WwUy34/08
         MzEVSOtAaB/gByARA9POjPy0ZA+nDlDUfPS9ICLL2UaCTKjZ60ugpAlNgSvDgKEGVjy0
         nxcm0gVgs8BzM7Ce1uYrrboUqs1OEWND4Ue7vWD8u/U2BGiRp98yIu89hKlBviojgIaJ
         VwjQ==
X-Gm-Message-State: AJcUukdutW57x6TxeLyDHqUoK6xmU14XvbJE492kIqA6qAIaH3ERV5Bh
        zBHdb3kt/wfrA7mF6PlK9cQnyEf+
X-Google-Smtp-Source: ALg8bN5zk6GQ/+lXPhtMSRt2ggBddwwCbCaiQ2xJP9jsCDVxJfI7R14wRg8DfGJ0vTYDNBvh329q1A==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr6369213wrw.311.1547068927843;
        Wed, 09 Jan 2019 13:22:07 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id a12sm62776164wro.18.2019.01.09.13.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 13:22:07 -0800 (PST)
Subject: Re: [PATCH] clk: Fix a missing check on regmap_bulk_read
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181224190032.23167-1-pakki001@umn.edu>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <dc74d564-8db7-a270-5bc3-44993a966f82@gmail.com>
Date:   Wed, 9 Jan 2019 22:22:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181224190032.23167-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/18 8:00 PM, Aditya Pakki wrote:
> Currently, vc5_pll_recalc_rate() may produce incorrect output when
> regmap_bulk_read() fails. The fix checks the return value of the
> latter function and returns 0 in case of failure.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/clk/clk-versaclock5.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
> index decffb3826ec..cd76a893c594 100644
> --- a/drivers/clk/clk-versaclock5.c
> +++ b/drivers/clk/clk-versaclock5.c
> @@ -413,7 +413,8 @@ static unsigned long vc5_pll_recalc_rate(struct clk_hw *hw,
>  	u32 div_int, div_frc;
>  	u8 fb[5];
>  
> -	regmap_bulk_read(vc5->regmap, VC5_FEEDBACK_INT_DIV, fb, 5);
> +	if (regmap_bulk_read(vc5->regmap, VC5_FEEDBACK_INT_DIV, fb, 5))
> +		return 0;

Shouldn't this return ret on failure ?

>  	div_int = (fb[0] << 4) | (fb[1] >> 4);
>  	div_frc = (fb[2] << 16) | (fb[3] << 8) | fb[4];
> 


-- 
Best regards,
Marek Vasut
