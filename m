Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AE2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B7D20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B7D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387965AbeKFWDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:03:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14181 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387454AbeKFWDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:03:24 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 799112151093A;
        Tue,  6 Nov 2018 20:38:17 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 6 Nov 2018
 20:38:11 +0800
Subject: Re: [PATCH v2] bit_spinlock: introduce smp_cond_load_relaxed
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
 <20181030060441.16107-1-gaoxiang25@huawei.com>
 <20181105224654.GA25864@brain-police>
 <20181106090642.GH22431@hirez.programming.kicks-ass.net>
 <5eb42b84-5195-69f2-e7a7-97568f360506@huawei.com>
 <20181106110026.GJ22431@hirez.programming.kicks-ass.net>
 <dedbc211-082b-be4a-1bce-2593084d4ca3@huawei.com>
 <20181106122713.GR22431@hirez.programming.kicks-ass.net>
 <cd305483-97f3-6935-65d6-d5de47cdfcd7@huawei.com>
Message-ID: <44213253-d108-cd63-db64-7d41fcd8af66@huawei.com>
Date:   Tue, 6 Nov 2018 20:38:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <cd305483-97f3-6935-65d6-d5de47cdfcd7@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

OK, I think I understand your point. If you think the performance of bit_spinlock
doesn't matter, Let's keep the current status.

Thanks,
Gao Xiang

On 2018/11/6 20:33, Gao Xiang wrote:
> Hi Peter,
> 
> On 2018/11/6 20:27, Peter Zijlstra wrote:
>> On Tue, Nov 06, 2018 at 07:36:41PM +0800, Gao Xiang wrote:
>>> IMO, to use wrapped up function for the detailed scenario could be better than
>>> open-coded all the time (eg. do cpu_relax(); while(...)) since it could be
>>> optimizated even more for the specific architecture...
>> That's the whole point though; if this actually matters, you're doing it
>> wrong.
> 
> I cannot fully understand your point...Sorry about my English...
> 
> To the point, you mean it is much better to fix it as Will suggested before or
> leave the matter as it is since the performance of bit_spinlock itself doesn't matter?
> 
> Thanks in advance.
> 
> Thanks,
> Gao Xiang
> 
