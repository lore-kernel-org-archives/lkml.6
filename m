Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273A9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0C22186A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYLaqvX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbfBKTay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:30:54 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:52096 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730828AbfBKTax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:30:53 -0500
Received: by mail-pf1-f202.google.com with SMTP id x134so29710pfd.18
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TK6/MzW4JnxuOsKgXQU2yQhAm/t8aNFqaE1bSL+NuZQ=;
        b=UYLaqvX6e2X6/7JleDYSYwoKBSnR8j25m+N1amtmf+8xdO/V0W8NYVyBCBnvlnVYZ1
         THVHLstkSHHateGi2GpIFWy3dNap5EthKBRy3JOeBNilPUrhEVW419zW+qXTTuMfKwuX
         nsgrv9vgKxrNiQh6qhnJFK8oicGYWce5tBYoPpKE8wskzj+tuyvzCtLnoQzMC3j0+GQl
         s6J2UT5hGjV3mXfoBW2mNcqqDiE2juvFMY/jJPJ1U86RvdFvjDz25tp7l5eEdQIeK2TL
         Qo+J/vgYcDENM2VQzcAS5UGcz0AB45S1uNZODAZmW15yiTYlmHzhvuTzBrTk4PsNrzMz
         G8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TK6/MzW4JnxuOsKgXQU2yQhAm/t8aNFqaE1bSL+NuZQ=;
        b=YDRarQNx03n1OrejliG1VIofIoyWTeMcGkV/DFcQmGhGm/TwKB5kD06oXr0lCPvaoI
         t4yt+eZ37mrUYd2e3R1UmrXUbhWaiOt+tE/S0BEYG7aF4S1YqBeXTKF/pJBgrI1eiwyp
         96Ok6kV0ZwKnYrXCKpeemiKk4X+keNfrXaQaNbR3pY6HQuFv6LJZDhzzeluWc8PE/3tP
         H3abKQR4YJCrO/Y5QXtYSmdA/yopjhtNOUJdEZL1Ku7NC8q05O2Tbn9GJEgQlsq0w0pI
         2eyVJ8gG8f9879GMpsKKPmFNV3XuuknaKkpMM03mNPLMMQdV1oKRMP3/trav2u5XHUEN
         NUFQ==
X-Gm-Message-State: AHQUAuaPV0M6Q/56skq88/a2pNm9vSbtM4t3DbFO0yjvxu0LcRCl2iYE
        eKGdBRlYe+H+E4QtlG7OhKAiBM3p6s98aRVcJs4=
X-Google-Smtp-Source: AHgI3IY7l9fFNEZd+rL4qbjVKTK6seQ6+wzFo/amHz9N6SyiAXUL0kq405alftfhMWBOLeNIRxJjEcYVKLjlmRGp8Z0=
X-Received: by 2002:aa7:810f:: with SMTP id b15mr9144453pfi.113.1549913452334;
 Mon, 11 Feb 2019 11:30:52 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:30:07 -0800
In-Reply-To: <20190211193008.24101-1-ndesaulniers@google.com>
Message-Id: <20190211193008.24101-5-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190211193008.24101-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH v2 0/4] Improve kernel LLD support
From:   ndesaulniers@google.com
To:     yamada.masahiro@socionext.com
Cc:     natechancellor@gmail.com, sedat.dilek@gmail.com,
        keescook@chromium.org, samitolvanen@google.com,
        michal.lkml@markovi.net, akpm@linux-foundation.org,
        hannes@cmpxchg.org, peterz@infradead.org,
        linux@dominikbrodowski.net, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, gor@linux.ibm.com, adrian@lisas.de,
        rgb@redhat.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up a few places in the Makefile to make way for
landing LLD support in the kernel.  There are still a few arch specific
fixes that need to get upstreamed, but this core set of patches should
be arch independent.

Some very rough numbers: LLD is improving the overall build time of
Google Pixel kernels by about 9%.  The build is mostly dominated by
compilation, but LLD is able to shave off quite a bit of time.

One of the included patches helps get LLD linked kernels to competitive
binary size, but there still some bugs in LLD causing it not to discard
certain sections.  Once that's fixed, I estimate an LLD linked kernel to
be just barely smaller than a BFD linked kernel (less than 1%).

Folks looking to test should use LLD built from source, as I recently
fixed a bug in LLD that prevented LLD linked kernel modules from being
loadable.

$ make LD=ld.lld

Nick Desaulniers (4):
  init/Kconfig: add config support for detecting linker
  Makefile: clang: choose GCC_TOOLCHAIN_DIR not on LD
  Makefile: lld: tell clang to use lld
  Makefile: lld: set -O2 linker flag when linking with LLD

Changes since v1:
* collect reviewed-by, sugguested-by, tested-by tags.
* move where -fuse-ld=lld is added to CFLAGS.

 Makefile     | 9 ++++++++-
 init/Kconfig | 9 +++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.20.1.791.gb4d0f1c61a-goog

