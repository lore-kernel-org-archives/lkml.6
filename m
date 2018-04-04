Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx482egH7CsQOgqSB4BVZm6TbPZtf1XU+F7+YyOFBNuyyWyUO+t0qjd96PxFjk6g+ucmKvnxL
ARC-Seal: i=1; a=rsa-sha256; t=1522856245; cv=none;
        d=google.com; s=arc-20160816;
        b=Y8sf54eF0nR/zTEmpzkB6wRCYWtaeTsuJXYhgsTmzsw0rN5vWV94KR9wU9Dn7kcyXH
         30Kxu5h7HJK8cB5olz61WB5HDZ26jR0rtdb5f604Wbz8f0hjWvbiCzhiCjqGLo2kcBhH
         HanlmxBxy4jKDT7tKQRPNWuWN61mwVvHT8G/iIF0iyq7fnFvNJZL+y/ZyOC2WBolbWkl
         FUMpy+yd9aIZ4pS26tq+wZIjznID14gpIgmsqKDdkRs2oPmSHI8gl8dNb8uAKVPXpmfm
         NzfrOquwwvD3yJOC+ojfGLXcHaSLuopD7bgPdsKkTmPynhNJ1kasERf02da9mBLoR8Rm
         TRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=p6GjOBXJzP6Bfege1xl8YA6yy6hAwtLWkQtgB7ZK06k=;
        b=fSchx0yBgS5VIGbJjPrUtAidaLTr2TySxjIZsbrPwRk9oWu4AJMG84FjbwXQeIoPNu
         XcuvrNZWTVF5cBBuc++4L9jkFf9ShEsCsuM1qthSSgYg22b5FXV9IM3Klt6Nd0GdOS7j
         3hjdZqJZA9IsF55OkGvPrQb+UC3O2kRMGfSeLrHqYqvswIOnS5jvGUjmQd4Vtfp/2mS2
         8DzsLmQAV+aNFIJlTeYiM8tqW1cVSKMKmd++TvCa7HjKjUoFsTUR7Qvh4RfTHT/GiiWt
         7mR4GPmVN3mJRcMjwvAQuRoAIXhm5hOo4hRfyTgrDUORPmplpVwoTMG1b+WypIXC1jaG
         gRUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@oracle.com header.s=corp-2017-10-26 header.b=i79wrFPs;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@oracle.com header.s=corp-2017-10-26 header.b=i79wrFPs;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeDDPcr (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 4 Apr 2018 11:32:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46556 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbeDDPco (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Apr 2018 11:32:44 -0400
Subject: Re: [PATCH 1/2] selftests/memfd/memfd_test.c: fix implicit
 declaration
To: Anders Roxell <anders.roxell@linaro.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>
References: <20180313114205.27714-1-anders.roxell@linaro.org>
 <c3341eb3-623a-b5dd-e0d1-e7b9b6650932@oracle.com>
 <CADYN=9K-=7jOHGmUP+GT9uz7Nwcc801tam+6wf6hUjsKhGEndQ@mail.gmail.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <204aed15-390c-f8eb-a248-d0f8305ab694@oracle.com>
Date: Wed, 4 Apr 2018 08:32:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CADYN=9K-=7jOHGmUP+GT9uz7Nwcc801tam+6wf6hUjsKhGEndQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804040153
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594822578193743011?=
X-GMAIL-MSGID: =?utf-8?q?1596830511013987183?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/04/2018 04:36 AM, Anders Roxell wrote:
> On 14 March 2018 at 02:09, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>> On 03/13/2018 04:42 AM, Anders Roxell wrote:
>>> gcc warns about implicit declaration.
>>>
>>> gcc -D_FILE_OFFSET_BITS=64 -I../../../../include/uapi/
>>>     -I../../../../include/ -I../../../../usr/include/
>>>     memfd_test.c common.o  -o memfd_test
>>> memfd_test.c: In function ‘mfd_assert_get_seals’:
>>> memfd_test.c:74:6: warning: implicit declaration of function ‘fcntl’
>>>     [-Wimplicit-function-declaration]
>>>   r = fcntl(fd, F_GET_SEALS);
>>>       ^~~~~
>>> memfd_test.c: In function ‘mfd_assert_open’:
>>> memfd_test.c:197:6: warning: implicit declaration of function ‘open’
>>>     [-Wimplicit-function-declaration]
>>>   r = open(buf, flags, mode);
>>>       ^~~~
>>> memfd_test.c: In function ‘mfd_assert_write’:
>>> memfd_test.c:328:6: warning: implicit declaration of function ‘fallocate’
>>>     [-Wimplicit-function-declaration]
>>>   r = fallocate(fd,
>>>       ^~~~~~~~~
>>>
>>> In the current code, we include the headers that the functions want
>>> according to the man pages, and we add some defines that will be used if
>>> they isn't found in glibc.  The defines was added into the kernel source
>>> in kernel >= 3.16 and glibc requires kernel header files >= 3.2.
>>>
>>> Fixes: 4f5ce5e8d7e2 ("selftests: add memfd_create() + sealing tests")
>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>> ---
>>>  tools/testing/selftests/memfd/memfd_test.c | 25 ++++++++++++++++++++++++-
>>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
>>> index 10baa1652fc2..0dbeb29c094c 100644
>>> --- a/tools/testing/selftests/memfd/memfd_test.c
>>> +++ b/tools/testing/selftests/memfd/memfd_test.c
>>> @@ -6,7 +6,6 @@
>>>  #include <inttypes.h>
>>>  #include <limits.h>
>>>  #include <linux/falloc.h>
>>> -#include <linux/fcntl.h>
>>>  #include <linux/memfd.h>
>>>  #include <sched.h>
>>>  #include <stdio.h>
>>> @@ -14,13 +13,37 @@
>>>  #include <signal.h>
>>>  #include <string.h>
>>>  #include <sys/mman.h>
>>> +#include <sys/types.h>
>>>  #include <sys/stat.h>
>>>  #include <sys/syscall.h>
>>>  #include <sys/wait.h>
>>> +#include <fcntl.h>
>>>  #include <unistd.h>
>>
>> I suspect there is some guiding philosophy for selftests that I am
>> unfamiliar with.  However, it seems that tests should use as much
>> of the header files in the current kernel source tree as possible.
>> This change removes the include of a header in the current source
>> tree <linux/fcntl.h>.  It replaces that with the header <fcntl.h>
>> from the host system (and some other changes).
>>
>> To me, this seems like step in the wrong direction.  But, I could
>> be totally wrong and perhaps self tests should primarily target the
>> host system header files.
> 
> So in a way I agree with you. However, what was the design decisions
> internal kernel headers vs. headers from Host System ?
> For me it isn't clear how/when we use them, its a mix today is it not?

I am unsure as well.  Was hoping someone who was more involved in the
development/design philosophy of self tests would chime in and comment.

My thought that the tests should use more of the associated kernel header
files is based on the fact that those header files 'should' be more
aligned with the tests.  The host system header files could be very
different than those of the running kernel we are testing.

> To ignore warnings with -Wno-implicit-function-declaration wont be an
> alternative I think.

I am not opposed to your changes.  Again, was just hoping to discover
what should be the direction/philosophy for header file use.

-- 
Mike Kravetz
