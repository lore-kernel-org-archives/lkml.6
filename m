Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D786ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0526820684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyNv7yUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0526820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbeGQRp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:45:28 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45293 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbeGQRp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:45:27 -0400
Received: by mail-ua0-f195.google.com with SMTP id k8-v6so1141855uaq.12;
        Tue, 17 Jul 2018 10:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RsqQ7ZdcR1E6QV9d8XKRn8KzhUfdTvA66gHft7FhVKI=;
        b=IyNv7yUpJsuCfZZykHm5/V+HfGlIZ3WQNR/UID/P2J7QA9vLKdHKhZ/E4VFwRy+R9Q
         4aY/GEZlboq8wk8o4hzMOk30MyyLNz1Y/71w0Gke6q+62hsG9Y1O+G/8T7DbucKmzxNc
         S+8MEZvElMuTZioQaHSEaeqmsUQfT3EDkC64Iv6/sbX8vlndYo0nWQrRUIz3Nujt05Yp
         8iJ0ye2WJOT3CopbhUlEYMQT768r44XEOPi1Nhv1sU+6QlJUmZt1PXdcrU5LXd+Ymn4D
         64b3/uMf15J1e8wySxi7tSMllfp/YaKkPQWmwX2B0wGVImk2qiGhiwxxzZIZaBS6oaFV
         i8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RsqQ7ZdcR1E6QV9d8XKRn8KzhUfdTvA66gHft7FhVKI=;
        b=YeSyySyP/OWM+70DsHpaWYfuBKVo8iizyUeDyS5otjvBAmXjHU83aVr2RbwBjQwNFR
         cRQB00m0ieaxI9+Qg+ykoBDXaH0TxOCLRVrhyeciRIMWIhjJ8RDVln6UUQBHkcmSp7aH
         EpjhmxKXGGU/nenJuUc2APra/hBey+l3fN/uAVKGWo9YLd2MBQ4l+37g15LPsSP+Ie0L
         0zqvcnP4QkxZw1FZMocWtqBtCE56yiMLHoKCE2bO9bPI2DMuyZaXu5PpdkenU+Lwp83U
         tbag2h8KCvng5mR+Eb2iNFoOyoqlurlzvdzgQVgW/+bt1PdNi32ctY38X//i4rXNn5wT
         geZw==
X-Gm-Message-State: AOUpUlE4lyrFHD7YRJ3Y+BgVdREehg3M04KVJPJUCf7k1qND53TxRi4b
        s1/snwTRIYTEjtrKha7p0GPE1f6QTHNteB6S0iBn8leu
X-Google-Smtp-Source: AAOMgpf7KQZOGz6Waxy9FQjgvOon6etdrr7kTxxEALM6w/oNvvhVZa0ZbX729lAHrK9Lvk7UVJkdXsjiywxDAr7DpVA=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr1588425uaf.199.1531847509736;
 Tue, 17 Jul 2018 10:11:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 10:11:49
 -0700 (PDT)
In-Reply-To: <20180717145525.50852-4-colyli@suse.de>
References: <20180717145525.50852-1-colyli@suse.de> <20180717145525.50852-4-colyli@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 Jul 2018 20:11:49 +0300
Message-ID: <CAHp75VcXDbDTebddnepeari8_ruynPudbtHGybFEQ=3Cz8Ddvg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] lib/test_crc: Add test cases for crc calculation
To:     Coly Li <colyli@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 5:55 PM, Coly Li <colyli@suse.de> wrote:
> This patch adds a kernel module to test the consistency of multiple crc
> calculation in Linux kernel. It is enabled with CONFIG_TEST_CRC enabled.
>
> The test results are printed into kernel message, which look like,
>
> test_crc: crc64: PASSED (0x4e6b1ff972fa8c55, expected 0x4e6b1ff972fa8c55)
> test_crc: crc64_bch: PASSED (0x0e4f1391d7a4a62e, expected 0x0e4f1391d7a4a62e)
> test_crc: crc64_update: FAILED (0x03d4d0d85685d9a1, expected 0x3d4d0d85685d9a1f)
>
> kernel 0day system has framework to check kernel message, then the above
> result can be handled by 0day system. If crc calculation inconsistency
> happens, it can be detected quite soon.
>
> lib/test_crc.c is a testing frame work for many crc consistency
> testings. For now, there are only test caes for 3 crc routines,
> - crc64()
> - crc64_bch()
> - crc64_update()

Thanks for an update. My comments below.

> Changelog:
> v3: Add test cases passed/failed statistic
>     More fixes for review comments of v2
> v2: Fixes for review comments of v1
> v1: Initial version.

Usually this part goes after --- line below.

> Signed-off-by: Coly Li <colyli@suse.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>

Please, Cc me as well this one in next version (use my Intel address).

> +#include <linux/async.h>
> +#include <linux/delay.h>
> +#include <linux/fs.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/miscdevice.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/vmalloc.h>
> +#include <linux/crc64.h>

Do we need all of them?

> +static int chk_and_msg(const char *name, u64 crc, u64 expval)
> +{

> +       int ret = 0;
> +
> +       if (crc == expval) {

> +               pr_info("test_crc: %s: PASSED:(0x%016llx, expected 0x%016llx)\n",
> +                       name, crc, expval);

This doesn't bring anything useful.

> +       } else {
> +               pr_err("test_crc: %s: FAILED:(0x%016llx, expected 0x%016llx)\n",
> +                       name, crc, expval);
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;

I would rewrite entire function as follows:

static void ...(...)
{
  total_tests++;
  if (crc == expval)
    return;

  pr_err(...);
  failed_tests++;
}


> +}

> +static int __init test_crc_init(void)
> +{
> +       int i;
> +       int v, err = 0;
> +
> +       pr_info("Kernel CRC consitency testing:\n");

> +       for (i = 0; test_data[i].name; i++) {
> +               v = test_data[i].handler(&test_data[i]);
> +               if (v < 0)
> +                       err++;
> +       }

...and correct this to simple
for (...)
 test_data[i].handler(...);

> +       if (err == 0)
> +               pr_info("test_crc: all %d tests passed\n", i);
> +       else
> +               pr_err("test_crc: %d cases tested, %d passed, %d failed\n",
> +                      i, i - err, err);

...and this accordingly.

Note, that in the future someone can add more test cases one or more
of which could not map 1:1 to i here.
That's why the rationale to have two global variables for test statistics.
Also it allows (as you see above) to get rid of return code from all
of those test. We don't interested in them I believe.

> +
> +       return (err == 0) ? 0 : -EINVAL;
> +}

-- 
With Best Regards,
Andy Shevchenko
