Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDADAC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D5820883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D5820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeKIVTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:19:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34719 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727596AbeKIVTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:19:17 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D536CD7FB8133;
        Fri,  9 Nov 2018 19:38:57 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 9 Nov 2018
 19:38:49 +0800
Subject: Re: How can I get user space tools of erofs?
To:     cgxu519 <cgxu519@gmx.com>
References: <cce741a4-8e15-a48c-070e-d16d71b864c3@gmx.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
CC:     Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>,
        <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "liguifu (C)" <bluce.liguifu@huawei.com>,
        "fangwei (I)" <fangwei1@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
Message-ID: <923d8f98-bd0c-47e1-63a5-512547d6a77d@huawei.com>
Date:   Fri, 9 Nov 2018 19:38:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <cce741a4-8e15-a48c-070e-d16d71b864c3@gmx.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chengguang,

Good question! It's in the final stage of preparation to open source erofs-mkfs (actually they are now struggle at how to properly spilt
into reasonable patches this week), hopefully the implementation could be released at the next week. (sorry I didn't mean to delay,
I have to put it in the first place --- successfully launch our linux-erofs products to the market)

@Guifu Li <bluce.liguifu@huawei.com> is the original author of erofs-mkfs, he will post the original mkfs source code to linux-erofs mailing list
and he will maintain erofs-mkfs together with @Wei Fang <fangwei1@huawei.com> later. You can contact them for further informations.
---  these piece of code is actually not clean enough (a lot hacked/dirty code compared to the kernel code) so a lot of cleanup will be done then.

currently, you can get erofs-mkfs binary from (still sorry to say that...):
https://github.com/hsiangkao/erofs_mkfs_binary

erofs is now in productization for these months, if all things go well, you'll see that HUAWEI mobile phones on the market run in erofs in few months. :)

These months I'm busy in solving bugs found by internal beta users and tuning memory policy in heavy memory workload for the best performance compared to ext4
(we have native in-place decompression compared with squashfs/btrfs, thus less extra memory allocation results in lower memory memory reclaim / page-writeback
for devices with limited memory, see: https://lists.ozlabs.org/pipermail/linux-erofs/2018-August/000494.html) in order to gain the competitive user experience
comparing to uncompressed filesystem solutions. I will update a document to describe our core design and linux-erofs future roadmap in this linux-4.21 round.

Thanks,
Gao Xiang

On 2018/11/9 16:37, cgxu519 wrote:
> Hi Xiang,
> 
> Could I ask a simple question about where can I get user space tools(like mkfs) of erofs?
> 
> 
> Thanks.
> 
