Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21B3C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0065218AD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549957260;
	bh=22c6w0mM8SX1qrkqCwOkIr6+XXGxbLmpsxYY+44otTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ULpPu2DSGeu1GLaH0D0vp5BkAMB7D4z3lwenzG+0HgECddkRBbY3KKKRje0rnCmUJ
	 sRBY7kisT5XqiU2plCR1YKOIrdSAt8kDYEQocJ+Cajqj7Y0bfGoSaCcTtN+HIe+GAP
	 6an71dzXzhSbKan6+KipnJs3j9RkOP588ujNjNj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfBLHlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfBLHk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:40:59 -0500
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BFDF218DE;
        Tue, 12 Feb 2019 07:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549957258;
        bh=22c6w0mM8SX1qrkqCwOkIr6+XXGxbLmpsxYY+44otTM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y58azOvoWqElTWDvVmuiRoJh4KwcPcT4uFU0+1yQNDN4wRKy/7VHeARcESubKdFcW
         uH1avxPyyAo6X4QqIlAWgUxw/HvEhxusBktsUJ9q+uURFMU3br3uUhJT8RHhjXFbCa
         a9ZzmNlV8XFIW6/etx3O92dZxC8tZEftz2kW0WGk=
Received: by mail-lj1-f170.google.com with SMTP id z25-v6so1329918ljk.7;
        Mon, 11 Feb 2019 23:40:58 -0800 (PST)
X-Gm-Message-State: AHQUAubPMH/zoj5qObdSjG+mFWAEBiJPyHJy1CocIz3oMzlTLEqNoeTC
        qQYQ/MK8UjfH4V+BWzy5clJ3TAiwW/OYzufD2rM=
X-Google-Smtp-Source: AHgI3IYwJedyNAOZQ2WU2J994ecuC/FkCcLV/qm178dahnUgp/BRGPZisdHjKBuzxAX5sTIwF3t9wO0Nwtilj7QiSgc=
X-Received: by 2002:a2e:890b:: with SMTP id d11-v6mr1531161lji.113.1549957256391;
 Mon, 11 Feb 2019 23:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20190211181531.GA3238@embeddedor>
In-Reply-To: <20190211181531.GA3238@embeddedor>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 12 Feb 2019 08:40:45 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeHp7sKkZ+jXmTXk5GEF_7G5ujfm3Lw==G3T4thfD+F7Q@mail.gmail.com>
Message-ID: <CAJKOXPeHp7sKkZ+jXmTXk5GEF_7G5ujfm3Lw==G3T4thfD+F7Q@mail.gmail.com>
Subject: Re: [PATCH] clk: samsung: s3c2443: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 at 19:40, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> drivers/clk/samsung/clk-s3c2443.c: In function =E2=80=98s3c2443_common_cl=
k_init=E2=80=99:
> drivers/clk/samsung/clk-s3c2443.c:390:3: warning: this statement may fall=
 through [-Wimplicit-fallthrough=3D]
>    samsung_clk_register_alias(ctx, s3c2450_aliases,
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      ARRAY_SIZE(s3c2450_aliases));
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/clk/samsung/clk-s3c2443.c:393:2: note: here
>   case S3C2416:
>   ^~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>
> Notice that, in this particular case,  the code comment is modified
> in accordance with what GCC is expecting to find.
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.

I saw this in multiple places already and I think fix is wrong. The
point is that the code is correct - the fall through is marked
properly.

It is just the GCC which has to be fixed not the code. You want to
adjust the code for specific version of GCC and what if GCC changes
its warning? For example GCC might require "fall through: "... or any
other syntax. Another point - what about clang's syntax?

Best regards,
Krzysztof
