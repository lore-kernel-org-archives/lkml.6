Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97806C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62806218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJLHQBt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfADONy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 09:13:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35693 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfADONy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 09:13:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so17570457pgs.2;
        Fri, 04 Jan 2019 06:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPkeIuAoYJnDBM5bhSuNhJIsEJe0X5Bke9g4zUI6DLc=;
        b=eJLHQBt7ZeLQJVm9J7XXst3Dx04k62clKBIJylYWJkwxIEpSfcnL3AY4WI+t5XN67S
         tpJCLOWTTxKRV6F95Nj8rKAx48Bl4b+Jk4RrIq2keIx4Qi8K11CXWiyABgliHT8ChSh3
         bxtIgNMVI1v4kKAVq+sETv1tsSEB2rQ4Kwb9qrr7eyHHafUovckSNMi+2ZZLKgQG4ab8
         VpyhODELcQIzETydUW7OGT+dT2oMbEAJ19DUOxtfxcx2N1Kk8/1RbtK4RATenM9OT/ys
         9mXtiWVpJi1ZwPNJnmNnt0tvUlhDyP2O2w7Gv2Ml9CSPjPoNTtIs1Ao0GzffkJIZUF6L
         7Llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPkeIuAoYJnDBM5bhSuNhJIsEJe0X5Bke9g4zUI6DLc=;
        b=NYB5s18Dy7+QLBVI/UvSluZHGSDj4H2G5gAN4E3phXuuolSgW5LvWQ0fyHuUefuopy
         TNWDq/5Oz8b273NAZl15D8cD0f6jL2FnbXtbF0p/eg5mUD4jJVds72RMYk9Zz1ITD9Ve
         V5WER53Y0HgkjjTBNaTbKEo6yKZPOZ55naPD4jALnCNEqx+zklhdIBEb9/tGqCOXS+pF
         7232j6sxn/kN8fckGlFFYBGW6UZmtZGd38a6G98rZm7x3FtZNi7OTbb4QVYa3Ttjnj7R
         A54j096IQgzqBLvTzEqha5fnK5mzeczEhfza0iwIRbQnu+tIvbYTUL5r8JKuMMsXYjNS
         98QA==
X-Gm-Message-State: AJcUukfez3ySMymQvSeleV6Yn09nbuLRq+VbxHYZSNvP1o/L5InLqua3
        OINguDOd/y+5FAZgB3krZ0TLtk9wtaNCYDdpxTw=
X-Google-Smtp-Source: ALg8bN5nEkfJ4+Hacwp6RAyAPVX9SXKVQ0CUzdszbP+GmwZ40V03qXFxHQjWBDxBFnUgom/ekCXtzcVTHmZB31Y5pMs=
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr1770016pgh.265.1546611233260;
 Fri, 04 Jan 2019 06:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-5-okaya@kernel.org>
In-Reply-To: <20190102181038.4418-5-okaya@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Jan 2019 16:13:42 +0200
Message-ID: <CAHp75VdnAACNQEKxfe5c3k4JrCuPNiJA2y8zWO5Q9CCQFV9W6A@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] platform/x86: intel_ips: make PCI dependency explicit
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-next <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 8:10 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. Ipss driver is a PCI device driver but this has
> not been mentioned anywhere in Kconfig.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/platform/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index e3b62c2ee8d1..b36ea14b41ad 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1009,7 +1009,7 @@ config INTEL_MFLD_THERMAL
>
>  config INTEL_IPS
>         tristate "Intel Intelligent Power Sharing"
> -       depends on ACPI
> +       depends on ACPI && PCI
>         ---help---
>           Intel Calpella platforms support dynamic power sharing between the
>           CPU and GPU, maximizing performance in a given TDP.  This driver,
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
