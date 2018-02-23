Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415099-3-9527025093589450335
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415099; b=ric5q3ocZ5bDrgiSsQn70z+9byNbXs2zRXUIgnksuDDwb0G
    M7M1bzKsBvdFC6F8oV/SdwjnBT73Wjwo8zNZdOSgnE+9Xs3VtvF1dP/34MId0l2j
    QPJOTfC/z/zfO24/kMKBS95/n3MGzdLG9qiaTJDkEc0DtLymyHS8R+Fe7jq8cxHG
    WXrf9bDvSiWevvQz35TRU8i2+ghn+HTWNHqpKI3MxAzpfe0k1BAEwMshVrSA/JS2
    in8oQuCdXd29Diy78vgs5WCSfMlcWOuNUTxEdxEeAg3sXo3LIIfSwgfsZa+NoePE
    bPqSBTY8GtXXSq6iKC8ooacGY7M+R4rWYFPrsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415099; bh=v1+pYpYLr+rXO5NdIzb+4KLeHb
    eLhP+kLrLOEphets4=; b=siYX5b9G5E0X4xrjZDlHcx4F/7xiq/RkE4umw7/5Td
    Vpfv0H9AC21XMnmftucgB4qCLL6xQWeDHbLadyYE4HG1dAHkND1LeMku+ODbhENd
    ik8wrAt528e25hhPSL4P/m9Lm9k9RBZ3oqYrLtsGBEj5TVZbM0Qliz0PPBX32BLo
    KVGdCJsT5OaMEkNEHIOvsK22HnVHNT7QeLIB9529sGAwMLAxM7NoWvTpLWESeXRp
    FhWegdMZ6xoc5Ty6vgMlQQkIc1vFvwWbxF9b9NnKIzwvvLW7GC3KNzHJ6fbPV6hF
    eWkdmS/Tj5w0PSuE58Cp1Q2HX7aSwf2Zq2MxS/TrBD7Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934052AbeBWSsT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:48:19 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44870 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934018AbeBWSsR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:48:17 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 133/145] kasan: rework Kconfig settings
Date: Fri, 23 Feb 2018 19:27:19 +0100
Message-Id: <20180223170741.957508092@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

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
[arnd: rebase to v4.9; only re-enable warning]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/Kconfig.debug |    1 -
 1 file changed, 1 deletion(-)

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -197,7 +197,6 @@ config ENABLE_MUST_CHECK
 config FRAME_WARN
 	int "Warn for stack frames larger than (needs gcc 4.4)"
 	range 0 8192
-	default 0 if KASAN
 	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
 	default 1024 if !64BIT
 	default 2048 if 64BIT
