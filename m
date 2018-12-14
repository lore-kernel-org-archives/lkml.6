Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247BAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E580206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDlTIWdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbeLNQGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:06:47 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39788 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeLNQGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:06:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id n18so4632036lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=05ieWldMSqeN0D5nXOs4ozu5igEBSH1ZRimi7wd8+/0=;
        b=uDlTIWdYS6y8gKDqILUiRoz0wZ+BiZ+FcYp9iaZS4h0jOiMITcKi7Ja2L4JOjCxPPE
         P/CrtusR/mmod3YMuAPIYe8X/ZY9u4pwCrXw9P5Ik9z2+LKkJX4Re6DZkD+w7jcDMLHh
         vliBqL/s9B8FWeJdPffX+Al03s1Y37JVMdH+ED24P1ez6KqrHSyCGh8h6Gi+jg5BWuiX
         WAr7S2uKoAAS/QsC8B1ru3b8++xUnwlfSGhu0xvAse34IHpXnlho3aDEpZi/TQY58WVE
         YXcJyyIw0U5xx1lE2P2kkywtCzu1HaVviYULvFts8FEuSsOTgop8GCz9DjT2LEIYmpTW
         XM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=05ieWldMSqeN0D5nXOs4ozu5igEBSH1ZRimi7wd8+/0=;
        b=dpSo2yWKBhamBdBFBdPD6qbyvh0NFzmnhG7ActNwlBqZDI4mAo1boY4Rlo9MrA2h6u
         p9rJR4TmMRErW/Ec0pUP56Fyyuh5FOyRi9w8pARzs+2a9d39Q87MRaNj3Cza5xEFkdaZ
         eDAdiggg52W5q6eMmouDZUXk2iqTl+Ll/KzcKBEVlTI9ev2oDvIdaX/RMpUREdCrxfrt
         OaCNypuUlKcZaevWeexQx7N2nLthx4Soh9djaB+1ERU+3tsvh1BQpRKpga2c1k0mNx8A
         I3JmwoW4Qyiyf3VmKV5+2bnBvkmSTwQEC0K6OrUSGK3RaAzWGfMk1y7tsiYXn+zF4Vi9
         VdTg==
X-Gm-Message-State: AA+aEWZ1tBqa98oLyzEgp46uKlGgzhaTLusU7Dy5R7NSGu0HFPU3l0Vv
        pStRYCO8IZ/Zj4jIyXVlkcBAHPObXEpHco2c/2w=
X-Google-Smtp-Source: AFSGD/WppSAkmo14Yiq5T0L9jOR41tNpkzcBFKkeOseYy1UhcWE8QrfdCsBviPv9Ie6jqHA6HIWrIAzYGO0KD+j+LUI=
X-Received: by 2002:a19:f813:: with SMTP id a19mr2090370lff.67.1544803604915;
 Fri, 14 Dec 2018 08:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20181214141433.466991-1-liuxiaozhou@bytedance.com>
In-Reply-To: <20181214141433.466991-1-liuxiaozhou@bytedance.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Dec 2018 17:06:33 +0100
Message-ID: <CANiq72ndmEBLm_0A6iKXta1rVhYgsaHBL6QE+UFa7xFt8xdzTA@mail.gmail.com>
Subject: Re: [PATCH v3] Compiler Attributes: don't pollute userspace with
 macro definitions
To:     liuxiaozhou@bytedance.com
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@mips.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 3:16 PM Xiaozhou Liu <liuxiaozhou@bytedance.com> wr=
ote:
>
> Macros 'inline' and '__gnu_inline' used to be defined in compiler-gcc.h,
> which was (and is) included entirely in (__KERNEL__ && !__ASSEMBLY__).
> Commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutual=
ly
> exclusive") had those macros exposed to userspace, unintentionally.
>
> Then commit a3f8a30f3f00 ("Compiler Attributes: use feature checks
> instead of version checks") moved '__gnu_inline' back into
> (__KERNEL__ && !__ASSEMBLY__) and 'inline' was left behind. Since 'inline=
'
> depends on '__gnu_inline', compiling error showing "unknown type name
> =E2=80=98__gnu_inline=E2=80=99" will pop up, if userspace somehow include=
s
> <linux/compiler.h>.
>
> Other macros like __must_check, notrace, etc. are in a similar situation.
> So just move all these macros back into (__KERNEL__ && !__ASSEMBLY__).
>
> Note:
>   1. This patch only affects what userspace sees.
>   2. __must_check (when !CONFIG_ENABLE_MUST_CHECK) and noinline_for_stack
>      were once defined in __KERNEL__ only, but we believe that they can
>      be put into !__ASSEMBLY__ too.
>
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Xiaozhou Liu <liuxiaozhou@bytedance.com>

Thanks Xiaozhou, picked into compiler-attributes with a slightly
modified title (since it is not about compiler attributes this time),
and let's see if there is any problem with it in linux-next.

Nick: I kept your Ack, even if it is a different patch. Let me know if
you don't want to Ack this version.

Cheers,
Miguel
