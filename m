Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDEAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7E82075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7E82075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeJKDta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:49:30 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:36416 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeJKDta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:49:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 2985522F3D;
        Wed, 10 Oct 2018 20:25:41 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WK6B_UXAJYo5; Wed, 10 Oct 2018 20:25:41 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 6F13A22F39;
        Wed, 10 Oct 2018 20:25:32 +0000 (UTC)
Subject: Re: [PATCH] selftests/gpio: fix compiling errors
To:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <1537524021-3371-1-git-send-email-lizhijian@cn.fujitsu.com>
 <1372e275-d276-7982-127e-dd339ead1b67@cn.fujitsu.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <ae288c01-5350-5b95-8157-dd377e6738b1@kernel.org>
Date:   Wed, 10 Oct 2018 14:25:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1372e275-d276-7982-127e-dd339ead1b67@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2018 08:32 AM, Li Zhijian wrote:
> ping
> 
> 
> On 09/21/2018 06:00 PM, Li Zhijian wrote:
>> lizhijian@haswell-OptiPlex-9020:/home/lizj/linux/tools/testing/selftests$ make
>> [...snip...]
>> make ARCH=x86 CROSS_COMPILE= -C ../../../gpio
>> make[2]: Entering directory '/home/lizj/linux/tools/gpio'
>> [...snip...]
>> make[3]: Leaving directory '/home/lizj/linux/tools/gpio'
>>    LINK     /home/lizj/linux/tools/testing/selftests/gpiogpio-event-mon
>> make[2]: Leaving directory '/home/lizj/linux/tools/gpio'
>> gcc -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ gpio-mockup-chardev.c ../../../gpio/gpio-utils.o  -lmount -I/usr/include/libmount -o gpio-mockup-chardev
>> gcc: error: ../../../gpio/gpio-utils.o: No such file or directory
>> <builtin>: recipe for target 'gpio-mockup-chardev' failed
>> make[1]: *** [gpio-mockup-chardev] Error 1
>> make[1]: Leaving directory
>> '/home/lizj/linux/tools/testing/selftests/gpio'
>> Makefile:85: recipe for target 'all' failed
>> make: *** [all] Error 2
>>
>> in this patch
>> - correct target name to $OUTPUTgpio-utils.o
>> - pass OUTPUT to tools/gpio/Makefile
>> - support cleanup ../gpiogpio-hammer.o
>>
>> CC: Bamvor Jian Zhang <bamv2005@gmail.com>
>> CC: Bartosz Golaszewski <brgl@bgdev.pl>
>> CC: Shuah Khan <shuah@kernel.org>
>> CC: linux-gpio@vger.kernel.org
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> ---
>>   tools/testing/selftests/gpio/Makefile | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
>> index 4665cdb..7f9354a 100644
>> --- a/tools/testing/selftests/gpio/Makefile
>> +++ b/tools/testing/selftests/gpio/Makefile
>> @@ -7,7 +7,7 @@ EXTRA_PROGS := ../gpiogpio-event-mon ../gpiogpio-hammer ../gpiolsgpio
>>   EXTRA_DIRS := ../gpioinclude/
>>   EXTRA_OBJS := ../gpiogpio-event-mon-in.o ../gpiogpio-event-mon.o
>>   EXTRA_OBJS += ../gpiogpio-hammer-in.o ../gpiogpio-utils.o ../gpiolsgpio-in.o
>> -EXTRA_OBJS += ../gpiolsgpio.o
>> +EXTRA_OBJS += ../gpiolsgpio.o ../gpiogpio-hammer.o
>>     include ../lib.mk
>>   @@ -22,7 +22,7 @@ CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
>>   LDLIBS += -lmount -I/usr/include/libmount
>>     $(BINARIES):| khdr
>> -$(BINARIES): ../../../gpio/gpio-utils.o
>> +$(BINARIES): ../gpiogpio-utils.o
>>   -../../../gpio/gpio-utils.o:
>> -    make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
>> +../gpiogpio-utils.o:
>> +    make OUTPUT=$(OUTPUT) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
> 
Is this still an issue in linux-kselftest next. I applied a few patches
from Fathi Boudra

Please check and let me know if this is till an issue.

thanks,
-- Shuah
