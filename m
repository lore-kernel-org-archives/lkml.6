Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E567CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E062082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbfAPHuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 02:50:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:48638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727667AbfAPHuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 02:50:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10E3EAFA0;
        Wed, 16 Jan 2019 07:50:15 +0000 (UTC)
Subject: Re: [PATCH v3] xen: Fix x86 sched_clock() interface for xen
To:     Hans van Kranenburg <hans@knorrie.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        stable@vger.kernel.org
References: <20190114124413.3742-1-jgross@suse.com>
 <ebfc24e3-21a0-6cc6-ae68-5c13c1e66b9a@knorrie.org>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4808225b-e413-2ec1-77a1-15999c18583f@suse.com>
Date:   Wed, 16 Jan 2019 08:50:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <ebfc24e3-21a0-6cc6-ae68-5c13c1e66b9a@knorrie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2019 01:24, Hans van Kranenburg wrote:
> Hi,
> 
> On 1/14/19 1:44 PM, Juergen Gross wrote:
>> Commit f94c8d11699759 ("sched/clock, x86/tsc: Rework the x86 'unstable'
>> sched_clock() interface") broke Xen guest time handling across
>> migration:
>>
>> [  187.249951] Freezing user space processes ... (elapsed 0.001 seconds) done.
>> [  187.251137] OOM killer disabled.
>> [  187.251137] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>> [  187.252299] suspending xenstore...
>> [  187.266987] xen:grant_table: Grant tables using version 1 layout
>> [18446743811.706476] OOM killer enabled.
>> [18446743811.706478] Restarting tasks ... done.
>> [18446743811.720505] Setting capacity to 16777216
>>
>> Fix that by setting xen_sched_clock_offset at resume time to ensure a
>> monotonic clock value.
>>
>> [...]
> 
> With v3 of the patch, I see the time jump in one log line happen, but
> only when using PVH.
> 
> [   49.486453] Freezing user space processes ... (elapsed 0.002 seconds)
> done.
> [   49.488743] OOM killer disabled.
> [   49.488764] Freezing remaining freezable tasks ... (elapsed 0.001
> seconds) done.
> [   49.491117] suspending xenstore...
> [2000731.388722] xen:events: Xen HVM callback vector for event delivery
> is enabled
> [   49.491750] xen:grant_table: Grant tables using version 1 layout
> [   49.810722] OOM killer enabled.
> [   49.810744] Restarting tasks ... done.
> [   49.856263] Setting capacity to 6291456
> [   50.006002] Setting capacity to 10485760
> 
> If I start as PV, it never seems to happen.
> 
> Up to you to decide how important this is. :)

We could do something like below. Boris?


Juergen
---
diff --git a/arch/x86/xen/suspend_hvm.c b/arch/x86/xen/suspend_hvm.c
index e666b614cf6d..088f3a6b4be9 100644
--- a/arch/x86/xen/suspend_hvm.c
+++ b/arch/x86/xen/suspend_hvm.c
@@ -13,6 +13,6 @@ void xen_hvm_post_suspend(int suspend_cancelled)
                xen_hvm_init_shared_info();
                xen_vcpu_restore();
        }
-       xen_callback_vector();
+       xen_callback_vector(true);
        xen_unplug_emulated_devices();
 }
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 0e60bd918695..ba293fda3265 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -55,7 +55,7 @@ void xen_enable_sysenter(void);
 void xen_enable_syscall(void);
 void xen_vcpu_restore(void);

-void xen_callback_vector(void);
+void xen_callback_vector(bool silent);
 void xen_hvm_init_shared_info(void);
 void xen_unplug_emulated_devices(void);

diff --git a/drivers/xen/events/events_base.c
b/drivers/xen/events/events_base.c
index 93194f3e7540..8d8d50bea215 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1637,7 +1637,7 @@ EXPORT_SYMBOL_GPL(xen_set_callback_via);
 /* Vector callbacks are better than PCI interrupts to receive event
  * channel notifications because we can receive vector callbacks on any
  * vcpu and we don't need PCI support or APIC interactions. */
-void xen_callback_vector(void)
+void xen_callback_vector(bool silent)
 {
        int rc;
        uint64_t callback_via;
@@ -1650,13 +1650,14 @@ void xen_callback_vector(void)
                        xen_have_vector_callback = 0;
                        return;
                }
-               pr_info("Xen HVM callback vector for event delivery is
enabled\n");
+               if (!silent)
+                       pr_info("Xen HVM callback vector for event
delivery is enabled\n");
                alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR,
                                xen_hvm_callback_vector);
        }
 }
 #else
-void xen_callback_vector(void) {}
+void xen_callback_vector(bool silent) {}
 #endif

 #undef MODULE_PARAM_PREFIX
@@ -1692,7 +1693,7 @@ void __init xen_init_IRQ(void)
                        pci_xen_initial_domain();
        }
        if (xen_feature(XENFEAT_hvm_callback_vector))
-               xen_callback_vector();
+               xen_callback_vector(false);

        if (xen_hvm_domain()) {
                native_init_IRQ();
