Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x227CSaQNxBErRP+mkc59aGugAzZ9oOFUcR9Cv+ANsqGjTPIMnaVSp6Bi5Ll84Rx6Q0zekF+6
ARC-Seal: i=1; a=rsa-sha256; t=1519035570; cv=none;
        d=google.com; s=arc-20160816;
        b=ovIz91uqElQH14xWSpm/y1pBtCUl97RsnZS/xr5y8412vMEp6RY8xDpeYNBC3dfMmR
         Lkt3iTXCPoZmVA2oQq/PwtmFhs+LMKcTezNsaBDtpuKgc8z25S4V5poT1NhX8qnqyqJK
         svxIssxv5vBVLlvS7tQLHubsL4Y05iLgOHzCKjmbW33puHEcKwZ0kTJXIbX5SVIp9DZd
         XwS91xJsHkr5LY01LAeG5yfvCWiLYoD5rQCoTLUz0ak1c1T3Ka7z/iI1PBkuGd49py6f
         PRECVqDOR8Iz8SK1KjXh5VCM76UWmbEwpE8o8jGqw5CCeCfWyohw7+v8sDbe+dW+6MLs
         Il5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=YFWtT77g5ALI0menvTm90EKyKYJB1aPpo7vFfSVSVIA=;
        b=D9ZvGdOKHyHruTJzPywkj8lni2STVzNZgGJcvcssNYoT3xhFnLm68MiaZqxNjzSudk
         JlvgTP0WF69CRyajSiG88/wwlVNiUEw4uRHqLAwIFyOnfbPAnRA7JFrjgYJySUPNfRod
         oh5Au7gUT5HVOJRvkDJotjlF9Lb27tcTgkgU60etygPhK/x70dL1JjxnGLVuSBE1qaUU
         JMJL/duN7mJl2UX2hO7j4+YxmH96Xrjx+agN8CW6LLUabe639YiZzDozTD66Zt6bbVA9
         nk5VrGs0eRd5ZNA23ZIjz3UOHMC/1l5iE2tB1m8GGOfVDRjZUkdiwMDglzymoZ/2xT3Q
         oCmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.131 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.131 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <alexander.levin@verizon.com>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [4.9-stable 1/9] kasan: rework Kconfig settings
Date: Mon, 19 Feb 2018 11:13:20 +0100
Message-Id: <20180219101343.2922561-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180219101343.2922561-1-arnd@arndb.de>
References: <20180219101343.2922561-1-arnd@arndb.de>
X-Provags-ID: V03:K0:wKI57U609WKa1lDv4jC1sGo6PKTYdkxXbFOocblHPrnST6aXqia
 3vfTiOzqVrJr7lCxOKSzyGapmNvi2xwhz+LHaHuR/Wtpk9K2wZ+doFDpG1jdyUk/BdvTFmM
 att7ca/Zby8GvqoYrVscTw7CmhI2AL2ciLXGmhbbpiR3JC+DxU+5wOoW2PCp8UooyBA7kMw
 hesnrWvd0XBA3IDktCPzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vQnDv8r1hHA=:3s50Ljt//uWSwNuuTgh2hr
 LIdS0U3scod3KfKq66kq8bTME4qNrdwUmnZx25QOf1xJMQxjNViyHoNMsmDuEIoTaBzWO7+2Z
 So67UpZSkD+qhYoQDsgi9vN3TpfxXv8Mg8MHK9mpgySmsD8m1OPEEAHy9GOpNZPkGsIICleUX
 wwSzKyCR9rsi0E0MY1MpFL37RErxDUct9QAamf07R51bKcq3n8DBmnPBOsIaVfXdfb/OAgSnU
 ZsKPumJVNmVExt2vBroyN6+0+RPBKxFO2hUIfEw+a30cpHGKuXVrVu02YnRIg1AhIgDxW185L
 rwTIMdu5YMxHj9dQb86Ypce9QLdCH73Uj2kXgRLnCcOT+XOICOcb+5sxE88Ji0z7USIxcOaOB
 pL5uCoYwwBTibhbeJfE7brOJd9uwCjpyNjD33rKZxVrEACiL85vTY5zSEdLsp4HkCqGcUIhiy
 m/mQhx4DmdOIuWjL16JRbgxXfqHxvgCl00Fs/HGSHPwFGUDLWbkyf+Hto6mLAAWJLvwvall1K
 qKfuPxi7P8V6mbHfMHdDAd9urL+AHYuPXaahmdsZ/2CqWtIhx87lUrodujl/q2XawizuwsGI3
 hr7m1QSLojWjFlBROneLiMruH4UjMc7GfygVyJeYMmQpb+6VP30BLr0ctql9eZ4gKtqwOg5gW
 25ym4n1DlhufnQ0EZ6ywOcmzgp4lHpty6kimTcKlfwyj5VQvpP1T7LQl6WM77lhIsO8wsaOG6
 bTQL2ajYgeEzfsvcysLoER9gpovr9dM5+95hJw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592824241749138600?=
X-GMAIL-MSGID: =?utf-8?q?1592824241749138600?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 lib/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f60e67217f18..58a22ca10f33 100644
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
-- 
2.9.0
