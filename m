Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-23294-1518527038-2-201085584506778195
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518527037; b=I17f2CGVmtP12XOnsX0NSutp3LfWhyb9XyjmLAsFaupygWs
    GL5Ayaa42Q8GNJoC52+/w1Ym1JRwa5T4CL/B34Wh2GefOKwdgxw/XBURZ1uO1QJV
    H5wdBHrj+Y4nnK799gLYUErQ0mz8s+6ipaZcpAh86HwnGufpGxv7kbHnIikodIcS
    yUKOl2NFi6cw3J0SDEXIJmRnC1h6q7yb0jrvMmmXJDy1SE6OFl++DmtnxlVmU8dQ
    nQ3kt4z4kvIlxq5W612MN9eXPmnstb5zh0IDwRLOVwZWjznVepTvhH8/z4yXqh+F
    xvgzONoeOJ2BVql09WfQx0678VEC3CHQZp1tabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:message-id:cc:reply-to
    :in-reply-to:references:to:subject:mime-version
    :content-transfer-encoding:content-type:sender:list-id; s=
    arctest; t=1518527037; bh=vifEUGc+jOA9DSp+iFRGyiWQBzRuCVxLJ1hTQz
    rn+eY=; b=uOBZK6eOWoFcYFVmt8wRdUi8aBEvwWFLlbhsnuialcQFgfjS8hNJFU
    uJGXc9cAIsn7LS/MJSU9dhwtHEMiDoxOVscV6JF6mUyyBbLkGEqte+TAqlR9HIn8
    qqbCJTxg7UpxNKpW7Vlk5HHaM5hZHqmIOhInL8P7nhzAnqDv+6IOBByNBAo0K3+T
    Z2QpJYb1kKOB+ImO0nOMMD1O9Qjc64/p2sddquqUfMudvjJaFdZjMdabY1YnDtMm
    m9Wt/JBMsRmOtuvf3k0MkDB4lwFwkdJTkakWMefisndIpylc7XeTT9LEgI5AOEso
    1qPUZ0yEBGenE47qseSJ/LFIj0NW8uJA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zytor.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zytor.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeBMNDz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 08:03:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34387 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750865AbeBMNDy (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 13 Feb 2018 08:03:54 -0500
Date: Tue, 13 Feb 2018 04:13:08 -0800
From: tip-bot for Masayoshi Mizuma <tipbot@zytor.com>
Message-ID: <tip-295cc7eb314eb3321fb6d67ca6f7305f5c50d10f@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, stable@vger.kernel.org, peterz@infradead.org,
        m.mizuma@jp.fujitsu.com, torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          m.mizuma@jp.fujitsu.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, stable@vger.kernel.org,
          hpa@zytor.com, mingo@kernel.org
In-Reply-To: <ed738d54-0f01-b38b-b794-c31dc118c207@gmail.com>
References: <ed738d54-0f01-b38b-b794-c31dc118c207@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/smpboot: Fix uncore_pci_remove() indexing bug
 when hot-removing a physical CPU
Git-Commit-ID: 295cc7eb314eb3321fb6d67ca6f7305f5c50d10f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Remote-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on terminus.zytor.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  295cc7eb314eb3321fb6d67ca6f7305f5c50d10f
Gitweb:     https://git.kernel.org/tip/295cc7eb314eb3321fb6d67ca6f7305f5c50d10f
Author:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
AuthorDate: Thu, 8 Feb 2018 09:19:08 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 12:47:28 +0100

x86/smpboot: Fix uncore_pci_remove() indexing bug when hot-removing a physical CPU

When a physical CPU is hot-removed, the following warning messages
are shown while the uncore device is removed in uncore_pci_remove():

  WARNING: CPU: 120 PID: 5 at arch/x86/events/intel/uncore.c:988
  uncore_pci_remove+0xf1/0x110
  ...
  CPU: 120 PID: 5 Comm: kworker/u1024:0 Not tainted 4.15.0-rc8 #1
  Workqueue: kacpi_hotplug acpi_hotplug_work_fn
  ...
  Call Trace:
  pci_device_remove+0x36/0xb0
  device_release_driver_internal+0x145/0x210
  pci_stop_bus_device+0x76/0xa0
  pci_stop_root_bus+0x44/0x60
  acpi_pci_root_remove+0x1f/0x80
  acpi_bus_trim+0x54/0x90
  acpi_bus_trim+0x2e/0x90
  acpi_device_hotplug+0x2bc/0x4b0
  acpi_hotplug_work_fn+0x1a/0x30
  process_one_work+0x141/0x340
  worker_thread+0x47/0x3e0
  kthread+0xf5/0x130

When uncore_pci_remove() runs, it tries to get the package ID to
clear the value of uncore_extra_pci_dev[].dev[] by using
topology_phys_to_logical_pkg(). The warning messesages are
shown because topology_phys_to_logical_pkg() returns -1.

  arch/x86/events/intel/uncore.c:
  static void uncore_pci_remove(struct pci_dev *pdev)
  {
  ...
          phys_id = uncore_pcibus_to_physid(pdev->bus);
  ...
                  pkg = topology_phys_to_logical_pkg(phys_id); // returns -1
                  for (i = 0; i < UNCORE_EXTRA_PCI_DEV_MAX; i++) {
                          if (uncore_extra_pci_dev[pkg].dev[i] == pdev) {
                                  uncore_extra_pci_dev[pkg].dev[i] = NULL;
                                  break;
                          }
                  }
                  WARN_ON_ONCE(i >= UNCORE_EXTRA_PCI_DEV_MAX); // <=========== HERE!!

topology_phys_to_logical_pkg() tries to find
cpuinfo_x86->phys_proc_id that matches the phys_pkg argument.

  arch/x86/kernel/smpboot.c:
  int topology_phys_to_logical_pkg(unsigned int phys_pkg)
  {
          int cpu;

          for_each_possible_cpu(cpu) {
                  struct cpuinfo_x86 *c = &cpu_data(cpu);

                  if (c->initialized && c->phys_proc_id == phys_pkg)
                          return c->logical_proc_id;
          }
          return -1;
  }

However, the phys_proc_id was already set to 0 by remove_siblinginfo()
when the CPU was offlined.

So, topology_phys_to_logical_pkg() cannot find the correct
logical_proc_id and always returns -1.

As the result, uncore_pci_remove() calls WARN_ON_ONCE() and the warning
messages are shown.

What is worse is that the bogus 'pkg' index results in two bugs:

 - We dereference uncore_extra_pci_dev[] with a negative index
 - We fail to clean up a stale pointer in uncore_extra_pci_dev[][]

To fix these bugs, remove the clearing of ->phys_proc_id from remove_siblinginfo().

This should not cause any problems, because ->phys_proc_id is not
used after it is hot-removed and it is re-set while hot-adding.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: yasu.isimatu@gmail.com
Cc: <stable@vger.kernel.org>
Fixes: 30bb9811856f ("x86/topology: Avoid wasting 128k for package id array")
Link: http://lkml.kernel.org/r/ed738d54-0f01-b38b-b794-c31dc118c207@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/smpboot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 6f27fac..cfc61e1 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1430,7 +1430,6 @@ static void remove_siblinginfo(int cpu)
 	cpumask_clear(cpu_llc_shared_mask(cpu));
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
-	c->phys_proc_id = 0;
 	c->cpu_core_id = 0;
 	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
 	recompute_smt_state();
