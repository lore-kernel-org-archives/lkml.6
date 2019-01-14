Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC198C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9920820657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VabHFFIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfANVrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:47:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45233 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfANVrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:47:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so223551pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 13:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rh41GYjdv0tt+nNJ/OcsygYaM8+w7ObgUpf4Jwd6L3A=;
        b=VabHFFINg2mMQE/rBbEG0qMcZIO0WKKXyj+cL+sB092Gk4tR6e7u0HS6m4t0X6DgT9
         20uhjFWNuuwSI69X3avSsnFti6DK1HgKcl0GsCjEhV6NKiA496yybCMpYmB7y4gtJ4G1
         SP5ZcHUKt1HF3Sipg26V9kgE6J0PRcoK0MgD4OSDohGiQ9GXPB52QopKa1TEwZSKRz9e
         k/6bjKThTw+6rjh/xnkFPBqMi5/QKU6JWRomfB4RfLh4EdnhTYJSF/Po1YCxLt929N/9
         4iHoNiEgrmiBS2GWuf4QpS20+bsjUY+GfCWyGDn3R74pa8NGiLjv04GJKnuL28LjVmDP
         v3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rh41GYjdv0tt+nNJ/OcsygYaM8+w7ObgUpf4Jwd6L3A=;
        b=RTkoe2RzjBzqLpgCp3UoVOk51c5w5Ild8ISnV2pmBOxwcwM99nlacQINrC4PwKKl1p
         6rK0Da5l1VZ7ZZcOUBahoLoI2dR+OLcYqmXflhDvJ2J4OjE+Egibg8RnKWmdmvpmbbbx
         9nTeoO7ZIimb3rWY7rgq6hP792wn5c0wFCM7UpVJh0vvfKl2LHj84Sf/x946zNSzyOsR
         8yV5uG8jGm7vPDs9mHqtz2KykWhDouYIhrgU+tFn5czmdkci6eQwF3qmfeUIetk9wULF
         3O2P3XGsFuEZWTNd3wDwQcq/KToh0ptdUdNQkFGYpkac8B1pyCw6/KVJy3S20BhkhpsF
         OQMA==
X-Gm-Message-State: AJcUukeYlAeaR1dcYKmSi7pD8RNDhKqpKbe5J3XsD0DQ5DXoiU6c3fpc
        3sRipqqPiX1zQUgiF+K97Zj6i17GINmuTNip4hcyiA==
X-Google-Smtp-Source: ALg8bN5KaN6RBLcIpmRrSbKRC64Z7htdU5/H/khjFVDmG6VXaibC55hiVjDhz1eWlaHkKnBxjATnTnLfpiV/fqoHt0g=
X-Received: by 2002:a63:bf0b:: with SMTP id v11mr601270pgf.302.1547502466710;
 Mon, 14 Jan 2019 13:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20181219183509.GB31643@zn.tnic> <20181219190145.252035-1-ndesaulniers@google.com>
 <CAKwvOdn5Syd_pvAmcDy6n6c9=HrpRxEU2fWBa7Rf2QexPZP90g@mail.gmail.com>
In-Reply-To: <CAKwvOdn5Syd_pvAmcDy6n6c9=HrpRxEU2fWBa7Rf2QexPZP90g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Jan 2019 13:47:35 -0800
Message-ID: <CAKwvOdnbPd+ApyqYXx-+X9jjYyA8_3zFxeC+TXMNGNr2XdVqJw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/build: Mark per-cpu symbols as absolute
To:     Borislav Petkov <bp@alien8.de>
Cc:     Rafael Avila de Espindola <rafael@espindo.la>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Bill Wendling <morbo@google.com>,
        Dmitry Golovin <dima@golovin.in>, hpa@zytor.com,
        Michael Matz <matz@suse.de>, Tri Vo <trong@android.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 12:52 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> Happy new year.  Bumping for review.

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/build&id=d071ae09a4a1414c1433d5ae9908959a7325b0ad
Thanks!
-- 
Thanks,
~Nick Desaulniers
