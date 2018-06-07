Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6h23BwqhGVsyXwAAmS7hNA
	; Thu, 07 Jun 2018 21:18:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 021EA6074D; Thu,  7 Jun 2018 21:18:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtVCr8Gy"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5F06A60452;
	Thu,  7 Jun 2018 21:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F06A60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeFGVR7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:17:59 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:45265 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbeFGVR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:17:57 -0400
Received: by mail-ua0-f194.google.com with SMTP id k14-v6so7464578uao.12;
        Thu, 07 Jun 2018 14:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A4DMgyyzKc+oC1zcKxYlyWdtTZBCToBO7GELQdZvUzw=;
        b=mtVCr8GyzDlngPcjYDzPlOddID2JFN38tPzIF7UFKGf1DjK1oroKL7K0pdkPw0wgbE
         xW91ZtIUADAVeI/46Ib/7BYFY2trGxhwKZ0YOIKZT707mgg2Pzv4qatbGvRpTeKS6Vu5
         mooampY80ty1iO/WD+ZQz/gOcKz3a2INT/vI1qWeOpwRvUDoI/d7qqWmvhJw0G/QEr9w
         clNZysIXvi5AmYea0DOb/5UHh7+DxXFVUlEJ1mnAB/UD14E0I7ROgtJ0Zer3qYbY2sPE
         V5RQTk7zDwShH8AI8r8soSukxXQev3fRz6EUYBDuQTvzNM10pW+//pAbLZTygJIvTQQB
         ZUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A4DMgyyzKc+oC1zcKxYlyWdtTZBCToBO7GELQdZvUzw=;
        b=jQJy4X5gjblF3N87vMYZEixhddennXKOGamWkfetEpRRJcQnAA2yixonRHM1nFOvjz
         Szc3PbBMB2gJ9XMrGEdu7neEZQmWUFfjIs9IcrNL5g4YaGm0toPRrVRYAvn4WsU50M+5
         yeCowm8EFmJXsSJBmnZM+4A2wgku+Uft/LesojYKXzL0EYiU5VyNAbMQBzErfj7omJyW
         sUxZgM63l+byDhaZh3iHQu2bdYMJZ6yeAAEqHSGymD30Yh9Pr9rKdyacCPHUgWM6JiHB
         1ORiIUcx3Y8x25SZeD6XFz4HittTQw3U3mS2bKF5Hls1KMiVbvwDldzP3QxQScjaC9v3
         akIg==
X-Gm-Message-State: APt69E2KTYJkBxSo45MBf+e1UYv1dsDxtJnB6HtMM8u5YXhNdhOYoPPs
        QsyEh78sspme2XuufijKxa/lGIY0YpFtpo+j86c=
X-Google-Smtp-Source: ADUXVKLQYCyH4PLUeqoGYUDYmQFfxg7gxWl2F5t+DsnhPTMJBWAJLgZZa1f3vMTwrhQ/QslOglzp54UHOgI1cZ11dM0=
X-Received: by 2002:a9f:2266:: with SMTP id 93-v6mr2405400uad.142.1528406276577;
 Thu, 07 Jun 2018 14:17:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:5494:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 14:17:16 -0700 (PDT)
In-Reply-To: <CADYN=9J3wY1f6q4NvH1mHJXnu6GnErOqz75CfzfG1q5-WzcyCg@mail.gmail.com>
References: <20180607105712.553-1-anders.roxell@linaro.org>
 <CAH3MdRWo0kUYngyAwXP1sOT_XqbxyfTvDd6sNz+qd7LL1T8LUA@mail.gmail.com> <CADYN=9J3wY1f6q4NvH1mHJXnu6GnErOqz75CfzfG1q5-WzcyCg@mail.gmail.com>
From: Y Song <ys114321@gmail.com>
Date: Thu, 7 Jun 2018 14:17:16 -0700
Message-ID: <CAH3MdRXMHRtK9FJ4UP8Gy-bahCS2oipOY7yLTEqu-x6uOMKLvw@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: fix urandom_read build issue
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 12:07 PM, Anders Roxell <anders.roxell@linaro.org> w=
rote:
> On 7 June 2018 at 19:52, Y Song <ys114321@gmail.com> wrote:
>> On Thu, Jun 7, 2018 at 3:57 AM, Anders Roxell <anders.roxell@linaro.org>=
 wrote:
>>> gcc complains that urandom_read gets built twice.
>>>
>>> gcc -o tools/testing/selftests/bpf/urandom_read
>>> -static urandom_read.c -Wl,--build-id
>>> gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../lib/bpf
>>> -I../../../../include/generated  -I../../../include    urandom_read.c
>>> urandom_read -lcap -lelf -lrt -lpthread -o
>>> tools/testing/selftests/bpf/urandom_read
>>> gcc: fatal error: input file
>>> =E2=80=98tools/testing/selftests/bpf/urandom_read=E2=80=99 is the
>>> same as output file
>>> compilation terminated.
>>> ../lib.mk:110: recipe for target
>>> 'tools/testing/selftests/bpf/urandom_read' failed
>>
>> What is the build/make command to reproduce the above failure?
>
> make -C tools/testing/selftests

Thanks. The patch will break
   make -C tools/testing/selftests/bpf

[yhs@localhost bpf-next]$ make -C tools/testing/selftests/bpf
make: Entering directory '/home/yhs/work/bpf-next/tools/testing/selftests/b=
pf'
gcc -o /urandom_read -static urandom_read.c -Wl,--build-id
/usr/bin/ld: cannot open output file /urandom_read: Permission denied
collect2: error: ld returned 1 exit status
make: *** [Makefile:20: /urandom_read] Error 1
make: Leaving directory '/home/yhs/work/bpf-next/tools/testing/selftests/bp=
f'
[yhs@localhost bpf-next]$

Could you still make the above command work?

>
> Cheers,
> Anders
>
>>
>>> To fix this issue remove the urandom_read target and so target
>>> TEST_CUSTOM_PROGS gets used.
>>>
>>> Fixes: 81f77fd0deeb ("bpf: add selftest for stackmap with BPF_F_STACK_B=
UILD_ID")
>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>> ---
>>>  tools/testing/selftests/bpf/Makefile | 6 ++----
>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
>>> index 607ed8729c06..67285591ffd7 100644
>>> --- a/tools/testing/selftests/bpf/Makefile
>>> +++ b/tools/testing/selftests/bpf/Makefile
>>> @@ -16,10 +16,8 @@ LDLIBS +=3D -lcap -lelf -lrt -lpthread
>>>  TEST_CUSTOM_PROGS =3D $(OUTPUT)/urandom_read
>>>  all: $(TEST_CUSTOM_PROGS)
>>>
>>> -$(TEST_CUSTOM_PROGS): urandom_read
>>> -
>>> -urandom_read: urandom_read.c
>>> -       $(CC) -o $(TEST_CUSTOM_PROGS) -static $< -Wl,--build-id
>>> +$(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
>>> +       $(CC) -o $@ -static $< -Wl,--build-id
>>>
>>>  # Order correspond to 'make run_tests' order
>>>  TEST_GEN_PROGS =3D test_verifier test_tag test_maps test_lru_map test_=
lpm_map test_progs \
>>> --
>>> 2.17.1
>>>
