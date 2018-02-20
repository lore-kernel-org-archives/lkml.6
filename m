Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x2256w1iNT+BBj3KWbuNiEKEsKFhOrR41nrHpxwyaJ+Rgr9mEh+PpnuYFLhJQmj3InQhCUqUx
ARC-Seal: i=1; a=rsa-sha256; t=1519127972; cv=none;
        d=google.com; s=arc-20160816;
        b=uq/b7T07ofczjJ5JZtzhtxRqFGgBxwgxsu6Wk4nw0ODpRQawv1YpDt65i6Nk2qDhe+
         ac2Se8S6YA/9UXK3/lA04/xNEzo3jo8tbM32N0oj/u5pEKOOwB9T6Z9LGT/G732vciHd
         +1AhkB4XPxK3xfW5pM+4GhIiZscbyHPosUoxw/jlbV5V7bVijO1ArYCqqxF/ytJzt/zp
         PVMmCnArujGlW7YAIPykLRnpbuzY+9zo6IztXh0Qv1cHHaLNhfx1dP4GAy5+TtkCP+LH
         /tm4B+bByD2SnDbuxnOczgjIDVjksL4SHwftUgW+C+dZnbrn7E9wbTDULKQQd32ptVZN
         jP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=jhotoyoWri2GEApGlRHagNVUionzj33ngEJXSTx05kA=;
        b=vm9f5bJF9TzyAeeR8Let7ZqQINOaBl51f1eMhtqDQkDETxys/i6j556uqjfVSYo4CP
         lBnS4xnmwmfRKYu9adrk4LRwrBBLrRGc7lM6vi45hL/EMKL1PA3f1T/nUwJxG6Li83bo
         nbh2Px/D/+hrnb0/fBqhTMLi39OcQJnJdWBq5sM83SENO7+ovtEX9m8E/d0t3URcMRI+
         OU1aOTCR4GLbWT8yYzVh7tsVEveCgNmaHpBWSyHStzxHoyPtvcFHaeYcOQC9695GUVNW
         5oGqzQ7Q0z5SsIV6NFmk2aaShf4/giXvMptr4HBHdAm5HqMw472vmWqgjmdonvtMKus0
         nvqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.17.10 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.17.10 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Subject: [4.4-stable 15/22] perf/x86: Shut up false-positive -Wmaybe-uninitialized warning
Date: Tue, 20 Feb 2018 12:55:02 +0100
Message-Id: <20180220115527.1806578-16-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:hTy6pIpOSkbjYvtV8AoKEqc60knZbtc5iYHTNxQAOjxZ9rhupVB
 CAC80qyYX4ew1wgpLUXSPSgmrxf1oR15i8oHPhkQexoVNv6d4aJWHBgPJFr1jUZyMKQUiet
 YhUNVM5VxElhP4UKrX3hzXwreCZSgGQTKllR8ADsA7WAOApfhXpmL/OWXeYqWgthGKuvKoJ
 go+G+lI0Aclh70IZ6gzzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EwxmDRNc3kw=:iaFlXy5V7Fhi0+oaT8SGd2
 5SZzafK7td3oJz0tI3/5wlUWg0RKmA0WgMHIrlh0ABYnCiLxDUQP2DAPcuJLg3ReEbdXb7LVi
 z0bJvO5c4ZbFBsmYd1yGo+R7FUhaRbSM/Vy/tSgNYkHnlYptydCCZD9SEfpwl3oeMzKV2QGq3
 tTFNJ1FQjT9fKCR+Z0rNFrtzdwACJLfQ2ULBswdSo7v5rMjS8XqHhPJ22edATCs/N2wB/5E3u
 GfnYeRlWEDPIHf2xl0icGS2+aKWFqk37xHpI0Liu4r6CZTxmIiRbdFYKdkCALcRZT7Prujqrw
 NF5g4TmZYzAVTAgejylwUbPpmZwkKqMzD9p1zAnrWrU/96IMbMXa/ITQ+XJTrdUeymLMRt1Zk
 Ctv5zUecfDZ0EMfqSBcSUaaDJ+g/t70fuaJmYnCSkvytPIDyZR0hYXZIhR7a3KqZJSF3t4fto
 t6Y8F+AHwqj0MimpStbs+HKfirUwaNDGSqJdicutVXAjK4ggxpag9olBYm7S71Hn8S/MdhIGz
 PSVZ9YsZSo2A/PN4TDAxxOBOjWR7mLOIcCB2sOgMWJ7iZq6m1UVxsman8NDp4KUKFMYlRF7rO
 n9Rbj44LQ0WgDaDPKo2dewd6eMoWfXwIUuOLUeR3l+If/jjR8aYMLiF25eJmfmAP3UlaFx/9Z
 1enbbHfkIh7VV0Vk2Lip+h2GNQ22UpE2LamGyaHK4nKlaELJRvfbZQo22QrM5YN+vWq5/7j+9
 oMwKwH1i6x/ZFJATrhVSElRmc05jUlon69E1AJbU1VZxvm7zLH84sVcXol0=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592921132299035768?=
X-GMAIL-MSGID: =?utf-8?q?1592921132299035768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 11d8b05855f3749bcb6c57e2c4052921b9605c77 upstream.

The intialization function checks for various failure scenarios, but
unfortunately the compiler gets a little confused about the possible
combinations, leading to a false-positive build warning when
-Wmaybe-uninitialized is set:

  arch/x86/events/core.c: In function ‘init_hw_perf_events’:
  arch/x86/events/core.c:264:3: warning: ‘reg_fail’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  arch/x86/events/core.c:264:3: warning: ‘val_fail’ may be used uninitialized in this function [-Wmaybe-uninitialized]
     pr_err(FW_BUG "the BIOS has corrupted hw-PMU resources (MSR %x is %Lx)\n",

We can't actually run into this case, so this shuts up the warning
by initializing the variables to a known-invalid state.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170719125310.2487451-2-arnd@arndb.de
Link: https://patchwork.kernel.org/patch/9392595/
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[arnd: rebased to 4.4]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/cpu/perf_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event.c b/arch/x86/kernel/cpu/perf_event.c
index 5b2f2306fbcc..b52a8d08ab36 100644
--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -188,8 +188,8 @@ static void release_pmc_hardware(void) {}
 
 static bool check_hw_exists(void)
 {
-	u64 val, val_fail, val_new= ~0;
-	int i, reg, reg_fail, ret = 0;
+	u64 val, val_fail = -1, val_new= ~0;
+	int i, reg, reg_fail = -1, ret = 0;
 	int bios_fail = 0;
 	int reg_safe = -1;
 
-- 
2.9.0
