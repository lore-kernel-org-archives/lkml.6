Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB98AC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3A4208CE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="kRULKBmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3A4208CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754312AbeGGV02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 17:26:28 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:50505 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753447AbeGGV01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 17:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EuxCpa6oNI4RCMeTOQFR6mbXsOnyRzeQUYM7yHG+5yA=; b=kRULKBmbNtqZarjr6kOMSkkLSE
        j3gQ+DrgF73ASHfiYZd/aal9XdE2udu4sxcsIJpKp6OLPR9XVs48XNoT8gjHqooRspK83zUdGUC1q
        /bDsWPJ66LagyQ8/rmLzWgC/6Uo6HJqw/JD82OPUYzVgqXAR+53ZHoI3RQd0r/TCxeP5rVOViNw1A
        qfthTWU+wXskVxHotJlKsC4Rr2KXxcEPWEMruLng5al3FAOns1zjpbRcyMIPAEQTpSLqoWFJKjgjr
        OAYQjcMUuZtHMDhP6CkBFXhIWpsY324GP/WjN2wJ2DgH7E7eZXuwgKGyCl6m7JsvDieEs5YQnQ6kr
        JnbwH+/g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:43786 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fbuin-00GiR3-98; Sat, 07 Jul 2018 21:26:25 +0000
Date:   Sat, 7 Jul 2018 14:26:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     wim@linux-watchdog.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] watchdog: stm32: replace "%p" with "%pK"
Message-ID: <20180707212624.GC1951@roeck-us.net>
References: <20180706130808.22466-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706130808.22466-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:08:08PM +0200, Benjamin Gaignard wrote:
> The format specifier "%p" can leak kernel addresses.
> Use "%pK" instead.
> 
The pointer has zero value either way. If the clock has a name,
it might make sense to display it. Otherwise just drop the pointer.

Guenter

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/watchdog/stm32_iwdg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index c97ad5619cb0..740f74a98644 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -172,7 +172,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
>  
>  	ret = clk_prepare_enable(clk);
>  	if (ret) {
> -		dev_err(&pdev->dev, "Unable to prepare clock %p\n", clk);
> +		dev_err(&pdev->dev, "Unable to prepare clock %pK\n", clk);
>  		return ret;
>  	}
>  
> -- 
> 2.15.0
> 
