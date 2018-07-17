Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39B7ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8821B208EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8821B208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbeGQBmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:42:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49250 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729910AbeGQBmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:42:22 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D41B866BC209;
        Tue, 17 Jul 2018 09:12:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Tue, 17 Jul 2018
 09:12:16 +0800
Subject: Re: [V9fs-developer] [PATCH] net/9p: Fix a deadlock case in the
 virtio transport
To:     Dominique Martinet <asmadeus@codewreck.org>
References: <5B49B8CF.40709@huawei.com> <20180714090502.GA16186@nautica>
 <5B49DAA5.3020600@huawei.com> <20180714124715.GA16134@nautica>
 <5B4BFB29.3080507@huawei.com> <20180716133847.GA9421@nautica>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5B4D426F.8050605@huawei.com>
Date:   Tue, 17 Jul 2018 09:12:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180716133847.GA9421@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/16 21:38, Dominique Martinet wrote:
> jiangyiwen wrote on Mon, Jul 16, 2018:
>> You're right, this wake up operation should be put after the unlocking,
>> I will resend it. In addition, whether I should resend this patch based
>> on your 9p-next branch?
> 
> There is a trivial conflict with Thomas' validate PDU length patch,
> but as it is trivial either work for me - pick whichever is easier to
> work with for you.
> 
> The main reason I asked for a new version of the other patch is that the
> IDR rework changed spin locks, so I'd rather it being clean.
> 
> 
> Thanks,
> 

ok, I will resend the patch later based on linux-next branch.

Thanks,
Yiwen.

