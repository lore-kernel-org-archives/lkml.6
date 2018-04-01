Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754682AbeDAUog (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:44:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754489AbeDAUoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:44:34 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 43/45] C++: Don't need to declare struct pgd_t after typedef
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:44:33 +0100
Message-ID: <152261547359.30503.9479679859332991741.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct pgd_t is typedef'd to pgd_t so predeclaration isn't required in
asm/tlbflush.h.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/tlbflush.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 84137c22fdfa..c0c13d4f6c41 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -117,7 +117,6 @@ static inline u16 user_pcid(u16 asid)
 	return ret;
 }
 
-struct pgd_t;
 static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
 {
 	if (static_cpu_has(X86_FEATURE_PCID)) {
