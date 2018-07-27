Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118E0C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C598020895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C598020895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389196AbeG0LXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:23:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732452AbeG0LXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:23:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 88D38147AAA93;
        Fri, 27 Jul 2018 18:02:30 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Fri, 27 Jul 2018
 18:02:30 +0800
Subject: Re: [PATCH 03/10] atmel: hide unused procfs helpers
To:     Kalle Valo <kvalo@codeaurora.org>
References: <20180713064658.10340-1-yuehaibing@huawei.com>
 <ded55181-e1b0-99e9-ac68-2d93fb6168c0@huawei.com>
 <87va91vxnr.fsf@codeaurora.org>
CC:     <simon@thekelleys.org.uk>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <davem@davemloft.net>, <rdunlap@infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <3684c95c-6df1-183e-8940-807dfb49e5bb@huawei.com>
Date:   Fri, 27 Jul 2018 18:02:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <87va91vxnr.fsf@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/27 17:24, Kalle Valo wrote:
> (fixing top posting)
> 
> YueHaibing <yuehaibing@huawei.com> writes:
> 
>> On 2018/7/13 14:46, YueHaibing wrote:
>>> When CONFIG_PROC_FS isn't set, gcc warning this:
>>>
>>> drivers/net/wireless/atmel/atmel.c:1402:12: warning: ‘atmel_proc_show’ defined but not used [-Wunused-function]
>>>  static int atmel_proc_show(struct seq_file *m, void *v)
>>>             ^
>>> fix this by adding #ifdef around it.
>>>
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>
>> pls ignore this,my bad.
> 
> Why should I drop this? Does the patch have something wrong which I'm
> missing?

No,the patch is ok,just because I find this issue has a fix patch from Randy.

> 
> I'm asking because I prefer this over Randy's version:
> 
> https://patchwork.kernel.org/patch/10512913/
> 

