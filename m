Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988E4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 01:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB4C20659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 01:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB4C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeJKItI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 04:49:08 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49742 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726007AbeJKItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 04:49:08 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="45899920"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Oct 2018 09:24:16 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id CE99E4B6ED40;
        Thu, 11 Oct 2018 09:24:13 +0800 (CST)
Received: from [10.167.226.45] (10.167.226.45) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.408.0; Thu, 11 Oct 2018 09:24:15 +0800
Subject: Re: [PATCH] selftests/gpio: fix compiling errors
To:     Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>
References: <1537524021-3371-1-git-send-email-lizhijian@cn.fujitsu.com>
 <1372e275-d276-7982-127e-dd339ead1b67@cn.fujitsu.com>
 <ae288c01-5350-5b95-8157-dd377e6738b1@kernel.org>
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
Organization: fnst-ulinux
Message-ID: <1232ce89-27db-d975-ca1c-e4783274ba6e@cn.fujitsu.com>
Date:   Thu, 11 Oct 2018 09:24:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ae288c01-5350-5b95-8157-dd377e6738b1@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-yoursite-MailScanner-ID: CE99E4B6ED40.AD838
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/2018 04:25 AM, Shuah Khan wrote:
> On 10/07/2018 08:32 AM, Li Zhijian wrote:
>> ping
>>
>>
>> On 09/21/2018 06:00 PM, Li Zhijian wrote:
>>> lizhijian@haswell-OptiPlex-9020:/home/lizj/linux/tools/testing/selftests$ make
>>> [...snip...]
>>> make ARCH=x86 CROSS_COMPILE= -C ../../../gpio
>>> make[2]: Entering directory '/home/lizj/linux/tools/gpio'
>>> [...snip...]
>>> make[3]: Leaving directory '/home/lizj/linux/tools/gpio'
>>>     LINK     /home/lizj/linux/tools/testing/selftests/gpiogpio-event-mon
>>> make[2]: Leaving directory '/home/lizj/linux/tools/gpio'
>>> gcc -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ gpio-mockup-chardev.c ../../../gpio/gpio-utils.o  -lmount -I/usr/include/libmount -o gpio-mockup-chardev
>>> gcc: error: ../../../gpio/gpio-utils.o: No such file or directory
>>> <builtin>: recipe for target 'gpio-mockup-chardev' failed
>>> make[1]: *** [gpio-mockup-chardev] Error 1
>>> make[1]: Leaving directory
>>> '/home/lizj/linux/tools/testing/selftests/gpio'
>>> Makefile:85: recipe for target 'all' failed
>>> make: *** [all] Error 2
>>>
>>> in this patch
>>> - correct target name to $OUTPUTgpio-utils.o
>>> - pass OUTPUT to tools/gpio/Makefile
>>> - support cleanup ../gpiogpio-hammer.o
>>>
>>> CC: Bamvor Jian Zhang <bamv2005@gmail.com>
>>> CC: Bartosz Golaszewski <brgl@bgdev.pl>
>>> CC: Shuah Khan <shuah@kernel.org>
>>> CC: linux-gpio@vger.kernel.org
>>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>>> ---
>>>    tools/testing/selftests/gpio/Makefile | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
>>> index 4665cdb..7f9354a 100644
>>> --- a/tools/testing/selftests/gpio/Makefile
>>> +++ b/tools/testing/selftests/gpio/Makefile
>>> @@ -7,7 +7,7 @@ EXTRA_PROGS := ../gpiogpio-event-mon ../gpiogpio-hammer ../gpiolsgpio
>>>    EXTRA_DIRS := ../gpioinclude/
>>>    EXTRA_OBJS := ../gpiogpio-event-mon-in.o ../gpiogpio-event-mon.o
>>>    EXTRA_OBJS += ../gpiogpio-hammer-in.o ../gpiogpio-utils.o ../gpiolsgpio-in.o
>>> -EXTRA_OBJS += ../gpiolsgpio.o
>>> +EXTRA_OBJS += ../gpiolsgpio.o ../gpiogpio-hammer.o
>>>      include ../lib.mk
>>>    @@ -22,7 +22,7 @@ CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
>>>    LDLIBS += -lmount -I/usr/include/libmount
>>>      $(BINARIES):| khdr
>>> -$(BINARIES): ../../../gpio/gpio-utils.o
>>> +$(BINARIES): ../gpiogpio-utils.o
>>>    -../../../gpio/gpio-utils.o:
>>> -    make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
>>> +../gpiogpio-utils.o:
>>> +    make OUTPUT=$(OUTPUT) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
> Is this still an issue in linux-kselftest next. I applied a few patches
> from Fathi Boudra
>
> Please check and let me know if this is till an issue.

This issue is gone in linux-kselftest next, please drop my patch. :)

Thans
  

>
> thanks,
> -- Shuah
>
>
> .
>



