Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC57EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8830C20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FzNMCQXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8830C20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbeIYVnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:43:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:32956 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbeIYVnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lBJ/UPRWVek//Y9HUJbkvjUroz8CGbDpiFFpf7IBPLA=; b=FzNMCQXwVOiKGtsE8+717J01UE
        CfCWjO/FuKshuwUBqFP13loX4m+KUgL9qIUKzHLZbUuBxxMAVM2e007fTbHWwWzKpTfjlJrWLGEKy
        1hb5MCSD3YTxwO8+cokgfi/Svrgxu9vaTQRMMfypZygqKEXwMhoMalO8dqTeUF7b9giiRrQgy/XyU
        2EabpGWduX2G0QbrlqUkjFdbjDv2SHcJ6CUfrGFQT9O7CCUVmoQSeLLE1b5vkwpyHKzkHSnUWUXhG
        rByqnftcwDrXE+rGzjGqPuugdLK8iqFaPUeTZXjoYasuGjwRWorWsKI4CdUQbuSIfr0brDVTCcFCN
        zl2pXGWQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4pMN-0002JA-55; Tue, 25 Sep 2018 15:35:07 +0000
Subject: Re: [PATCH] staging: dgnc: Fix Kconfig help header and text
To:     sehro rautenkranz <sehro@sehro.org>, lidza-louina@gmail.com
Cc:     markh@compro.net, driverdev-devel@linuxdriverproject.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180925062001.12273-1-sehro@sehro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d5bb4ab0-42f6-3fd1-006d-670a355e8702@infradead.org>
Date:   Tue, 25 Sep 2018 08:34:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925062001.12273-1-sehro@sehro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 11:20 PM, sehro rautenkranz wrote:
> Replace Kconfig help header and text to match other modules. Issue found
> by checkpatch.
> 
> Signed-off-by: sehro rautenkranz <sehro@sehro.org>
> ---

Hi,

Documentation/process/coding-style.rst says:

Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.


>  drivers/staging/dgnc/Kconfig | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/dgnc/Kconfig b/drivers/staging/dgnc/Kconfig
> index 032c2a795238..c845b357b53d 100644
> --- a/drivers/staging/dgnc/Kconfig
> +++ b/drivers/staging/dgnc/Kconfig
> @@ -2,5 +2,9 @@ config DGNC
>         tristate "Digi Neo and Classic PCI Products"
>         default n
>         depends on TTY && PCI
> -       ---help---
> -       Driver for the Digi International Neo and Classic PCI based product line.
> +       help
> +            Say Y here to enable support for the Digi International Neo and
> +            Classic PCI based product line.
> +
> +            To compile this driver as a module, say M here: the module will be
> +            called dgnc
> 

thanks,
-- 
~Randy
