Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CE5C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF7D21761
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF7D21761
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbeHMQDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:03:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728370AbeHMQDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:03:15 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 261F9D3A37705;
        Mon, 13 Aug 2018 21:20:55 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 13 Aug
 2018 21:20:48 +0800
Subject: Re: [PATCH 4/8] staging: erofs: cleanup z_erofs_vle_work_{lookup,
 register}
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Chao Yu <chao@kernel.org>, <devel@driverdev.osuosl.org>,
        <gregkh@linuxfoundation.org>, Chao Yu <yuchao0@huawei.com>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-5-chao@kernel.org>
 <20180813120057.6grkpue6h7dtmpt2@mwanda>
 <f162748e-cc02-8578-2a0b-af16d982e0b3@huawei.com>
 <20180813130541.hzjgb6wznkxcnajg@mwanda>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <1b095571-ba5e-c85a-2e9b-285cb2b8448d@huawei.com>
Date:   Mon, 13 Aug 2018 21:19:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180813130541.hzjgb6wznkxcnajg@mwanda>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2018/8/13 21:05, Dan Carpenter wrote:
> Yeah.  You'd have to remove the const.
> 
> Anyway, on looking at it more, I guess this patch is fine for now.  We
> will probably end up changing z_erofs_vle_work_lookup() and
> z_erofs_vle_work_register() some more in the future.
> 

Thanks for review, I personally tend to leave this patch unmodified for now :( .........

The struct is wrote in order to read-only or assign and read at once, and let compilers notice that
(all modifications are local so compilers can handle them safely)...

Thanks,
Gao Xiang

> regards,
> dan carpenter
> 
