Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325266-2-8967325615785396805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325265; b=mIx4CJbQLvBgQDo79C06C73rjks6j12hTPVXSwHYM46P1hW
    H8hgo498pgLRhJgJhRAQxgWukKiFuEp/TaL29V6hVPUUfDYwrdtqVkYPkQYWm+qi
    iwQ6Ryu6K+ty1OiuhDMSRThmzTgl34GXnnfiM8qHpOpmzQAZv9pZKMr5n51deXKx
    36t6grnYbswlsBK0k2rCDuh6Bh2IxQjDEURCWbSEU9HiYhtxLZW9zRXse4d3th+g
    JNYinTT91TBjsl4whNL+/i8jNBKS7kUopaRAyofPnsWcrGV/+dZ2/FwUEynhUoZf
    2RPkO5VJoiq73mYvZO5oAKJEvDGIN3xcABmmrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325265; bh=cOBw3HGbCPP70YW8mLk
    wjBIf4otlrVBsk7g7SilMFjk=; b=jbRD5mWEEMhoPZDQOoWB8ruLzb2U8EULts2
    j88o3MIyDKmRQhi8z9+1AD9cnefDPQNEVq5VbiyeTXv4Ndd31+g9nYVBzslZgHnk
    FA0j3MzTtJae1u0qaxOQ2Ne04vHev0Ue3QxCa385JtZuCZWQI/PyPIoSU1jypFcf
    +HJEZ8/ikCKHD7IMHzJ+L8759Rg9OTsGn/MmAt1VMJYg2xyKIk+CCE2CROHg42mv
    M4afDTKHMGU+hzEo2LoHiXgwls7a6ER+98t9ySnitwnnGJXg1nTtLjnupzzOJtls
    hbypu0DR99h7uRzP/4ciTtX3bw9NJVbnbSoOVanogwMKjG22iTQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753761AbeBKE6r (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:58:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41682 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752788AbeBKEd4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.534920868@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 133/136] x86/platform/uv: Include clocksource.h for
 clocksource_touch_watchdog()
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ingo Molnar <mingo@kernel.org>

commit d51953b0873358d13b189996e6976dfa12a9b59d upstream.

This build failure triggers on 64-bit allmodconfig:

  arch/x86/platform/uv/uv_nmi.c:493:2: error: implicit declaration of function ‘clocksource_touch_watchdog’ [-Werror=implicit-function-declaration]

which is caused by recent changes exposing a missing clocksource.h include
in uv_nmi.c:

  cc1e24fdb064 x86/vdso: Remove pvclock fixmap machinery

this file got clocksource.h indirectly via fixmap.h - that stealth route
of header inclusion is now gone.

Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/platform/uv/uv_nmi.c | 1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -28,6 +28,7 @@
 #include <linux/nmi.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/clocksource.h>
 
 #include <asm/apic.h>
 #include <asm/current.h>
