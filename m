Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+HEqfAwBlk1MLhq1ZP4eZer2LTnjdnzfu49KHNXaGD+erwn1I2vgPqUVINZfiQWzRoB2pN
ARC-Seal: i=1; a=rsa-sha256; t=1522857256; cv=none;
        d=google.com; s=arc-20160816;
        b=P1oHATPSdSqF9blRMaQNnC3jGmXI8/An1EpBLv3ww3v1DKAWcs3SnNXQu8Mlqs6lbB
         BG7c+7eNTSWeSHR5xbH8VgugIafd/Hm0e4VOH7/lU003MXOrtne+wZB3YfaaWRbDkBYP
         TpzWIO/MM0/ftxeZHeZBTYp4xZkr8+pazlqZGNC7OXGI1PF5T8X7/AMgYK+uWXcNhgLN
         SsfG5b0C3lTwIh9ckFUc5/1ERlj3zbXOtiVPpWqaXDlWe83jJlGzfYUqJBfDX1qQ2Rp8
         /nSxNOQnwQvddhWLp6QPu+mbQrwfcrafM2HUW23xXz+znhwxRRLQBwCcG49BUPZJEDGZ
         AcMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=zttJBmTYUXAYw4j1CzgkrxcJcxmpR8uCSA51+TyEGCQ=;
        b=vT1MPcrUaHle8R8NrUlbS4+orbBXFUjuSs6OQR2Pgf+wXLCCOi560NlP+d9WH1X8pa
         6YmLRlWXN1i+kYQcvSJNKtxc9hwPHWhDlkvwI0zzE9UDNRvijGFNf/uITR0C4WqjX+ec
         jD2H3ZNTF9kK3Z3Vd6hgcmcd9IYZHguSXYJUNMWzrNf9B5Wg0z11baJQ4P4citW4ZNVk
         EcQdE65lMKkGgE/XGZTBJroxevcDfgxZ/njQLFj3nJChptbfWHUa8doe6afrbYwnb8iA
         3BGsvJj/p9ggwY1yJZ5sUSW1EkaGA3t3A7hB5MCjbt8nYlra2nkm1DAfTTzogAXwUIfu
         keIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbeDDPyQ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 4 Apr 2018 11:54:16 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:55577 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbeDDPyP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Apr 2018 11:54:15 -0400
Subject: Re: [PATCH 1/2] selftests/memfd/memfd_test.c: fix implicit
 declaration
To: Mike Kravetz <mike.kravetz@oracle.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc: linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>
References: <20180313114205.27714-1-anders.roxell@linaro.org>
 <c3341eb3-623a-b5dd-e0d1-e7b9b6650932@oracle.com>
 <CADYN=9K-=7jOHGmUP+GT9uz7Nwcc801tam+6wf6hUjsKhGEndQ@mail.gmail.com>
 <204aed15-390c-f8eb-a248-d0f8305ab694@oracle.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <75028421-267e-bb1f-a912-5387362eef8b@kernel.org>
Date: Wed, 4 Apr 2018 09:54:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <204aed15-390c-f8eb-a248-d0f8305ab694@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594822578193743011?=
X-GMAIL-MSGID: =?utf-8?q?1596831570898060429?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/04/2018 09:32 AM, Mike Kravetz wrote:
> On 04/04/2018 04:36 AM, Anders Roxell wrote:
>> On 14 March 2018 at 02:09, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>> On 03/13/2018 04:42 AM, Anders Roxell wrote:
>>>> gcc warns about implicit declaration.
>>>>
>>>> gcc -D_FILE_OFFSET_BITS=64 -I../../../../include/uapi/
>>>>     -I../../../../include/ -I../../../../usr/include/
>>>>     memfd_test.c common.o  -o memfd_test
>>>> memfd_test.c: In function ‘mfd_assert_get_seals’:
>>>> memfd_test.c:74:6: warning: implicit declaration of function ‘fcntl’
>>>>     [-Wimplicit-function-declaration]
>>>>   r = fcntl(fd, F_GET_SEALS);
>>>>       ^~~~~
>>>> memfd_test.c: In function ‘mfd_assert_open’:
>>>> memfd_test.c:197:6: warning: implicit declaration of function ‘open’
>>>>     [-Wimplicit-function-declaration]
>>>>   r = open(buf, flags, mode);
>>>>       ^~~~
>>>> memfd_test.c: In function ‘mfd_assert_write’:
>>>> memfd_test.c:328:6: warning: implicit declaration of function ‘fallocate’
>>>>     [-Wimplicit-function-declaration]
>>>>   r = fallocate(fd,
>>>>       ^~~~~~~~~
>>>>
>>>> In the current code, we include the headers that the functions want
>>>> according to the man pages, and we add some defines that will be used if
>>>> they isn't found in glibc.  The defines was added into the kernel source
>>>> in kernel >= 3.16 and glibc requires kernel header files >= 3.2>>>>
>>>> Fixes: 4f5ce5e8d7e2 ("selftests: add memfd_create() + sealing tests")
>>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>>> ---
>>>>  tools/testing/selftests/memfd/memfd_test.c | 25 ++++++++++++++++++++++++-
>>>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
>>>> index 10baa1652fc2..0dbeb29c094c 100644
>>>> --- a/tools/testing/selftests/memfd/memfd_test.c
>>>> +++ b/tools/testing/selftests/memfd/memfd_test.c
>>>> @@ -6,7 +6,6 @@
>>>>  #include <inttypes.h>
>>>>  #include <limits.h>
>>>>  #include <linux/falloc.h>
>>>> -#include <linux/fcntl.h>

We don't want to change this to fix the warnings. This will defeat
the purpose of testing the kernel including the headers.

>>>>  #include <linux/memfd.h>
>>>>  #include <sched.h>
>>>>  #include <stdio.h>
>>>> @@ -14,13 +13,37 @@
>>>>  #include <signal.h>
>>>>  #include <string.h>
>>>>  #include <sys/mman.h>
>>>> +#include <sys/types.h>
>>>>  #include <sys/stat.h>
>>>>  #include <sys/syscall.h>
>>>>  #include <sys/wait.h>
>>>> +#include <fcntl.h>
>>>>  #include <unistd.h>
>>>
>>> I suspect there is some guiding philosophy for selftests that I am
>>> unfamiliar with.  However, it seems that tests should use as much
>>> of the header files in the current kernel source tree as possible.
>>> This change removes the include of a header in the current source
>>> tree <linux/fcntl.h>.  It replaces that with the header <fcntl.h>
>>> from the host system (and some other changes).
>>>
>>> To me, this seems like step in the wrong direction.  But, I could
>>> be totally wrong and perhaps self tests should primarily target the
>>> host system header files.
>>
>> So in a way I agree with you. However, what was the design decisions
>> internal kernel headers vs. headers from Host System ?
>> For me it isn't clear how/when we use them, its a mix today is it not?

Internal headers are the primary focus to be able to find regressions.

> 
> I am unsure as well.  Was hoping someone who was more involved in the
> development/design philosophy of self tests would chime in and comment.
> 
> My thought that the tests should use more of the associated kernel header
> files is based on the fact that those header files 'should' be more
> aligned with the tests.  The host system header files could be very
> different than those of the running kernel we are testing.

Right. The goal for these tests is to verify the kernel including the
headers. So for best results, the tests should be built with the headers
in the kernel not the ones that are installed on the system they are being
built on.

thanks,
-- Shuah
