Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61683C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288AA2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288AA2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeKHPpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:45:52 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbeKHPpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:45:51 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8D5B2A094DA46;
        Thu,  8 Nov 2018 14:11:56 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Thu, 8 Nov 2018
 14:11:48 +0800
Subject: Re: [PATCH] staging: erofs: use the new LZ4_decompress_safe_partial()
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, Chao Yu <chao@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Miao Xie" <miaoxie@huawei.com>,
        <weidu.du@huawei.com>
References: <20181108040036.13671-1-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a3b6d2dc-43e3-ed30-a209-55523671a0b0@huawei.com>
Date:   Thu, 8 Nov 2018 14:11:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181108040036.13671-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/8 12:00, Gao Xiang wrote:
> LZ4_decompress_safe_partial() can now decode exactly the nb of bytes
> requested after the upstreamed commit 2209fda323e2 ("lib/lz4: update LZ4
> decompressor module"), remove the erofs hacked lz4 decompression code.
> 
> A more cleaned compressor wrapper will be introduced in the subsequent
> patches in order to prepare for supporting multiple compression algorithms.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> 
> Hi Chao,
>  Could you please kindly confirm (review) this before merging into the staging tree?

Looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

