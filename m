Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF64C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833F32150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="nyNpIlPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833F32150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbeISVSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:18:51 -0400
Received: from sonic302-21.consmr.mail.gq1.yahoo.com ([98.137.68.147]:40177
        "EHLO sonic302-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732164AbeISVSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1537371621; bh=KXiHp3D9aUD5+TAcD63qLbF10gk3auQa1PodmqpCqUs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=nyNpIlPRotz5fpaft+HLakPac2sm2xq6i6z9nkFvh4DNG65rEMkq4l6MVFZs3pUpggrxifI7YiWpIzau2Ap132ZxQxp7F7qYqTLqb6FXCpSnlN+F4Uxlwaiiay7YlCUob+bCH1kXO15kxxFnK93S39XwqVcCNGQZQbh262gMKC9yZtiZidQFPMP9aA2WwMZQ446Q1SsNbSFxVjx87PV8QtdGHGMzqTAvwlH/fjGyqH+eGm1DGnEQVC/U2b0Nf+KVaDF3CsamCYfAf8QJi7v+iWV64lAPJtN+sRGNJo2J/svb0FG9o+7QfuMgHvAPb8cKBTA1TTbGE0D/nXvFlKtHNg==
X-YMail-OSG: 7gJoFw4VM1mY8W2dEomn0uRHXPlOiu02_8y1AIKDzBizI504LsVSDthKUiuTkIO
 AywXfwSwGde4ijvDEIU2uEHEodorplwOq5GH4_f4..JNoWcnk_OD4.KGELEKh_y5cQ9At5gNgOEC
 pOufh9DUYXaiJ5T5ecTFDx9sG1upTYOj9vfQ9x.eNYmNdUPzHAP352uGccyIwQ.P654cnQSVVlgj
 OyHEHbFbjsmspsmk1fczQsZzf0gKLDQs1cqhc5cTqFwTXwhsO1KhmqEojPbGn5UXNx6Gd1bzPgAS
 z266oJXnF4b6O5subQYvzJvwqDH84V2k5H9RWVwQqWp6I79ikPimFxJKbPIYsEXgRAACOBDnDirw
 UvcbxHJPzuntJltr.YWFgORTkRJNL7es2ZDrKCAnyGAEKQ1D8.l8mcWm110o6Wo9C5uLW2edHYqc
 pq6NL.FM5OnB49ohe4SqL_c_DwUBUq0rmIrm9pfCdYT1yxP1K8xeyFcPpCCYpR9n49MB5lmCiB1i
 SoGSxbiRC93Ip7ONLfxVlxzzhSenEioOfg4qeJbl6UpxRwFtSunpdxJKHYhNV0v806pNBuH8vnvH
 KytKzclSjvBejvk.sq6jUvF2yp2x8MNz72lGOO6.hOyEcy62DAAk3ZpILqvXZKKJP5I5In.Tcxtd
 SZtbBcgh7e.HIhalOxgBAyAwn2LmNFQdxpe18pQaX8Z_Y7aGxDJWoLdDd9mX_V59YMo5GKbjQ84A
 UicGTVik7DIOcSwjKOm7AHLNdWRfY1zsyEsOnAO_nDGl_HkMeM8gH4.NHayawgL5FxV80D3z0kHV
 le3xZu5lY8ariHxfrcQFngS3uMlv05WGv5ylgUAOKSF0YFh5E1NWO1ooK.IdmuuvjUylNHdoSm7g
 TVeWi1rARHn3r0iLsPjqj8NOEXFomJrPXh9qioyXbgnRaKOkHa7eZaKkdA16TcWZgKhGJTFPPAE5
 qW6gH7ct_EI9IiUA7ZgA7AttuMyF0TM9wgDpoSmBKjFs.kaMhhLXd2aLjY98swuq_P6Zqu_Z7UDb
 xZfU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Sep 2018 15:40:21 +0000
Received: from 180.173.110.117 (EHLO [192.168.1.3]) ([180.173.110.117])
          by smtp413.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 28bd4440c9616d1e959253b8a45d5185;
          Wed, 19 Sep 2018 15:40:20 +0000 (UTC)
Subject: Re: [PATCH 4/6] staging: erofs: cleanup
 `z_erofs_vle_normalaccess_readpages'
To:     Chao Yu <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Du Wei <weidu.du@huawei.com>, linux-erofs@lists.ozlabs.org
References: <1537336150-90604-1-git-send-email-gaoxiang25@huawei.com>
 <1537336150-90604-4-git-send-email-gaoxiang25@huawei.com>
 <1b38cbfe-70e0-1e6d-fa50-89b1fddeeb43@kernel.org>
 <fc0f977f-b1c3-41a9-a058-bca4261bf9ea@aol.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <84d5403d-2849-0ba9-d027-9a1c770c271c@aol.com>
Date:   Wed, 19 Sep 2018 23:40:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fc0f977f-b1c3-41a9-a058-bca4261bf9ea@aol.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 2018/9/19 23:32, Gao Xiang via Linux-erofs wrote:
> Hi Chao,
> 
> On 2018/9/19 23:26, Chao Yu wrote:
>> Hi Xiang,
>>
>> On 2018/9/19 13:49, Gao Xiang wrote:
>>> This patch introduces `__should_decompress_synchronously' to
>>> cleanup `z_erofs_vle_normalaccess_readpages'.
>>>
>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>>> ---
>>>  drivers/staging/erofs/internal.h  | 11 +++++++++++
>>>  drivers/staging/erofs/super.c     |  5 +++++
>>>  drivers/staging/erofs/unzip_vle.c | 20 ++++++--------------
>>>  3 files changed, 22 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
>>> index cfcc6db..c84eb97 100644
>>> --- a/drivers/staging/erofs/internal.h
>>> +++ b/drivers/staging/erofs/internal.h
>>> @@ -95,6 +95,9 @@ struct erofs_sb_info {
>>>  	/* the dedicated workstation for compression */
>>>  	struct radix_tree_root workstn_tree;
>>>  
>>> +	/* threshold for decompression synchronously */
>>> +	unsigned int max_sync_decompress_pages;
>>> +
>>>  #ifdef EROFS_FS_HAS_MANAGED_CACHE
>>>  	struct inode *managed_cache;
>>>  #endif
>>> @@ -273,6 +276,14 @@ extern int erofs_try_to_free_cached_page(struct address_space *mapping,
>>>  	struct page *page);
>>>  #endif
>>>  
>>> +#define DEFAULT_MAX_SYNC_DECOMPRESS_PAGES	4
>>> +
>>> +static inline bool __should_decompress_synchronously(struct erofs_sb_info *sbi,
>>> +						     unsigned int nr)
>>> +{
>>> +	return nr <= sbi->max_sync_decompress_pages;
>> -		nr_pages < 4 /* sync */);
>>
>> There is a little bit changed except cleanup, IIUC, would it be any difference
>> of performance around boundary of four pages?
> 
> No.. Once synchronous decompression is applied for 1,2,3 pages for no special reasons.
> But I think it could be better to adjust it to the power of two --- 1,2,3,4 is preferred.
> Since I have no idea to measure which is better or what value is best for all platform or use cases...
> 
> Therefore I tune it in this patch since I don't like the number
> DEFAULT_MAX_SYNC_DECOMPRESS_PAGES == 3 ...

p.s. If you think that is not the cleanup meaning, I will resend this patch with
the original 3. Both are ok for me. it is a minor tuning and I don't have a way
to measure which is better and the best boundary.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>>
