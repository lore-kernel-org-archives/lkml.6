Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4F1ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826D72086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Btsyq5wF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826D72086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbeGQIEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:04:00 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40207 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeGQIEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:04:00 -0400
Received: by mail-ua0-f193.google.com with SMTP id p22-v6so78788uao.7;
        Tue, 17 Jul 2018 00:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qrJPFHLaBDSOL9khb/4YPxbd0lP219BuFiE/MMn/70I=;
        b=Btsyq5wFhLhB+3AzIITNDj8LBIJgHAonmBHKT4WKbIyRqMZTZCYC675JTFA9Swlbao
         S9lKDw/iV4nC0QVhxe2NN12bANPjDtK/tJrwZoaGDoI9F91Ms8kqyp8BDe+1r+xdbBcq
         h5KcFATzUMsRBx7y48Uq4lmKvRabZT0qHuLjGedqrGQUl9G11pEXSiMYfz2C5RTx2Tri
         NxlIyOWwLStqPuR7kIY611M2ztTad71wwzN1Dg/LexQemIXrLZWSTOE7dAUdQHPwU2/0
         04+gRye50ZaKW3rKHN08ErIqd0CAzdfMlKJLZO77BTti5Hi1pPtPBfGYNuqUQ41cYzNB
         LRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qrJPFHLaBDSOL9khb/4YPxbd0lP219BuFiE/MMn/70I=;
        b=Ur08O2x0tUkpae4EKB2QkMvyaTe4ftaS7BkXQqC/QRn+zE76rdEjQeAl8s0qsBS9Ml
         FsOY4MH0CMAuBwBxivFmAqvkT29euf4ANZAh4no0AEHud8nVB1d+1P6PtW903dMbnMVW
         QA4vli2qBTWpOwq5DCfmRf0eoZHmhw++1VBAaa8zEX3Z3pafZjO4xEg8SkLpWsLiu3Ek
         /H3d9Y228aqkXaencPEIxb1T7FMeN8OY8+V0fmQyeEiFQxcd3cwV6AhXQTKP8RrtQtuq
         3PDINJdC11lL+TYiq9c7X1yPK4LdA56l7ldhgdeanVCtFl1lat3SMkKWjs84ryO/GS+n
         MJDg==
X-Gm-Message-State: AOUpUlG8o4ZfVheh5XQiji8rwR5WJRANisWpXpTttu+uZSu2cUd2ypD4
        q6jrN2u7V6HdHjmTLAwkQGXm1cfwEkKPV5oHA3XsedGz
X-Google-Smtp-Source: AAOMgpeKwARGBCoqvCq6bQ7HNay13CnR7CthWT8PJJia5x63LE+UPnDTjbDnHCERN1iBUo/vtl8lnLsSxYAQbiLvcHQ=
X-Received: by 2002:ab0:1b93:: with SMTP id k19-v6mr301571uai.122.1531812765753;
 Tue, 17 Jul 2018 00:32:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 00:32:45
 -0700 (PDT)
In-Reply-To: <20180717065711.28281-4-colyli@suse.de>
References: <20180717065711.28281-1-colyli@suse.de> <20180717065711.28281-4-colyli@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 Jul 2018 10:32:45 +0300
Message-ID: <CAHp75Vfe34n31UAxyqdX63hP7kCYWHo-_LEWx2KLsiW5F9xEEQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lib/test_crc: Add test cases for crc calculation
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

On Tue, Jul 17, 2018 at 9:57 AM, Coly Li <colyli@suse.de> wrote:
> This patch adds a kernel module to test the consistency of multiple crc
> calculation in Linux kernel. It is enabled with CONFIG_TEST_CRC enabled.
>
> The test results are printed into kernel message, which look like,
>
> test_crc: crc64_le: PASSED (0x4e6b1ff972fa8c55, expval 0x4e6b1ff972fa8c55)
> test_crc: crc64_le_bch: PASSED (0x0e4f1391d7a4a62e, expval 0x0e4f1391d7a4a62e)
> test_crc: crc64_le_update: FAILED (0x03d4d0d85685d9a1, expval 0x3d4d0d85685d9a1f)
>
> kernel 0day system has framework to check kernel message, then the above
> result can be handled by 0day system. If crc calculation inconsistency
> happens, it can be detected quite soon.
>
> lib/test_crc.c is a testing frame work for many crc consistency
> testings. For now, there are only test caes for 3 crc routines,
> - crc64_le()
> - crc64_le_bch()
> - crc64_le_update()

> +config TEST_CRC
> +       tristate "CRC calculation test driver"
> +       depends on CRC64

> +       default n

Please, remove it.
You Cc'ed the guy who did this:
http://git.infradead.org/linux-platform-drivers-x86.git/commit/0192f17529fa3f8d78ca0181a2b2aaa7cbb0784d

> +       help
> +         This builds the "test_crc" module. This driver enables to test the
> +         CRC calculation consistency to make sure new modification does not
> +         break existing checksum calculation.

> +static int chk_and_msg(const char *name, __le64 crc, __le64 expval)
> +{
> +       int ret = 0;
> +
> +       if (crc == expval) {
> +               pr_info("test_crc: %s: PASSED:(0x%016llx, expected 0x%016llx)",
> +                       name, crc, expval);
> +       } else {
> +               pr_err("test_crc: %s: FAILED:(0x%016llx, expected 0x%016llx)",
> +                       name, crc, expval);
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}

> +
> +

One of the blank lines is redundant.

> +static int __init test_crc_init(void)
> +{
> +       int i;
> +       int v, ret = 0;
> +
> +       pr_info("Kernel CRC consitency testing:");
> +       for (i = 0; test_data[i].name; i++) {
> +               v = test_data[i].handler(&test_data[i]);
> +               if (v < 0 && ret == 0)
> +                       ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}

Didn't notice anything about statistics.

See, for example,
https://elixir.bootlin.com/linux/v4.18-rc5/source/lib/test_printf.c#L536

-- 
With Best Regards,
Andy Shevchenko
