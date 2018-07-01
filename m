Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618E5C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 02:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A2824F70
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 02:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="loACgUT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A2824F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeGACZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 22:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbeGACZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 22:25:28 -0400
Received: from [192.168.0.101] (unknown [180.111.132.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C30E241F1;
        Sun,  1 Jul 2018 02:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530411927;
        bh=UYdboAAFFgHGt0s8mksiOMhIDmWW1OkHHubo/Ye472M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=loACgUT4Xg27Cq0BPLp4rJHsR+vCnnYifqcLaUYbgPU2bFav2G0YK8ByvDsBiXSGk
         cehKBdGTAN1IARsnTdr+DZguHI+EhLBFrmAE5FZQLSHTYoKoYwA7fXCYBNXSMWFKw7
         Rj2+h2tN8F5bSQZ1Crqej/TH9zL6BUdYe2mkrkGA=
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid the global name 'fault_name'
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <1530374223-130895-1-git-send-email-gaoxiang25@huawei.com>
 <174b5d84-8d41-4b8e-4e87-39f8cc3948ae@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <c00e7a33-ca80-283b-be88-88e0adf5cbfc@kernel.org>
Date:   Sun, 1 Jul 2018 10:25:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <174b5d84-8d41-4b8e-4e87-39f8cc3948ae@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/1 0:06, Gao Xiang wrote:
> 
> Oh, I just found the same patch written by Chao at:
> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev
> 
> I just fixed the erofs name conflicts, so fixed f2fs as well.
> Please ignore this one.

I didn't send it out, I think merging yours will be fine to me. :)

Thanks,

> 
> Thanks, 
> Gao Xiang
> 
> On 2018/6/30 23:57, Gao Xiang wrote:
>> Non-prefix global name 'fault_name' will pollute global
>> namespace, fix it.
>>
>> Refer to:
>> https://lists.01.org/pipermail/kbuild-all/2018-June/049660.html
>>
>> To: Jaegeuk Kim <jaegeuk@kernel.org>
>> To: Chao Yu <yuchao0@huawei.com>
>> Cc: linux-f2fs-devel@lists.sourceforge.net
>> Cc: linux-kernel@vger.kernel.org
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>>  fs/f2fs/f2fs.h  | 4 ++--
>>  fs/f2fs/super.c | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 4d8b1de..11a2e09 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -65,7 +65,7 @@ struct f2fs_fault_info {
>>  	unsigned int inject_type;
>>  };
>>  
>> -extern char *fault_name[FAULT_MAX];
>> +extern char *f2fs_fault_name[FAULT_MAX];
>>  #define IS_FAULT_SET(fi, type) ((fi)->inject_type & (1 << (type)))
>>  #endif
>>  
>> @@ -1279,7 +1279,7 @@ struct f2fs_sb_info {
>>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>>  #define f2fs_show_injection_info(type)				\
>>  	printk("%sF2FS-fs : inject %s in %s of %pF\n",		\
>> -		KERN_INFO, fault_name[type],			\
>> +		KERN_INFO, f2fs_fault_name[type],		\
>>  		__func__, __builtin_return_address(0))
>>  static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
>>  {
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 3995e92..df12dcd 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -41,7 +41,7 @@
>>  
>>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>>  
>> -char *fault_name[FAULT_MAX] = {
>> +char *f2fs_fault_name[FAULT_MAX] = {
>>  	[FAULT_KMALLOC]		= "kmalloc",
>>  	[FAULT_KVMALLOC]	= "kvmalloc",
>>  	[FAULT_PAGE_ALLOC]	= "page alloc",
>>
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
