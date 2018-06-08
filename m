Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9964Nn8lGlsadAAAmS7hNA
	; Fri, 08 Jun 2018 06:45:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4F1D7607E4; Fri,  8 Jun 2018 06:45:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJy5JzYW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B4A2F6074D;
	Fri,  8 Jun 2018 06:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4A2F6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeFHGpb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:45:31 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37905 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeFHGp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:45:28 -0400
Received: by mail-pl0-f68.google.com with SMTP id b14-v6so7711119pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 23:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GbC4LEzMFLHSLMlkpBvphN8IMpRZIZ+S3/CmwaQxefo=;
        b=AJy5JzYW3yZ09gs4XflPYFYOdgDEy+C8StbRTRmXAImL2maoHvrgbbQtQB9KL0Z/EK
         l31pzI3OwhnKpWgmeLVAi7+gUGZ9jO43NhR64Sni7+gZshtSrMF5I4iLLgdURhliAk5y
         0FonktMqsGzGFMjVDMT5GEHd9mQKcFudeOWh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GbC4LEzMFLHSLMlkpBvphN8IMpRZIZ+S3/CmwaQxefo=;
        b=naVITnV2TpcsbIkmpw74OTf1Fs8rVcyQwK2kpe6b4xeBx4dWrg3HnJF4VQlRll496Y
         MTFqLP9YarO/RXv968pmRsSxIgHfHqY9VQIuov8EP3InF7+8MpDBgwM6AYEjUFkEZKrv
         UxS/2mqqRxbFQVE5JaTIJwyjsnWsdVj3HVDeTQTJmdFpXHlGc+TCs38drZrkP4mrZVtE
         PBTBeP7TtCMrkjV1FSi8Oqn7KRNEV31kekFX0ZQ56BK8gt8r9BvmabS/nhpvio6W8wmM
         qrQSUmY7jiB+EjVjWdF5KpieNtyoi7//QunCwbU4v/Fg684olnzVqaPKg9prazPgTG+t
         xZDg==
X-Gm-Message-State: APt69E2MkolfeDX4rrOJp8A8ddtqJRq2HSfdRNkvMmiaKTMYy3igrWZE
        1y095rRhq+91mzstIEh8WrY82aNOXKxcwfdGZCxTQg==
X-Google-Smtp-Source: ADUXVKLvGzkwiCD1SJq1C56JXm1s9fIzg1ygbo7mk3wierL+pNP/r4CdlWxUU4HvrJQ5yTMZw6QtvYFyj/SD9PbUmxs=
X-Received: by 2002:a17:902:26a:: with SMTP id 97-v6mr5289431plc.367.1528440328296;
 Thu, 07 Jun 2018 23:45:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:178d:0:0:0:0 with HTTP; Thu, 7 Jun 2018 23:45:27
 -0700 (PDT)
In-Reply-To: <CAH3MdRWaVKrYbR14wjn6YjurcHvOFe-=t6g0Me=9=g+GRXqeeg@mail.gmail.com>
References: <20180607105712.553-1-anders.roxell@linaro.org>
 <CAH3MdRWo0kUYngyAwXP1sOT_XqbxyfTvDd6sNz+qd7LL1T8LUA@mail.gmail.com>
 <CADYN=9J3wY1f6q4NvH1mHJXnu6GnErOqz75CfzfG1q5-WzcyCg@mail.gmail.com>
 <CAH3MdRXMHRtK9FJ4UP8Gy-bahCS2oipOY7yLTEqu-x6uOMKLvw@mail.gmail.com>
 <CADYN=9Ly5UU34CxZFnWfQhNrS8V3gG7=Bdfn9n0h5XphZ8EiVQ@mail.gmail.com> <CAH3MdRWaVKrYbR14wjn6YjurcHvOFe-=t6g0Me=9=g+GRXqeeg@mail.gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 8 Jun 2018 08:45:27 +0200
Message-ID: <CADYN=9JEi2=YcC0KD555atZFiJNbP8Y9O0UME+63iTpSSd=ttg@mail.gmail.com>
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

On 8 June 2018 at 07:08, Y Song <ys114321@gmail.com> wrote:
> On Thu, Jun 7, 2018 at 2:43 PM, Anders Roxell <anders.roxell@linaro.org> =
wrote:
>> On 7 June 2018 at 23:17, Y Song <ys114321@gmail.com> wrote:
>>> On Thu, Jun 7, 2018 at 12:07 PM, Anders Roxell <anders.roxell@linaro.or=
g> wrote:
>>>> On 7 June 2018 at 19:52, Y Song <ys114321@gmail.com> wrote:
>>>>> On Thu, Jun 7, 2018 at 3:57 AM, Anders Roxell <anders.roxell@linaro.o=
rg> wrote:
>>>>>> gcc complains that urandom_read gets built twice.
>>>>>>
>>>>>> gcc -o tools/testing/selftests/bpf/urandom_read
>>>>>> -static urandom_read.c -Wl,--build-id
>>>>>> gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../lib/=
bpf
>>>>>> -I../../../../include/generated  -I../../../include    urandom_read.=
c
>>>>>> urandom_read -lcap -lelf -lrt -lpthread -o
>>>>>> tools/testing/selftests/bpf/urandom_read
>>>>>> gcc: fatal error: input file
>>>>>> =E2=80=98tools/testing/selftests/bpf/urandom_read=E2=80=99 is the
>>>>>> same as output file
>>>>>> compilation terminated.
>>>>>> ../lib.mk:110: recipe for target
>>>>>> 'tools/testing/selftests/bpf/urandom_read' failed
>>>>>
>>>>> What is the build/make command to reproduce the above failure?
>>>>
>>>> make -C tools/testing/selftests
>>>
>>> Thanks. The patch will break
>>>    make -C tools/testing/selftests/bpf
>>>
>>> [yhs@localhost bpf-next]$ make -C tools/testing/selftests/bpf
>>> make: Entering directory '/home/yhs/work/bpf-next/tools/testing/selftes=
ts/bpf'
>>> gcc -o /urandom_read -static urandom_read.c -Wl,--build-id
>>> /usr/bin/ld: cannot open output file /urandom_read: Permission denied
>>> collect2: error: ld returned 1 exit status
>>> make: *** [Makefile:20: /urandom_read] Error 1
>>> make: Leaving directory '/home/yhs/work/bpf-next/tools/testing/selftest=
s/bpf'
>>> [yhs@localhost bpf-next]$
>>
>> urgh, I'm sorry, missed that.
>>
>>>
>>> Could you still make the above command work?
>>
>> $(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
>>         $(CC) -o $(TEST_CUSTOM_PROGS) -static $< -Wl,--build-id
>>
>> That worked both with:
>> make -C tools/testing/selftests
>> and
>> make -C tools/testing/selftests/bpf
>>
>> for me.
>>
>> what do you think?
>
> This indeed works. You can submit a revised patch and add my Ack.
> Acked-by: Yonghong Song <yhs@fb.com>

Thank you for your time reviewing this.
I will send that out shortly.


Cheers,
Anders
