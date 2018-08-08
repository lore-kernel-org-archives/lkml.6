Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B09C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3ABB21767
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3ABB21767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeHHQbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:31:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727050AbeHHQbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:31:10 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 93C1C598E538D;
        Wed,  8 Aug 2018 22:11:13 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Wed, 8 Aug 2018
 22:11:10 +0800
Message-ID: <5B6AF9FB.10701@huawei.com>
Date:   Wed, 8 Aug 2018 22:11:07 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <dsterba@suse.cz>, <clm@fb.com>, <jbacik@fb.com>,
        <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fs/btrfs: remove the unneeded variable "err" and change
 the function to be void function
References: <1533523978-50321-1-git-send-email-zhongjiang@huawei.com> <20180807152500.GJ3218@twin.jikos.cz>
In-Reply-To: <20180807152500.GJ3218@twin.jikos.cz>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/7 23:25, David Sterba wrote:
> On Mon, Aug 06, 2018 at 10:52:58AM +0800, zhong jiang wrote:
>> The err is not modified after initalization, So just remove it and make
>> the function to be void function.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>> v1->v2:
>>  - Merge v1 series into a patch to void same changelog.
> Please do one patch per function. If the change follows the same logic,
> it's not a problem to use the same changelog, but the patch should be
> revieweable and not doing unrelated things.
>
> If the function prototype or return values is changed it's easier from
> the reviewer's perspective to focus on just one function and the
> surrounding code. Even if it looks straightforward to you to merge them
> together.
>
> When the return value changes from int -> void, it's necessary to check
> wheter any of the callees is not hiding a BUG_ON that should be really
> turned into proper error handling in the caller. In that case the return
> type should stay and error handling added.
>
> After a brief look I think all functions are safe here, but that's
> something that should be mentioned in the changelog. Please update the
> patches and resend. Thanks.
>
> .
>
I will repost the patches with detailed changlog. Thank you for explaination.

Thanks
zhong jiang

