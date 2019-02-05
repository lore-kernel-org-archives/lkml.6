Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3740CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F882083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="baffNN5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfBECSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 21:18:43 -0500
Received: from vern.gendns.com ([98.142.107.122]:51146 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbfBECSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 21:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8yKYhikQZxCUa/cCc0k1fLcffd+7gOuz7prbBCzKXrw=; b=baffNN5q3Q/aiNryDJRQaOooJP
        OJKUJUiGzX2IZm0+MlVdeh21v43M7OI8ApJOmjOdwWEeZ5cSWR9c5I2j4r10oH84lTtfpdH8vFCI8
        EXmZgqVW38jiW06rDLzm1gvXBUokTRxl5yN0/AmRSFTfIHmOza4PyiDo9QeKJ3G7UQ71rt+aZ1xPu
        Z2p6k4372eh8tjDouLYFXTC6tVQ+e9Gpr1OqnpSxqyczuPOUicDOL67gJRPg4EbaVTvSYvN4Zwc4t
        +Pe1fKXM8bfKHGUM1p0I8MLy735I5sfIdH8XkQUOUuJMUI9+a6BLgFHjEiZMmmjpfpNYfaFGF8o6E
        FrDEEx+Q==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:34230 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqqGO-0004Oe-Mm; Mon, 04 Feb 2019 21:15:04 -0500
Subject: Re: [PATCH v2 04/12] ARM: davinci: WARN_ON() if clk_get() fails
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-5-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <0750392d-e298-b467-24c0-3c2779ead3f7@lechnology.com>
Date:   Mon, 4 Feb 2019 20:18:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204171757.32073-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/19 11:17 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Currently the timer code checks if the clock pointer passed to it is
> good (!IS_ERR(clk)). The new clocksource driver expects the clock to
> be functional and doesn't perform any checks so emit a warning if
> clk_get() fails. Apply this to all davinci platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/da830.c  | 4 ++++
>   arch/arm/mach-davinci/da850.c  | 4 ++++
>   arch/arm/mach-davinci/dm355.c  | 4 ++++
>   arch/arm/mach-davinci/dm365.c  | 4 ++++
>   arch/arm/mach-davinci/dm644x.c | 4 ++++
>   arch/arm/mach-davinci/dm646x.c | 4 ++++
>   6 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
> index 2cc9fe4c3a91..9a4b749cbb6b 100644
> --- a/arch/arm/mach-davinci/da830.c
> +++ b/arch/arm/mach-davinci/da830.c
> @@ -834,6 +834,10 @@ void __init da830_init_time(void)
>   	da830_pll_init(NULL, pll, NULL);
>   
>   	clk = clk_get(NULL, "timer0");
> +	if (WARN_ON(IS_ERR(clk))) {
> +		pr_err("Unable to get the timer clock\n");

Do we really need a warning _and_ an error?

> +		return;
> +	}
>   
>   	davinci_timer_init(clk);
>   }
