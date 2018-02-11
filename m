Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324961-2-2634642101612289245
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324961; b=ZrHHMSefn/7V2742QVJkLG4gGkLTQu6VPbFkC5kue7wJD+y
    IVnhzX7nzmPdToejXCAieeHiNk7fYqSIO5vagqA7L4EGM38SbZozz0UfxtMz+ICE
    plql4QYzxYVmOLLAq0QqMZQInGsM/jNvnADakuPdLwIhDCo/64SdE119ByiXElKo
    LJoUobtDJQ5+WVzV/WKtgwBwlt1dOhUqeM2btJMW2ZghdjrK9YKB6NoehCN4KVl/
    RIC8o/KcgweWH9cSDsCShWxAhagaXUx6KyW/5pJ05vEE2pl/ecMp0U4PC7WKoWMT
    oDb0AFnQYy5VnYxTRLmanTr2c70o56v3x2DyExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324961; bh=4r/5rVqPh5rxwFO93Cq
    zqRr6z4oCuNkMOw/GyZMuObg=; b=s/nVIJuX/WuwuO3g67sOlC8Qtrnqg9Dl7eb
    wTUr5VSis2b7iDiOiieeJGfGHtEnBs05EOZMbJbC7adko5QC1HdUt/dMQTHLRvmU
    OnHRfUBLlVL1yfSzk5QMcviJTBusMc6uofI09SKI2VonK3O61ahIiJcKmPUa2pZb
    LvEGdnHMrUBYVzDrYcJDnyOb8jnFi+r/B6UOAStp2gz5doZsufY2Lkhu+Y5pEOZd
    poHJAlWhjg6HXKtjm8F0UkVwEdDPHvm97xyGD5xLvCqB2V6bG0BGh+iA8BuF6JJs
    vst41IIy9Qy1lw5ah0+Zq9jYKOYThz5zW4F63q/B+7OR/Al89uw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbeBKEz7 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:55:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41697 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752794AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Borislav Petkov" <bp@alien8.de>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Andy Lutomirski" <luto@amacapital.net>, linux-mm@kvack.org,
        "Ingo Molnar" <mingo@kernel.org>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Brian Gerst" <brgerst@gmail.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.513508387@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 130/136] x86, vdso, pvclock: Simplify and speed up
 the vdso pvclock reader
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

From: Andy Lutomirski <luto@amacapital.net>

commit 6b078f5de7fc0851af4102493c7b5bb07e49c4cb upstream.

The pvclock vdso code was too abstracted to understand easily
and excessively paranoid.  Simplify it for a huge speedup.

This opens the door for additional simplifications, as the vdso
no longer accesses the pvti for any vcpu other than vcpu 0.

Before, vclock_gettime using kvm-clock took about 45ns on my
machine. With this change, it takes 29ns, which is almost as
fast as the pure TSC implementation.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/6b51dcc41f1b101f963945c5ec7093d72bdac429.1449702533.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16:
 - Open-code rdtsc_ordered()
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/vdso/vclock_gettime.c
+++ b/arch/x86/vdso/vclock_gettime.c
@@ -78,47 +78,59 @@ static notrace const struct pvclock_vsys
 
 static notrace cycle_t vread_pvclock(int *mode)
 {
-	const struct pvclock_vsyscall_time_info *pvti;
+	const struct pvclock_vcpu_time_info *pvti = &get_pvti(0)->pvti;
 	cycle_t ret;
-	u64 last;
-	u32 version;
-	u8 flags;
-	unsigned cpu, cpu1;
-
+	u64 tsc, pvti_tsc;
+	u64 last, delta, pvti_system_time;
+	u32 version, pvti_tsc_to_system_mul, pvti_tsc_shift;
 
 	/*
-	 * Note: hypervisor must guarantee that:
-	 * 1. cpu ID number maps 1:1 to per-CPU pvclock time info.
-	 * 2. that per-CPU pvclock time info is updated if the
-	 *    underlying CPU changes.
-	 * 3. that version is increased whenever underlying CPU
-	 *    changes.
+	 * Note: The kernel and hypervisor must guarantee that cpu ID
+	 * number maps 1:1 to per-CPU pvclock time info.
+	 *
+	 * Because the hypervisor is entirely unaware of guest userspace
+	 * preemption, it cannot guarantee that per-CPU pvclock time
+	 * info is updated if the underlying CPU changes or that that
+	 * version is increased whenever underlying CPU changes.
 	 *
+	 * On KVM, we are guaranteed that pvti updates for any vCPU are
+	 * atomic as seen by *all* vCPUs.  This is an even stronger
+	 * guarantee than we get with a normal seqlock.
+	 *
+	 * On Xen, we don't appear to have that guarantee, but Xen still
+	 * supplies a valid seqlock using the version field.
+
+	 * We only do pvclock vdso timing at all if
+	 * PVCLOCK_TSC_STABLE_BIT is set, and we interpret that bit to
+	 * mean that all vCPUs have matching pvti and that the TSC is
+	 * synced, so we can just look at vCPU 0's pvti.
 	 */
-	do {
-		cpu = __getcpu() & VGETCPU_CPU_MASK;
-		/* TODO: We can put vcpu id into higher bits of pvti.version.
-		 * This will save a couple of cycles by getting rid of
-		 * __getcpu() calls (Gleb).
-		 */
-
-		pvti = get_pvti(cpu);
-
-		version = __pvclock_read_cycles(&pvti->pvti, &ret, &flags);
-
-		/*
-		 * Test we're still on the cpu as well as the version.
-		 * We could have been migrated just after the first
-		 * vgetcpu but before fetching the version, so we
-		 * wouldn't notice a version change.
-		 */
-		cpu1 = __getcpu() & VGETCPU_CPU_MASK;
-	} while (unlikely(cpu != cpu1 ||
-			  (pvti->pvti.version & 1) ||
-			  pvti->pvti.version != version));
 
-	if (unlikely(!(flags & PVCLOCK_TSC_STABLE_BIT)))
+	if (unlikely(!(pvti->flags & PVCLOCK_TSC_STABLE_BIT))) {
 		*mode = VCLOCK_NONE;
+		return 0;
+	}
+
+	do {
+		version = pvti->version;
+
+		/* This is also a read barrier, so we'll read version first. */
+		rdtsc_barrier();
+		tsc = __native_read_tsc();
+
+		pvti_tsc_to_system_mul = pvti->tsc_to_system_mul;
+		pvti_tsc_shift = pvti->tsc_shift;
+		pvti_system_time = pvti->system_time;
+		pvti_tsc = pvti->tsc_timestamp;
+
+		/* Make sure that the version double-check is last. */
+		smp_rmb();
+	} while (unlikely((version & 1) || version != pvti->version));
+
+	delta = tsc - pvti_tsc;
+	ret = pvti_system_time +
+		pvclock_scale_delta(delta, pvti_tsc_to_system_mul,
+				    pvti_tsc_shift);
 
 	/* refer to tsc.c read_tsc() comment for rationale */
 	last = gtod->cycle_last;
