Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22367C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA362086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA362086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeLLMSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:18:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727091AbeLLMSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:18:20 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9E6A5619BA044;
        Wed, 12 Dec 2018 20:18:17 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 12 Dec
 2018 20:18:08 +0800
Subject: Re: [PATCH v2] staging:erofs: Remove __EROFS_BIT macro
To:     Aaron Strahlberger <aaron.strahlberger@posteo.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <linux-kernel@i4.cs.fau.de>,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        Dominik Huber <domi250@gmx.de>
References: <9d324f50-e632-c020-04b9-57269ff7bdca@aol.com>
 <20181212120209.16304-1-aaron.strahlberger@posteo.de>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <6db43c9b-f668-167c-cc08-b19689329a27@huawei.com>
Date:   Wed, 12 Dec 2018 20:18:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181212120209.16304-1-aaron.strahlberger@posteo.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

On 2018/12/12 20:02, Aaron Strahlberger wrote:
> The `__EROFS_BIT` macro is used only once, do define the
> `EROFS_I_DATA_MAPPING_BIT` constant. This Patch removes this
> macro and expands it in the place it is used.
> 
> Signed-off-by: Aaron Strahlberger <aaron.strahlberger@posteo.de>
> Signed-off-by: Julius Wiedmann <julius.wiedmann@fau.de>
> Signed-off-by: Dominik Huber <domi250@gmx.de>
> ---
>  drivers/staging/erofs/erofs_fs.h | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

> +
>  #define EROFS_I_VERSION_BITS            1
>  #define EROFS_I_DATA_MAPPING_BITS       3
>  
>  #define EROFS_I_VERSION_BIT             0
> -__EROFS_BIT(EROFS_I_, DATA_MAPPING, VERSION);
> +enum {
> +	EROFS_I_DATA_MAPPING_BIT = EROFS_I_VERSION_BIT + EROFS_I_VERSION_BITS
> +}

Thanks for your patch. I have fixed it yesterday,
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/drivers/staging/erofs?h=staging-testing&id=ccd9c19c7ae165c70221b0a4927c31a56e395658

EROFS_I_DATA_MAPPING_BIT = EROFS_I_VERSION_BIT + EROFS_I_VERSION_BITS is not straight-forward as well for erofs on-disk format definition,
fix it to a plain number.

Thanks,
Gao Xiang

>  
>  struct erofs_inode_v1 {
>  /*  0 */__le16 i_advise;
> 
