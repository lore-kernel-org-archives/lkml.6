Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25B5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DB020881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rsalveti-net.20150623.gappssmtp.com header.i=@rsalveti-net.20150623.gappssmtp.com header.b="Uc4MSbbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DB020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rsalveti.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeIOAJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 20:09:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38852 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbeIOAJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 20:09:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id p6-v6so8338615ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 11:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rsalveti-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRjnGRS1bYLyzAXtzY1UvPUuddUnYex/3I0zOxiWEL4=;
        b=Uc4MSbbqYHC589cCx6sYo0FOQhc5TDJeegaNYWnD0qfosTowW8rC8BzXlFCwh7H5el
         yp2GyiqAg2jQDWWF9HwnzT9YJEUl16sw+Yw3/jGzWZvn4NB52XoffbIlvnkBecBMbqK0
         aittLgVOrT+3NOcjbqsNDA6+DkJkJQpJxpvoSw5yG+NkmYHxSTupjumXd2c3Pcpmss8J
         0Oj5DXhQfJJD3Dk1RoRDVUck36LhbLrjiSKiKT08d1Sj2XVPyjo9McjlFLKALA9Ewyta
         WmRCrX/HmTtVL8mz2/uxDEUEC9qNGa+STvk1n6NcOZNxM2fNBR6ri5SP8XeFuyQgS6gB
         4hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRjnGRS1bYLyzAXtzY1UvPUuddUnYex/3I0zOxiWEL4=;
        b=Xj9XBnT8SlyImjC7/hax5Sy7BUCjH01mSwlDqNsibKy/1K3xRT+2smsYTQm0bLaVMn
         J6oZ04NtDc8xpAzr4fMzb4cxIqrSlKuw/nnvqiJ7pi964RwTKU74Z+PX0R0qcHEhL0Bw
         28SGh9XK2g2W8e0PBIQnGct3SgftmOByozxauInWvQQhE29fOHzGBXprF5/fs5eb5t6B
         z3aQt+fNLI4viQ/iv0o+8FDZWeYwndo/DrY/d7rAzTKsoDFG10GemxTRv7MpfBmFOUYi
         CiMyAh9kWGl7Ceqme7DIcukuS6hC+499lqsfTpT0t5STr+IodxXu49oIkkFAHgHPbAks
         Ejeg==
X-Gm-Message-State: APzg51BJAoht8WcTXt20udp6z1CcoJ4LaQvLw662Qic/DLRCemivZJPq
        PSYr2q/YVSJFF0NTgngFuj5N5SaA9jGag6m345wpuw==
X-Google-Smtp-Source: ANB0VdaJZwC6yKIZvOKXTOEECl3PReTg3VygEoLBBC2MdrZfHcMcCanAr1WJRMRmf9LSUOw6WpTO8zBJ3oexpcQWfsI=
X-Received: by 2002:a2e:80d3:: with SMTP id r19-v6mr8479635ljg.85.1536951219386;
 Fri, 14 Sep 2018 11:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180614215358.11264-1-ilia.lin@gmail.com> <20180614215358.11264-4-ilia.lin@gmail.com>
In-Reply-To: <20180614215358.11264-4-ilia.lin@gmail.com>
From:   Ricardo Salveti <rsalveti@rsalveti.net>
Date:   Fri, 14 Sep 2018 15:53:02 -0300
Message-ID: <CAHYQr0rR=mcV-SxZFW+5M4CTUaTv_f_bruyq91HiGP6sqUZ3Yw@mail.gmail.com>
Subject: Re: [PATCH v13 3/8] clk: Use devm_ in the register fixed factor clock
To:     ilia.lin@gmail.com
Cc:     ilialin@codeaurora.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, will.deacon@arm.com,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 6:55 PM <ilia.lin@gmail.com> wrote:
>
> From: Ilia Lin <ilialin@codeaurora.org>
>
> Use devm_clk_hw_register instead of clk_hw_register
> to simplify the usage of this API. This way drivers that call
> the clk_hw_register_fixed_factor won't need to maintain
> a data structure for further cleanup.
>
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/clk/clk-fixed-factor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> index a5d402de5584..8e39bda8e596 100644
> --- a/drivers/clk/clk-fixed-factor.c
> +++ b/drivers/clk/clk-fixed-factor.c
> @@ -94,7 +94,7 @@ struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
>         init.num_parents = 1;
>
>         hw = &fix->hw;
> -       ret = clk_hw_register(dev, hw);
> +       ret = devm_clk_hw_register(dev, hw);

Not sure what is the current state of this patch-set, but this change
breaks drivers calling clk_hw_register_fixed_factor with a NULL dev
(e.g. imx_clk_fixed_factor), as devm_clk_hw_register needs a valid dev
for devres_add to work.

>         if (ret) {
>                 kfree(fix);
>                 hw = ERR_PTR(ret);
> --
> 2.11.0

Cheers,
-- 
Ricardo Salveti de Araujo
