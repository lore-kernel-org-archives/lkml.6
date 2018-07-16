Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D03ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA51208EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMKxML5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA51208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeGPVQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:16:22 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33319 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbeGPVQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:16:22 -0400
Received: by mail-vk0-f68.google.com with SMTP id y70-v6so20091214vkc.0;
        Mon, 16 Jul 2018 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=etkEXwGfXyUJQa+sYW985/GS+26wbrqrTfhHlLeZzlU=;
        b=SMKxML5fwDle0VbDSeVOkxwWGKQablH/tgkPs6ns2ENPvrg4zfWBV9EF/nOQ1yHOII
         mJGUCBG8LDoZLvGwsyE4ax2AELEvVTvxXwqujOmNNT5D3yW74zNx5XHGk9jgEEjStZEn
         iXfecMav+eWgcogaBXXPkbrS1Igqpgq4kvgaDMkDmzZrmq/TyupFrt+gMnU45YpM2NcO
         ZEmgdjKiznH/USjyqL0+x7NDTwLpOs70T/irfOZ0Qol7UIHLBanwJNkaWP1dKeJD7RN2
         KT0fyglhbFYkV4k3H/nPyhs+KhrBIbew9eMRu//dF/5Z5e/VRIp4ow4sOEZyMWt14VCM
         HvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=etkEXwGfXyUJQa+sYW985/GS+26wbrqrTfhHlLeZzlU=;
        b=MiioyBBfCbjzTBKk+cR7psT7+pELstkL4UjFFa+1uJUmTtmprK7T/cGBnHIvOVr0i4
         8vpibAj9xqPemYwQx428HWcxwUxLki0krCLHSRhpNfsA321KE+l0+8Mjb0ZeIqOOglKl
         0iSwcbCBue6rwcGkdodTNV5cAEMEtubp4xsOX0tu3x7Xe9Tx9sduXMEASZGxwHP1x83d
         4Gckm7pt1rMcSwhaQmEAO0d8FO+fLoNQAHNj7PpIlo3Z2V2nssbmI7aPnYcsfv3PjaeY
         bBkmEmksEWmVIjl0MISPf7+4rFZg7giBl3yt63vHM0537ZivXDTmcRisUdZMSlQc0uFQ
         KW6w==
X-Gm-Message-State: AOUpUlF6X1yNRb/6MupSiLd0mbzmnL98TM51/0TZdJVPSb2oQ5aBCLQT
        nRq2vr43qS74gGWgdmvCeo2mQlKsGyg0k3P9sKeROCKx
X-Google-Smtp-Source: AAOMgpcjaVxbo2eXRPi8mCoEIXu4xoQyNmw9eJ8g3JvMljZc3D65nTmQJNfyvp4XdYcjZwvjCTnvYovZc8lokDLJ6rs=
X-Received: by 2002:a1f:50c:: with SMTP id 12-v6mr10318562vkf.26.1531774034622;
 Mon, 16 Jul 2018 13:47:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 13:47:14
 -0700 (PDT)
In-Reply-To: <20180716165507.23100-5-colyli@suse.de>
References: <20180716165507.23100-1-colyli@suse.de> <20180716165507.23100-5-colyli@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 16 Jul 2018 23:47:14 +0300
Message-ID: <CAHp75VchQOrUU1pA3GRraXO=gdhr9Uwibxo-ri1W_mwtehRtyw@mail.gmail.com>
Subject: Re: [PATCH 4/4] lib/test_crc: Add test cases for crc calculation
To:     Coly Li <colyli@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 7:55 PM, Coly Li <colyli@suse.de> wrote:
> This patch adds a kernel module to test the consistency of multiple crc
> calculation in Linux kernel. It is enabled with CONFIG_TEST_CRC enabled.
>
> The test results are printed into kernel message, which look like,
>
> test_crc: crc64_le: PASSED (0x4e6b> +
1ff972fa8c55, expval 0x4e6b1ff972fa8c55)
> test_crc: crc64_le_bch: PASSED (0x0e4f1391d7a4a62e, expval 0x0e4f1391d7a4a62e)
> test_crc: crc64_le_update: FAILED (0x03d4d0d85685d9a1, expval 0x3d4d0d85685d9a1f)
>
> kernel 0day system has framework to check kernel message, then the above
> result can be handled by 0day system. If crc calculation inconsistency
> happens, it can be detected quite soon.
>
> lib/test_crc.c can is a testing frame work for all crc consistency
> testings. For now, there are only test caes for 3 crc routines,
> - crc64_le()
> - crc64_le_bch()
> - crc64_le_update()

> +config TEST_CRC
> +       tristate "CRC calculation test driver"

> +       default n

Default default is n.

> +       depends on CRC64

> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/fs.h>
> +#include <linux/miscdevice.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/async.h>
> +#include <linux/delay.h>
> +#include <linux/vmalloc.h>
> +#include <linux/crc64.h>

Perhaps in order?

Moreover, either init.h or module.h depending on the Kconfig (here
seems module.h is a right choice).

> +struct crc_test_record {

> +

Redundant.

> +       char    *name;
> +       __le64  data[4];
> +       __le64  initval;
> +       __le64  expval;
> +       int     (*handler)(struct crc_test_record *rec);
> +};
> +
> +static int chk_and_msg(const char *name, __le64 crc, __le64 expval)
> +{
> +       int ret = 0;
> +
> +       if (crc == expval) {
> +               pr_info("test_crc: %s: PASSED:(0x%016llx, expval 0x%016llx)",
> +                       name, crc, expval);
> +       } else {
> +               pr_err("test_crc: %s: FAILED:(0x%016llx, expval 0x%016llx)",
> +                       name, crc, expval);
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;

Perhaps collect statistics instead how it's done in many other tests?

> +}
> +
> +/* Add your crc test caese here */

caese ?

> +static int test_crc64_le(struct crc_test_record *rec)
> +{
> +       __le64 crc;
> +
> +       crc = crc64_le(rec->data, sizeof(rec->data));
> +       return chk_and_msg(rec->name, crc, rec->expval);

> +

Redundant.

> +}

> +       { .name = NULL, }

Simple {} would work.

> +static int __init test_crc_init(void)
> +{
> +       int i;
> +       int v, ret = 0;
> +
> +       pr_info("Kernel crc consitency testing:");
> +       for (i = 0; test_data[i].name; i++) {

> +               v = test_data[i].handler(&test_data[i]);
> +               if (v < 0 && ret == 0)
> +                       ret = -EINVAL;

A bit strange. Anyway, better to collect statistics and print it at
the end with corresponding return code.

> +       }
> +
> +       return ret;
> +}

> +late_initcall(test_crc_init);

Why?

> +static void __exit test_crc_exit(void) { }
> +module_exit(test_crc_exit);

> +MODULE_LICENSE("GPL");

It's not the same as in SPDX.

-- 
With Best Regards,
Andy Shevchenko
