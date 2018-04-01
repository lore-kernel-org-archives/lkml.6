Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754416AbeDAUmc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:42:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754401AbeDAUm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:42:29 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 22/45] C++: Define apic_intr_mode after the enum definition,
 not before
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:42:27 +0100
Message-ID: <152261534776.30503.8538178003485154810.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define apic_intr_mode after the enum definition, not before, otherwise an
error results.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/apic.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 98722773391d..c8eef5e6c46c 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -53,7 +53,6 @@ extern int local_apic_timer_c2_ok;
 extern int disable_apic;
 extern unsigned int lapic_timer_frequency;
 
-extern enum apic_intr_mode_id apic_intr_mode;
 enum apic_intr_mode_id {
 	APIC_PIC,
 	APIC_VIRTUAL_WIRE,
@@ -61,6 +60,7 @@ enum apic_intr_mode_id {
 	APIC_SYMMETRIC_IO,
 	APIC_SYMMETRIC_IO_NO_ROUTING
 };
+extern enum apic_intr_mode_id apic_intr_mode;
 
 #ifdef CONFIG_SMP
 extern void __inquire_remote_apic(int apicid);
