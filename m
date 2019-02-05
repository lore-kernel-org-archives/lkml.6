Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6341AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EF2206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="ZvP/vaVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfBEAj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:39:56 -0500
Received: from vern.gendns.com ([98.142.107.122]:35220 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfBEAjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 19:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+WWmm7yrU817Zr0tDoCRONn2s3MuLKbDqSlsYRYthV4=; b=ZvP/vaVmTPwe8ajeNo1WywoRhB
        X419PzsDslx8M2DSti06RnRVYQOnd1sU/E/gLe/t68akmNkZLjxbfoLQswpGlmeTL/FF9Ch+k8Hlm
        LoRhCAVKT3UEmsE5KwSRs+wjF9oENKw7xotzW6odNmVsbZzJ3e6do7rpAIqRBXePntSFmYExRQOnE
        6JVjBcwArauuInNctAGhN1MEbHpVqmH86SFiqEiw6UU0CWPJ3WuyxwXympry8yhwabmlfySXKpCo2
        2vXGfHWeTF7V/1M0eVNHyDSU2/u2xcbIlCHLC0ggxu51ccuk553KGjDqTOhBH+VD96aO7rSAARwpW
        vYSfMn/w==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:60730 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqoio-0004Y9-Jf; Mon, 04 Feb 2019 19:36:18 -0500
Subject: Re: [PATCH 28/35] ARM: davinci: cp-intc: remove unneeded include
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-29-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <0a5cb74c-baba-36ce-d2b6-03202fe39168@lechnology.com>
Date:   Mon, 4 Feb 2019 18:39:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-29-brgl@bgdev.pl>
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

On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This header is no longer needed. Remove it.

Is there another patch in this series that causes it to no
longer be needed? If so, this patch could be squashed into
that patch.

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/cp_intc.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
> index 8d751318682d..812e49fcaa8b 100644
> --- a/arch/arm/mach-davinci/cp_intc.c
> +++ b/arch/arm/mach-davinci/cp_intc.c
> @@ -21,7 +21,6 @@
>   #include <linux/of_irq.h>
>   
>   #include <asm/exception.h>
> -#include <mach/common.h>
>   
>   #define DAVINCI_CP_INTC_CTRL			0x04
>   #define DAVINCI_CP_INTC_HOST_CTRL		0x0c
> 

