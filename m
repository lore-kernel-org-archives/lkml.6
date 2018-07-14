Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10156ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 04:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1927208B0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 04:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sxA+jC8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1927208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbeGNEef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 00:34:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54324 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeGNEef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 00:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NlhKrX54D6axL4V8VpVvpRwSz1NgbL7SiCG30N/13oQ=; b=sxA+jC8Pv6UvHJ+POpbRQeFdFI
        UQAmW/FOSGoAr04gTB/ADAIRKpDYfYBb3r2tBxXcOtxuB6Vsom1MIfujku349dQV/UO2QdyPRmAxt
        tKRTMgnguBLosAZtCozXxqyv8zDdCjSdagybHMOnynMT+repP08/gmVxvUpYANLRVj2oL5nXFwwj6
        DkRlGIm9CDx8nQDoIIluZpFTTk2K12E7kEgdxQaDcAH69ckcaTmb0hLmGk5Si+Klk0/Pl+K8KQ1Ra
        haKud4YUzwE6G22FLTM6rifs/LBJav0sOsnfu5+F4BLOf7aAcJG+v2eSG26/pWQYz69LzbZKtX1lu
        qEsXZu4g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1feBzQ-0006Wd-9z; Sat, 14 Jul 2018 04:17:00 +0000
Subject: Re: [PATCH] mmc: mxcmmc: Fix missing parentheses and brace
To:     Kees Cook <keescook@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180712195937.GA36007@beast>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4bba8958-b328-68c1-6eec-61ffe0f2f086@infradead.org>
Date:   Fri, 13 Jul 2018 21:16:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180712195937.GA36007@beast>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 12:59 PM, Kees Cook wrote:
> Looks like the adjusted syntax wasn't fully build tested. This fixes
> failures with powerpc builds:
> 
> drivers/mmc/host/mxcmmc.c: In function ‘mxcmci_swap_buffers’:
> drivers/mmc/host/mxcmmc.c:296:51: error: expected ‘)’ before ‘;’ token
>    void *buf = kmap_atomic(sg_page(sg) + sg->offset;
>                                                    ^
> drivers/mmc/host/mxcmmc.c:299:1: error: expected ‘,’ or ‘;’ before ‘}’ token
>  }
>  ^
> 
> Fixes: b189e7589f6d3 ("mmc: mxcmmc: handle highmem pages")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/mmc/host/mxcmmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 75f781c11e89..de4e6e5bf304 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -293,9 +293,10 @@ static void mxcmci_swap_buffers(struct mmc_data *data)
>  	int i;
>  
>  	for_each_sg(data->sg, sg, data->sg_len, i) {
> -		void *buf = kmap_atomic(sg_page(sg) + sg->offset;
> +		void *buf = kmap_atomic(sg_page(sg) + sg->offset);
>  		buffer_swap32(buf, sg->length);
>  		kunmap_atomic(buf);
> +	}
>  }
>  #else
>  static inline void mxcmci_swap_buffers(struct mmc_data *data) {}
> 


-- 
~Randy
