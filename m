Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226WCxTzQSvRCs5PSbWHutk/ZDWy5tPFtsXB0cNoZfg53Lh1H6chTMm+ccXgu3TFLJczqsaB
ARC-Seal: i=1; a=rsa-sha256; t=1519329478; cv=none;
        d=google.com; s=arc-20160816;
        b=zToqR8NqftjeMRjV6nSLev1qv05e3VRdLSJIb0n1695hVVQdXEjAycegVlPCGp4CVA
         AjA7tLVkdFbpXaxVW5ZIFJeBTOxvkWmY27dgeNUXri8xD8N54qn8vlqnZ6W4gD3Uxb9r
         4YRYb0sxEL5pIwwfau56Ui+H9BJ0YAayMR1pSFLe9AwIk7fR3WxlqmZlUXNFr9HRJs9L
         v02vJ8b6iOAwIM49WvzrlaA7GbvLDuQCEMD4VdK7jg3tqk7KdNMTM66gdz2M5e+UT3Xq
         nfqlGUMHeHFa0ndqf5hfB70tb2SF9mJq3gcYTdXR2vCNKfOsZn0XRngbe3/gcSJyGQCz
         6NDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=3uRlsY3Td1tlaWxUaZthtYNFDgiocoYkoIFYjQCW5Ik=;
        b=LM9oAA34nGWweULlGl9vzZzGKqPcEllY/kwgyuEh3vxHeq9Cz4vuuRCOSFTZ7G8zTK
         5mIpQzkTQ68r9xZLAFFTaU5lLIH1naYH9YuAcHYQBItiP2Zf4gUORRAnqdMLliHSyWp/
         24aJC+GhioSO9EtrchcSrdRDtusIrbszvOvoR7spmEqn+vN/PmaH+a8NvCcI9Fxz0zXU
         tlTdn8rtfhnoCXz1aqXyaNe0o2DFvDPQ5wDHJtYnoCn7wDmV0iRIiPJ5CNUfu4nnwswM
         RXvy/UurcHzDqxpl8P/7MKGxarDl61rJ79khdnOq2FoSYHsj4FH1Ago2FOuVTpfdX+/k
         Z8GA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=Hga+mcW2;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=Hga+mcW2;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeBVT5j (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 22 Feb 2018 14:57:39 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37970 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbeBVT5i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Feb 2018 14:57:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180222115307.15063-1-zongbox@gmail.com>
References: <20180222115307.15063-1-zongbox@gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 22 Feb 2018 20:57:36 +0100
Message-ID: <CADYN=9KgBp0+iGDL8x774UUadyo54Za4ESLPk2GUfqFz+7W02Q@mail.gmail.com>
Subject: Re: [PATCH] selftest: fix kselftest-merge depend on 'RUNTIME_TESTING_MENU'
To: Zong Li <zongbox@gmail.com>
Cc: shuah@kernel.org, vincent.legoll@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, mcgrof@kernel.org, davem@davemloft.net,
        Kees Cook <keescook@chromium.org>,
        Fathi Boudra <fathi.boudra@linaro.org>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zong@andestech.com, greentime@andestech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593102038295942155?=
X-GMAIL-MSGID: =?utf-8?q?1593132426541982411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22 February 2018 at 12:53, Zong Li <zongbox@gmail.com> wrote:
> Since the 'commit d3deafaa8b5c ("lib/: make RUNTIME_TESTS a menuconfig
> to ease disabling it all")', the make kselftest-merge cannot merge the
> config dependencies of kselftest to the existing .config file.
>
> These config dependencies of kselftest need to enable the
> 'CONFIG_RUNTIME_TESTING_MENU=y' at the same time.

Is this patch needed when patch sha 'f29c79906064 ("lib/Kconfig.debug: enable
RUNTIME_TESTING_MENU")' find its way into the kernel ?
I think it's in linux-next now.

Cheers,
Anders

>
> Signed-off-by: Zong Li <zong@andestech.com>
> Cc: Greentime Hu <greentime@andestech.com>
> ---
>  tools/testing/selftests/bpf/config         | 1 +
>  tools/testing/selftests/firmware/config    | 1 +
>  tools/testing/selftests/kmod/config        | 1 +
>  tools/testing/selftests/lib/config         | 1 +
>  tools/testing/selftests/net/config         | 1 +
>  tools/testing/selftests/static_keys/config | 1 +
>  tools/testing/selftests/sysctl/config      | 1 +
>  tools/testing/selftests/user/config        | 1 +
>  8 files changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 983dd25d49f4..d93b82144b19 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -1,3 +1,4 @@
> +CONFIG_RUNTIME_TESTING_MENU=y
>  CONFIG_BPF=y
>  CONFIG_BPF_SYSCALL=y
>  CONFIG_NET_CLS_BPF=m
> diff --git a/tools/testing/selftests/firmware/config b/tools/testing/selftests/firmware/config
> index c8137f70e291..01d7445ef007 100644
> --- a/tools/testing/selftests/firmware/config
> +++ b/tools/testing/selftests/firmware/config
> @@ -1 +1,2 @@
> +CONFIG_RUNTIME_TESTING_MENU=y
>  CONFIG_TEST_FIRMWARE=y
> diff --git a/tools/testing/selftests/kmod/config b/tools/testing/selftests/kmod/config
> index 259f4fd6b5e2..37070985e428 100644
> --- a/tools/testing/selftests/kmod/config
> +++ b/tools/testing/selftests/kmod/config
> @@ -1,3 +1,4 @@
> +CONFIG_RUNTIME_TESTING_MENU=y
>  CONFIG_TEST_KMOD=m
>  CONFIG_TEST_LKM=m
>  CONFIG_XFS_FS=m
> diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
> index 126933bcc950..d1fe14c2c8cb 100644
> --- a/tools/testing/selftests/lib/config
> +++ b/tools/testing/selftests/lib/config
> @@ -1,3 +1,4 @@
> +CONFIG_RUNTIME_TESTING_MENU=y
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_BITMAP=m
>  CONFIG_PRIME_NUMBERS=m
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index 7177bea1fdfa..847a99873128 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -1,3 +1,4 @@
> +CONFIG_RUNTIME_TESTING_MENU=y
>  CONFIG_USER_NS=y
>  CONFIG_BPF_SYSCALL=y
>  CONFIG_TEST_BPF=m
> diff --git a/tools/testing/selftests/static_keys/config b/tools/testing/selftests/static_keys/config
> index d538fb774b96..732d17f6b9a1 100644
> --- a/tools/testing/selftests/static_keys/config
> +++ b/tools/testing/selftests/static_keys/config
> @@ -1 +1,2 @@
> +CONFIG_RUNTIME_TESTING_MENU=y
>  CONFIG_TEST_STATIC_KEYS=m
> diff --git a/tools/testing/selftests/sysctl/config b/tools/testing/selftests/sysctl/config
> index 6ca14800d755..772ce8c3c0d9 100644
> --- a/tools/testing/selftests/sysctl/config
> +++ b/tools/testing/selftests/sysctl/config
> @@ -1 +1,2 @@
> +CONFIG_RUNTIME_TESTING_MENU=y
>  CONFIG_TEST_SYSCTL=y
> diff --git a/tools/testing/selftests/user/config b/tools/testing/selftests/user/config
> index 784ed8416324..f9f491fa4ae8 100644
> --- a/tools/testing/selftests/user/config
> +++ b/tools/testing/selftests/user/config
> @@ -1 +1,2 @@
> +CONFIG_RUNTIME_TESTING_MENU=y
>  CONFIG_TEST_USER_COPY=m
> --
> 2.16.1
>
