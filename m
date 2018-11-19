Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CF0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE3C2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CTNQlXQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE3C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeKSVCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:02:02 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:61879 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeKSVCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:02:02 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wAJAcMJh006616
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 19:38:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wAJAcMJh006616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542623903;
        bh=+gAI4g5S1M52sVqB21rRM39JgWE2Z6AU3KFfL5ct27U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CTNQlXQXXOxYhIiHEBxOkyQTMLWrZTbjOXJXL4kHJ8/Hj62KJ092nsZlTOX++hT64
         BxfScaN8QfdTYZYAYdmdmSY3Z+bsWw4fUoGTFWv1iIG9Lp3a819ZFt6N+C1pwSZNeR
         7DlpZzKabEAbO1IIFxt6uSwyENMu+DXzTC9rQRT6UWJFqvUYsyCrpMxIVovDF0D/2E
         jP26mmw3tovN7Cc5FJPCfXb4aUdIQBt1BFcJjo983RNKfGFbB92NFk+nhSzuAYmATg
         i0URAiow9QfI5WoD3C2Qar8OtIqPViYD7iACVqR76HrHBTuxal1ndYOCRRa1CCrNsZ
         en0jJ6iK27h7w==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id y27so17490920vsi.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 02:38:23 -0800 (PST)
X-Gm-Message-State: AGRZ1gLp4rI+xWWfUUsZfpyOfg0Tt/edXkhqZkYPbNrb38todOTkEkHB
        EkMyFx/DjC5+EyPQNO6dqhuVKGuctPr2LSzhyFo=
X-Google-Smtp-Source: AJdET5dNXkF7//KGo9MfV/qDn6XjJAnWedhPEHFdlDWx0MoPTMrPZXF0iymc2cMO/K3ocw8jIiS4dWQI4g/4Nc1lSY0=
X-Received: by 2002:a67:a858:: with SMTP id r85mr8739883vse.215.1542623902374;
 Mon, 19 Nov 2018 02:38:22 -0800 (PST)
MIME-Version: 1.0
References: <1542349141-7229-2-git-send-email-yamada.masahiro@socionext.com> <201811171831.qhwHC7gp%fengguang.wu@intel.com>
In-Reply-To: <201811171831.qhwHC7gp%fengguang.wu@intel.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 19 Nov 2018 19:37:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQQE+dexoqsrkxnHNf3J1o83PkHD1vf7RUKYFN1QugBJw@mail.gmail.com>
Message-ID: <CAK7LNAQQE+dexoqsrkxnHNf3J1o83PkHD1vf7RUKYFN1QugBJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] build_bug.h: remove all dummy BUILD_BUG_ON stubs for sparse
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 7:56 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Masahiro,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.20-rc2 next-20181116]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/build_bug-h-remove-negative-array-fallback-for-BUILD_BUG_ON/20181116-190414
> config: x86_64-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64


OK, I was digging into this Sparse warning.

I suspect this is a bug of Sparse.

I submitted this to disable __builtin_types_compatible_p() for Sparse.

https://lore.kernel.org/patchwork/patch/1013734/





-- 
Best Regards
Masahiro Yamada
