Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC81CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A09320850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RUF6zoWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A09320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeLCSGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:06:53 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49620 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeLCSGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PHMwcboEr5y8iZqZKXK4xq+yzNV3AdJh02+hNPX31+I=; b=RUF6zoWBOjvmjw4uODz8dePUo
        1RHgxJ7IzA0jEo7OlQQ8f8SdDtQcBr7nr8zYeYZYu2+sOsEARicXd4UtLjrZ8LBrpTe64+Sx/xgMW
        PSxJ4ccVaX1Rt0wyd6gnVPC2gMFZ0NsDcfN1Wc3CogN8VTArwamxaKu460VFkD3TRRZH8=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:54393)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gTsbp-0001Dr-8E; Mon, 03 Dec 2018 18:06:17 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gTsbm-0001r9-EF; Mon, 03 Dec 2018 18:06:14 +0000
Date:   Mon, 3 Dec 2018 18:06:12 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, cw00.choi@samsung.com, krzk@kernel.org,
        b.zolnierkie@samsung.com, andy.gross@linaro.org,
        david.brown@linaro.org, pavel@ucw.cz, andrew.smirnov@gmail.com,
        lee.jones@linaro.org, pombredanne@nexb.com, sjhuang@iluvatar.ai,
        akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/9] clkdev: add managed clkdev lookup registration
Message-ID: <20181203180612.GM30658@n2100.armlinux.org.uk>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
 <b6c5c110c482ff6a6b2378ab3518bd31c6233872.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c5c110c482ff6a6b2378ab3518bd31c6233872.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 03, 2018 at 02:17:56PM +0200, Matti Vaittinen wrote:
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 9ab3db8b3988..68a1e55a60d2 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -401,6 +401,25 @@ static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
>  	return cl;
>  }
>  
> +static int do_clk_register_clkdev(struct clk_hw *hw,
> +	struct clk_lookup **cl, const char *con_id, const char *dev_id)
> +{
> +

No need for this blank line.

> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +	/*
> +	 * Since dev_id can be NULL, and NULL is handled specially, we must
> +	 * pass it as either a NULL format string, or with "%s".
> +	 */
> +	if (dev_id)
> +		*cl = __clk_register_clkdev(hw, con_id, "%s",
> +					   dev_id);

Please move "dev_id);" onto the line above.

> @@ -420,20 +439,10 @@ int clk_register_clkdev(struct clk *clk, const char *con_id,
>  {
>  	struct clk_lookup *cl;
>  
> -	if (IS_ERR(clk))
> -		return PTR_ERR(clk);
> -
> -	/*
> -	 * Since dev_id can be NULL, and NULL is handled specially, we must
> -	 * pass it as either a NULL format string, or with "%s".
> -	 */
> -	if (dev_id)
> -		cl = __clk_register_clkdev(__clk_get_hw(clk), con_id, "%s",
> -					   dev_id);
> -	else
> -		cl = __clk_register_clkdev(__clk_get_hw(clk), con_id, NULL);
> -
> -	return cl ? 0 : -ENOMEM;
> +	if (!IS_ERR(clk))
> +		return do_clk_register_clkdev(__clk_get_hw(clk), &cl, con_id,
> +					      dev_id);
> +	return PTR_ERR(clk);

Please keep this as:

	if (IS_ERR(clk))
		return PTR_ERR(clk);

	return do_clk_register_clkdev(__clk_get_hw(clk), &cl, con_id,
				      dev_id);

rather than inverting it - it makes it more consistent with code elsewhere.

> +static int devm_clk_match_clkdev(struct device *dev, void *res, void *data)
> +{
> +	struct clk_lookup **l = res;
> +
> +	if (!l || !*l) {
> +		WARN_ON(!l || !*l);

How can "l" be NULL here?  How can *l be NULL?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
