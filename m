Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA25C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479CC20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="COplA6en"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479CC20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935031AbeFRKvh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:51:37 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37747 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932612AbeFRKvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:51:35 -0400
Received: by mail-pf0-f194.google.com with SMTP id y5-v6so7965448pfn.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 03:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Egvan1XyZ7FGCwZLdqypInvGyX6TjoGIN8CY0tIhQbA=;
        b=COplA6enWxN1ZBhooQEbtRPdjnZ+q9GPM13X2/HUmj7MiV15w2PbsF/jk+l0b7NJyF
         j84bulVw2uKq/kp+h0sMiNZzr+158XuBrJA7QFu62ft2GdjJfKzBmd/z8xli2H3u3ucx
         rB8UCTr9TYKcdtbz2J4n4Fzb9vss1zQoEcDio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Egvan1XyZ7FGCwZLdqypInvGyX6TjoGIN8CY0tIhQbA=;
        b=pN6d8uBwMO/WMmPQ7SgpDLo09aZhEG4GqKU8B6nZnIqN5Ni0AZ7lJ3e4YJ72v7xc4z
         /XdNEI4J7FYZHlyjPmL0dpxguTjjGzLYbzvn594Kgl46Df1RKAZudwI5pmP8L57m8FNS
         i+YwNYfLbXKS6/VvohM4fPGsg9l1pJbTkFxdTxDmH3gFw30JKXMPNi06WrLavI4PDRSC
         cDqzMEaJWXZesnFVSbbI8ynZ5DdOyuOKILa3UKFifkQlUdmkhPFHWHtWAFgGjMf+Pt7Y
         juI3UpilCuMl9NHw4X+wtyWCgFJ81uBStMkJ0MfmIsCdqfIYYBtL77ss2NSF/lL4jpam
         umLA==
X-Gm-Message-State: APt69E0sL4PsnGIRg+tMK6o4IW1K91Hdei3BoPHUQvXpBOv7Jzu6zIov
        QBTR69SgwsjFexd36GRH/AZSHQ==
X-Google-Smtp-Source: ADUXVKJufwrJZTCUm05WamtBqYrOwdjliaTj22J2+7KRlqZIoqUWchiBHFBLKt8tX/58I7tSS8jgZA==
X-Received: by 2002:a65:4a51:: with SMTP id a17-v6mr10616815pgu.168.1529319095250;
        Mon, 18 Jun 2018 03:51:35 -0700 (PDT)
Received: from localhost ([122.171.103.96])
        by smtp.gmail.com with ESMTPSA id s75-v6sm35934079pfj.125.2018.06.18.03.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 03:51:34 -0700 (PDT)
Date:   Mon, 18 Jun 2018 16:21:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / OPP: Update voltage in case freq == old_freq
Message-ID: <20180618105132.xky2ayan7q24jsp3@vireshk-i7>
References: <20180614135609.20574-1-waldemar.rymarkiewicz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614135609.20574-1-waldemar.rymarkiewicz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-06-18, 15:56, Waldemar Rymarkiewicz wrote:
> This commit fixes a rare but possible case when the clk rate is updated
> without update of the regulator voltage.
> 
> At boot up, CPUfreq checks if the system is running at the right freq. This
> is a sanity check in case a bootloader set clk rate that is outside of freq
> table present with cpufreq core. In such cases system can be unstable so
> better to change it to a freq that is preset in freq-table.
> 
> The CPUfreq takes next freq that is >= policy->cur and this is our
> target_freq that needs to be set now.
> 
> dev_pm_opp_set_rate(dev, target_freq) checks the target_freq and the
> old_freq (a current rate). If these are equal it returns early. If not,
> it searches for OPP (old_opp) that fits best to old_freq (not listed in
> the table) and updates old_freq (!).
> 
> Here, we can end up with old_freq = old_opp.rate = target_freq, which
> is not handled in _generic_set_opp_regulator(). It's supposed to update
> voltage only when freq > old_freq  || freq > old_freq.
> 
> if (freq > old_freq) {
> 		ret = _set_opp_voltage(dev, reg, new_supply);
> [...]
> if (freq < old_freq) {
> 		ret = _set_opp_voltage(dev, reg, new_supply);
> 		if (ret)
> 
> It results in, no voltage update while clk rate is updated.
> 
> Example:
> freq-table = {
> 	1000MHz   1.15V
> 	 666MHZ   1.10V
> 	 333MHz   1.05V
> }
> boot-up-freq        = 800MHz   # not listed in freq-table
> freq = target_freq  = 1GHz
> old_freq            = 800Mhz
> old_opp = _find_freq_ceil(opp_table, &old_freq);  #(old_freq is modified!)
> old_freq            = 1GHz
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index ab2f3fe..31ff03d 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -598,7 +598,7 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
>  	}
>  
>  	/* Scaling up? Scale voltage before frequency */
> -	if (freq > old_freq) {
> +	if (freq >= old_freq) {
>  		ret = _set_opp_voltage(dev, reg, new_supply);
>  		if (ret)
>  			goto restore_voltage;

Applied with:

Fixes: 6a0712f6f199 ("PM / OPP: Add dev_pm_opp_set_rate()")
Cc: 4.6+ <stable@vger.kernel.org> # v4.6+

Thanks.

-- 
viresh
