Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELusjPCMkDuUd5g6DVmdD681D274Wj7+F56hHSpaJUjyzOr/yM/jn1F+ucgbMW1dkvQ9ZDOA
ARC-Seal: i=1; a=rsa-sha256; t=1520824089; cv=none;
        d=google.com; s=arc-20160816;
        b=BJHmYHjGiju/ih38vnicjF/z2CTGwLRO+s3FLpIyMlyXfLIJT8puRpYVCJabwwA8E4
         l3oIqEbG5amfBxi3Yc34E8A0UFUlk/COW1mm140l916VX8ixuA4gru4gPZns+7PWt4bh
         l1G4r+6/I6A7Bxe9PB0Q9R+bhuxEK1Rk5/vBe2Rn9f1vVejdIW57ymsG+SVjSBN6uJpf
         Zhgc4FAh1KA5j6SL7otems3yvaojMXs+/7FZNMOsdqhxnADQwAnbjwPUR1xHndNixWSY
         KXXZBgw9d3Fds3mwXqebgfgX+R+ck3GsgmfEujPvLDzKpEuOgJJl6QVlqr+xG7zUrTLB
         Dvng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=CDF53EYXC63rapTKzoOvyDQ746/l7UojoZq+LQRGWuc=;
        b=CZ8bGCYdFfZkWGf4rv5U9mSPym7dddnba6Z4X9pOZ0DSlblefhO7T+CizhJHU/p7Xk
         jCVJe+hrSjKS/DHZYizH4Nip4KQron0FDOZRW4tE72qJbej08w6ym3Z5IY4KUxDmQ/jU
         /KGVFHqciHjrKz5CCKLeVEzvrEqgjlw8sX5sKqeY8zytOYhTugAuzQRFkdUJgPyQcqNT
         FnW2WgCN46Szb3fcwgwa0/YAER/h5fPizUOvTzfzq4271kdBaktdxpVQoU8MduXfvsA3
         F1zq/MXIXKeaXycBwtUHNk3/pFicCCH5eCzsvC4Unlr0k8pH8LgOZ1V3aStNetzMrMaf
         i31g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Paul Turner" <pjt@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 gnomes@lxorguk.ukuu.org.uk,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Ingo Molnar" <mingo@kernel.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Rik van Riel" <riel@redhat.com>,
 "Juergen Gross" <jgross@suse.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Andy Lutomirski" <luto@amacapital.net>,
 thomas.lendacky@amd.com,
 "Kees Cook" <keescook@google.com>,
 "Arjan van de Ven" <arjan@linux.intel.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.733851180@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 063/104] x86/retpoline/xen: Convert Xen hypercall
 indirect jumps
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699641637563018?=
X-GMAIL-MSGID: =?utf-8?q?1594699640988717678?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit ea08816d5b185ab3d09e95e393f265af54560350 upstream.

Convert indirect call in Xen hypercall to use non-speculative sequence,
when CONFIG_RETPOLINE is enabled.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: thomas.lendacky@amd.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/1515707194-20531-10-git-send-email-dwmw@amazon.co.uk
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/xen/hypercall.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -43,6 +43,7 @@
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/nospec-branch.h>
 
 #include <xen/interface/xen.h>
 #include <xen/interface/sched.h>
@@ -212,9 +213,9 @@ privcmd_call(unsigned call,
 	__HYPERCALL_DECLS;
 	__HYPERCALL_5ARG(a1, a2, a3, a4, a5);
 
-	asm volatile("call *%[call]"
+	asm volatile(CALL_NOSPEC
 		     : __HYPERCALL_5PARAM
-		     : [call] "a" (&hypercall_page[call])
+		     : [thunk_target] "a" (&hypercall_page[call])
 		     : __HYPERCALL_CLOBBER5);
 
 	return (long)__res;
