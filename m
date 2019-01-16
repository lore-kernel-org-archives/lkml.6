Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD53C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CBA2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392954AbfAPNCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:02:02 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60930 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390275AbfAPNCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:02:02 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2BE7249F6CACF109937B;
        Wed, 16 Jan 2019 21:02:00 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 16 Jan
 2019 21:01:51 +0800
Subject: Re: [PATCH 3/5] staging: erofs: decrease the shrink count in
 erofs_workgroup_get
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <weidu.du@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190116085956.21004-1-gaoxiang25@huawei.com>
 <20190116085956.21004-3-gaoxiang25@huawei.com> <20190116104553.GE4482@kadam>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <75258956-db6f-501e-f022-536134c53911@huawei.com>
Date:   Wed, 16 Jan 2019 21:01:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190116104553.GE4482@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2019/1/16 18:45, Dan Carpenter wrote:
> On Wed, Jan 16, 2019 at 04:59:54PM +0800, Gao Xiang wrote:
>> It is more suitable to update in erofs_workgroup_get since
>> it's actually the one matched with erofs_workgroup_put.
>>
> 
> This patch is fine.  No need to resend.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> But for future reference, I found the commit message a bit confusing.
> Ideally, I would understand basically what the commit does and why
> without needing to read the diff.
> 
> I mostly just read the subject or the commit message, either or, instead
> of reading both.  (This is not really true.)  My email client looks like
> this.  (Also not true).
> 
> https://marc.info/?l=linux-driver-devel&m=154762932712086&w=2
> 
> While none of that was strictly true, it is a little bit true-ish...
> So please, assume that some people will start reading the commit message
> without reading the subject.
> 
> I sort of thought from reading the commit message that it was a bugfix
> or a behavior change.  A better commit message would be:
> 
> staging: erofs: move shrink accounting inside the function
> 
> This patch moves the &erofs_global_shrink_cnt accounting from the caller
> to erofs_workgroup_get().  It's cleaner and it matches erofs_workgroup_put()
> better.  No behavior change.

Thanks for your kindly suggestion.
Actually I have to think more about how to express in English
as a foreign speaker...

But you are absolutely right ;) this commit is actually confusing and I will
do my best to write commit subject and message clearly...

If something wrong like this, please kindly point out and I will update immediately :)

Anyway, I will send patch v2 of this commit for Greg to merge...

Thanks,
Gao Xiang

> 
> regards,
> dan carpenter
> 
