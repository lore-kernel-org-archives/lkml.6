Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuoSY5441pDknpiYOYaP1nEWCF8WOLoIb2rEuonQcd1Fa5mZcOSJ+D6tJDARIu1s+CXC6by
ARC-Seal: i=1; a=rsa-sha256; t=1520551804; cv=none;
        d=google.com; s=arc-20160816;
        b=Ob7TgoSuwBLNMFiSZNnFBYE46UlQVuXMDU0fzojLqbY3oL/VliD1gWSuyOuBfr/MH6
         vm0OgyFeKAE6k4QklJGGJWXOZ91IxOFXLNTCcoMz+Lo3vPY/jyPD/xwWmG6PlVpUV3Db
         W5LecZvBIxlY+cnEudIIcS98kFiO5pht1vhi6UEKkVbsoxIgI2lwR0ZemLRagsOadNil
         QfXgr9uXu2CBF5/KEcx8DUrec8dCwSF22waqkr5SLePyLaix1EdoFiQMTQXlpRe/OJSC
         daRZW0q5JgaHJyivJDcPwbw572k52gKTFuY1mpbQoEk8ywo7W7N70ktGZV2ZYGKcoEyK
         vVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=SCa+52K+W6+OZj6Q9hc6Vcbn+iS6XjsiOq6P3SAEoTM=;
        b=C47ryrb99yV3x7+c3QdZsIYKdyH+Pqf2Oqh/LdW7lXylmaVwDgNAyT1sO7h1cyeUeH
         8LvHEkDHXcLP4xeF+qZlHe9LQfCAAkEfahLmfA1fkV0/XQhhebZV62Wbkz69kOp0D+Pc
         IqIz4doMjphW+88ZTFi5VDCFxHml9icjPAixTrunDN2WYweIZtdaedY3R1BpLZYbMh4B
         pBU79zSqh3czp5Ly6hrpZQ5mdUcWPBk4h3WWHjn9XVqP48VAOY7ZAlwuLdvRVD5SDXzy
         VKYy0RaUwkt+7mHvAhmG+oP6MUh8AipZHFGwWssA1JbUA78MWdr7kAo1AWvomb7I9x9m
         AlTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=YNzeMDFX;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=YNzeMDFX;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750857AbeCHXaE (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 18:30:04 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39953 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeCHXaD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 18:30:03 -0500
MIME-Version: 1.0
In-Reply-To: <9e41eb91-8bac-0bf0-987d-8d95c0bfce94@redhat.com>
References: <20180308143741.4415-1-anders.roxell@linaro.org> <9e41eb91-8bac-0bf0-987d-8d95c0bfce94@redhat.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 9 Mar 2018 00:30:02 +0100
Message-ID: <CADYN=9LcM1N3xSEMq_AgF7=JmC-ZPif2=J2mY9X_yqg1gHMb7Q@mail.gmail.com>
Subject: Re: [PATCH] selftests/android/ion: Makefile: fix build error
To: Laura Abbott <labbott@redhat.com>
Cc: shuah@kernel.org, Pintu Kumar <pintu.ping@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594380652226081333?=
X-GMAIL-MSGID: =?utf-8?q?1594414129327838837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 8 March 2018 at 20:32, Laura Abbott <labbott@redhat.com> wrote:
> On 03/08/2018 06:37 AM, Anders Roxell wrote:
>>
>> Fails to build iomap_test.c due to missing include
>>
>> gcc  -I. -I../../../../../drivers/staging/android/uapi/ -Wall -O2 -g
>> ionmap_test.c ipcsocket.c ionutils.c   -o ionmap_test
>> ionmap_test.c:12:27: fatal error: linux/dma-buf.h: No such file or
>> directory
>>   #include <linux/dma-buf.h>
>>                             ^
>> compilation terminated.
>> <builtin>: recipe for target 'ionmap_test' failed
>> make[2]: *** [ionmap_test] Error 1
>>
>> In the current code, we add a new -I ../../../../../usr/include/ to the
>> INCLUDEDIR variable. Also add ionmap_test to the .gitignore file.
>> > Fixes: ac93f7046a53 ("selftests: ion: Add simple test with the vgem
>> > driver")
>
>
> Where is this hash from?

In linux-next.

> It's not in Linus' master branch.
> Are the /usr/include header properly sanitized

That my understanding but please correct me if I'm wrong.

Cheers,
Anders

>, if so that's nice
> because there's been debates before about how best to pick up
> the sanitized headers. I see that used several other places
> around self-tests too. Anyway, you can add
>
> Acked-by: Laura Abbott <labbott@redhat.com>
>
> Thanks,
> Laura
>
>
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> ---
>>   tools/testing/selftests/android/ion/.gitignore | 1 +
>>   tools/testing/selftests/android/ion/Makefile   | 2 +-
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/android/ion/.gitignore
>> b/tools/testing/selftests/android/ion/.gitignore
>> index 67e6f391b2a9..95e8f4561474 100644
>> --- a/tools/testing/selftests/android/ion/.gitignore
>> +++ b/tools/testing/selftests/android/ion/.gitignore
>> @@ -1,2 +1,3 @@
>>   ionapp_export
>>   ionapp_import
>> +ionmap_test
>> diff --git a/tools/testing/selftests/android/ion/Makefile
>> b/tools/testing/selftests/android/ion/Makefile
>> index d23b6d537d8b..e03695287f76 100644
>> --- a/tools/testing/selftests/android/ion/Makefile
>> +++ b/tools/testing/selftests/android/ion/Makefile
>> @@ -1,5 +1,5 @@
>>   -INCLUDEDIR := -I. -I../../../../../drivers/staging/android/uapi/
>> +INCLUDEDIR := -I. -I../../../../../drivers/staging/android/uapi/
>> -I../../../../../usr/include/
>>   CFLAGS := $(CFLAGS) $(INCLUDEDIR) -Wall -O2 -g
>>     TEST_GEN_FILES := ionapp_export ionapp_import ionmap_test
>>
>
