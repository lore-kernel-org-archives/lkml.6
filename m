Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCFEC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D37217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeLXISd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:18:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59856 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726788AbeLXISd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:18:33 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3DB026C5DF62;
        Mon, 24 Dec 2018 16:18:29 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Mon, 24 Dec 2018
 16:18:27 +0800
Subject: Re: [PATCH 1/1] f2fs: fix validation of the block count in
 sanity_check_raw_super
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "kbuild test robot" <lkp@intel.com>
CC:     <kbuild-all@01.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20181221192820.26222-2-martin.blumenstingl@googlemail.com>
 <201812221401.4m4zuU4G%fengguang.wu@intel.com>
 <CAFBinCA=-st_bM0Cz7mu-Hq6Asv5HAXPMwDZUjMj6GqMb8s=hw@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0ad23150-72df-4bcc-851e-1da306e5a027@huawei.com>
Date:   Mon, 24 Dec 2018 16:18:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCA=-st_bM0Cz7mu-Hq6Asv5HAXPMwDZUjMj6GqMb8s=hw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/22 19:08, Martin Blumenstingl wrote:
> On Sat, Dec 22, 2018 at 8:00 AM kbuild test robot <lkp@intel.com> wrote:
>>
>> Hi Martin,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on f2fs/dev-test]
>> [also build test WARNING on v4.20-rc7 next-20181221]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Martin-Blumenstingl/f2fs-fix-sanity_check_raw_super-on-big-endian-machines/20181222-142616
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
>> config: i386-randconfig-x006-201850 (attached as .config)
>> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
>> reproduce:
>>         # save the attached .config to linux build tree
>>         make ARCH=i386
>>
>> All warnings (new ones prefixed by >>):
>>
>>    fs/f2fs/super.c: In function 'sanity_check_raw_super':
>>>> fs/f2fs/super.c:2498:46: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'long long unsigned int' [-Wformat=]
>>        "Wrong segment_count / block_count (%u > %u)",
>>                                                 ~^
>>                                                 %llu
> I sent a v2 with this fixed and Chao Yu's reviewed by included

Sorry, I didn't catch previous print issue on v1, anyway, I'm okay with v2. :)

Thanks,

> 
> .
> 

