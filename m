Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFA0C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D862083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCiyn7eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D862083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbeJBUaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:30:52 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:44599 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbeJBUaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:30:52 -0400
Received: by mail-qt1-f180.google.com with SMTP id c56-v6so1911439qtd.11;
        Tue, 02 Oct 2018 06:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=19T0Fm7XDb8OXjL6BiHkI0Qn4B86+ziTcltuQNWW1zs=;
        b=bCiyn7ebaRoQKlrZyji2/HgVQxfgQfN1EbXFxANqqNRAmEZkFuMrCg/ZEr7q1++T+S
         0PnXqJUCY31m5mHB+k75ENGiiaEqKtkl6zYCAIvObIQxGdyJANrStbVkgxV2d4byF109
         6MIRWADZy/GUGh3rg7m7nkP8UKrTDA0D4bW1UVj8WVYyNvYl2C9a7Fb+J4JUDJr5duyi
         6ee7vOwRt6nOrVC28Z2fQFoMSj3iMies4JRsU3sGXAEc5Clxz2v/FvTlNngUEN7X9X32
         7eUyJPOajDd3AusVvwqIiG3BWc//j3niW/PhPInBNktIjaqP9RJUO/i2UAhozxbXeOy3
         IIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=19T0Fm7XDb8OXjL6BiHkI0Qn4B86+ziTcltuQNWW1zs=;
        b=eRLTrdv5//AbEYcKbquv9MdWQM7kQi9TXBoC8HSQY4N8rpmfPgRxwnzk736MBKi8dI
         V4Zg1Apo//enK1ve0aGwnQaYmt8MMDarArGPBHHp0pCE8tNfgn6G4WEzjBSFYqUsW7R+
         jZhNMedfJYcpr6V+r3BeCdRROsOcaYQiS8yWiuAsfJGM369pw3y2Q+T6LCummRxLpK08
         lNkcCRxdDUltV2l5g2aKAhaFNc7Y2tpdiuTg/HT2g/t+Ru/y3z+sJsmqdp27a3IjHwmZ
         kYr1trIfiF5+7eF6Q5C54XWjCXIbLZPoklyQKGetYiqmxKVMHR0C67qnUFnSAfHTYix9
         LfDQ==
X-Gm-Message-State: ABuFfoiSM32YtSEY+sl2dMK7JdPbERLsmcuxNOxxDKSD+ofjKk3ZbsoR
        NyiuWTBKlsNDmkyl3jtIxCu1nOhpL0YB+yPkgfc=
X-Google-Smtp-Source: ACcGV637dvbgpMHqNcTPRM5X+pC1PfWsZVQyouA6HuRVlLRqhOpgDkIldYJ88rzelcFdpTMiD96WgRH3nVwJGLg4QkY=
X-Received: by 2002:aed:3c1b:: with SMTP id t27-v6mr8294151qte.226.1538488043824;
 Tue, 02 Oct 2018 06:47:23 -0700 (PDT)
MIME-Version: 1.0
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 2 Oct 2018 15:47:12 +0200
Message-ID: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
Subject: [GIT PULL linux-next] Add Compiler Attributes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

The Compiler Attributes series has been stable for 10+ days. To
increase testing before 4.20, I would to request it being picked up
for -next.

The changes w.r.t. v5 in the LKML:

  - Rebased on top of next-20180928, which required removing
aligned_largest, which was removed by 9503cd9cbaba
("include/linux/compiler*.h: add version detection to
asm_volatile_goto").
  - Added latest Reviewed-by's and Tested-by's.

Thanks!

Cheers,
Miguel

The following changes since commit 4794a36bf08dfa89fe636e5080db9d8350e255dd:

  Add linux-next specific files for 20180928 (2018-09-28 15:26:51 +1000)

are available in the Git repository at:

  https://github.com/ojeda/linux.git compiler-attributes

for you to fetch changes up to dbce062c0b519db1cdad8d87ab46851f0be6bdea:

  Compiler Attributes: ext4: remove local __nonstring definition
(2018-10-02 15:11:26 +0200)

----------------------------------------------------------------
Miguel Ojeda (15):
      Compiler Attributes: remove unused attributes
      Compiler Attributes: always use the extra-underscores syntax
      Compiler Attributes: remove unneeded tests
      Compiler Attributes: homogenize __must_be_array
      Compiler Attributes: remove unneeded sparse (__CHECKER__) tests
      Compiler Attributes: add missing SPDX ID in compiler_types.h
      Compiler Attributes: use feature checks instead of version checks
      Compiler Attributes: KENTRY used twice the "used" attribute
      Compiler Attributes: remove uses of __attribute__ from compiler.h
      Compiler Attributes: add Doc/process/programming-language.rst
      Compiler Attributes: add MAINTAINERS entry
      Compiler Attributes: add support for __nonstring (gcc >= 8)
      Compiler Attributes: enable -Wstringop-truncation on W=1 (gcc >= 8)
      Compiler Attributes: auxdisplay: panel: use __nonstring
      Compiler Attributes: ext4: remove local __nonstring definition

 Documentation/process/index.rst                |   1 +
 Documentation/process/programming-language.rst |  45 +++++
 MAINTAINERS                                    |   5 +
 drivers/auxdisplay/panel.c                     |   7 +-
 fs/ext4/ext4.h                                 |   9 -
 include/linux/compiler-clang.h                 |   5 -
 include/linux/compiler-gcc.h                   |  70 +------
 include/linux/compiler-intel.h                 |   9 -
 include/linux/compiler.h                       |  19 +-
 include/linux/compiler_attributes.h            | 257 +++++++++++++++++++++++++
 include/linux/compiler_types.h                 | 100 ++--------
 scripts/Makefile.extrawarn                     |   1 +
 12 files changed, 340 insertions(+), 188 deletions(-)
 create mode 100644 Documentation/process/programming-language.rst
 create mode 100644 include/linux/compiler_attributes.h
