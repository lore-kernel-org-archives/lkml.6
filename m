Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39404C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1932098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="CAxSo7wT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1932098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbeISVKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:10:50 -0400
Received: from sonic316-8.consmr.mail.gq1.yahoo.com ([98.137.69.32]:40364 "EHLO
        sonic316-8.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728054AbeISVKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1537371141; bh=RrjDZIc6V+vF0BgGGI+ZARbKKPcENhsG7SdNU6O4G1U=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=CAxSo7wTA1lK9yZntZdbfRgJnts9FGAZO/D8IpG8im3rcTjwM6kFURXXBlHV8mrPJbtjSaOk3qxaFccmnjvgy2IpZ6dEWk3IlgeVjUokIpUHZfnnm07wPnG7sucNAKn1XSOS8HZUGpcTrrlNFN9lZA90cHmX7zcccLZ5skhkH4uo/VeP1Ee7BBvQj5gUK6LPaakZ9oVHxfoozrwkVmgsjTQeo3r1Fm0cNyjxW2iXLxCYdNx/v8QSWKkhunG5rYVLQHC2LtnFifIw1AGs/2Q8NdDvuth94FlHou1b2aGHgcZMdOA/mkCpg02dZuUG0U+tT+RqIt8lPKpSGD7DaUxPwA==
X-YMail-OSG: eDlfEQUVM1mk8oCN7j9XS1URcntnA2h.rRqsb78p3QwHddL21kT7Iv3iws2eX.O
 j8i72h.KjfCvGmsVE2jp9yogpqPpdnX3xtbMswouDCaBZzBeIPrVG6maa_d9KDLRQ6dI5mGO1RUE
 HwsrE.Fwi3xrOupoCauYVsbIpeIuQM9kBLHN4ReL53NqK0_AmT4qC0alRc_IKWTSmpyYxf3xgGz3
 YchDZhr88ycOGbXLqNVqgszWiny6pEYh55_vKBK2Ffj58h_ttRTtIUSpNZpGz5.EsmyuNgiuWrEJ
 qudbteGShH6GXjZe2ctqN.u4etUgftnEpHFpwMDKMAyKT5KIj04mAkB2TlgEp2C.H3AF3_iNXjkO
 I1jOs09y5OqayZRbIpFNI..s9RKrLV9qkZ3sKTw9xTs.Zevo_uQdWQZGhFzrpelY6VVglOQUgZ4K
 6IC_JXfnjVyhD4DqBk9wCHflrc18zd9C7zHauhHrJPrGWyHk_mLG07sVpgRSDJQ7_zklXcJXPQct
 qQjuSWhacy4RiN_wwm_c.JvDPXyqbHVvPjcDmf_dYsdxN4mYLMAZuX1.QR1bP7PzK.KdnCaDTW0t
 0XDD1dsU_ZOI0U2KWUS96Fxqo_rcrIXmx_TVTXC_dSaMfxRqjN0uDZz1iX2a.9MV6BtvGUmp2vYp
 E8TxvEVvxCFsHdqjIhVzFLKdFybZeVnV6AQAKwVIBN0ROixHF_rN9.IINwnHzJDLX64UDRzNXvwl
 eA3KsX.NcK.XwtzXqh80iXlrnAdTZQnhmstI6PznhQvYJpj3qFkkMhmk7yhgCa5mU_jlAD2ZK9Q.
 7GUvD7mGb1tmaRnocbnVVeACzURIwf42xUgigwBspdkLMB4f8weNs7Ovhv427TrHlYmLt0w0JHnp
 zKzQ_puLfL8LK39j8Ti..l2Hl7qNHLSoLu.oXbPioJ6JLPykeqnkhkDxKqgRRcoJDHl.fggXtP6c
 5E6ogHwzaHijYlkOU5Vjr.IL_JG0hh0SZ2M78eLl1DmRwskNOAwAo5ephH._vmcVEvaFbSFfvyMe
 PAg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Sep 2018 15:32:21 +0000
Received: from 180.173.110.117 (EHLO [192.168.1.3]) ([180.173.110.117])
          by smtp405.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7e136eb424188ec5952a527bcd80f8f1;
          Wed, 19 Sep 2018 15:32:20 +0000 (UTC)
Subject: Re: [PATCH 4/6] staging: erofs: cleanup
 `z_erofs_vle_normalaccess_readpages'
To:     Chao Yu <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        devel@driverdev.osuosl.org
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, Du Wei <weidu.du@huawei.com>
References: <1537336150-90604-1-git-send-email-gaoxiang25@huawei.com>
 <1537336150-90604-4-git-send-email-gaoxiang25@huawei.com>
 <1b38cbfe-70e0-1e6d-fa50-89b1fddeeb43@kernel.org>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <fc0f977f-b1c3-41a9-a058-bca4261bf9ea@aol.com>
Date:   Wed, 19 Sep 2018 23:32:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1b38cbfe-70e0-1e6d-fa50-89b1fddeeb43@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 2018/9/19 23:26, Chao Yu wrote:
> Hi Xiang,
> 
> On 2018/9/19 13:49, Gao Xiang wrote:
>> This patch introduces `__should_decompress_synchronously' to
>> cleanup `z_erofs_vle_normalaccess_readpages'.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>>  drivers/staging/erofs/internal.h  | 11 +++++++++++
>>  drivers/staging/erofs/super.c     |  5 +++++
>>  drivers/staging/erofs/unzip_vle.c | 20 ++++++--------------
>>  3 files changed, 22 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
>> index cfcc6db..c84eb97 100644
>> --- a/drivers/staging/erofs/internal.h
>> +++ b/drivers/staging/erofs/internal.h
>> @@ -95,6 +95,9 @@ struct erofs_sb_info {
>>  	/* the dedicated workstation for compression */
>>  	struct radix_tree_root workstn_tree;
>>  
>> +	/* threshold for decompression synchronously */
>> +	unsigned int max_sync_decompress_pages;
>> +
>>  #ifdef EROFS_FS_HAS_MANAGED_CACHE
>>  	struct inode *managed_cache;
>>  #endif
>> @@ -273,6 +276,14 @@ extern int erofs_try_to_free_cached_page(struct address_space *mapping,
>>  	struct page *page);
>>  #endif
>>  
>> +#define DEFAULT_MAX_SYNC_DECOMPRESS_PAGES	4
>> +
>> +static inline bool __should_decompress_synchronously(struct erofs_sb_info *sbi,
>> +						     unsigned int nr)
>> +{
>> +	return nr <= sbi->max_sync_decompress_pages;
> -		nr_pages < 4 /* sync */);
> 
> There is a little bit changed except cleanup, IIUC, would it be any difference
> of performance around boundary of four pages?

No.. Once synchronous decompression is applied for 1,2,3 pages for no special reasons.
But I think it could be better to adjust it to the power of two --- 1,2,3,4 is preferred.
Since I have no idea to measure which is better or what value is best for all platform or use cases...

Therefore I tune it in this patch since I don't like the number
DEFAULT_MAX_SYNC_DECOMPRESS_PAGES == 3 ...

Thanks,
Gao Xiang

> 
> Thanks,
> 
