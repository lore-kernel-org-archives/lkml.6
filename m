Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B93C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41AA2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="B8N1Jjv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41AA2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbeISVaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:30:01 -0400
Received: from sonic305-20.consmr.mail.gq1.yahoo.com ([98.137.64.83]:37195
        "EHLO sonic305-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732435AbeISVaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1537372288; bh=jUQ3hU3BxrhEb8ncN8aukABv1gQrGFnXBtnnUmssR2Q=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=B8N1Jjv+ST1Q1L6BOeQ5o08L6wv9MhKsG2zrUBaTR5LhM09OJI2ELxWq4n4zkz0XMkc2rMBrpIhuXWtmv/0io3Tf2FjyPdoM1EbcWFQQjw/zyhtind3cY3CSLqvtAJLGThvSXHrtDaEeap6oA5v+JjjuPqn/hVKywc+Q8EWrH/0xVH0uqQrU4pSiAN3WUkW8cbWL093uYZ/hZlqgZjj0GocZ0XQuuHUCgxX5Iv3Io7wCzjlPdDr4Z0j9Ti4ZuuRodELyc+Uuq+qddYFWLFipThi9NRfyAcpf0+RB0zBb4GDrbS8+SAz3jncW6ECtxv9uTu/oeTPHhZc6JGHdJTtz0Q==
X-YMail-OSG: LTLTW1EVM1k_gtdBaAjYaMhrz7IKn0fz8nGoIy7GEDo1VgwN.NtdRJKZxLOArPL
 ZX45neRbe9rzfyNbDKfCb72moVLU7lmpsNavQQywE1.hhLU.uyK4pFv48D.noQmqj8YevWZVGSby
 BwcnRa2kVJ5kHj_P82NRWetgDdM8O_Te8qz7p1CyiAMzZzmsVUanzCyMYZso.uhMME64ZgSjruGJ
 qhkjpgzIXoqZNuT.WhwsWyC6Lw0nFGRrKsgOZw.A1248zpWd6vykwfD36p1Mj0T9cX_W6mKG4.tF
 PjWefyYkV30lsaxYs.hBMk9hEze35T82JP17pnQQJqvZ7p7n07LYIueeibymXhOXhMX4CbkwYvJx
 2.I0BJryHH43Q7ySwORvKdgaeXrZ1xk0VtcFX4GcuPfVxf0yZS2tU0kA5jYzCNVWoyWgvsOOTsFR
 WpLMj4vtp2aj8YRYd0t.4j0L7an8DHEVi06u0SuJXBmwUSBWJhKK333Duwk4VbgaoJnWVOy76jCm
 NLxjOPWx7ob_LUgKY_IQIrB4_GZJVCDZ05gtv84xGVotsU8wv4.3PKR8gkEAmICCFhXsbNPIAdS6
 oZUi1VPRMuEsvtZLaChR_ZvVu8yGKfWqzmYHh7HFcNYUQfy6G4ojXLwj7ta4NEb9Zfe3Isx5PiGz
 PytS5kbCoT.OLcuyPolI7PuoKRM6tmYkO8G5fDkgb39s.n8TAYbSOFoPVq5K8tTueFyRAPZh_s9y
 N3PhL9QrX8Tu0QR_8RgceXdfQijPEVggCEhw_heBErKxrN229sQv5n6bPKHqaQNl.kUzLWyBpMJr
 IchofiqPmPvqUebUiZTHaBusHcShyyh3nqeN4K3FnVBtUHWwfVsN7781Sn878931k2xMCImHpqMH
 N9Z1XSieQFNwy_tglgKST_j7FU9KWmWidrYdbgJhuVUlQBGOYzQDehdv3o1QSC3YSIn8QyXnNy2V
 Y5rivFt0bLIo_jvmpdMRj3ZTtfRtQXlvuclcaQremyiTCGg8qA7rb8JUM.c1FFKgJDIT1Ke9PfP4
 v
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Sep 2018 15:51:28 +0000
Received: from 180.173.110.117 (EHLO [192.168.1.3]) ([180.173.110.117])
          by smtp411.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 02532fb4924e373c622fc939a6514f11;
          Wed, 19 Sep 2018 15:51:28 +0000 (UTC)
Subject: Re: [PATCH 4/6] staging: erofs: cleanup
 `z_erofs_vle_normalaccess_readpages'
To:     Chao Yu <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     devel@driverdev.osuosl.org, Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, Du Wei <weidu.du@huawei.com>
References: <1537336150-90604-1-git-send-email-gaoxiang25@huawei.com>
 <1537336150-90604-4-git-send-email-gaoxiang25@huawei.com>
 <1b38cbfe-70e0-1e6d-fa50-89b1fddeeb43@kernel.org>
 <fc0f977f-b1c3-41a9-a058-bca4261bf9ea@aol.com>
 <37b566ea-273b-8d81-7428-06bd35d60092@kernel.org>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <f49a05f6-c6cb-db9f-3fa3-d38881708ab3@aol.com>
Date:   Wed, 19 Sep 2018 23:51:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <37b566ea-273b-8d81-7428-06bd35d60092@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 2018/9/19 23:45, Chao Yu wrote:
> Hi Xiang,
> 
> On 2018/9/19 23:32, Gao Xiang wrote:
>> Hi Chao,
>>
>> On 2018/9/19 23:26, Chao Yu wrote:
>>> Hi Xiang,
>>>
>>> On 2018/9/19 13:49, Gao Xiang wrote:
>>>> This patch introduces `__should_decompress_synchronously' to
>>>> cleanup `z_erofs_vle_normalaccess_readpages'.
>>>>
>>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>>>> ---
>>>>  drivers/staging/erofs/internal.h  | 11 +++++++++++
>>>>  drivers/staging/erofs/super.c     |  5 +++++
>>>>  drivers/staging/erofs/unzip_vle.c | 20 ++++++--------------
>>>>  3 files changed, 22 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
>>>> index cfcc6db..c84eb97 100644
>>>> --- a/drivers/staging/erofs/internal.h
>>>> +++ b/drivers/staging/erofs/internal.h
>>>> @@ -95,6 +95,9 @@ struct erofs_sb_info {
>>>>  	/* the dedicated workstation for compression */
>>>>  	struct radix_tree_root workstn_tree;
>>>>  
>>>> +	/* threshold for decompression synchronously */
>>>> +	unsigned int max_sync_decompress_pages;
>>>> +
>>>>  #ifdef EROFS_FS_HAS_MANAGED_CACHE
>>>>  	struct inode *managed_cache;
>>>>  #endif
>>>> @@ -273,6 +276,14 @@ extern int erofs_try_to_free_cached_page(struct address_space *mapping,
>>>>  	struct page *page);
>>>>  #endif
>>>>  
>>>> +#define DEFAULT_MAX_SYNC_DECOMPRESS_PAGES	4
>>>> +
>>>> +static inline bool __should_decompress_synchronously(struct erofs_sb_info *sbi,
>>>> +						     unsigned int nr)
>>>> +{
>>>> +	return nr <= sbi->max_sync_decompress_pages;
>>> -		nr_pages < 4 /* sync */);
>>>
>>> There is a little bit changed except cleanup, IIUC, would it be any difference
>>> of performance around boundary of four pages?
>>
>> No.. Once synchronous decompression is applied for 1,2,3 pages for no special reasons.
>> But I think it could be better to adjust it to the power of two --- 1,2,3,4 is preferred.
>> Since I have no idea to measure which is better or what value is best for all platform or use cases...
>>
>> Therefore I tune it in this patch since I don't like the number
>> DEFAULT_MAX_SYNC_DECOMPRESS_PAGES == 3 ...
> 
> Yeah, how about adding one more patch to tune this magic number first? as that
> change would not be part of cleanup thing. I guess later maybe we could export a
> sysfs node to provider tuning ability on that threshold.

OK, I think we can leave the original "3" for now. I will fix that value and resend this patch soon.

The sysfs interface could be necessary later since it seems some arguments
involved in decompression could impact the decompression performance.

Thanks,
Gao Xiang

> 
> Thanks,
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> Thanks,
>>>
