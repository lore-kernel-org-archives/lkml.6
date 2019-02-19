Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7C2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A494421773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryJvo0FL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfBSKzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:55:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37490 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSKzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:55:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id q3so2896497pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 02:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMbXI/sRchrAM+Lt4T5cFPwcRP+iUAgWgNMg+rEpV2Q=;
        b=ryJvo0FLUhlr6N5IEtvvdq0ciqoBCkiCI4ouVxLlzFhmwkbq3ZpTNOT4jxiCItzLm/
         LPMmu4YzkX41UVX3pB7etwzAk8ZknyOViDCGFL7K8bxheR0AY4ujcM/bv8PkuwCsIjaW
         ihNCwrC4mN1ZZXX33gUyJScJSOq1s0QwZTOYNthCdcb3dS7OwV8MCQmMQ94iP0LWqXNa
         Kn4ggWFa3d+7j2SLaiPyG6zFkVqohhbaWMTxUA19QY16KUx90Az+R30RKH06B0dGWaod
         UGyiKZDWHwduDcTeKLwwuxRigsyjhXQ8HSVNObDSWq8xfRAtSPFkWOoajq9NWdLiVYlp
         VPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMbXI/sRchrAM+Lt4T5cFPwcRP+iUAgWgNMg+rEpV2Q=;
        b=aftaWM1ZK11UJdwN6wd5IufrV7860HatXOwT6ki1Ho2IOFeq13kVN6HwF9Nzvh8yrw
         uvZigrJUsxLo6XfBfCM2IjOK/5fKyUZ/9rgp9UUyQDE8jZgZZJC0IVlWmDo5IJ757QOp
         V5P9z4lEEwIGS3r0ZV8YAb6FIGkLmMUPUhGV6urVIMttD7yi+ZZm2C7PwdTMteupwE0e
         C0rQ7uGlSCy5AsAXfs7nKirlGye4VQK9Eek7LwUQ3VIB6P0QAkGbrtsCsCrLyk8urzyw
         OJPMSfrnqInk3JEd6MNmJ3BZbxr/OAqFx0M8DAS+1TgqOnKu397wCMbUB9U1a7E8PnSp
         z9aA==
X-Gm-Message-State: AHQUAuYStAopl1mK9/xbhLAOQ3LScyZxOSVT6DlAfz4tPcyOYARXOlFw
        x2Xxy7bz9ul0yxJ0YOBJpluiRQT0g0w+hyAaGh0=
X-Google-Smtp-Source: AHgI3IaZzIuZlHNj4iLsnrcTxoeFCKjFSnBqZz4VHTvrq53TOFX0vvLLEzsAJytGOfo5Jk3s18yhbW3z/lAjff+Rucs=
X-Received: by 2002:a17:902:7682:: with SMTP id m2mr17462519pll.311.1550573720831;
 Tue, 19 Feb 2019 02:55:20 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-2-tobin@kernel.org>
In-Reply-To: <20190218232308.11241-2-tobin@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Feb 2019 12:55:09 +0200
Message-ID: <CAHp75VfP_gyx_+8XKhyJMShooPubpR2KJ7gvzu0Mbv3+TaFTxg@mail.gmail.com>
Subject: Re: [PATCH 1/6] lib/string: Enable string selftesting
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 4:44 AM Tobin C. Harding <tobin@kernel.org> wrote:
>
> Currently we have a test module but it is not tied into the kselftest
> infrastructure.  In preparation for adding string manipulation functions
> and testing we should enable kselftest to utilize the test module.
>
> Enable string testing via kselftest infrastructure.
>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  lib/Kconfig.debug                     | 14 ++++++++++++++
>  lib/Makefile                          |  2 +-
>  lib/test_string.c                     |  4 ++--
>  tools/testing/selftests/lib/Makefile  |  2 +-
>  tools/testing/selftests/lib/config    |  1 +
>  tools/testing/selftests/lib/string.sh | 19 +++++++++++++++++++
>  6 files changed, 38 insertions(+), 4 deletions(-)
>  create mode 100755 tools/testing/selftests/lib/string.sh
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d4df5b24d75e..0dca64c1d8a4 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1802,8 +1802,22 @@ config ASYNC_RAID6_TEST
>  config TEST_HEXDUMP
>         tristate "Test functions located in the hexdump module at runtime"
>
> +config TEST_STRING
> +       tristate "Perform selftest on string manipulation functions"

> +       default n

Redundant

> +       help
> +        Enable this option to test string manipulation functions.
> +       Currently this only tests memset_{16,32,64}.
> +
> +       If unsure, say N.
> +
>  config TEST_STRING_HELPERS
>         tristate "Test functions located in the string_helpers module at runtime"

> +       default n

Redundant

> +       help
> +        Enable this option to unit test code in lib/string_helpers.c
> +
> +        If unsure, say N.
>
>  config TEST_KSTRTOX
>         tristate "Test kstrto*() family of functions at runtime"
> diff --git a/lib/Makefile b/lib/Makefile
> index e1b59da71418..9c30e1fee27f 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -39,7 +39,7 @@ obj-y += bcd.o div64.o sort.o parser.o debug_locks.o random32.o \
>          bsearch.o find_bit.o llist.o memweight.o kfifo.o \
>          percpu-refcount.o rhashtable.o reciprocal_div.o \
>          once.o refcount.o usercopy.o errseq.o bucket_locks.o
> -obj-$(CONFIG_STRING_SELFTEST) += test_string.o
> +obj-$(CONFIG_TEST_STRING) += test_string.o
>  obj-y += string_helpers.o
>  obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
>  obj-y += hexdump.o
> diff --git a/lib/test_string.c b/lib/test_string.c
> index 0fcdb82dca86..a9cba442389a 100644
> --- a/lib/test_string.c
> +++ b/lib/test_string.c
> @@ -111,7 +111,7 @@ static __init int memset64_selftest(void)
>         return 0;
>  }
>
> -static __init int string_selftest_init(void)
> +static __init int test_string_init(void)
>  {
>         int test, subtest;
>
> @@ -137,5 +137,5 @@ static __init int string_selftest_init(void)
>         return 0;
>  }
>
> -module_init(string_selftest_init);
> +module_init(test_string_init);
>  MODULE_LICENSE("GPL v2");
> diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
> index 70d5711e3ac8..2ee4559b277e 100644
> --- a/tools/testing/selftests/lib/Makefile
> +++ b/tools/testing/selftests/lib/Makefile
> @@ -3,6 +3,6 @@
>  # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
>  all:
>
> -TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh
> +TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh string.sh
>
>  include ../lib.mk
> diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
> index 126933bcc950..2032402ad409 100644
> --- a/tools/testing/selftests/lib/config
> +++ b/tools/testing/selftests/lib/config
> @@ -1,3 +1,4 @@
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_BITMAP=m
> +CONFIG_TEST_STRING=m
>  CONFIG_PRIME_NUMBERS=m
> diff --git a/tools/testing/selftests/lib/string.sh b/tools/testing/selftests/lib/string.sh
> new file mode 100755
> index 000000000000..99024b6f3a6a
> --- /dev/null
> +++ b/tools/testing/selftests/lib/string.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Runs string manipulation tests using test_string kernel module
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +if ! /sbin/modprobe -q -n test_string; then
> +       echo "string: module test_string is not found [SKIP]"
> +       exit $ksft_skip
> +fi
> +
> +if /sbin/modprobe -q test_string; then
> +       /sbin/modprobe -q -r test_string
> +       echo "string: ok"
> +else
> +       echo "string: [FAIL]"
> +       exit 1
> +fi
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
