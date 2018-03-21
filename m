Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELssqEFBzGd2BraRlYo5wnXO92v9QQm/xDxWMA6Mdcr43idWkgWCS4xcO2H3vkHMTtbt3qLC
ARC-Seal: i=1; a=rsa-sha256; t=1521651152; cv=none;
        d=google.com; s=arc-20160816;
        b=XXlMXSoHaPjUyMEaCjWhfbU7An7lBTkZplatQH6Ny4bn2E6sf1PrUskm5L/ianka7v
         /Z1ysp3OW6ghLugPFKaHqUF8XL8nj5ttPybOZIQa8IeWWD97CnuG1G+PGgtY/sJK42d9
         R56v0s5jadJKLVzgHQZ5UTUyqQ7sqJIkaTYyCD5T9fcTyfO3eXYgcXrqqM1Aad8Xynfl
         tyYxue3UUYuX85DufZooROsn9sP5E5JEvSoGB1xW2zBhEngZeqVowQhV93tBhjd37oT1
         NmCnK1388jFh8PBUcapDUhmG8pHhQsG00HHqw1rgOheZLtSmBv4FjPwT8pTAh8OKtEAs
         FP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=EGGA2ztu/qqBMZKvdWjH+KL6o0uIoPp133xcF4Y3arE=;
        b=g/cnBM4MbN5sO+alytjXo9tpBpQq3r6S2+NssV1w0V54vmpJLwbVXMhtcJNYLuI5Cp
         MBLTywz+bHtxoHgaf0d8SzLWNstDUTUDVH092v4il0sulp+VRPN+BAyjMHBJ3XXHwq/k
         v3l2qjn9z5orjbuJK6rT50O5P1GRyetp71aXnwoJVYy0i6NVp9VxkaksSa4VxaW7m45T
         vzxglp5KBXmqdz5teNuGYqLdPdk1dyTfGm1nIRA2hcfgL3s+D2pE/gTLiHSi2RlWHtVO
         iBf/UG+Hqgnj7s5dywMbv2EbRWFE7ErMhCHjuehBNStDjcs7uxPr2hqJYTdpP2Eh2rWM
         RMDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbeCUQwb (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Mar 2018 12:52:31 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:59711 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeCUQwa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Mar 2018 12:52:30 -0400
Subject: Re: [PATCH] selftests/android/ion: Makefile: fix build error
To: Anders Roxell <anders.roxell@linaro.org>,
        Laura Abbott <labbott@redhat.com>
Cc: Pintu Kumar <pintu.ping@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180308143741.4415-1-anders.roxell@linaro.org>
 <9e41eb91-8bac-0bf0-987d-8d95c0bfce94@redhat.com>
 <CADYN=9LcM1N3xSEMq_AgF7=JmC-ZPif2=J2mY9X_yqg1gHMb7Q@mail.gmail.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <2cf8f691-0951-57bb-6670-53d762946d9d@kernel.org>
Date: Wed, 21 Mar 2018 10:52:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CADYN=9LcM1N3xSEMq_AgF7=JmC-ZPif2=J2mY9X_yqg1gHMb7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594380652226081333?=
X-GMAIL-MSGID: =?utf-8?q?1595566878401788876?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/08/2018 04:30 PM, Anders Roxell wrote:
> On 8 March 2018 at 20:32, Laura Abbott <labbott@redhat.com> wrote:
>> On 03/08/2018 06:37 AM, Anders Roxell wrote:
>>>
>>> Fails to build iomap_test.c due to missing include
>>>
>>> gcc  -I. -I../../../../../drivers/staging/android/uapi/ -Wall -O2 -g
>>> ionmap_test.c ipcsocket.c ionutils.c   -o ionmap_test
>>> ionmap_test.c:12:27: fatal error: linux/dma-buf.h: No such file or
>>> directory
>>>   #include <linux/dma-buf.h>
>>>                             ^
>>> compilation terminated.
>>> <builtin>: recipe for target 'ionmap_test' failed
>>> make[2]: *** [ionmap_test] Error 1
>>>
>>> In the current code, we add a new -I ../../../../../usr/include/ to the
>>> INCLUDEDIR variable. Also add ionmap_test to the .gitignore file.
>>>> Fixes: ac93f7046a53 ("selftests: ion: Add simple test with the vgem
>>>> driver")
>>
>>
>> Where is this hash from?
> 
> In linux-next.
> 
>> It's not in Linus' master branch.
>> Are the /usr/include header properly sanitized
> 
> That my understanding but please correct me if I'm wrong.
> 
> Cheers,
> Anders
> 
>> , if so that's nice
>> because there's been debates before about how best to pick up
>> the sanitized headers. I see that used several other places
>> around self-tests too. Anyway, you can add
>>
>> Acked-by: Laura Abbott <labbott@redhat.com>
>>

Thanks. Applied to linux-kselftest next for 4.17-rc1

-- Shuah

