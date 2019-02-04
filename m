Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8645DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA9E2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="xUK0yY4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfBDWck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:32:40 -0500
Received: from vern.gendns.com ([98.142.107.122]:35034 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfBDWck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=c5a+DhB4fFRi20eTBRlbGs3mejq5cz+PvuGy8QjZFfg=; b=xUK0yY4U9P/6fCEAac0Q9yNziS
        YKpq9hMmIbVAiINR2hhwo+Cuox4QNHvKmZ2MiI1akcU1i2Z0iAxPwpgatp6BEvjIUnnW0tDiaSgoX
        6E+1umcpbbngoEa7Yaf17P6L6NXmhxUL0Lh9h4ksD8vrBHPcziUNwdjGRyau7FQAS6uPao+PqA+4q
        RrQgMMfgfXb9eSV6V5JWoJ1jT4AvtSiiOg6/CprA4gFBie2pP8J043fsQ0k/q1trAdrDNEYhdgGLL
        TRemD6bXTXUlrVYyY52Xl+T203nM77VfQicGrlQ9Kitkt49+HW8w/idtzeBUNkY2HzYQbD19WzNiF
        XG9qaFTw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:58228 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqmje-00021c-Os; Mon, 04 Feb 2019 17:29:02 -0500
Subject: Re: [PATCH 06/35] ARM: davinci: wrap interrupt definitions with a
 macro for SPARSE_IRQ
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-7-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <b06cd3b4-b960-15cb-1bf4-f389e18248ac@lechnology.com>
Date:   Mon, 4 Feb 2019 16:32:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-7-brgl@bgdev.pl>
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

On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This is done in preparation for selecting CONFIG_SPARSE_IRQ. The
> interrupt numbers will then start at the predefined NR_IRQS offset.
> 
> For now wrap all interrupt numbers with a macro and define
> DAVINCI_INTC_START to 0. Logically nothing changes for now.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

> diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/include/mach/irqs.h
> index 03c446635301..14fa668d4e8d 100644
> --- a/arch/arm/mach-davinci/include/mach/irqs.h
> +++ b/arch/arm/mach-davinci/include/mach/irqs.h
> @@ -30,371 +30,374 @@
>   /* Base address */
>   #define DAVINCI_ARM_INTC_BASE 0x01C48000
>   
> +#define DAVINCI_INTC_START		0
> +#define DAVINCI_INTC_IRQ(_irqnum)	(DAVINCI_INTC_START + (_irqnum))

Almost not worth mentioning, but DAVINCI_INTC_START is only
ever used once, so it could be omitted.
