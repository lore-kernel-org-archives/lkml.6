Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FC8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E63B214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfAJLXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:23:04 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40540 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbfAJLXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:23:03 -0500
Received: by mail-qt1-f195.google.com with SMTP id k12so12028992qtf.7;
        Thu, 10 Jan 2019 03:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6P+PRX0zU1eJwaaLlLHDXyE1ziW+BRlCB2dSF0fome4=;
        b=YJSRLE9FdKTbSWuarXLRaTTJMi0HGwctg+MqUuIw4yTRA47MNb80aZCI47+kRGj1lh
         b1T5df8rI/cPM7IjlaZofzLf1qxj51QevtGYFiVM7mCwQXK9RcBbP66RMMfcmc/U2mj0
         cA/qvw3CfbzokPYP6TwIitOukqjNAMUb3pLGTOv1wMqWyAs2irEN2019Bw+xllkDGHtt
         XqazhYBigAEEF8PLvhwLS2n1ZDrDDitkZeZUuCbVunwP0VWnYOPkP9y5pOkTH7/vEpVH
         mna+WL7XsVvZsCTuPm8GPCExAN/LZeRwfOszHoXnV9bNdUtBx5DHLGsUFkC6ou5HWejV
         NL0Q==
X-Gm-Message-State: AJcUukfbzt1nV2SrdZeQljF8mr0va9LDTdUuGmWrgp9uHPcUE8Otqn9e
        1ce+qfBvzQBQKEIdWDhb0+MHHn9wq9cdwhK2kQs=
X-Google-Smtp-Source: ALg8bN4KgkK9JFVxLzoSj63GQPxDvjjcvhIqCJGvuss2wVvhpr05nZjewBaW6udwSdXgjaLir8yotD79QZYcRRSmFz4=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr9414827qta.152.1547119382523;
 Thu, 10 Jan 2019 03:23:02 -0800 (PST)
MIME-Version: 1.0
References: <1547045397-24388-1-git-send-email-guoren@kernel.org> <20190110081052.GB13262@guoren-Inspiron-7460>
In-Reply-To: <20190110081052.GB13262@guoren-Inspiron-7460>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Jan 2019 12:22:46 +0100
Message-ID: <CAK8P3a3OS2Y3_B04z5shaT+CHZ3isQYj-GO+G9kxeY4aGkQmUA@mail.gmail.com>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
To:     Guo Ren <guoren@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 9:11 AM Guo Ren <guoren@kernel.org> wrote:
>
> Sorry Linus,
>
> This pull-request is wrong on the patch:
> "csky: fixup module relocation error with 807 & 860".
> diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
> -       uint16_t location_tmp = (uint16_t *)location;
> +       uint16_t *location_tmp = (uint16_t *)location;
>
> Please drop it if possible and I'll send another [GIT PULL].

It's already pulled into mainline, so it can't be undone, you have
to send a separate pull request, based on top of the patches
that got pulled.

       Arnd
