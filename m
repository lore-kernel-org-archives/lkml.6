Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E8AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEF7218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHKXO1px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfAaRCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:02:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34643 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfAaRCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:02:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so1755687plz.1;
        Thu, 31 Jan 2019 09:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CC7dp18dvRYsg3Sbt3psT+OJkvJ6lszubfG1FjM3SV8=;
        b=bHKXO1pxIoVJAc5zlGsSzACX9lU1m0o2okOk6u5PRsMxQvW2IRD0i+8SzlZ79txFA8
         P/meVfoabIpyGNkutZnudvWwWBXfC7LC5EM4Kfa2LrgYzUARu9wCiF/u4+BZZkmNKzOj
         gea6d5hog20EzG87dWOOCmt8GuREFTOmiTAVhxc7aQoHoVHpo05oVMI0Lq0ff9kSd1H5
         XVTRGcyfuc6+VExIMe8jb4OPuH79UxO7UrV0QVcPSCfYju4pVJkvUJ1MhixEKPDbhUSd
         82hzywOBzjWzB3dQO6TV3DuKG4xecOIpLmy3xJn5xqcAU9n3+3IH9ifzZrTBwB0SbqaX
         hjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CC7dp18dvRYsg3Sbt3psT+OJkvJ6lszubfG1FjM3SV8=;
        b=BatKF5p8rYfeklp9flkIB6WhWLUeTP0EM5vszMiXmWXguQ1JAJSw6s05yO6K0H4uqc
         qyjujTJzc+hcomZ48JAno/YbSJnSSp2ICEj3tWoz7PCkSSGVXVlY0KgcIoTNiMEmjxor
         xVyQOVp2R/W+LBB+RXbP6IjRdkOxZljEL7ERwLpi/0+Zi9M3UaEPsTWBPpgiSZKj6JFR
         ZJGi24dAKdfJJURI10djlgzjh3mF0OheEZS3ByytU06BAuekf0IwgnAFg6GdqJ0Y1T9w
         tH39ZP/mvmIw013v2JofEfkwgvUT2Su0KUE6QtLQVVk5r7wBPHafwWTo6ngNn/jyMzal
         fxLQ==
X-Gm-Message-State: AJcUukcZujMXbLDsN8/E1ZxyivpUropuq5dG0teYB+5qj0wtE+dK6x97
        y16pxTdZJjxV75OCy31XXKOUvPfl2JwUFi14jVYDnBLy
X-Google-Smtp-Source: ALg8bN44JYugLudkAmcD8/o53qvsGZuMCUw7ly6zX6ViNV+SE7QW0lyIcgVPcoJTe7yWdkKMeC3+OJgiXCg4Q7a9EH8=
X-Received: by 2002:a17:902:4081:: with SMTP id c1mr36174319pld.87.1548954149545;
 Thu, 31 Jan 2019 09:02:29 -0800 (PST)
MIME-Version: 1.0
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <1548953587-12719-1-git-send-email-lsun@mellanox.com>
In-Reply-To: <1548953587-12719-1-git-send-email-lsun@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 31 Jan 2019 19:02:18 +0200
Message-ID: <CAHp75Vfr7+NONzthw=E77BqLb06=wgfmNqu7D01fkcNQMqUCsQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/mellanox: Add bootctl driver for Mellanox
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

On Thu, Jan 31, 2019 at 6:53 PM Liming Sun <lsun@mellanox.com> wrote:
>
> This commit adds the bootctl platform driver for Mellanox BlueField
> Soc, which controls the eMMC boot partition swapping and sends SMC
> calls to ATF running at exception level EL3 to program some system
> register. This register is only accessible in secure code and is
> used to enable the watchdog after reboot.
>
> Below are the sequences of a typical use case.
>
>   1. User-space tool upgrades one eMMC boot partition and requests
>      the boot partition swapping;
>
>   2. The bootctl driver handles such request and sends SMC call
>      to ATF. ATF programs register BREADCRUMB0 which has value
>      preserved during software reset. It also programs eMMC to
>      swap the boot partition;
>
>   3. After software reset (rebooting), ATF BL1 (BootRom) checks
>      register BREADCRUMB0 to enable watchdog if configured;
>
>   4. If booting fails, the watchdog timer will trigger rebooting.
>      In such case, ATF BootRom will switch the boot partition
>      to the previous one.

Thanks for an update. My comments below.


> Reviewed-by: David Woods <dwoods@mellanox.com>

I'm not sure I see this guy to review v2. Of course if you consider
all changes minor, you may leave this tag.

> Signed-off-by: Liming Sun <lsun@mellanox.com>
> ---

Here should be a changelog what had been done in new version.
> +/* UUID used to probe ATF service. */

> +static const char * const mlxbf_bootctl_svc_uuid_str =
> +       "89c036b4-e7d7-11e6-8797-001aca00bfc4";

static const char *xxx = ...;

> +/*
> + * UUID structure used to match the returned value from ATF in
> + * four 32-bit words. No need to do endian conversion here.
> + */
> +union mlxbf_bootctl_uuid {
> +       guid_t guid;
> +       u32 words[4];
> +};

I'm not sure it's the best you can do. instead of using union, better
to use conversion from and to corresponding uuid type.

The rest I will comment on v3.

-- 
With Best Regards,
Andy Shevchenko
