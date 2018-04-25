Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524672491-2-4603330043064912948
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524672489; b=lHfmkQj+2Pyt+JvA9bBIQI4lC7IYXYZAD6YoF4nFmPiqp0VCdX
    v67dsU2EvCV+DFvdMgZbEbgilOZ9YEDcn3qpM7yTqZ9AhiOdRXVdcoFk2SLc16j9
    zMHQp+orcA74Mecg0t0OdUNybjFOEaR4Ti8cwQv2biXydQwViu5dG7/kl/BIdK55
    qxtBUVETKtI/S8IVT1pZohWEhFylYjwuXoBSP2Rqpr+GqkGPyl/rNplPyG4vdlhL
    smGNHv+bIUxycn8aITDnh34gVV4uva1ebbIivSK0hAgY2yUKYz9WLo63yx0pEJgN
    gII6lJNT5yYrZJwU8pDkKX3A46RGfKhXNX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672489; bh=
    qwryKJvA5OseG29nsPkSrfa/TWt3VMxH3H+fe5qdQBI=; b=kOLLzFsA+oda9sT7
    SSnSdN36o7uw0MY177NiaopjIwIyS3FMDXVyqQR4/sDo0H33Be7pAgBQ87wMZ/6c
    +xFyMJwqeoZCM+7dsJ3gHf1swBm3ooZ06r0WjXZkIopf+R1EkR6o77WeczfpF+Ic
    Ov8RebGOYRS6DogvbVHvumx3k4+Id/nDUi8cN/LvepZLX7xIMqYhBBWYMG7fwNo6
    gg9SmlSU39uz0ifu39LorMZcEk19xzZfjjZQu9B3PMnEAk61GbEYMSaTrUOoFzoO
    Kb+1QxzZ9FDDd2I7taSSCcEOCZg+JaIAQ9BcLMRChuRanb8waFCdbKdhi3EpO0H6
    /Zh9iw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAMMGgse/yIxhLvhGwsE2ywYRB2zFhJN9j670JPFG5S/IPoLEgzw67VF9YKUY3wtZg3n4MI7v6jQ9VPrSiApoAoGxswmosF1PNeMrox7eD8Bp9JtZkxp
    l5IQd/E3erQTMAMzimg0r5rCkTAPL5MDpMil2AN4MglYjjWv4LpGt5GrUsHNhWa5KpdHUORzFz8lHLcWzny8qM8hYTOMP4zbQNz7z3JBtyNc9TZLcT9vmCeK
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=VCx0LXix7ME5Neo_Bg0A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755855AbeDYQFD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:05:03 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755253AbeDYQE4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:04:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, netdev@vger.kernel.org, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, albert.aribaud@3adev.fr,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 11/17] y2038: Prepare sched_rr_get_interval for __kernel_timespec
Date: Wed, 25 Apr 2018 18:03:05 +0200
Message-Id: <20180425160311.2718314-12-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:8jwDeyfmJKkciOyNw0bu2Tt8CtGOBeJN9yCrM2Scbqyw99Pz3kF
 kmBBkDi+c5gNlWYHPef3tIbeF/0q8IkMlQTvcunkQDNlbnE77ppLbI9WTQDWRQbpDolE3WW
 zHaHdKzFKNXZiYmpg2PZJytYwxpI0DvwHfuH4HtQXeLsiXbHgFvE9tGT0K8FXUgKH6SDrRt
 YCMhP1D6ErxbwNroaPXLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/FaaNQSDfXA=:9RI72P3/fCSIoEz5AehtOp
 Z0NMYXhTYhud0oBUDxmHd9qNcll4mgXzU48abDtcCQG19gl1v9ecytnu8ODKPuGt4AiGh8TPw
 s6LrO/81e57P0qTMNRPJxWUWA5Cbe7gPFLRtURoMU+xYria8cwhJN/imNhrl7qfTEER/kBqXl
 b3OuFRDxgdFaaok/4/IVQ8GiAIdaNGXsdQ2dJqxLuwtlbIr0hW2DpZNbjccwhyJH0BXGkT/yf
 ZH8dxheDMcN9KQpzZB8XAp083yKyJ8O3OT2O916M+pQTwgZhoBm+hQXRxGbNs0K5G8XnyDCm7
 2isfPv9r2Q+jAbS2udojw46o2gc/ZOTEJaSZ1a0OmPkkM+Vp4a0weTkUhCd+0ohtQwhkOunE2
 +iFhVYTxw7fzgVRp0MJcMfa2WoHRc2ebZ0hBg3lqJKIGWaBVcK3emr7yxMMUEsAA3PmY9Mp4r
 z5iP5BRJipbMlBjsb2J4Y2jhcY50C82fn7mOQHkzc+rREZVjJusf490JMvRJHYl0D7B7+lNGH
 Bp893+YyJbP3R4CngVkrR6gqLoFN3Xc3Ebr7BuPxpv0v7y+zanIcKS9UXoLqAJ59zdx+pZowH
 bmhxoZy69Y9WTYhaKtfytomJrOlkDFX+7FWRITNsqhkQvGlmtATdkzvROXZMRAFnsn+2QRv7Z
 GrUmTZ1JB3B5kXSM2EMStBP+8JJpk8vlEBBf3A+sYUulO1rxBb2ObdDNefFunkL5ahYA=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a preparation patch for converting sys_sched_rr_get_interval to
work with 64-bit time_t on 32-bit architectures. The 'interval' argument
is changed to struct __kernel_timespec, which will be redefined using
64-bit time_t in the future. The compat version of the system call in
turn is enabled for compilation with CONFIG_COMPAT_32BIT_TIME so
the individual 32-bit architectures can share the handling of the
traditional argument with 64-bit architectures providing it for their
compat mode.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h | 2 +-
 kernel/sched/core.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c3d504dbba9c..2619678359ee 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -601,7 +601,7 @@ asmlinkage long sys_sched_yield(void);
 asmlinkage long sys_sched_get_priority_max(int policy);
 asmlinkage long sys_sched_get_priority_min(int policy);
 asmlinkage long sys_sched_rr_get_interval(pid_t pid,
-					struct timespec __user *interval);
+				struct __kernel_timespec __user *interval);
 
 /* kernel/signal.c */
 asmlinkage long sys_restart_syscall(void);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e10aaeebfcc..1e0afc42975b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5272,7 +5272,7 @@ static int sched_rr_get_interval(pid_t pid, struct timespec64 *t)
  * an error code.
  */
 SYSCALL_DEFINE2(sched_rr_get_interval, pid_t, pid,
-		struct timespec __user *, interval)
+		struct __kernel_timespec __user *, interval)
 {
 	struct timespec64 t;
 	int retval = sched_rr_get_interval(pid, &t);
@@ -5283,7 +5283,7 @@ SYSCALL_DEFINE2(sched_rr_get_interval, pid_t, pid,
 	return retval;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE2(sched_rr_get_interval,
 		       compat_pid_t, pid,
 		       struct compat_timespec __user *, interval)
-- 
2.9.0

