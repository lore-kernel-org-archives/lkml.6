Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FC6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0801C25C38
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tatq2hzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0801C25C38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeGBU5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:57:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753209AbeGBU5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nwHrtd9r/+uweD6ZAqFpLmLUQLvv0uLexDRcpZfGTyM=; b=Tatq2hzOBEGOdHLhUXIeHNSJi
        ZH394fipZrpc7+zBBYsWZrnZ9B5K/nellg8Nz0ntqXLxJ4LeV+cFZHJdWnOfeMSucFyGJF6EhrfDq
        XLvstTdrfv/8LeXoZgdLuDiXHz5+qUZuKeP1DVrXdD3UKdoYtrshOPfdvJDfH+NaX2QLKpOcp7etR
        6NG/Ey+d7Ny43ZrC87gi7kZM80erY6HkarlDGl6BzSwRdHnjZxZzJOU2QLKigvsSlNc0vXPzToIj0
        brwS/eAyGnW914wkgXwqz+o75Kts6HMWYNxqF6fMEUQAl4YPG1OSoWiNdOE8Do5k91AFouQkIgaHl
        sKRJaBTuA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa5tL-0004gH-AD; Mon, 02 Jul 2018 20:57:47 +0000
Subject: Re: [PATCH 4/5] kconfig: add a Memory Management options" menu
To:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702144711.22111-1-hch@lst.de>
 <20180702144711.22111-5-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a9b9964f-c4c0-5b82-269b-32aada44cf0d@infradead.org>
Date:   Mon, 2 Jul 2018 13:57:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702144711.22111-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 07:47, Christoph Hellwig wrote:
> This moves all the options under a proper menu.
> 
> Based on a patch from Randy Dunlap.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  mm/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ce95491abd6a..9ae1b6a8e30f 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1,3 +1,6 @@
> +
> +menu "Memory Management options"
> +
>  config SELECT_MEMORY_MODEL
>  	def_bool y
>  	depends on ARCH_SELECT_MEMORY_MODEL
> @@ -762,3 +765,5 @@ config GUP_BENCHMARK
>  
>  config ARCH_HAS_PTE_SPECIAL
>  	bool
> +
> +endmenu
> 


-- 
~Randy
