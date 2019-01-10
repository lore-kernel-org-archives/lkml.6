Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A953C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF51214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g41J30Le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfAJL7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:59:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41737 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfAJL7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:59:41 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so9428956ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 03:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUBtGsn1YACW0dCF7J8bwtLAagesyuHhWNIO3OqZunk=;
        b=g41J30LeTosyHGh2xbZNhOHVkRpsXxc0+eJ/xOpqQcvx4qXU9hJKUzl0z8+N44VNiE
         65rHzRrT72PqVkBcHwxi4eePh7jfsCzDdO9fdXM83bLZUN8fuYRraIQzmT4RYN6MHKud
         W0FCuNG3PGaLO9ZFKTgsr8ulHq2lkBxbdcVjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUBtGsn1YACW0dCF7J8bwtLAagesyuHhWNIO3OqZunk=;
        b=dIyzO3IFWYF0/TjU6Jn/cY4++tvCXteNzTpnEvRxKiN1+9gI1AlrRx+P9u2JnktArO
         2bqpKT2mEBaDRq3QuAJvCm9OMKEdjx8MZXnmJtGaWGcwPuXUYxNcW003XjaNciBFab6G
         n13gEQcTp7GziAesCC5LsW5CGJOJaQ43rkzlXGGa+posgY9RE6os++TTld+WaxDmgO4p
         yuKgyx2YZs7I7mba4WCoOaa6M11bokeAi6zZii0qfe8Smh5C7qyaA/W2N23jcQyaBV2n
         XlnzIZ1x1ABlnA/KQOzBx0Ts5mvzSOzZ1QjsWbP12ToMbIn6bky8jpweYrwLWV5bIwwL
         TjCQ==
X-Gm-Message-State: AJcUukdZIdd8X/l5wr4Zc0iV1QgOU/XiKVWwXVX9agaaHbi4rO2JiPwS
        AdXsD6cm0HwIY7/vg5WRhc5f88Et4YE=
X-Google-Smtp-Source: ALg8bN5lfPvPPouNHf3twSXqefd3CdnAluRixoBjkYEbVg+gsamX1nE4i5UtZLPdSl51Fyec+PaSkg==
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr6333405ljj.18.1547121579476;
        Thu, 10 Jan 2019 03:59:39 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id j76-v6sm15453364ljb.12.2019.01.10.03.59.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 03:59:38 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id i26so8127861lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 03:59:38 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr5362733lfj.138.1547121578152;
 Thu, 10 Jan 2019 03:59:38 -0800 (PST)
MIME-Version: 1.0
References: <1547045397-24388-1-git-send-email-guoren@kernel.org> <20190110081052.GB13262@guoren-Inspiron-7460>
In-Reply-To: <20190110081052.GB13262@guoren-Inspiron-7460>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jan 2019 03:59:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=whE1Gea=216t=1OfEUrsEYRq2wn27OaPE8HBD4mSUDaOQ@mail.gmail.com>
Message-ID: <CAHk-=whE1Gea=216t=1OfEUrsEYRq2wn27OaPE8HBD4mSUDaOQ@mail.gmail.com>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:11 AM Guo Ren <guoren@kernel.org> wrote:
>
> This pull-request is wrong on the patch:
> "csky: fixup module relocation error with 807 & 860".
> diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
> -       uint16_t location_tmp = (uint16_t *)location;
> +       uint16_t *location_tmp = (uint16_t *)location;
>
> Please drop it if possible and I'll send another [GIT PULL].

Too late, already pulled.

Send a patch, and I'll apply it. Or send a pull request with updates
if there's more than that oneliner..

                 Linus
