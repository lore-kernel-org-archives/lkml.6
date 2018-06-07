Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pptaHvERGVt1KwAAmS7hNA
	; Thu, 07 Jun 2018 11:07:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 24866608B8; Thu,  7 Jun 2018 11:07:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSa/dQMR"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6EFF4607DC;
	Thu,  7 Jun 2018 11:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6EFF4607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeFGLHh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:07:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38409 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932186AbeFGLHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:07:35 -0400
Received: by mail-pl0-f68.google.com with SMTP id b14-v6so5927442pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 04:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MFl4EP+B8XV5a9PfDXfx8E5EQDotN4PEqm2HDvyX5eg=;
        b=WSa/dQMR2oriUESGX2pgy5XZ0yry4pn8WxPE8o2bYcHX4XdjpJH7sm3W3FXEYMDOQG
         XgMutS8XLIGCq9sqMxVFO7bi6YprX1/d6hs8t6G1OIcZnfDXNz3AT7fIKewgEUVbaxf8
         HfGff77w7J4OoOQCBH1FMrWT02WYVzXZ4PwLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MFl4EP+B8XV5a9PfDXfx8E5EQDotN4PEqm2HDvyX5eg=;
        b=uVZjK1auQj9q0bS3PXQbvmO2rDZVXPHhOzoC1zFeO8kn/fCKJLCB8Xm/GdK4zSSpAu
         rMXvN5+RFV1s+ZDpU+eTGeanRWQqnLLyLmcR68z37ykPJRL1yXSc7oaGmgtDodQ5mSvj
         LDu214mnSTyvtxmWXUHgmxF659Gd2bvuIjLYQyQPgDqjpry3KCyFswz9rSiGGKKKXEqX
         0+5ILd6k0LAHS4mbRlUNNF1es5QHvVJP3BqLAypg6rRmqEXKNaNfGDmdPGUUnK/c4Myz
         NfDBmnABEg3tJSU99HaKXhVTMeowYhmo2Oi+zZx5FoQAwOOo0tka/g7hZbMuiDXS0Axu
         6Lpg==
X-Gm-Message-State: APt69E0ibKXjO65GZTlVySCFgz/YUBZB+KPiBa1Aak5Q5SawoWsjMTxv
        QCIp79x5dX30Rlk4Jee+YSe4Sh41o5IHm53wcY2GQg==
X-Google-Smtp-Source: ADUXVKLxJH2I7Wwi7HLmYu2t/d+zdgtvijkpwrcTe6+e9cPhKFlRO60hcaZUPPW9V0cAu5DggHn/iXmu3mqPm43dY6w=
X-Received: by 2002:a17:902:b18b:: with SMTP id s11-v6mr1594796plr.190.1528369654610;
 Thu, 07 Jun 2018 04:07:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:284b:0:0:0:0 with HTTP; Thu, 7 Jun 2018 04:07:33
 -0700 (PDT)
In-Reply-To: <1a021bf3-cf93-aa12-c5a8-1ea6c7900fbb@iogearbox.net>
References: <20180413090351.25662-1-anders.roxell@linaro.org>
 <20180514115809.9803-1-anders.roxell@linaro.org> <1a021bf3-cf93-aa12-c5a8-1ea6c7900fbb@iogearbox.net>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 7 Jun 2018 13:07:33 +0200
Message-ID: <CADYN=9LR5rqf_2vqW0jKixZpnvtM_XyOwJuvXX4hgMwGkD-QoA@mail.gmail.com>
Subject: Re: [PATCH v3] selftests: add headers_install to lib.mk
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Zhang <bamv2005@gmail.com>, brgl@bgdev.pl,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, aarcange@redhat.com,
        linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, alexei.starovoitov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 May 2018 at 21:20, Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 05/14/2018 01:58 PM, Anders Roxell wrote:
>> If the kernel headers aren't installed we can't build all the tests.
>> Add a new make target rule 'khdr' in the file lib.mk to generate the
>> kernel headers and that gets include for every test-dir Makefile that
>> includes lib.mk If the testdir in turn have its own sub-dirs the
>> top_srcdir needs to be set to the linux-rootdir to be able to generate
>> the kernel headers.
>>
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>
>> ---
>>  Makefile                                          | 14 +-------------
>>  scripts/subarch.include                           | 13 +++++++++++++
>>  tools/testing/selftests/android/Makefile          |  2 +-
>>  tools/testing/selftests/android/ion/Makefile      |  1 +
>>  tools/testing/selftests/bpf/Makefile              |  5 ++---
>>  tools/testing/selftests/futex/functional/Makefile |  1 +
>>  tools/testing/selftests/gpio/Makefile             |  7 ++-----
>>  tools/testing/selftests/kvm/Makefile              |  7 ++-----
>>  tools/testing/selftests/lib.mk                    | 10 ++++++++++
>>  tools/testing/selftests/vm/Makefile               |  4 ----
>>  10 files changed, 33 insertions(+), 31 deletions(-)
>>  create mode 100644 scripts/subarch.include
> [...]
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 438d4f93875b..9741609a0eb1 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -16,9 +16,8 @@ LDLIBS += -lcap -lelf -lrt -lpthread
>>  TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
>>  all: $(TEST_CUSTOM_PROGS)
>>
>> -$(TEST_CUSTOM_PROGS): urandom_read
>> -
>> -urandom_read: urandom_read.c
>> +$(TEST_CUSTOM_PROGS):| khdr
>> +$(TEST_CUSTOM_PROGS): urandom_read.c
>>       $(CC) -o $(TEST_CUSTOM_PROGS) -static $<
>>
>>  # Order correspond to 'make run_tests' order
>
> Can you elaborate on the error in BPF you're seeing that would force a
> headers_install for it?

BPF shouldn't be affected, a new revision of the patch does not touch
the bpf/Makefile.
I will send out a patch soon.

Cheers,
Anders

> Some people are running the tools/ infrastructure
> (incl. BPF kselftests) outside of kernel tree where this dependency would
> break their setup. Why BPF bits cannot be fixed otherwise?
>
> Thanks,
> Daniel
