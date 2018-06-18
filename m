Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D91C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8632075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rt6o+GrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8632075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936499AbeFRUot (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:44:49 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34601 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935510AbeFRUos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:44:48 -0400
Received: by mail-vk0-f66.google.com with SMTP id q135-v6so10392644vkh.1;
        Mon, 18 Jun 2018 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6xkUK8GftZCWtkpPvbABuzwDyo7H7LCIYM1BP6zPtjU=;
        b=rt6o+GrQgPjCWY5+pNvNVhZ9lP5/0VHWllmE3hj9gueYIbiHQW3JnI9w77Hcn9kFCy
         o+RNL1qyC8gLTAXZzxYHClAPsNMKottd+jTTzfWeL+Jpn7a7y85xpsGSHWpgFZREcTjr
         UGVjuaZ5ZexTgpNXcSc6yKu2wLkU39w0t9nw7bD+2TDS9wzV2+I2+nrelKAYV+yzDnPI
         UhqkTXbIjZ0LYnMOMRjcQP0OcOUOmoE3eeOeG2jzJb5BKPNVRhKqck4XfLWDP81d0Fq+
         z43w5mxLH6U5Zl964GrQTxNbN/tDnn/7rnvuIwe0smKvGkBB0c23tzksEAgl3ezk+l5s
         kLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6xkUK8GftZCWtkpPvbABuzwDyo7H7LCIYM1BP6zPtjU=;
        b=H2ja5IAKwQZgQWVA3A+KHGNdtx6pxoEtkAHNsPn563ucN7FTJMRVNJWlcPzu2RW3Sb
         UGf4gqsn2ZTbZMWHhtyhYVUWM4XpyuK9qkLLXa5tbVtZEkC4olIFiVlotf7QwtwWW3F5
         icOXv6J0WrDiQCBU203JixHzuxEcaRZeGc8PEEfBibvOeeyYG/szx79+l7deNu0hjTQh
         d6o3W3mJCjd4PwqTi/8uuJFh7RzAc9MPmXTzEHN/+5VnUSzNA18Zq26bArI9ESt34tgL
         5MOtyrEFtry1B+50xfvBLVlFPpw3eS2KVvaaskOgm4erwuypDMfwZdUoNKu5FdmS1tGl
         C0Sw==
X-Gm-Message-State: APt69E3nVQxbLxEprd1G844nqlcVSrdRNadhJYxm0qh78B60btoAbuVb
        +i+ops8IDHmeih0cqgf9qDJEL5bxmuj3hE8sK8k=
X-Google-Smtp-Source: ADUXVKJiuK5LzNXC1aJN2XFqwMDtuVOUC9ELMPIebyUrXEj8IByfD/ZGiAvfU5kK+ZIIy2j/RBUwE7STPvy/8ivXG58=
X-Received: by 2002:a1f:7283:: with SMTP id n125-v6mr7965992vkc.26.1529354687304;
 Mon, 18 Jun 2018 13:44:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 13:44:46
 -0700 (PDT)
In-Reply-To: <20180618203750.28658-3-johannes@sipsolutions.net>
References: <20180618203750.28658-1-johannes@sipsolutions.net> <20180618203750.28658-3-johannes@sipsolutions.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jun 2018 23:44:46 +0300
Message-ID: <CAHp75VfeMBr57Frzvm2vJ2irJQat-6a+_dN9mtftAnwfPT=Bww@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] bitfield: add tests
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:37 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> Add tests for the bitfield helpers. The constant ones will all
> be folded to nothing by the compiler (if everything is correct
> in the header file), and the variable ones do some tests against
> open-coding the necessary shifts.
>
> A few test cases that should fail/warn compilation are provided
> under ifdef.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Though license mismatch. Either GPL-2.0+ for SPDX, or "GPL v2" for _LICENSE().

>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> ---
>  lib/Kconfig.debug   |   7 +++
>  lib/Makefile        |   1 +
>  lib/test_bitfield.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 176 insertions(+)
>  create mode 100644 lib/test_bitfield.c
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index eb885942eb0f..b0870377b4d1 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1799,6 +1799,13 @@ config TEST_BITMAP
>
>           If unsure, say N.
>
> +config TEST_BITFIELD
> +       tristate "Test bitfield functions at runtime"
> +       help
> +         Enable this option to test the bitfield functions at boot.
> +
> +         If unsure, say N.
> +
>  config TEST_UUID
>         tristate "Test functions located in the uuid module at runtime"
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 84c6dcb31fbb..02ab4c1a64d1 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
>  obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
>  obj-$(CONFIG_TEST_PRINTF) += test_printf.o
>  obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
> +obj-$(CONFIG_TEST_BITFIELD) += test_bitfield.o
>  obj-$(CONFIG_TEST_UUID) += test_uuid.o
>  obj-$(CONFIG_TEST_PARMAN) += test_parman.o
>  obj-$(CONFIG_TEST_KMOD) += test_kmod.o
> diff --git a/lib/test_bitfield.c b/lib/test_bitfield.c
> new file mode 100644
> index 000000000000..c9bf2d542244
> --- /dev/null
> +++ b/lib/test_bitfield.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test cases for bitfield helpers.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/bitfield.h>
> +
> +#define CHECK_ENC_GET_U(tp, v, field, res) do {                                \
> +               {                                                       \
> +                       u##tp _res;                                     \
> +                                                                       \
> +                       _res = u##tp##_encode_bits(v, field);           \
> +                       if (_res != res) {                              \
> +                               pr_warn("u" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != " #res "\n",\
> +                                       (u64)_res);                     \
> +                               return -EINVAL;                         \
> +                       }                                               \
> +                       if (u##tp##_get_bits(_res, field) != v)         \
> +                               return -EINVAL;                         \
> +               }                                                       \
> +       } while (0)
> +
> +#define CHECK_ENC_GET_LE(tp, v, field, res) do {                       \
> +               {                                                       \
> +                       __le##tp _res;                                  \
> +                                                                       \
> +                       _res = le##tp##_encode_bits(v, field);          \
> +                       if (_res != cpu_to_le##tp(res)) {               \
> +                               pr_warn("le" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != 0x%llx\n",\
> +                                       (u64)le##tp##_to_cpu(_res),     \
> +                                       (u64)(res));                    \
> +                               return -EINVAL;                         \
> +                       }                                               \
> +                       if (le##tp##_get_bits(_res, field) != v)        \
> +                               return -EINVAL;                         \
> +               }                                                       \
> +       } while (0)
> +
> +#define CHECK_ENC_GET_BE(tp, v, field, res) do {                       \
> +               {                                                       \
> +                       __be##tp _res;                                  \
> +                                                                       \
> +                       _res = be##tp##_encode_bits(v, field);          \
> +                       if (_res != cpu_to_be##tp(res)) {               \
> +                               pr_warn("be" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != 0x%llx\n",\
> +                                       (u64)be##tp##_to_cpu(_res),     \
> +                                       (u64)(res));                    \
> +                               return -EINVAL;                         \
> +                       }                                               \
> +                       if (be##tp##_get_bits(_res, field) != v)        \
> +                               return -EINVAL;                         \
> +               }                                                       \
> +       } while (0)
> +
> +#define CHECK_ENC_GET(tp, v, field, res) do {                          \
> +               CHECK_ENC_GET_U(tp, v, field, res);                     \
> +               CHECK_ENC_GET_LE(tp, v, field, res);                    \
> +               CHECK_ENC_GET_BE(tp, v, field, res);                    \
> +       } while (0)
> +
> +static int test_constants(void)
> +{
> +       /*
> +        * NOTE
> +        * This whole function compiles (or at least should, if everything
> +        * is going according to plan) to nothing after optimisation.
> +        */
> +
> +       CHECK_ENC_GET(16,  1, 0x000f, 0x0001);
> +       CHECK_ENC_GET(16,  3, 0x00f0, 0x0030);
> +       CHECK_ENC_GET(16,  5, 0x0f00, 0x0500);
> +       CHECK_ENC_GET(16,  7, 0xf000, 0x7000);
> +       CHECK_ENC_GET(16, 14, 0x000f, 0x000e);
> +       CHECK_ENC_GET(16, 15, 0x00f0, 0x00f0);
> +
> +       CHECK_ENC_GET_U(8,  1, 0x0f, 0x01);
> +       CHECK_ENC_GET_U(8,  3, 0xf0, 0x30);
> +       CHECK_ENC_GET_U(8, 14, 0x0f, 0x0e);
> +       CHECK_ENC_GET_U(8, 15, 0xf0, 0xf0);
> +
> +       CHECK_ENC_GET(32,  1, 0x00000f00, 0x00000100);
> +       CHECK_ENC_GET(32,  3, 0x0000f000, 0x00003000);
> +       CHECK_ENC_GET(32,  5, 0x000f0000, 0x00050000);
> +       CHECK_ENC_GET(32,  7, 0x00f00000, 0x00700000);
> +       CHECK_ENC_GET(32, 14, 0x0f000000, 0x0e000000);
> +       CHECK_ENC_GET(32, 15, 0xf0000000, 0xf0000000);
> +
> +       CHECK_ENC_GET(64,  1, 0x00000f0000000000ull, 0x0000010000000000ull);
> +       CHECK_ENC_GET(64,  3, 0x0000f00000000000ull, 0x0000300000000000ull);
> +       CHECK_ENC_GET(64,  5, 0x000f000000000000ull, 0x0005000000000000ull);
> +       CHECK_ENC_GET(64,  7, 0x00f0000000000000ull, 0x0070000000000000ull);
> +       CHECK_ENC_GET(64, 14, 0x0f00000000000000ull, 0x0e00000000000000ull);
> +       CHECK_ENC_GET(64, 15, 0xf000000000000000ull, 0xf000000000000000ull);
> +
> +       return 0;
> +}
> +
> +#define CHECK(tp, mask) do {                                           \
> +               u64 v;                                                  \
> +                                                                       \
> +               for (v = 0; v < 1 << hweight32(mask); v++)              \
> +                       if (tp##_encode_bits(v, mask) != v << __ffs64(mask)) \
> +                               return -EINVAL;                         \
> +       } while (0)
> +
> +static int test_variables(void)
> +{
> +       CHECK(u8, 0x0f);
> +       CHECK(u8, 0xf0);
> +       CHECK(u8, 0x38);
> +
> +       CHECK(u16, 0x0038);
> +       CHECK(u16, 0x0380);
> +       CHECK(u16, 0x3800);
> +       CHECK(u16, 0x8000);
> +
> +       CHECK(u32, 0x80000000);
> +       CHECK(u32, 0x7f000000);
> +       CHECK(u32, 0x07e00000);
> +       CHECK(u32, 0x00018000);
> +
> +       CHECK(u64, 0x8000000000000000ull);
> +       CHECK(u64, 0x7f00000000000000ull);
> +       CHECK(u64, 0x0001800000000000ull);
> +       CHECK(u64, 0x0000000080000000ull);
> +       CHECK(u64, 0x000000007f000000ull);
> +       CHECK(u64, 0x0000000018000000ull);
> +       CHECK(u64, 0x0000001f8000000ull);
> +
> +       return 0;
> +}
> +
> +static int __init test_bitfields(void)
> +{
> +       int ret = test_constants();
> +
> +       if (ret) {
> +               pr_warn("constant tests failed!\n");
> +               return ret;
> +       }
> +
> +       ret = test_variables();
> +       if (ret) {
> +               pr_warn("variable tests failed!\n");
> +               return ret;
> +       }
> +
> +#ifdef TEST_BITFIELD_COMPILE
> +       /* these should fail compilation */
> +       CHECK_ENC_GET(16, 16, 0x0f00, 0x1000);
> +       u32_encode_bits(7, 0x06000000);
> +
> +       /* this should at least give a warning */
> +       u16_encode_bits(0, 0x60000);
> +#endif
> +
> +       pr_info("tests passed\n");
> +
> +       return 0;
> +}
> +module_init(test_bitfields)
> +
> +MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
> +MODULE_LICENSE("GPL");
> --
> 2.14.4
>



-- 
With Best Regards,
Andy Shevchenko
