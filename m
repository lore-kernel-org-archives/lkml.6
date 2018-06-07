Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gJz+AxenGVtuCwAAmS7hNA
	; Thu, 07 Jun 2018 21:43:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E9056606FA; Thu,  7 Jun 2018 21:43:50 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DhA6EhCI"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4EAED601B4;
	Thu,  7 Jun 2018 21:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4EAED601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeFGVns (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:43:48 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33091 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752615AbeFGVnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:43:46 -0400
Received: by mail-pl0-f65.google.com with SMTP id n10-v6so6959447plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 14:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y/uNcp7Wu4DEchIu621YW2qvpe+ujcBIyrW9eND/AjI=;
        b=DhA6EhCIbO9OmOZKLcSfFoPfuR+ERL3V7TQCjxbcekpj11z9ftwe7HW8P4KA2qMxsz
         dzv6xoLTTn4jaNhJiV4K4MbWD/0EY2dVknbjymanL3VacUKLwdkG51RcHQbXYjV82+Xt
         A2EcYRKEEhK/4aV+FEil9rfGcl12GbydfAZLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y/uNcp7Wu4DEchIu621YW2qvpe+ujcBIyrW9eND/AjI=;
        b=QJAhFOYxnxejviN0t/TMl16s2rKME/NPqSlq2jUP7eZzZRzolSAEOS604Wuk4O9Sqc
         1sFDf4IGjyvBrj+PdHqSbliNm8SrDhVzWBbjW/h73ET13FyMEUjtRWxezmcQola4rmPb
         l5mLLazI+prFkHxERQGy0qrtr0miVHPWuYgktKCwqo0Y0ixn1jhtW40KvB9tJ9rgawfm
         NiPzYQXLLjBHxHkPUkOIR1t4gWST6OkxzRw62zUvEtviNXpYunkVtVKxjstLRjc3/5n2
         dywxiH2dvzyN1CukoaKOFUHTr3oVTE7tGPWhvGpot1Y0Wt1YSkmZywM63aPKCPmrsWPl
         NwUg==
X-Gm-Message-State: APt69E1FTdcBsEIV1+FsxZdWdmc2C1DVtW5iyo5Yq6CgmWTbW5VrZ84M
        2TkJx2XncQxs96vtPGHMSEdJN6006MclyouS21uOQQ==
X-Google-Smtp-Source: ADUXVKIDLLQs6J9iH6Vjz1ml8yMqUz56xpaSD76prBTfTSfTNT3U0PaPZQtd61HOxm5CigfwizTQ3YLOuLIiRypGbVs=
X-Received: by 2002:a17:902:9309:: with SMTP id bc9-v6mr3691706plb.189.1528407825705;
 Thu, 07 Jun 2018 14:43:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:178d:0:0:0:0 with HTTP; Thu, 7 Jun 2018 14:43:45
 -0700 (PDT)
In-Reply-To: <CAH3MdRXMHRtK9FJ4UP8Gy-bahCS2oipOY7yLTEqu-x6uOMKLvw@mail.gmail.com>
References: <20180607105712.553-1-anders.roxell@linaro.org>
 <CAH3MdRWo0kUYngyAwXP1sOT_XqbxyfTvDd6sNz+qd7LL1T8LUA@mail.gmail.com>
 <CADYN=9J3wY1f6q4NvH1mHJXnu6GnErOqz75CfzfG1q5-WzcyCg@mail.gmail.com> <CAH3MdRXMHRtK9FJ4UP8Gy-bahCS2oipOY7yLTEqu-x6uOMKLvw@mail.gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 7 Jun 2018 23:43:45 +0200
Message-ID: <CADYN=9Ly5UU34CxZFnWfQhNrS8V3gG7=Bdfn9n0h5XphZ8EiVQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: fix urandom_read build issue
To: Y Song <ys114321@gmail.com>
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

On 7 June 2018 at 23:17, Y Song <ys114321@gmail.com> wrote:
> On Thu, Jun 7, 2018 at 12:07 PM, Anders Roxell <anders.roxell@linaro.org>=
 wrote:
>> On 7 June 2018 at 19:52, Y Song <ys114321@gmail.com> wrote:
>>> On Thu, Jun 7, 2018 at 3:57 AM, Anders Roxell <anders.roxell@linaro.org=
> wrote:
>>>> gcc complains that urandom_read gets built twice.
>>>>
>>>> gcc -o tools/testing/selftests/bpf/urandom_read
>>>> -static urandom_read.c -Wl,--build-id
>>>> gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../lib/bp=
f
>>>> -I../../../../include/generated  -I../../../include    urandom_read.c
>>>> urandom_read -lcap -lelf -lrt -lpthread -o
>>>> tools/testing/selftests/bpf/urandom_read
>>>> gcc: fatal error: input file
>>>> =E2=80=98tools/testing/selftests/bpf/urandom_read=E2=80=99 is the
>>>> same as output file
>>>> compilation terminated.
>>>> ../lib.mk:110: recipe for target
>>>> 'tools/testing/selftests/bpf/urandom_read' failed
>>>
>>> What is the build/make command to reproduce the above failure?
>>
>> make -C tools/testing/selftests
>
> Thanks. The patch will break
>    make -C tools/testing/selftests/bpf
>
> [yhs@localhost bpf-next]$ make -C tools/testing/selftests/bpf
> make: Entering directory '/home/yhs/work/bpf-next/tools/testing/selftests=
/bpf'
> gcc -o /urandom_read -static urandom_read.c -Wl,--build-id
> /usr/bin/ld: cannot open output file /urandom_read: Permission denied
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:20: /urandom_read] Error 1
> make: Leaving directory '/home/yhs/work/bpf-next/tools/testing/selftests/=
bpf'
> [yhs@localhost bpf-next]$

urgh, I'm sorry, missed that.

>
> Could you still make the above command work?

$(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
        $(CC) -o $(TEST_CUSTOM_PROGS) -static $< -Wl,--build-id

That worked both with:
make -C tools/testing/selftests
and
make -C tools/testing/selftests/bpf

for me.

what do you think?

>
>>
>> Cheers,
>> Anders
>>
>>>
>>>> To fix this issue remove the urandom_read target and so target
>>>> TEST_CUSTOM_PROGS gets used.
>>>>
>>>> Fixes: 81f77fd0deeb ("bpf: add selftest for stackmap with BPF_F_STACK_=
BUILD_ID")
>>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>>> ---
>>>>  tools/testing/selftests/bpf/Makefile | 6 ++----
>>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/self=
tests/bpf/Makefile
>>>> index 607ed8729c06..67285591ffd7 100644
>>>> --- a/tools/testing/selftests/bpf/Makefile
>>>> +++ b/tools/testing/selftests/bpf/Makefile
>>>> @@ -16,10 +16,8 @@ LDLIBS +=3D -lcap -lelf -lrt -lpthread
>>>>  TEST_CUSTOM_PROGS =3D $(OUTPUT)/urandom_read
>>>>  all: $(TEST_CUSTOM_PROGS)
>>>>
>>>> -$(TEST_CUSTOM_PROGS): urandom_read
>>>> -
>>>> -urandom_read: urandom_read.c
>>>> -       $(CC) -o $(TEST_CUSTOM_PROGS) -static $< -Wl,--build-id
>>>> +$(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
>>>> +       $(CC) -o $@ -static $< -Wl,--build-id
>>>>
>>>>  # Order correspond to 'make run_tests' order
>>>>  TEST_GEN_PROGS =3D test_verifier test_tag test_maps test_lru_map test=
_lpm_map test_progs \
>>>> --
>>>> 2.17.1
>>>>
