Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE685C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A422170A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A422170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbeHNKjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 06:39:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11105 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727701AbeHNKjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 06:39:18 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 766EA18427FBB;
        Tue, 14 Aug 2018 15:53:13 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Tue, 14 Aug 2018
 15:53:12 +0800
Subject: Re: [PATCH] Revert "f2fs: use printk_ratelimited for f2fs_msg"
To:     Joe Perches <joe@perches.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20180813062845.25394-1-yuchao0@huawei.com>
 <a5f29d4ed6098373fb3fe7a0194687d78d3592f7.camel@perches.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c59c6667-b532-42a6-2e61-752d7aba9001@huawei.com>
Date:   Tue, 14 Aug 2018 15:53:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a5f29d4ed6098373fb3fe7a0194687d78d3592f7.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe, thanks for pointing out this, I didn't see any cases need to be limited now.

Thanks,

On 2018/8/13 17:50, Joe Perches wrote:
> On Mon, 2018-08-13 at 14:28 +0800, Chao Yu wrote:
>> Don't limit printing log, so that we will not miss any key messages.
>>
>> This reverts commit a36c106dffb616250117efb1cab271c19a8f94ff.
> []
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> []
>> @@ -209,7 +209,7 @@ void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
>>  	va_start(args, fmt);
>>  	vaf.fmt = fmt;
>>  	vaf.va = &args;
>> -	printk_ratelimited("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
>> +	printk("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
>>  	va_end(args);
>>  }
> 
> If there was value in ratelimiting these messages at all,
> perhaps there is value in using a specific ratelimit_state
> other than
> 
> 	static DEFINE_RATELIMIT_STATE(_rs,				\
> 				      DEFAULT_RATELIMIT_INTERVAL,	\
> 				      DEFAULT_RATELIMIT_BURST);		\
> 
> 
> 
> 
> .
> 

