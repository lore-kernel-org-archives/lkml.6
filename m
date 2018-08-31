Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167DEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA9120837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0tfv2aE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA9120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeIACZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:25:52 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41768 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeIACZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:25:52 -0400
Received: by mail-qt0-f195.google.com with SMTP id t39-v6so16216185qtc.8;
        Fri, 31 Aug 2018 15:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kb8jYiBKnsYyK2GOksDAJmaz5dz/XdVw7Jee/J9nrKs=;
        b=l0tfv2aE9ZmVZ0XdcnCgGqj7x5HAxTAHYb4M9xgPmPgBQYW7WBmi9r+hbAdu6vaOKf
         CaAIHl8McpXQgpUWNpwjBKaJybBg205pLnIepBTRRAWQH6VZDDT6Tpf82+HHqNSseDhT
         ZEEEMp4u4Y6YY6gDyBLo5CGLHJiq/VbRUjDZNdLnu4oqaCv0uaPEVn67UO1cpu230zyg
         900tkBdbPvuBJOQ64ylSOxHlEutQ6yLiXdhW31R1YC4kssXRKrqLqldgo/cIbA92j2G9
         Z2WtqhdUh5mlO0FNcT2mqEuBvLWQxAG8tUONYIR+ghLYEQsIfW5rihHVDJ8kQ2DrR5js
         5/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kb8jYiBKnsYyK2GOksDAJmaz5dz/XdVw7Jee/J9nrKs=;
        b=oHrTxegjZpTHToM2B/FLi7cPwveMoWIdNOd/zSdpWrTpyRzCYZpyEICqPbxElgWLCy
         GOV6rQTlwVlkeSW/d0vHnNDU8IrUNJ0tHvqsoalvLZUeTRxC1P9Vr9cQsXjmdlIzlZDo
         7+Dyd5zSd+UxN2cWJvl6LL+AkgagN+iJx+Bp/JdGVqKp5u6rNPc3T88E3DgrLDsFha5O
         MpKPyBFCkr9PY8m1RYhSJH+n+n8OxB9N43eCctesIzaezw/MKsCodYa4ifTXvI7O+Qf+
         ICSwbAuNTeeddykN7XPRF/JXKi9UT7gG6SPxV4SGZUO2tptiyAKnw8+7K9g0Ty3fJA+6
         Hoig==
X-Gm-Message-State: APzg51BIjE4RvYSXP0/v3AzxZPTjYSZi2qsO8L55wS2+1J/UbRTBB4gA
        dfb2nwyS/7ZhNDBgGl90vOZcQd+Z8W/3o+cSkOM=
X-Google-Smtp-Source: ANB0VdZ1pmFRGtzIGbP0OQyShJPlFnD0WqG0AzIQr1IxygYq9eeuEfGDvMqDxKjc0n4IBt7TxfBKS1uBahykEzUsdc0=
X-Received: by 2002:aed:3fd3:: with SMTP id w19-v6mr17772234qth.226.1535753781550;
 Fri, 31 Aug 2018 15:16:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2291:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 15:16:01
 -0700 (PDT)
In-Reply-To: <CAKwvOdk3mL87ZA_7ifGdmbztzxdFzJhFAwKoGfv6OiH0ECV0vg@mail.gmail.com>
References: <20180730213412.242849-1-ndesaulniers@google.com>
 <20180730213412.242849-2-ndesaulniers@google.com> <CAKwvOdk3mL87ZA_7ifGdmbztzxdFzJhFAwKoGfv6OiH0ECV0vg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 1 Sep 2018 00:16:01 +0200
Message-ID: <CANiq72nLmTbstZq6Ley_++hhnz3g8jq=Kqy5hf83a9d=6Ab2Uw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] compiler-clang.h: Add CLANG_VERSION and __diag macros
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paul.burton@mips.com>, christophe.leroy@c-s.fr,
        Stafford Horne <shorne@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@suse.de>, neilb@suse.com,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, dwmw@amazon.co.uk,
        sandipan@linux.vnet.ibm.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Paul Lawrence <paullawrence@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>, ghackmann@android.com,
        stable@vger.kernel.org, Greg Hackmann <ghackmann@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Wei Wang <wvw@google.com>, avagin@openvz.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Fri, Aug 31, 2018 at 11:50 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> + Miguel and Joe
>
> This is the old patch I had sent for detecting Clang version.  If we
> wanted to set a minimal version, this plus the actual version should
> do it.  Probably could drop the diag stuff, as we changed clang to not
> warn in this case, so my solution using _Pragma is obsolete.

Nitpick: do we want to use the CLANG_VERSION notation? In some cases I
think it is easier to simply use directly the original values (like I
did in compiler_attributes.h for gcc).

Consider that we almost never need the patchlevel (and if we do, it is
better to *see* we are explicitly testing for it), and given the
versioning schemes that compilers nowadays use (i.e. only major
versions), I would bet not even the minor (except maybe for GCC in
compiler_attributes.h until we drop gcc < 5).

Cheers,
Miguel
