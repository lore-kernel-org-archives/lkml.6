Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SkTYCoEPGlvYZgAAmS7hNA
	; Fri, 08 Jun 2018 05:09:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F2011607DC; Fri,  8 Jun 2018 05:09:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnIG6EX0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5F4F0602FC;
	Fri,  8 Jun 2018 05:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F4F0602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbeFHFJS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 01:09:18 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:37919 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbeFHFJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 01:09:17 -0400
Received: by mail-ua0-f196.google.com with SMTP id 59-v6so8081868uas.5;
        Thu, 07 Jun 2018 22:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4jkeYeXOhzL/qM8dV2E38BdfyF0jaduBUSfulGwfRT4=;
        b=TnIG6EX0EjedZpMc3MEWH/x3RpWJDLsxD3Cu731Wj0ZWs1iR42RZjhOr0+7SCZV7El
         QUSVtzWGLEWg/rEOU4pLpKdw3uSI4PCMBk9qnj16MHZXTxVtuiZ4Pdk3PYdnnWLF+Ct9
         hZbxqUQAd6q3ifVzAlkBTQILXf7V2h8adySvmzBg9ZuSsenjA+ZVuPP4K6if6q6v/L2E
         oKtieRorP07W8dGOWgcURRdkWvSQOXvAMxDR5DdwNPNJSCdNDmmRJIekTOgln0S3tS5m
         aFx8V0WXsqnykWQ2+u7XONjTh1egX1E6ySZZO/e7ChmMvvyELEccFaJSvgtuldqrbClY
         VaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4jkeYeXOhzL/qM8dV2E38BdfyF0jaduBUSfulGwfRT4=;
        b=fGvt3/m7ZFaLVIodAwnkize+uYXUhHlTF6SwqvGuI6FS7LG63G2Ri38D55ob3PuibJ
         ppNosZJLEdJEnuOQQ2eXqScK4YcUWx6r6G/6REp1dBsgB7bLDteVQob7UslhzjDpA+ql
         YNbQfjmbEvGVAwU8ruA5QKsMONY6pCvtvAuv++mX9VgTcQV38duPeIZUWjAafuo6dc1X
         kCvSNIv7Aggt7LIdFv9bbn6ZniPVrdATbh6paSJnwzSBpamIgnBMd3Mjk7uuHpiGmk/V
         NBSyN5GFCWfFPAxHhstaj9qGhm6la1ur4fnOlnmdZssyFCt+njQIIpbzQZ5Fya/X3OKi
         tO8w==
X-Gm-Message-State: APt69E3F0dusdN2WXNK05V6zl1j2EIEMCW1ajgCUCunE2kN7ZKHz/PGF
        M9JP75Vq201N3JlCbNeTCYH/RMOcOBhQfWr/T2Gmiy5v
X-Google-Smtp-Source: ADUXVKLaEDvpRi6FccagkFIzPAfK+gxWcvtlRPNM4menfflHoLyR/gCDLUiZ7P66kuzxgbn5H05qNaSObWbRqiR1mDE=
X-Received: by 2002:ab0:3141:: with SMTP id e1-v6mr3356946uam.48.1528434555979;
 Thu, 07 Jun 2018 22:09:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:5494:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 22:08:35 -0700 (PDT)
In-Reply-To: <CADYN=9Ly5UU34CxZFnWfQhNrS8V3gG7=Bdfn9n0h5XphZ8EiVQ@mail.gmail.com>
References: <20180607105712.553-1-anders.roxell@linaro.org>
 <CAH3MdRWo0kUYngyAwXP1sOT_XqbxyfTvDd6sNz+qd7LL1T8LUA@mail.gmail.com>
 <CADYN=9J3wY1f6q4NvH1mHJXnu6GnErOqz75CfzfG1q5-WzcyCg@mail.gmail.com>
 <CAH3MdRXMHRtK9FJ4UP8Gy-bahCS2oipOY7yLTEqu-x6uOMKLvw@mail.gmail.com> <CADYN=9Ly5UU34CxZFnWfQhNrS8V3gG7=Bdfn9n0h5XphZ8EiVQ@mail.gmail.com>
From: Y Song <ys114321@gmail.com>
Date: Thu, 7 Jun 2018 22:08:35 -0700
Message-ID: <CAH3MdRWaVKrYbR14wjn6YjurcHvOFe-=t6g0Me=9=g+GRXqeeg@mail.gmail.com>
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

On Thu, Jun 7, 2018 at 2:43 PM, Anders Roxell <anders.roxell@linaro.org> wr=
ote:
> On 7 June 2018 at 23:17, Y Song <ys114321@gmail.com> wrote:
>> On Thu, Jun 7, 2018 at 12:07 PM, Anders Roxell <anders.roxell@linaro.org=
> wrote:
>>> On 7 June 2018 at 19:52, Y Song <ys114321@gmail.com> wrote:
>>>> On Thu, Jun 7, 2018 at 3:57 AM, Anders Roxell <anders.roxell@linaro.or=
g> wrote:
>>>>> gcc complains that urandom_read gets built twice.
>>>>>
>>>>> gcc -o tools/testing/selftests/bpf/urandom_read
>>>>> -static urandom_read.c -Wl,--build-id
>>>>> gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../lib/b=
pf
>>>>> -I../../../../include/generated  -I../../../include    urandom_read.c
>>>>> urandom_read -lcap -lelf -lrt -lpthread -o
>>>>> tools/testing/selftests/bpf/urandom_read
>>>>> gcc: fatal error: input file
>>>>> =E2=80=98tools/testing/selftests/bpf/urandom_read=E2=80=99 is the
>>>>> same as output file
>>>>> compilation terminated.
>>>>> ../lib.mk:110: recipe for target
>>>>> 'tools/testing/selftests/bpf/urandom_read' failed
>>>>
>>>> What is the build/make command to reproduce the above failure?
>>>
>>> make -C tools/testing/selftests
>>
>> Thanks. The patch will break
>>    make -C tools/testing/selftests/bpf
>>
>> [yhs@localhost bpf-next]$ make -C tools/testing/selftests/bpf
>> make: Entering directory '/home/yhs/work/bpf-next/tools/testing/selftest=
s/bpf'
>> gcc -o /urandom_read -static urandom_read.c -Wl,--build-id
>> /usr/bin/ld: cannot open output file /urandom_read: Permission denied
>> collect2: error: ld returned 1 exit status
>> make: *** [Makefile:20: /urandom_read] Error 1
>> make: Leaving directory '/home/yhs/work/bpf-next/tools/testing/selftests=
/bpf'
>> [yhs@localhost bpf-next]$
>
> urgh, I'm sorry, missed that.
>
>>
>> Could you still make the above command work?
>
> $(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
>         $(CC) -o $(TEST_CUSTOM_PROGS) -static $< -Wl,--build-id
>
> That worked both with:
> make -C tools/testing/selftests
> and
> make -C tools/testing/selftests/bpf
>
> for me.
>
> what do you think?

This indeed works. You can submit a revised patch and add my Ack.
Acked-by: Yonghong Song <yhs@fb.com>
