Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6B4C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E8C20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E8C20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeILLZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:25:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39936 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbeILLZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:25:12 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A742A4A552CF3;
        Wed, 12 Sep 2018 14:22:11 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 12 Sep
 2018 14:22:05 +0800
Subject: Re: [PATCH v4] staging: erofs: use explicit unsigned int type
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
References: <23218dc6-8aba-a4e6-7c18-64380082f747@kernel.org>
 <20180910194114.13314-1-linux@weissschuh.net>
From:   Gao Xiang <gaoxiang25@huawei.com>
CC:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Message-ID: <94678bbe-4d9b-67a7-c3a4-b711fe32c432@huawei.com>
Date:   Wed, 12 Sep 2018 14:21:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180910194114.13314-1-linux@weissschuh.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2018/9/11 3:41, Thomas Weißschuh wrote:
> Hi Chao,
> 
> On Mon, 2018-09-10T23:59+0800, Chao Yu wrote:
>> [...]
>>>> I was not aware of this tree and worked off of staging / next.
>>>> A patch is attached to this message that adds the tree to the MAINTAINERS file.
>>> Hi Chao,
>>>
>>> I think this tree has some PREVIEW patches which preview in linux-erofs mailing list only and
>>> doesn't send to staging mailing list and LKML,
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=erofs
>>>
>>> so erofs tree is actually Greg's staging tree.
>> Thomas,
>>
>> I confirmed that erofs git repository for linux upstream is Greg's staging tree.
>>
>> Let me explain, in order to avoid sending buggy or preview patch, Xiang and me
>> plan to review patches in erofs mailing list first, and then cache reviewed
>> patches in my git tree before sending them to Greg and staging mailing list.
>>
>> Based on that, I'm trying to serialize all erofs patches, expecting that can
>> help those patches sent to staging mailing list can be merged by Greg with
>> lesser conflict. But I made a mistake that my erofs branch has merged some
>> pending patches, result in failing to merge yours, that mislead me to ask you to
>> rebase the code, sorry about that.
> Thank you for clearing this up! And I am sorry for causing you all this work
> for what is essentially a very small style cleanup.
> 
>> Now I can confirm that your v2 patch can apply on Greg's staging-next, so fixing
>> warning reported by checkpatch.pl on your v2 patch is enough. :)
> The patch follows.
> 
> Thomas

Could you please resend your patch seperately? Because it will be easier for Greg to merge.

> 
> 
> Changes since v1:
> 
> * Removed changes that conflicted with
>   [PATCH 1/6] staging: erofs: formatting fix in unzip_vle_lz4.c
> * Added patch description
> 
> Changes since v2:
> 
> * Fixed conflicts with other patchsets
> * Don't introduce new style issues
> 
> Changes since v3:
> 
> * Fixed conflicts with other patchsets
> 
> Note: This patchset should be applied with the "git am --scissors", to
> remove the historic information and this note.
> 
> -- >8 --

I personally think that is not the correct kernel patch style.

Just as Greg's said,
> These changes belong below the --- line, not above it.

LINK: https://lists.ozlabs.org/pipermail/linux-erofs/2018-August/000367.html

For reference, it will help the patch quickly get merged. ;)

and you could add,
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

> 
> Fix coding style issue "Prefer 'unsigned int' to bare use of 'unsigned'"
> detected by checkpatch.pl.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
