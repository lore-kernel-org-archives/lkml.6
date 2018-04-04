Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/l9CZ9eEjPbF/gdOwf51fTDRviYLNCq6AcOYrBAJQVCNajiCT1m8+Kmiaa0MOiQX1k3UTW
ARC-Seal: i=1; a=rsa-sha256; t=1522841781; cv=none;
        d=google.com; s=arc-20160816;
        b=KsEJ35cmZTGwf/cXUHSL4qREaKGs9iO/ljXuvMUVysmi4xS93Jk/FcVfv1PHs//26M
         npvTqwjJJlL9ExAUd8JHNu8QtjJUzaUSCQ4cfRbWNuAYKyEeu4gduFtRFZYn/Avn1mW1
         f/ZKVMtUvzrG3+CbRZLuRWMSezgruTkf1E0HcdKdQocu50TMYWCT/juExCS29tz8jxzk
         u+BnvX2+61dHumZ9ninYk7m8539nO3rQh0GEnql9UfXxzrnh3xfZBxM5WJ8/t4728hQL
         O9m1IMsUfAy9By5indWu0sdbmEOIwYX0+JiuNR5qmp5kQxxwVeXfpL6jORMjrsb3jwMp
         LJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:cc:to:subject
         :message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature:arc-authentication-results;
        bh=6MlstFKfWOW71FIxlf1LX+FNCXlnV3soB3ht2f+GNH4=;
        b=JLp+ZMef6vm5IH0wgF09F/lVas7QQsPF/lgpUMP6p17s14Sc3aXF/DmA+/IxK+JBNb
         bmy9p1pn0HpsK7XjLu3jBIk5EgjJWPs8BtUgtzSKaUBxdu7uDQV5+99l+o3hUOQLyqoV
         axZUoP4Rsb/Ox+zhZAiS0DW5fGIiOuMabzCfRVKbCboim8/5/welOx5lwbV7UM9ysKr3
         /jzSfTcXTo4OyVtU+3jeeTCOvph1fbb/Ugqsngn+UbTQvZxu7ayOpW8VP+exruxCXTye
         zSvjMECwZtu0aaMT8ALxjtFjii4h0YnXP64CguHZxsadW5agw8wMuE23SFvety5ysl9p
         UW9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=e592dfHc;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=e592dfHc;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeDDLgU (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 4 Apr 2018 07:36:20 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37660 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbeDDLgT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Apr 2018 07:36:19 -0400
MIME-Version: 1.0
In-Reply-To: <c3341eb3-623a-b5dd-e0d1-e7b9b6650932@oracle.com>
References: <20180313114205.27714-1-anders.roxell@linaro.org> <c3341eb3-623a-b5dd-e0d1-e7b9b6650932@oracle.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 4 Apr 2018 13:36:18 +0200
Message-ID: <CADYN=9K-=7jOHGmUP+GT9uz7Nwcc801tam+6wf6hUjsKhGEndQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/memfd/memfd_test.c: fix implicit declaration
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594822578193743011?=
X-GMAIL-MSGID: =?utf-8?q?1596815343505293944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14 March 2018 at 02:09, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> On 03/13/2018 04:42 AM, Anders Roxell wrote:
>> gcc warns about implicit declaration.
>>
>> gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/
>>     -I../../../../include/ -I../../../../usr/include/
>>     memfd_test.c common.o  -o memfd_test
>> memfd_test.c: In function =E2=80=98mfd_assert_get_seals=E2=80=99:
>> memfd_test.c:74:6: warning: implicit declaration of function =E2=80=98fc=
ntl=E2=80=99
>>     [-Wimplicit-function-declaration]
>>   r =3D fcntl(fd, F_GET_SEALS);
>>       ^~~~~
>> memfd_test.c: In function =E2=80=98mfd_assert_open=E2=80=99:
>> memfd_test.c:197:6: warning: implicit declaration of function =E2=80=98o=
pen=E2=80=99
>>     [-Wimplicit-function-declaration]
>>   r =3D open(buf, flags, mode);
>>       ^~~~
>> memfd_test.c: In function =E2=80=98mfd_assert_write=E2=80=99:
>> memfd_test.c:328:6: warning: implicit declaration of function =E2=80=98f=
allocate=E2=80=99
>>     [-Wimplicit-function-declaration]
>>   r =3D fallocate(fd,
>>       ^~~~~~~~~
>>
>> In the current code, we include the headers that the functions want
>> according to the man pages, and we add some defines that will be used if
>> they isn't found in glibc.  The defines was added into the kernel source
>> in kernel >=3D 3.16 and glibc requires kernel header files >=3D 3.2.
>>
>> Fixes: 4f5ce5e8d7e2 ("selftests: add memfd_create() + sealing tests")
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> ---
>>  tools/testing/selftests/memfd/memfd_test.c | 25 +++++++++++++++++++++++=
+-
>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/=
selftests/memfd/memfd_test.c
>> index 10baa1652fc2..0dbeb29c094c 100644
>> --- a/tools/testing/selftests/memfd/memfd_test.c
>> +++ b/tools/testing/selftests/memfd/memfd_test.c
>> @@ -6,7 +6,6 @@
>>  #include <inttypes.h>
>>  #include <limits.h>
>>  #include <linux/falloc.h>
>> -#include <linux/fcntl.h>
>>  #include <linux/memfd.h>
>>  #include <sched.h>
>>  #include <stdio.h>
>> @@ -14,13 +13,37 @@
>>  #include <signal.h>
>>  #include <string.h>
>>  #include <sys/mman.h>
>> +#include <sys/types.h>
>>  #include <sys/stat.h>
>>  #include <sys/syscall.h>
>>  #include <sys/wait.h>
>> +#include <fcntl.h>
>>  #include <unistd.h>
>
> I suspect there is some guiding philosophy for selftests that I am
> unfamiliar with.  However, it seems that tests should use as much
> of the header files in the current kernel source tree as possible.
> This change removes the include of a header in the current source
> tree <linux/fcntl.h>.  It replaces that with the header <fcntl.h>
> from the host system (and some other changes).
>
> To me, this seems like step in the wrong direction.  But, I could
> be totally wrong and perhaps self tests should primarily target the
> host system header files.

So in a way I agree with you. However, what was the design decisions
internal kernel headers vs. headers from Host System ?
For me it isn't clear how/when we use them, its a mix today is it not?

To ignore warnings with -Wno-implicit-function-declaration wont be an
alternative I think.

Cheers,
Anders

> --
> Mike Kravetz
