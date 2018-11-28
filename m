Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D567C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FA7208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tE2isRbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FA7208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeK1XJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:09:03 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34922 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeK1XJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:09:03 -0500
Received: by mail-qt1-f196.google.com with SMTP id v11so25488370qtc.2;
        Wed, 28 Nov 2018 04:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1NmIhB34gIvHrOSZjMOLfwQxmnFKJiHwT6Ugcjpndo=;
        b=tE2isRbsROzKvmb/J7GUlvOc2/cDNvngZ35F23mqVoRoTqeF4n3YBpwu39C/OyQ5TH
         JL39nTpXu+o9r1IbtB8wVLURTLmCmgsAmAWbSF1F1vlpRmF77/czHSkyh5VXIxPvlzIO
         tuhxZwZ5ICDPk6940n1RaJ3GxpIGMqJ70nBYupAnB8SthGUsVAC9GLkctMcJxfNvN6vr
         JF+VDRy1KLUGrmEGt+NnuQl1u3+biIZjLq5jssW/WRY496ab/7ExcJT4txH+fzxDjcsi
         9IIOH/2i+yTJL7RyLm7c2UGhEKUEkEdqGhp9L/E2E3hFhTGZWdBUOa0kdLfb6i92gH7O
         IQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1NmIhB34gIvHrOSZjMOLfwQxmnFKJiHwT6Ugcjpndo=;
        b=U+7P7HDzUJkFM64yrn82qSzsO4KMPQImjvfuYCHWJHjd0NVRdn/Wq9/50JGd9UTx2j
         3Hix+w8VOKV7rexMMyvyxcfnGYNcVQrPhuhGdsv9N4qvbzfH1jsThm8KfcHFjTt+ppLR
         nsGaBJfWobaVvw/dJK8fAamDUuxatu4QvXypK2jJXlkZxqpUXgLPEMrqLTz3xHqo3cpS
         sfvnQwyJMUK89sLERdqEJCdEpR1ww7FDKTxrkSbVeIZlh2FU1V8BFrGENHKHpKLNbxC1
         MQENdC9d1qKyv8iZRtq7N6xUBtsy4kgYeNkJUny334ih9DDEPA6LLds+dgiHSE6rGYbW
         uxFQ==
X-Gm-Message-State: AA+aEWZcA5eU5YrmMXt+Y6brUyG36WFygOXuQ3V5K/t7wNjBTtV1UkOS
        a9wk8KBvUUjBMpfv0TI8Tem8Ef4rCVXXPKhel8lDqwJI
X-Google-Smtp-Source: AFSGD/UM4MMfcapeiuj9nQainu/Ax6k1vetwMBHSQZVSmRBlDS/eWBs9N0j40GMJUSRTpf0AglcFRTaAHlRH46EFtpI=
X-Received: by 2002:a0c:d268:: with SMTP id o37mr35183232qvh.136.1543406856481;
 Wed, 28 Nov 2018 04:07:36 -0800 (PST)
MIME-Version: 1.0
References: <20181127132508.5501-1-fe@dev.tdt.de>
In-Reply-To: <20181127132508.5501-1-fe@dev.tdt.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Nov 2018 14:07:25 +0200
Message-ID: <CAHp75VfFYJQzTv_oe8RKPo03-FLYHy6BkrKaG23svAKtC+jVBg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add device driver for APU2/APU3 GPIOs
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Eckert.Florian@googlemail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 3:25 PM Florian Eckert <fe@dev.tdt.de> wrote:

> Changes v5:
> gpio-apu.c
> - Remove GPIO_GENERIC select from Kconfig
> - Make gpio_chip real member of apu_gpio_pdata
> - Use BIT macro for get_data and get_dir functions
> - Pass platform data to devm_gpiochip_add_data to get data
>   per-instance state container
> - Remove DEVNAME define
> - Remove platfrom_device member from apu_gpio_pdata this
> - Clean up init function
> - Remove MODULE_ALIAS
>
> Until now it was not possible to get more information to detect the
> MMIO_BASE address from the ACPI subsystem.

I'm sorry if I already asked, please, remind me where dump of ACPI
tables can be found?
Also would be nice to have the output of `lspci -nk -vv -xxx` on such platform.

-- 
With Best Regards,
Andy Shevchenko
