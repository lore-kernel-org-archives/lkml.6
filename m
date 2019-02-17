Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BD4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23F12192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="R1GGl6x3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfBQKBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 05:01:10 -0500
Received: from vern.gendns.com ([98.142.107.122]:54782 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfBQKBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 05:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ee2s5d7l6e2sMjJzKOgeJLb3Jl5nBh4pZLvnPxu9/bE=; b=R1GGl6x3KwpB/Pkcrw8udGrYYH
        9lMF2pEXn6Nxn9xut3pT4sPzs0FqUr7lsm+mOqmei2odFybpQ3BN94I+asA4gWpyS+F9wc0ipznYN
        KA9fHKLnWELOwdz8ATq1K7jGAAGI6FIX3W1DmKPsawyz4nOODVZXlKWH+yZ+6pvXmSDOhZEd90SG0
        UsGzUlHH+QEiBf/M/ZMNk4m1jZi6J1P8kMJrQMnxM7A8vh41L8JrzwEUfS7F4VJ+VddKz2VRX8Ksx
        yFIvPiOH9qubwgIHA6t1CkwEcB+16rePoz0+GS9OiOaXeJsV+d8GmJpcYlUer3z8bDMXIb2kzCdV2
        oufcOOrA==;
Received: from [185.122.190.68] (port=28456 helo=gerda-5.local)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gvJFq-0000vN-52; Sun, 17 Feb 2019 05:00:58 -0500
Subject: Re: [PATCH v4 33/37] ARM: davinci: cp-intc: use
 readl/writel_relaxed()
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190214145231.8750-1-brgl@bgdev.pl>
 <20190214145231.8750-34-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <681a7831-8c20-d634-a1cb-04064e3077b8@lechnology.com>
Date:   Sun, 17 Feb 2019 11:01:05 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214145231.8750-34-brgl@bgdev.pl>
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

On 2/14/19 8:52 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Raplace all calls to __raw_readl() & __raw_writel() with readl_relaxed()

s/Raplace/Replace/

> and writel_relaxed() respectively. It's safe to do as there's no
> endianness conversion being done in the code.

Should this be combined with patch 14/37?

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/cp_intc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
> index 1bf11fa8be76..f88b7f0978aa 100644
> --- a/arch/arm/mach-davinci/cp_intc.c
> +++ b/arch/arm/mach-davinci/cp_intc.c
> @@ -45,13 +45,13 @@ static struct irq_domain *davinci_cp_intc_irq_domain;
>   
>   static inline unsigned int davinci_cp_intc_read(unsigned int offset)
>   {
> -	return __raw_readl(davinci_cp_intc_base + offset);
> +	return readl_relaxed(davinci_cp_intc_base + offset);
>   }
>   
>   static inline void davinci_cp_intc_write(unsigned long value,
>   					 unsigned int offset)
>   {
> -	__raw_writel(value, davinci_cp_intc_base + offset);
> +	writel_relaxed(value, davinci_cp_intc_base + offset);
>   }
>   
>   static void davinci_cp_intc_ack_irq(struct irq_data *d)
> 
