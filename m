Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C347EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3B8218DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfBRCd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:33:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49800 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727266AbfBRCd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:33:27 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 767B451E2AF09FD68B05;
        Mon, 18 Feb 2019 10:33:24 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Feb 2019
 10:33:18 +0800
Subject: Re: [net-next] net: crypto set sk to NULL when af_alg_release.
To:     David Miller <davem@davemloft.net>
References: <20190215142415.149153-1-maowenan@huawei.com>
 <20190217.154218.1671210082238894003.davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <xiyou.wangcong@gmail.com>,
        <linux-kernel@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Message-ID: <e6185caf-4807-eb26-969b-b4f189b84f38@huawei.com>
Date:   Mon, 18 Feb 2019 10:33:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190217.154218.1671210082238894003.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/2/18 7:42, David Miller wrote:
> From: Mao Wenan <maowenan@huawei.com>
> Date: Fri, 15 Feb 2019 22:24:15 +0800
> 
>> KASAN has found use-after-free in sockfs_setattr.
>> The existed commit 6d8c50dcb029 ("socket: close race condition between sock_close()
>> and sockfs_setattr()") is to fix this simillar issue, but it seems to ignore
>> that crypto module forgets to set the sk to NULL after af_alg_release.
> 
> Please target this at 'net' since this is a bug fix.

Thank you, I have sent the v2 patch targets to "net" mail list.

> 
> .
> 

