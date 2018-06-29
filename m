Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D19C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A7323DF5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UQ27chq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A7323DF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934789AbeF2Df1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 23:35:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932140AbeF2Df0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 23:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZNVT83Xvk5dazkhfC9hybdEHM1VZVjcL/MrsCMTm/JE=; b=UQ27chq69jx9dd5ypeir9B7+q
        fNXJt77MGmVm+Cwv67fmjAKlVJZrLmBroXk9LodbGlCdskAEHLuaAzyBopG/U6vimDdFfpRq6ET+W
        dG29QwkzAaU8Z7U617TuhD14OvR3SM6nKU77cF2tUDE33gH3llQnXIdAOgyfGPcRDt0FgrWn2HxGv
        6mCuzEHQLODKigvOaW7Qej9ElJK/GwxvFi804JxxGtT+61lyIAzVtpPKP1RMDh93KmlfcgObIJX7U
        byxLsqXInwvpDsKFP3fLQhC6VRVAn4rewi+Gkcmtg5BmGgDh+Kqq8YNHQht0hKVQ6pEvRtPdAqY24
        W8RjiF4pg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYkBs-00057K-SN; Fri, 29 Jun 2018 03:35:21 +0000
Subject: Re: [PATCH] lib/string.c: fix a typo in comment: 'iff' -->'if'
To:     YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        mawilcox@microsoft.com, kstewart@linuxfoundation.org,
        aryabinin@virtuozzo.com, gregkh@linuxfoundation.org
References: <20180629033303.13012-1-yuehaibing@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a0b2a088-4887-e864-d211-bed0665a0b81@infradead.org>
Date:   Thu, 28 Jun 2018 20:35:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629033303.13012-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/2018 08:33 PM, YueHaibing wrote:
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  lib/string.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi,

This isn't a typo.  "iff" means "if and only if".

> diff --git a/lib/string.c b/lib/string.c
> index 2c0900a..23ed944 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -609,7 +609,7 @@ EXPORT_SYMBOL(strsep);
>   * @s1: one string
>   * @s2: another string
>   *
> - * This routine returns true iff two strings are equal, treating both
> + * This routine returns true if two strings are equal, treating both
>   * NUL and newline-then-NUL as equivalent string terminations.  It's
>   * geared for use with sysfs input strings, which generally terminate
>   * with newlines but are compared against values without newlines.
> 


-- 
~Randy
