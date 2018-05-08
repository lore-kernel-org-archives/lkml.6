Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932974AbeEHPAv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:00:51 -0400
Received: from ozlabs.org ([203.11.71.1]:44627 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932679AbeEHPAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:00:02 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxram@us.ibm.com
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: [PATCH 7/8] mm/pkeys: Add an empty arch_pkeys_enabled()
Date: Wed,  9 May 2018 00:59:47 +1000
Message-Id: <20180508145948.9492-8-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180508145948.9492-1-mpe@ellerman.id.au>
References: <20180508145948.9492-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an empty arch_pkeys_enabled() in linux/pkeys.h for the
CONFIG_ARCH_HAS_PKEYS=n case.

Split out of a patch by Ram Pai <linuxram@us.ibm.com>.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 include/linux/pkeys.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 946cb773b79f..2955ba976048 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -39,6 +39,11 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	return 0;
 }
 
+static inline bool arch_pkeys_enabled(void)
+{
+	return false;
+}
+
 static inline void copy_init_pkru_to_fpregs(void)
 {
 }
-- 
2.14.1
