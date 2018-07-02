Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD9CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C0B208B7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a86F8JY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C0B208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeGBU2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:28:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeGBU2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O7XZlCdXaKm7ti/uA4ar1X6xxbILziQt5p5EjW1eWSU=; b=a86F8JY9eEYrnYIPqhYYOkZQ/
        Dc4XBZ5MHPyIrfNaATmrr/TxSQxGeUkXPK8Qe8GprkldsBWkRWZZVBEhkiMTqH10CdfUEBSduLQ87
        xb6kbuG4FJcspuhRXtFfY3nw2BK4psF+Ery2XGJybmu9Td23aiIq+xbNaNSbJsolhntbU+qESTzkC
        HkQutalGFmby1itYVrzeoJgfmiwXLzWyC0g/m5m9BcbnOgmbz125T5YB+/ZXgxZAJLTuKsIIk3eRb
        zMfBfcerDlOQoGF//9X6T5mTM6TmjBYqQi8yjawdb6dshFi3z6choFrc6ej8kVdgFuqh9ZbcbRf70
        Df64TVZ1w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa5R3-0000ZQ-61; Mon, 02 Jul 2018 20:28:33 +0000
Subject: Re: [PATCH 2/5] Kconfig: consolidate the "Kernel hacking menu"
To:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702144711.22111-1-hch@lst.de>
 <20180702144711.22111-3-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5b408924-f7d6-24f6-b214-0778550e22d9@infradead.org>
Date:   Mon, 2 Jul 2018 13:28:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702144711.22111-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 07:47, Christoph Hellwig wrote:
> diff --git a/Kconfig b/Kconfig
> index 5499b1273ba5..5f580c81d85d 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -32,3 +32,5 @@ source "security/Kconfig"
>  source "crypto/Kconfig"
>  
>  source "lib/Kconfig"
> +
> +source "lib/Kconfig.debug"

Ack having Kernel hacking menu at the end.
I've been wanting to do that as well.

thanks,

-- 
~Randy
