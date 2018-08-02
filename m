Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FDCC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A1620894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A1620894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeHBDIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 23:08:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57472 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbeHBDIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 23:08:24 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 49CA75E034F41;
        Thu,  2 Aug 2018 09:19:46 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Thu, 2 Aug 2018
 09:19:47 +0800
Subject: Re: [PATCH] net/9p/trans_virtio.c: add a terminal char for mount tag
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Greg Kurz <groug@kaod.org>
References: <5B6164F6.60004@huawei.com> <20180801081157.GA20127@nautica>
 <5B616E3B.4050205@huawei.com> <20180801125222.3ba39416@bahia.lan>
 <20180801120958.GA571@nautica>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B625BD1.8050602@huawei.com>
Date:   Thu, 2 Aug 2018 09:18:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180801120958.GA571@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominique and Greg,

Thanks for your reviewing, and I will try to simplify other related code
according your suggestions in patch v2.

Thanks,
Jun

On 2018/8/1 20:09, Dominique Martinet wrote:
> Greg Kurz wrote on Wed, Aug 01, 2018:
>> So this patch basically turns chan->tag into a nul terminated string,
>> which is indeed more convenient and robust. Maybe you can update the
>> rest of the code accordingly and drop chan->tag_len then ?
> 
> If we can use that to simplify some other part of the code, that's
> certainly more appealing to me :)
> 
> 
>> FWIW, 9P strings received from the client are also converted to
>> nul terminated strings:
> 
> Oh, good to know; I guess that makes sense when these strings come and
> go from/to other components of the kernel that likely expect that.
> 
