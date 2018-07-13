Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2391ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF13208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF13208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeGMJcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:32:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9621 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbeGMJcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:32:02 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BD14EA46A3AEE;
        Fri, 13 Jul 2018 17:18:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 17:17:55 +0800
Subject: Re: [PATCH] f2fs: hide unused procfs helpers
To:     Chao Yu <yuchao0@huawei.com>, <jaegeuk@kernel.org>
References: <20180713035304.18520-1-yuehaibing@huawei.com>
 <643f0ef2-f74a-8ea9-b24c-fb1cc231b8ba@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <7181036d-854d-2278-3039-e14542586b1a@huawei.com>
Date:   Fri, 13 Jul 2018 17:17:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <643f0ef2-f74a-8ea9-b24c-fb1cc231b8ba@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/13 17:02, Chao Yu wrote:
> Hello,
> 
> On 2018/7/13 11:53, YueHaibing wrote:
>> When CONFIG_PROC_FS isn't set, gcc warning this:
>>
>> fs/f2fs/sysfs.c:519:12: warning: ‘segment_info_seq_show’ defined but not used [-Wunused-function]
>>  static int segment_info_seq_show(struct seq_file *seq, void *offset)
>>             ^
>> fs/f2fs/sysfs.c:546:12: warning: ‘segment_bits_seq_show’ defined but not used [-Wunused-function]
>>  static int segment_bits_seq_show(struct seq_file *seq, void *offset)
>>             ^
>> fs/f2fs/sysfs.c:570:12: warning: ‘iostat_info_seq_show’ defined but not used [-Wunused-function]
>>  static int iostat_info_seq_show(struct seq_file *seq, void *offset)
>>
>> We can fix the warning by adding the same #ifdef around them.
> 
> Could you check below patch sent from Randy Dunlap? It has already fixed this
> issue, anyway, thanks for your patch. :)
> 
> [PATCH] f2fs: fix defined but not used build warnings

thank you for your information.
> 
> Thanks,
> 
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  fs/f2fs/sysfs.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index 2e7e611..7d45e65 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -516,6 +516,7 @@ static struct kobject f2fs_feat = {
>>  	.kset	= &f2fs_kset,
>>  };
>>  
>> +#ifdef CONFIG_PROC_FS
>>  static int segment_info_seq_show(struct seq_file *seq, void *offset)
>>  {
>>  	struct super_block *sb = seq->private;
>> @@ -608,6 +609,7 @@ static int iostat_info_seq_show(struct seq_file *seq, void *offset)
>>  
>>  	return 0;
>>  }
>> +#endif
>>  
>>  int __init f2fs_init_sysfs(void)
>>  {
>>
> 
> 
> .
> 

