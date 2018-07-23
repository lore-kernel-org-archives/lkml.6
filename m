Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BA5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BED20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rIJeXQ17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BED20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388657AbeGWQhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:37:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387995AbeGWQhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5IXRtWXaq6L5zdIsaVQ/kgbb/8qd9m/llUYiwmaSINg=; b=rIJeXQ17oAqZieRWEltJrebJ2
        TekrLl8JFyqxoMZbvb980PFHvKbM4ysDXFxKDHoSbcijnhDlndmqUF+Qi/lM67ETWrGeZ3ODdFVsE
        j16W65XifjMoR23HAdt8FBFEXjvX9vg5QoAoOb22jS8zMSo9+F4LXbOUDXpa/HlyVI47llMam6xHY
        Dufrmc0LePRyozzImxYK0O/N4zUGa7TGDqABJgVG+rhrHgQkXy6gEV9GZ57zT+eSnW1Q868KP2Ugo
        3G/6Lz00iY5V1ss5kjKq2oiuxyvFwU7uM5tdDcQ9QhsnXw7VrYMYK1XZfQpJsS1ZdVEXddXatTJ7P
        b5WXJG22w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhcsJ-0006fA-79; Mon, 23 Jul 2018 15:35:51 +0000
Subject: Re: [PATCH] memory: jz4780-nemc: build depend on OF
To:     Corentin Labbe <clabbe@baylibre.com>, Zubair.Kakakhel@imgtec.com,
        gregkh@linuxfoundation.org, alex@alex-smith.me.uk
Cc:     linux-kernel@vger.kernel.org
References: <1532345923-28811-1-git-send-email-clabbe@baylibre.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3660b849-930f-8771-21d7-9f3e63789d13@infradead.org>
Date:   Mon, 23 Jul 2018 08:35:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532345923-28811-1-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 04:38 AM, Corentin Labbe wrote:
> jz4780-nemc use of_ functions, so it needs to depend on OF
> 
> This fix the following build failure on x86
> drivers/memory/jz4780-nemc.c: In function ‘jz4780_nemc_num_banks’:
> drivers/memory/jz4780-nemc.c:72:10: error: implicit declaration of function ‘of_read_number’ [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/memory/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index a642552..faa1a23 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -124,6 +124,7 @@ config JZ4780_NEMC
>  	default y
>  	depends on MACH_JZ4780 || COMPILE_TEST
>  	depends on HAS_IOMEM
> +	depends on OF
>  	help
>  	  This driver is for the NAND/External Memory Controller (NEMC) in
>  	  the Ingenic JZ4780. This controller is used to handle external
> 

Duplicate of https://lore.kernel.org/lkml/20180721200049.7553-1-anders.roxell@linaro.org/


-- 
~Randy
