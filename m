Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074EBC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB1520881
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgiWvShd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB1520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeIKVq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeIKVq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:46:26 -0400
Received: from [192.168.0.101] (unknown [49.77.238.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7A4A2086A;
        Tue, 11 Sep 2018 16:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536684377;
        bh=HdK/WlIel4P8OWRwRUx/XXRP4Uwbg02fKJNsisuMaD4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=cgiWvShd3ArCssGuPtlawCJbi28KfPUAsA8A623n3zZIkQJ66iLjGiCzZfIIT8C1u
         8tLXJqWqAyNfTwJiivvSq3MBpcrTqMXpPnkU7loJ4D1UAd8s6U1+FOY4KugKxKv0cb
         F4Hf4qAcngLK3fPYlMV4ATfTOqoc5BYvEDRYTlnE=
Subject: Re: [PATCH v4] staging: erofs: use explicit unsigned int type
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <23218dc6-8aba-a4e6-7c18-64380082f747@kernel.org>
 <20180910194114.13314-1-linux@weissschuh.net>
From:   Chao Yu <chao@kernel.org>
Message-ID: <1b6fcc86-5b0c-e5b3-15de-63938222213e@kernel.org>
Date:   Wed, 12 Sep 2018 00:46:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910194114.13314-1-linux@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/11 3:41, Thomas Weißschuh wrote:
> Hi Chao,
> 
> On Mon, 2018-09-10T23:59+0800, Chao Yu wrote:
>> [...]
> 
>>>> I was not aware of this tree and worked off of staging / next.
>>>> A patch is attached to this message that adds the tree to the MAINTAINERS file.
>>>
>>> Hi Chao,
>>>
>>> I think this tree has some PREVIEW patches which preview in linux-erofs mailing list only and
>>> doesn't send to staging mailing list and LKML,
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=erofs
>>>
>>> so erofs tree is actually Greg's staging tree.
>>
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
> 
> Thank you for clearing this up! And I am sorry for causing you all this work
> for what is essentially a very small style cleanup.
> 
>> Now I can confirm that your v2 patch can apply on Greg's staging-next, so fixing
>> warning reported by checkpatch.pl on your v2 patch is enough. :)
> 
> The patch follows.
> 
> Thomas
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
> 
> Fix coding style issue "Prefer 'unsigned int' to bare use of 'unsigned'"
> detected by checkpatch.pl.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
