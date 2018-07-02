Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FA3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2617A255A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPLi2aE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2617A255A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932819AbeGBJrp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:47:45 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:39506 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753942AbeGBJrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:47:40 -0400
Received: by mail-pf0-f182.google.com with SMTP id s21-v6so7260319pfm.6;
        Mon, 02 Jul 2018 02:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9ZFvG/lInhfPQWu5nPdz4fsjEiRt4NHAVL7HPyOBNUg=;
        b=JPLi2aE7M+ZoiQfUpAyZbbn911X0Gm/3CsSLxpYAWM+kv5dmGr7ytNM7lUPZ8D0Cdq
         GSvriJ3aInUJyPfHcASKJiCzitFs9t7+z5vFXC3ti9hhtYLr/ZiCCS6zw3R+oqKMtRw9
         BUeA5SBN5F8py7Lxqtbxp/fp9sJebZy+n0NkUW5+UI+5OTfsb+Ng5Cedwjehfni7VHxu
         +Y3kxfh64+UVtnSVwDwG5axFrweDK8EKlkLboohHEI59R1XPnPWwMjE0mUEH8WJXM3Hf
         vWKrPCSuC3Y8i2qBzkN+Kh6eQpz5cM96KGjcELJS25LTAYUKI0lZAPWSrC/4kR1nM6V6
         0Zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ZFvG/lInhfPQWu5nPdz4fsjEiRt4NHAVL7HPyOBNUg=;
        b=L0Yx1ibP8ZSlTAVz8bRck8Pqq33ckPMwyOKtx4StzOmVJnbHpYvZuBKz0x21uIf1yW
         8no6C7JhxQvu2YVAtynMvlzlHVIEPdSctivJ/Y24d4fWoR/RJoL2fV20TMrVSZw1IYKY
         HBK/viFLWZQh7TQOLYicAxR0oWTrufxRAMTrwTQ53S1AFP4rNxKow+ao9ufOYePmJl2V
         Qz6f2Po5fzqnNIvlV/EkoMvL5xIh6vmLGDlgzz0/nXLwvpjJ0XZQyNsb1uSTIjGFRNZ2
         NlWvgK80UpsUk2TQTvjP9kq2vfjHaKqyKC/lf8BOal6MkqJHZYBiLzYfrK76uOZqFCGR
         z3lw==
X-Gm-Message-State: APt69E1yehcrVlwpQ2+jX/BcLKx3bwEQxW4KeD3pug0ElNqEWYQzS4Dv
        iSKUEEc71ozKtXMSbGUu+67Oyp05
X-Google-Smtp-Source: AAOMgpf6RnVkmehD/gwkrfVjk/syrCYNanOIOnySf+8CefpkjOHwQ9pRUPb71Dfc2gXqoiEF/FSOOA==
X-Received: by 2002:a62:e00a:: with SMTP id f10-v6mr6723350pfh.208.1530524859598;
        Mon, 02 Jul 2018 02:47:39 -0700 (PDT)
Received: from [192.168.0.77] ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id y81-v6sm41381364pfd.178.2018.07.02.02.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 02:47:38 -0700 (PDT)
Subject: Re: [PATCH 3/4] samples/bpf: Check the error of write() and read()
To:     David Laight <David.Laight@ACULAB.COM>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Teng Qin <qinteng@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1530522893-8961-1-git-send-email-treeze.taeung@gmail.com>
 <1530522893-8961-4-git-send-email-treeze.taeung@gmail.com>
 <c8fd15978e6642158c7e64190e4dee13@AcuMS.aculab.com>
From:   Taeung Song <treeze.taeung@gmail.com>
Message-ID: <a80014c4-e74e-179d-3a6e-352704af0b7d@gmail.com>
Date:   Mon, 2 Jul 2018 18:47:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c8fd15978e6642158c7e64190e4dee13@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David Laight,

On 07/02/2018 06:25 PM, David Laight wrote:
> From: Taeung Song
>> Sent: 02 July 2018 10:15
>> test_task_rename() and test_urandom_read()
>> can be failed during write() and read(),
>> So check the result of them.
>>
>> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
>> ---
>>   samples/bpf/test_overhead_user.c | 20 +++++++++++++++-----
>>   1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/samples/bpf/test_overhead_user.c b/samples/bpf/test_overhead_user.c
>> index 6caf47a..8a88d9c 100644
>> --- a/samples/bpf/test_overhead_user.c
>> +++ b/samples/bpf/test_overhead_user.c
>> @@ -6,6 +6,7 @@
>>    */
>>   #define _GNU_SOURCE
>>   #include <sched.h>
>> +#include <errno.h>
>>   #include <stdio.h>
>>   #include <sys/types.h>
>>   #include <asm/unistd.h>
>> @@ -44,8 +45,12 @@ static void test_task_rename(int cpu)
>>   		exit(1);
>>   	}
>>   	start_time = time_get_ns();
>> -	for (i = 0; i < MAX_CNT; i++)
>> -		write(fd, buf, sizeof(buf));
>> +	for (i = 0; i < MAX_CNT; i++) {
>> +		if (write(fd, buf, sizeof(buf)) < 0) {
>> +			printf("task rename failed: %s\n", strerror(errno));
>> +			break;
> 
> I'm not sure 'break' generates sensible output.
> 

OK,
it seems to be better to off on the above error case instead of break;

>> +		}
>> +	}
> 
> What about partial writes??
> 
Hum..
do you mean just skipping several errors of the above write() ?

>>   	printf("task_rename:%d: %lld events per sec\n",
>>   	       cpu, MAX_CNT * 1000000000ll / (time_get_ns() - start_time));
>>   	close(fd);
>> @@ -55,7 +60,7 @@ static void test_urandom_read(int cpu)
>>   {
>>   	__u64 start_time;
>>   	char buf[4];
>> -	int i, fd;
>> +	int i, fd, err = 0;
>>
>>   	fd = open("/dev/urandom", O_RDONLY);
>>   	if (fd < 0) {
>> @@ -63,8 +68,13 @@ static void test_urandom_read(int cpu)
>>   		exit(1);
>>   	}
>>   	start_time = time_get_ns();
>> -	for (i = 0; i < MAX_CNT; i++)
>> -		read(fd, buf, sizeof(buf));
>> +	for (i = 0; i < MAX_CNT; i++) {
>> +		err = read(fd, buf, sizeof(buf));
>> +		if (err < 0 || err >= sizeof(buf)) {
> 
> Overlong reads indicate that something is seriously awry.
> Short reads are valid - but maybe not expected.
>> +			printf("failed to read from /dev/urandom: %s\n", strerror(errno));
> 
> 
> strerror() won't give anything sensible unless err == -1;
> You probably want to include the loop count.
> 
>> +			break;
> 
> The summary print will be gibberish after break.
> 

Ditto, will change the code to do exit(1);
on the err == -1 case.
What do you think about it ?

Thanks,
Taeung

>> +		}
>> +	}
>>   	printf("urandom_read:%d: %lld events per sec\n",
>>   	       cpu, MAX_CNT * 1000000000ll / (time_get_ns() - start_time));
>>   	close(fd);
>> --
>> 2.7.4
> 
