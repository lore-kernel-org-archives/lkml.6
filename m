Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D05FC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1572420811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1572420811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeLNBrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:47:31 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:37745 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728203AbeLNBrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:47:31 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07791651|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01534;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.DX8CvOb_1544752047;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DX8CvOb_1544752047)
          by smtp.aliyun-inc.com(10.147.42.22);
          Fri, 14 Dec 2018 09:47:27 +0800
Subject: Re: [PATCH] pstore: fix crypto dependencies of 842/zstd compression
To:     gmpy.liaowx@gmail.com
Cc:     Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1544603038-9373-1-git-send-email-liaoweixiong@allwinnertech.com>
 <CAGXu5j+nTVoD=AMvOcn2bvA4C0mw=LKDbVnDWhUkL3c6mJye_g@mail.gmail.com>
From:   =?UTF-8?B?5buW5aiB6ZuE?= <liaoweixiong@allwinnertech.com>
Message-ID: <653367a2-3aae-4b76-8375-186833d34277@allwinnertech.com>
Date:   Fri, 14 Dec 2018 09:47:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+nTVoD=AMvOcn2bvA4C0mw=LKDbVnDWhUkL3c6mJye_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2018年12月13日 02:43, Kees Cook 写道:
> On Wed, Dec 12, 2018 at 12:24 AM liaoweixiong
> <liaoweixiong@allwinnertech.com> wrote:
>>
>> Reference to commit 58eb5b670747 ("pstore: fix crypto dependencies"),
>> which fixed crypto dependencies of deflate, lzo, lz4 and lz4hc
>> compression, but omitted 842 and newer compression zstd from
>> commit 1021bcf44d0e ("pstore: add zstd compression support")
>>
>> Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
> 
> Were you seeing build or config failures without this patch?
> 
testsdfsdf
> -Kees
> 
>> ---
>>   fs/pstore/Kconfig | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
>> index 0d19d19..7068f45 100644
>> --- a/fs/pstore/Kconfig
>> +++ b/fs/pstore/Kconfig
>> @@ -44,14 +44,14 @@ config PSTORE_LZ4HC_COMPRESS
>>            This option enables LZ4HC (high compression) mode algorithm.
>>
>>   config PSTORE_842_COMPRESS
>> -       bool "842 compression"
>> +       tristate "842 compression"
>>          depends on PSTORE
>>          select CRYPTO_842
>>          help
>>            This option enables 842 compression algorithm support.
>>
>>   config PSTORE_ZSTD_COMPRESS
>> -       bool "zstd compression"
>> +       tristate "zstd compression"
>>          depends on PSTORE
>>          select CRYPTO_ZSTD
>>          help
>> --
>> 1.9.1
>>
> 
> 
