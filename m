Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6687C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7085A205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C6JzWE84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394306AbfAPQtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:49:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40364 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387470AbfAPQtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tXzm4ZFqfrJ3uxaZyYtK0O94wiawvIETUKwH6LKXs98=; b=C6JzWE84Ii85zGmedOZY58cdbL
        A4DnSupfuvYwbS3e7qaWL4tpcik3IyH2fLDMHZBF6dJOGYAxikYs43/r83R/VDbnWsn9wU8uIrrTW
        Gqe9SK2zQCzKdkOCndMqfL0jqoaCe+braWDgx445e5pnv2NozKMLJ1DCC2o4yxljkHk84ENFDa8eE
        bmSGU1MobWdLVprVKd7LJqnfgAJ3RP96LD4cu+vGZSZR20cz+WUoJRcdgHuHrFRJsjRAt8LBPpGLE
        sZae/YdhaA39Hq7PPS8z4Y+4kcRm122L/c9g5dOAFaNEgSVXukwxcGhBbkuj8fmsvg73VVn2b97Jg
        PtJGAjMA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjoNM-0002SK-O1; Wed, 16 Jan 2019 16:49:13 +0000
Subject: Re: [PATCH] clockchips: convert the code format to BIT()
To:     Yangtao Li <tiny.windzz@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
References: <20190116160900.20771-1-tiny.windzz@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dc8270f2-a500-5067-4535-11edadc6c7a4@infradead.org>
Date:   Wed, 16 Jan 2019 08:49:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190116160900.20771-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 8:09 AM, Yangtao Li wrote:
> Use BIT() to do some clean-up.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Hi,

Looks to me like this header file needs to
#include <linux/bitops.h>
and not assume that the bitops.h header file will be pulled in
by some side effect.

> ---
>  include/linux/clockchips.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
> index 8ae9a95ebf5b..39a2294e995b 100644
> --- a/include/linux/clockchips.h
> +++ b/include/linux/clockchips.h
> @@ -43,9 +43,9 @@ enum clock_event_state {
>  /*
>   * Clock event features
>   */
> -# define CLOCK_EVT_FEAT_PERIODIC	0x000001
> -# define CLOCK_EVT_FEAT_ONESHOT		0x000002
> -# define CLOCK_EVT_FEAT_KTIME		0x000004
> +# define CLOCK_EVT_FEAT_PERIODIC	BIT(0)
> +# define CLOCK_EVT_FEAT_ONESHOT		BIT(1)
> +# define CLOCK_EVT_FEAT_KTIME		BIT(2)
>  
>  /*
>   * x86(64) specific (mis)features:
> @@ -53,19 +53,19 @@ enum clock_event_state {
>   * - Clockevent source stops in C3 State and needs broadcast support.
>   * - Local APIC timer is used as a dummy device.
>   */
> -# define CLOCK_EVT_FEAT_C3STOP		0x000008
> -# define CLOCK_EVT_FEAT_DUMMY		0x000010
> +# define CLOCK_EVT_FEAT_C3STOP		BIT(3)
> +# define CLOCK_EVT_FEAT_DUMMY		BIT(4)
>  
>  /*
>   * Core shall set the interrupt affinity dynamically in broadcast mode
>   */
> -# define CLOCK_EVT_FEAT_DYNIRQ		0x000020
> -# define CLOCK_EVT_FEAT_PERCPU		0x000040
> +# define CLOCK_EVT_FEAT_DYNIRQ		BIT(5)
> +# define CLOCK_EVT_FEAT_PERCPU		BIT(6)
>  
>  /*
>   * Clockevent device is based on a hrtimer for broadcast
>   */
> -# define CLOCK_EVT_FEAT_HRTIMER		0x000080
> +# define CLOCK_EVT_FEAT_HRTIMER		BIT(7)
>  
>  /**
>   * struct clock_event_device - clock event device descriptor
> 

ciao.
-- 
~Randy
