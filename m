Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gCxtKIttGVuDUwAAmS7hNA
	; Thu, 07 Jun 2018 17:52:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EA9BF6074D; Thu,  7 Jun 2018 17:52:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrPA/D1Q"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5F3BD601C3;
	Thu,  7 Jun 2018 17:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F3BD601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935108AbeFGRwp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:52:45 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:38202 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933071AbeFGRwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:52:43 -0400
Received: by mail-vk0-f65.google.com with SMTP id b77-v6so6600074vkb.5;
        Thu, 07 Jun 2018 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MwLCCVMUA4y0XFNJhkDSjfwkDA5Z0xsgqOG20bebUsw=;
        b=IrPA/D1QQBCmc2EuDJFmzLNhzcH30dv+y8HwDnrK/Y/zWy8a7FJDDyHHXcHD1y3KXN
         8q88BO0O+ZlJ8DC0nBAHPE+TVeJWgIOaSWruaTsN4mPj8GL0btnZ3qxx/MbMetqO0egG
         4TJiHrPEKWlofb1mL/ByCQ97td5QDHqTze0iaQzzuo25buXxM9q+oph+JzmJYET7v1Db
         xX1iYV0T8WkQkFw+NeBwGZsfvQpGX3ayJwVGIWKp7+3GqqUD09I38F6rt8ceD7bBRHJ5
         YgS2AA8SWLZVNrl1KbxuG2e9ONiYKEzRRuFo+2kej3OHjIUlv5QI4ZioCbn/8cBI/xJD
         Mq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MwLCCVMUA4y0XFNJhkDSjfwkDA5Z0xsgqOG20bebUsw=;
        b=iJYjm6B3JJiWh/nnR6JT7S/rQc3U0wC6M0lrD1kliLruEF5KEunto6jbYqf9wbcngr
         AGKJMRV2UNNI+WkedaMqFwgFAzifCsVlXAIk6Ehw8Ak0Sym+kPKBWrp591zziyHqXwjx
         s9i0M8bL8YzQxPm2sEp04kqJqW2RBOERGkqhjcR8kORo/tion7nuX1ulP65npCvWe2ve
         WKcVS/V3uBFt4DmmwOM86GPWItzUdD+HlyPzd8bhnemunr6qJ4Kv9PlTQcekL2fKH6H9
         0Dp8Ye9lugxVVHhtk0IPE+vHTIMxeGprZLHvT7pjRZZd7saqYDfqk8uZ5z4JN9l8AhlI
         RVyQ==
X-Gm-Message-State: APt69E3PctASWdzD+KCVCFtyBHLwKCICYHrBAGih7xnCtkuu8XN4wfHB
        v6QUfW0hUDpu02qO8sT3Bqk0FSklzYcXwleNLo0=
X-Google-Smtp-Source: ADUXVKKVcKGHWWXvkj3os3LEHu30aWqjtfxwEcjx6EELzY2ZN2GVoiW/VBbTPZ8I4nRFdHlmKW2ted2mZhT7e4DEMfc=
X-Received: by 2002:a1f:c007:: with SMTP id q7-v6mr1930526vkf.144.1528393962481;
 Thu, 07 Jun 2018 10:52:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:5494:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 10:52:02 -0700 (PDT)
In-Reply-To: <20180607105712.553-1-anders.roxell@linaro.org>
References: <20180607105712.553-1-anders.roxell@linaro.org>
From: Y Song <ys114321@gmail.com>
Date: Thu, 7 Jun 2018 10:52:02 -0700
Message-ID: <CAH3MdRWo0kUYngyAwXP1sOT_XqbxyfTvDd6sNz+qd7LL1T8LUA@mail.gmail.com>
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

On Thu, Jun 7, 2018 at 3:57 AM, Anders Roxell <anders.roxell@linaro.org> wr=
ote:
> gcc complains that urandom_read gets built twice.
>
> gcc -o tools/testing/selftests/bpf/urandom_read
> -static urandom_read.c -Wl,--build-id
> gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../lib/bpf
> -I../../../../include/generated  -I../../../include    urandom_read.c
> urandom_read -lcap -lelf -lrt -lpthread -o
> tools/testing/selftests/bpf/urandom_read
> gcc: fatal error: input file
> =E2=80=98tools/testing/selftests/bpf/urandom_read=E2=80=99 is the
> same as output file
> compilation terminated.
> ../lib.mk:110: recipe for target
> 'tools/testing/selftests/bpf/urandom_read' failed

What is the build/make command to reproduce the above failure?

> To fix this issue remove the urandom_read target and so target
> TEST_CUSTOM_PROGS gets used.
>
> Fixes: 81f77fd0deeb ("bpf: add selftest for stackmap with BPF_F_STACK_BUI=
LD_ID")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/bpf/Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 607ed8729c06..67285591ffd7 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -16,10 +16,8 @@ LDLIBS +=3D -lcap -lelf -lrt -lpthread
>  TEST_CUSTOM_PROGS =3D $(OUTPUT)/urandom_read
>  all: $(TEST_CUSTOM_PROGS)
>
> -$(TEST_CUSTOM_PROGS): urandom_read
> -
> -urandom_read: urandom_read.c
> -       $(CC) -o $(TEST_CUSTOM_PROGS) -static $< -Wl,--build-id
> +$(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
> +       $(CC) -o $@ -static $< -Wl,--build-id
>
>  # Order correspond to 'make run_tests' order
>  TEST_GEN_PROGS =3D test_verifier test_tag test_maps test_lru_map test_lp=
m_map test_progs \
> --
> 2.17.1
>
