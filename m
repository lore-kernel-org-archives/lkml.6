Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23360C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948A92178A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948A92178A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeHRRlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 13:41:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbeHRRlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 13:41:31 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0141918CB170B;
        Sat, 18 Aug 2018 22:33:34 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Sat, 18 Aug 2018
 22:33:32 +0800
Message-ID: <5B782E3B.7030001@huawei.com>
Date:   Sat, 18 Aug 2018 22:33:31 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Bhaskar Singh <bhaskar.kernel@gmail.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: rtl8188eu: Type cast function argument
References: <20180818142409.GA17122@Gentoo-PC>
In-Reply-To: <20180818142409.GA17122@Gentoo-PC>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/18 22:24, Bhaskar Singh wrote:
> This patch might suppress some warrning.
>
> The function prototype of rtw_malloc2d is
>
> void *rtw_malloc2d(int h, int w, int size)
>
> This patch also resolves the checkpatch.pl warning
>
> WARNING: line over 80 characters
>
> Signed-off-by: Bhaskar Singh <bhaskar.kernel@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_efuse.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> index 0fd306a808c4..735d654b2844 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> @@ -91,7 +91,8 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
>  	if (!efuseTbl)
>  		return;
>  
> -	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
> +	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E,
> +			EFUSE_MAX_WORD_UNIT, (int)sizeof(u16));
>  
  You should be align with left parenthesis.

 Thanks,
 zhong jiang
> 	if (!eFuseWord) {
>  		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
>  		goto eFuseWord_failed;


