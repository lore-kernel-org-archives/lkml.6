Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id e42PFYyCGVv7FgAAmS7hNA
	; Thu, 07 Jun 2018 19:07:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 393766074D; Thu,  7 Jun 2018 19:07:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gZZ+cg1a"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 98AF16063F;
	Thu,  7 Jun 2018 19:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98AF16063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753683AbeFGTHx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:07:53 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44397 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753028AbeFGTHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:07:50 -0400
Received: by mail-pg0-f65.google.com with SMTP id p21-v6so5192850pgd.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g/9nCp4TpcX4Thh9XSLbPkzRRvyxCOsX5VnH1nqwMGM=;
        b=gZZ+cg1aoCt94UfXUrstx4gTTR3QvUsL90tnRyz5ulj3EHX5MIr2mKV+/2wQ17Yz5D
         Zllu5k1dXXkQFu0i3XmeJzkB9O/TPCO48L14cYqY/BUfSHii+9UIzmrPhJswfiJbsAZ0
         2UkplxcuYUSvxhSW0S1Gm3cg4ksfPeyLIQDGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g/9nCp4TpcX4Thh9XSLbPkzRRvyxCOsX5VnH1nqwMGM=;
        b=ShZ2Mz90ZkI12BjpgDF+kbd8Z0tbBxRuLEDg/oUanroaUehquUh9uA1WZYSPTzg0kf
         ZckvVGsQgnC+ov24lNjCXhpzaxsyVtUZ2o2bO9X0txL2mAXoGY5NAPX2QbVoDDWYJ7QK
         19fnONX5o3F1G2jsBIIi9FB3dnHhJT680ky2+1ZqqGkg0QFJp5EYSZVQPSn7P62cqFVW
         J69Lr67+fXjApxv/qxCEiCZ8O3EsFwloSPyB2jDEefl8TDEKwR+YhxroUNstACV9m5XH
         bX/zJPUt9K39sFBZrhIqpCt7ehSktU3UgonEvx2MuVpKZiY/ZNkZnzwks1p80Z1fyAR1
         DGNg==
X-Gm-Message-State: APt69E1c41QXyFLh4aK8/7KnMhtxejvXQq3qCVkmyvyoiQbAKCOAgPI7
        aBSxjUMtqvVyw+IMAgFkD9IDHLR4MQYUAzuTolvT1w==
X-Google-Smtp-Source: ADUXVKKwW8Yghu/g81VUwRcpZ7gwm2/AhYo9rTKkw6Y77b7f0vhuBpLcdG8kwURSpe0Owxf5POfVqZ/HcfTezsrHxgg=
X-Received: by 2002:a62:e005:: with SMTP id f5-v6mr2903637pfh.88.1528398469962;
 Thu, 07 Jun 2018 12:07:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:178d:0:0:0:0 with HTTP; Thu, 7 Jun 2018 12:07:49
 -0700 (PDT)
In-Reply-To: <CAH3MdRWo0kUYngyAwXP1sOT_XqbxyfTvDd6sNz+qd7LL1T8LUA@mail.gmail.com>
References: <20180607105712.553-1-anders.roxell@linaro.org> <CAH3MdRWo0kUYngyAwXP1sOT_XqbxyfTvDd6sNz+qd7LL1T8LUA@mail.gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 7 Jun 2018 21:07:49 +0200
Message-ID: <CADYN=9J3wY1f6q4NvH1mHJXnu6GnErOqz75CfzfG1q5-WzcyCg@mail.gmail.com>
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

On 7 June 2018 at 19:52, Y Song <ys114321@gmail.com> wrote:
> On Thu, Jun 7, 2018 at 3:57 AM, Anders Roxell <anders.roxell@linaro.org> =
wrote:
>> gcc complains that urandom_read gets built twice.
>>
>> gcc -o tools/testing/selftests/bpf/urandom_read
>> -static urandom_read.c -Wl,--build-id
>> gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../lib/bpf
>> -I../../../../include/generated  -I../../../include    urandom_read.c
>> urandom_read -lcap -lelf -lrt -lpthread -o
>> tools/testing/selftests/bpf/urandom_read
>> gcc: fatal error: input file
>> =E2=80=98tools/testing/selftests/bpf/urandom_read=E2=80=99 is the
>> same as output file
>> compilation terminated.
>> ../lib.mk:110: recipe for target
>> 'tools/testing/selftests/bpf/urandom_read' failed
>
> What is the build/make command to reproduce the above failure?

make -C tools/testing/selftests

Cheers,
Anders

>
>> To fix this issue remove the urandom_read target and so target
>> TEST_CUSTOM_PROGS gets used.
>>
>> Fixes: 81f77fd0deeb ("bpf: add selftest for stackmap with BPF_F_STACK_BU=
ILD_ID")
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> ---
>>  tools/testing/selftests/bpf/Makefile | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index 607ed8729c06..67285591ffd7 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -16,10 +16,8 @@ LDLIBS +=3D -lcap -lelf -lrt -lpthread
>>  TEST_CUSTOM_PROGS =3D $(OUTPUT)/urandom_read
>>  all: $(TEST_CUSTOM_PROGS)
>>
>> -$(TEST_CUSTOM_PROGS): urandom_read
>> -
>> -urandom_read: urandom_read.c
>> -       $(CC) -o $(TEST_CUSTOM_PROGS) -static $< -Wl,--build-id
>> +$(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
>> +       $(CC) -o $@ -static $< -Wl,--build-id
>>
>>  # Order correspond to 'make run_tests' order
>>  TEST_GEN_PROGS =3D test_verifier test_tag test_maps test_lru_map test_l=
pm_map test_progs \
>> --
>> 2.17.1
>>
