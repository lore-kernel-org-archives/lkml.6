Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF24C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAD2218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNfK2ulf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbfA3VRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:17:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44167 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbfA3VRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:17:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so388075plt.11;
        Wed, 30 Jan 2019 13:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwsXWhqhObmoCvm6HCrYpY1W9DGqdyw1V/0UwP7b1B0=;
        b=ZNfK2ulfgT4A1e4nhgSIqo9tRFGidREQLZip6W/re+jWfr6HzH/qJ5Y5gFOVSHDJ5H
         rPhIA7GM9rAoU61ouPoWRGn2QQLABkeefcwMZwpECS/Fpno1z0uVmxlfuTW/3oaEFD2z
         fNFP2s9XXll2laQ2J4CgNqhRSzBwZo1CQTePowSo0B5O3e05dLL22EzdbyCXZyFeRR9e
         UxMz7guVQqgIEfjjO9fzOghw+ZrsYJPkhGjrTyKrZZRifX90J+T5TON+24tUU460nZV/
         k0kyZIxHaOohNKoR3YaurWkSCAK0hmdZX7+a+ErbJ8aFGYzdT2NRKG9SuKmBqHU75jxM
         t4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwsXWhqhObmoCvm6HCrYpY1W9DGqdyw1V/0UwP7b1B0=;
        b=bA3JCL4mcaxPcaOxgFEPjaT2TTw3x2hZhGapdxodpUEGuiMp3MqJtSm+4gSf6I0okL
         CqW2QIrwduhkIa11TAFrBpmsUwZ5ef2AjCdwmJWXPSZApOedsKwTX6585dgJKqB1xmqD
         px2aFuBblCM9vOkYBXi7KUbGWVs35TivmiTi1isMitYdB4mtibYV++ngxzgFypSYM2Vq
         hfXcVX0xJGVybCNp+//R1TKDvBBz/OteZO0gDIGW0jt37/n9OrARC5audC5NAAoZ6awu
         /afINpUq0AF/NRCUN+rTYcWiFYZ556rcXlZybn05qjYMbGFaW58G4OFdb2nJuWSh6/7G
         1HWQ==
X-Gm-Message-State: AJcUukdc7PxtVv6+KoeRfXgsqtp0uu9VhxQ9VQMdkhDgTWYNwov8zFil
        mowCsBeppzTRM2Ca2TJR7Z5HVHovzghZ5FI8MPGawSct
X-Google-Smtp-Source: ALg8bN6pHgHK2/vNGGh/SMblifFRv9MV+5on6+Dbxek81zRYcgojtyceA3rEWkY5ohSq5GTjPImep/Y+5RzDfT8GvWk=
X-Received: by 2002:a17:902:2468:: with SMTP id m37mr31965097plg.314.1548883041547;
 Wed, 30 Jan 2019 13:17:21 -0800 (PST)
MIME-Version: 1.0
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <CAHp75VfpmBMmR_zU8JxN3Apb__QyWXyU9wD8e03z0N3TTRpMYg@mail.gmail.com> <DB6PR05MB32230728A361BD68D14D7B69A1900@DB6PR05MB3223.eurprd05.prod.outlook.com>
In-Reply-To: <DB6PR05MB32230728A361BD68D14D7B69A1900@DB6PR05MB3223.eurprd05.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Jan 2019 23:17:09 +0200
Message-ID: <CAHp75VcsYsxSfUT6Sc9-59gXaQRXs0ugpPRAvAzFr2+DYJHeCg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] platform/mellanox: Add bootctl driver for Mellanox
 BlueField Soc
To:     Liming Sun <lsun@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:47 PM Liming Sun <lsun@mellanox.com> wrote:

> > First of all, is it a real watchdog with a driver? I think watchdog in
> > that case should be set up through standard watchdog facilities.
>
> This is not a watchdog driver itself. Instead, it provides interface to
> user-space and use ARM SMC calls to ATF to configure registers and
> watchdog. I'll update the commit message in v2 to clarify it.

Hmm... For example Intel MID platforms have SCU (system controller
unit) that provides a watchdog facility. In the kernel we have a
watchdog driver for that.
Can't you do similar for your case?

> > > +       if (mlxbf_bootctl_smc_call1(MLXBF_BOOTCTL_SET_POST_RESET_WDOG,
> > > +                                   watchdog) < 0)
> > > +               return -EINVAL;
> >
> > If that call returns an error it shouldn't be shadowed here.
>
> Not sure I understand this comment correctly or not.
> This function is defined by DRIVER_ATTR_RW(), which appears to expect
> ssize_t or an error code as return value according to other examples I saw.

What is returned by mlx...call1() should be propagated to the actual caller.
Same comment for all similar cases.

> > > +       lc_state &= (MLXBF_BOOTCTL_SB_MODE_TEST_MASK |
> > > +                    MLXBF_BOOTCTL_SB_MODE_SECURE_MASK);
> >
> > Better to split like
> >
> > xxx =
> >  (A | B);
>
> It seems hard to do "(A | B);" within 80 characters plus the indents.

Repeating myself, it's still better than your variant for readability.

> > > +       if (res.a0 != 0x89c036b4 || res.a1 != 0x11e6e7d7 ||
> > > +           res.a2 != 0x1a009787 || res.a3 != 0xc4bf00ca)
> >
> > What is this?!
> >
> > Can you use UUID API?
>
> Yes, it is UUID comparison. The SMC call returns four 'unsigned long' from ATF
> to represent the UUID. There seems no existing APIs in uapi/linux/uuid.h to
> compare such special format. How about replacing it with comment and MACROs
> instead of the hardcoded values to make it more readable?

Should be no magic numbers involved inside the function at the end.
Use descriptive definitions and I still recommend to give a look at
UUID API how it can be utilized here.
(hint: Thunderbolt hw is operating with integers, though driver uses
UUID API at the end)

-- 
With Best Regards,
Andy Shevchenko
