Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2757788-1519128167-2-17825501637761044627
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519128166; b=bNtBbM0jSOhnbC2I7cyAAXpPoEpS2god/ilqprDVc/L6z3i
    tekQ6YZAWIr1bMznqaky063VfdYSB+0yce9l+J5278T36JMaAqtltqZ04dSoSGE9
    kF7qxGGrqxu9foanbPLOb/6E413YVOGC+H3jul9jVkv+dH3EQB5hpRSULhUtXS3D
    CQuxJ2Az9fiUZtuaXqGKZC9P26JFfIheQ3IWYjn9mt47uF119Gybb7HYG3VaddIx
    rQbBy+6cC/BZfWDrgUC6Mqkq+RIJ25xyUZWHFcH5Mm4FpLW8Yyh6+5i9qBbf10f3
    6LklzsQG0qRlFGE6yvbXt7kJ5zL/MFWKxJ5ygXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519128166;
    bh=n0VPyhCXMZURuvjGfsn+sOKO7XNwJVSThX0pcKQE9K4=; b=TGyX716ctuGU
    yYPcm42urAGKGmZ2+BgbA6mwO8kyyWOB16b9OvS/ZG31Pb3KxhWsl1qO6z0Vsk+k
    iTEPY6K97YX3vkhbFY6xyF7EVuF5uU1B6R5sbhK4yUONzJazUo7T3Cm8qo5SVGm7
    WbLLCazTVVHDJ5NHWNMXLtsnR39HL7w0aPL44JMHEL0KgzbkKnHyibLhZAoytsyE
    I21UydTSGe5IHVCm+ynAaGe77WC5c/UAJKzBThfZNvbKq14tJnxovafvOFegymYK
    2Wj9BS0J8JcBCRgAJFnoV0q23gSkBtEL380asrqNcAaGNbdOGwHVlfILn7lBavdQ
    GX1KT7NJWQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeBTMCP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 07:02:15 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:46519 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeBTMAV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 07:00:21 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [4.4-stable 22/22] kasan: rework Kconfig settings
Date: Tue, 20 Feb 2018 12:55:09 +0100
Message-Id: <20180220115527.1806578-23-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:S4mdm5x4T++C9QIixzjcAyGZztw2Zy+ftfeWHzCdBr9tmDnyvLd
 7TxMbnkqGnj2EPd6s1wyDcMmITN6XRBYqIQGPhFIKIC93C/pORvDSnx8VpFkw7kMMI8ty6x
 uV6mRkvOezSskeR6DhXVGyweZtkCVRNy+gdUTfHS6Jsp1NerKBlMhhZG8NWZw04AMVbe20d
 Ojcz/sZqsyOSSCCGm3tNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bVxY23n4UA0=:m0lyNLaLHxedUEauTCm1Yy
 07SNmLRWDZlcRzfhMb6kJfQ28ZBK32c7jVtiSf8cCJ9UlZWQTk28mJB8FpkZppQUJ+8QsSmWW
 DVmd69pU7y7zXLmNn2qWpBDl2rY58KRTTtRKuL7mC/RU8DlkArI1m2JiDMdVal0IMZDRG7cyK
 vXELcXIiO+x7nn3nhJhCgd43hbajLzbIDNerInW8KF4hjXN0SXn8FlpPcJg1puSTabj/cepFy
 +qFdNqsJTscGJNbxZdlBnWwT/Lh9DXjkzTE50npzi79F09c6jGIiM03cBhdk2QaNOt65AqiTk
 yUaNHobffZVPWe3SHCOhEAZR8V5VpmNfoDasmJMV2t1BEd8LRDqvMZObozKYkvcLkw7TmrUsL
 stVYFbJOk1NIpwX1E5JCRrYbjcIkp9oBeQZahtaLdq4qw7JImG8RAMUQhUy58ZciYAkBXn98m
 gbZWmyporQZ+U2pZGTXVbJHqpO8ZaBkyKXJZR/AzbaR0pvi8sAXOjvqQAqtP6WLrI5IMHJUUI
 lwPceMSCR3HmMUqa45kGgR22p+EONmSt5dhtzopHz2jRqBmPxhjsS/ujGCF+5Qz/RbFbhnOqx
 mBXj/TQFfmKCG3dhql3QEOm6hBWoqsR2KlSoCsxDLHUUhFlkcc7b5krEJubdXKcRX143c3QZd
 sUncxDuCis3rcY5d2BqLnCWhLEZeU3qwYAAaWCjDm9NjhKAyF0hg/S05wLM1ZIuHCW1IB6Qcg
 kvgH1kvWtMjhArgEtweDdwwPko1jvKhXIaB0xA==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit e7c52b84fb18f08ce49b6067ae6285aca79084a8 upstream.

We get a lot of very large stack frames using gcc-7.0.1 with the default
-fsanitize-address-use-after-scope --param asan-stack=1 options, which can
easily cause an overflow of the kernel stack, e.g.

  drivers/gpu/drm/i915/gvt/handlers.c:2434:1: warning: the frame size of 46176 bytes is larger than 3072 bytes
  drivers/net/wireless/ralink/rt2x00/rt2800lib.c:5650:1: warning: the frame size of 23632 bytes is larger than 3072 bytes
  lib/atomic64_test.c:250:1: warning: the frame size of 11200 bytes is larger than 3072 bytes
  drivers/gpu/drm/i915/gvt/handlers.c:2621:1: warning: the frame size of 9208 bytes is larger than 3072 bytes
  drivers/media/dvb-frontends/stv090x.c:3431:1: warning: the frame size of 6816 bytes is larger than 3072 bytes
  fs/fscache/stats.c:287:1: warning: the frame size of 6536 bytes is larger than 3072 bytes

To reduce this risk, -fsanitize-address-use-after-scope is now split out
into a separate CONFIG_KASAN_EXTRA Kconfig option, leading to stack
frames that are smaller than 2 kilobytes most of the time on x86_64.  An
earlier version of this patch also prevented combining KASAN_EXTRA with
KASAN_INLINE, but that is no longer necessary with gcc-7.0.1.

All patches to get the frame size below 2048 bytes with CONFIG_KASAN=y
and CONFIG_KASAN_EXTRA=n have been merged by maintainers now, so we can
bring back that default now.  KASAN_EXTRA=y still causes lots of
warnings but now defaults to !COMPILE_TEST to disable it in
allmodconfig, and it remains disabled in all other defconfigs since it
is a new option.  I arbitrarily raise the warning limit for KASAN_EXTRA
to 3072 to reduce the noise, but an allmodconfig kernel still has around
50 warnings on gcc-7.

I experimented a bit more with smaller stack frames and have another
follow-up series that reduces the warning limit for 64-bit architectures
to 1280 bytes (without CONFIG_KASAN).

With earlier versions of this patch series, I also had patches to address
the warnings we get with KASAN and/or KASAN_EXTRA, using a
"noinline_if_stackbloat" annotation.

That annotation now got replaced with a gcc-8 bugfix (see
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715) and a workaround for
older compilers, which means that KASAN_EXTRA is now just as bad as
before and will lead to an instant stack overflow in a few extreme
cases.

This reverts parts of commit 3f181b4d8652 ("lib/Kconfig.debug: disable
-Wframe-larger-than warnings with KASAN=y").  Two patches in linux-next
should be merged first to avoid introducing warnings in an allmodconfig
build:
  3cd890dbe2a4 ("media: dvb-frontends: fix i2c access helpers for KASAN")
  16c3ada89cff ("media: r820t: fix r820t_write_reg for KASAN")

Do we really need to backport this?

I think we do: without this patch, enabling KASAN will lead to
unavoidable kernel stack overflow in certain device drivers when built
with gcc-7 or higher on linux-4.10+ or any version that contains a
backport of commit c5caf21ab0cf8.  Most people are probably still on
older compilers, but it will get worse over time as they upgrade their
distros.

The warnings we get on kernels older than this should all be for code
that uses dangerously large stack frames, though most of them do not
cause an actual stack overflow by themselves.The asan-stack option was
added in linux-4.0, and commit 3f181b4d8652 ("lib/Kconfig.debug:
disable -Wframe-larger-than warnings with KASAN=y") effectively turned
off the warning for allmodconfig kernels, so I would like to see this
fix backported to any kernels later than 4.0.

I have done dozens of fixes for individual functions with stack frames
larger than 2048 bytes with asan-stack, and I plan to make sure that
all those fixes make it into the stable kernels as well (most are
already there).

Part of the complication here is that asan-stack (from 4.0) was
originally assumed to always require much larger stacks, but that
turned out to be a combination of multiple gcc bugs that we have now
worked around and fixed, but sanitize-address-use-after-scope (from
v4.10) has a much higher inherent stack usage and also suffers from at
least three other problems that we have analyzed but not yet fixed
upstream, each of them makes the stack usage more severe than it should
be.

Link: http://lkml.kernel.org/r/20171221134744.2295529-1-arnd@arndb.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[arnd: rebase to v4.4; only re-enable warning]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index b53b375e14bd..f0602beeba26 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -197,7 +197,7 @@ config ENABLE_MUST_CHECK
 config FRAME_WARN
 	int "Warn for stack frames larger than (needs gcc 4.4)"
 	range 0 8192
-	default 0 if KASAN
+	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
 	default 1024 if !64BIT
 	default 2048 if 64BIT
 	help
-- 
2.9.0
