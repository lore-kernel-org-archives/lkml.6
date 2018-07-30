Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10708C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47EF20842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47EF20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbeG3EFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 00:05:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbeG3EFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 00:05:43 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 27DD767459F35;
        Mon, 30 Jul 2018 10:32:54 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 30 Jul
 2018 10:32:49 +0800
Subject: Re: [PATCH 1/2] staging: erofs: fix compile error without built-in
 decompression support
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <chao@kernel.org>, Gao Xiang <hsiangkao@aol.com>
CC:     <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
References: <1532761832-6964-1-git-send-email-gaoxiang25@huawei.com>
 <20180729053459.34140-1-hsiangkao@aol.com>
 <5a396128-822f-5232-f3ee-1c5ac6524380@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <614f3148-91ae-2a9a-f932-21e32e290717@huawei.com>
Date:   Mon, 30 Jul 2018 10:32:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <5a396128-822f-5232-f3ee-1c5ac6524380@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 2018/7/30 10:07, Chao Yu wrote:
> On 2018/7/29 13:34, Gao Xiang via Linux-erofs wrote:
>> This patch fixes incorrect code snippets due to spilt code
>> into small patches by mistake.
>>
>> Link: https://lists.01.org/pipermail/kbuild-all/2018-July/050747.html
>> Link: https://lists.01.org/pipermail/kbuild-all/2018-July/050750.html
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>>  I test several Kconfig option combinations and all these
>> combinations are successfully compiled.
>>
>> Hi Chao,
>>  Could you please review this two patches first before merging
>> into staging-next tree?
> Hi Xiang,
> 
> For this compiler issue, I think we only need to cover erofs_shrink_workstation
> with marco CONFIG_EROFS_FS_ZIP, other modification like symbol name change or
> relocate erofs_shrink_workstation are with other reason, so how about separate
> them into different patches?
> 
> Thanks,
> 

It seems that Greg merged this patch to staging-next yesterday, since it is a urgent fix
(otherwise erofs cannot be compiled properly without CONFIG_EROFS_FS_ZIP, that is my fault).

I wrote in a patch yesterday becuase all the modifications have the same root cause ----
    fix incorrect code snippets due to spilt code into small patches by mistake.

But you are right, it is more proper to spilt into two patches, let me resend these patches later
(I don't know whether Greg will apply them... :-( sorry... )

I think in order to reduce Greg's patchwork burden, we could quickly review patches internally in linux-erofs first,
tidy up in a patchset set and send to Greg in a series periodically (if patches are not urgent).

How do you think about it?

Thanks,
Gao Xiang
