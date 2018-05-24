Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163694-2-13118092613725259330
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163692; b=QuNWVXVrKjvc2WK4Dq9fhggbck7k/M80WWr61FXTf4WIGwCr2k
    q8tqiYYzyiHiuG/MncLkXI5P67rW33baE2YfS3Sh3jpMbN4TUdYh5Pl29IA6TWaH
    0RY9aVI3E+QA4mjilakre/QkkHAxnkILsR1UAubCexfMRgWBi1puhRu6t9Bz9Sdc
    a6/+VLaZezmGm4eNCJl6qFS9WyJiJkwIFImLrSjudMpAFzxtTbfykdxzuwZv5ZVs
    UkKT8wuFX9E5TZmYjYTqGlp1igwWaVpcFJFiaI4ZmEvd8HqxOy85fd4YhRsqI18J
    Qb35GRBuPuXsZK+FR7s9BfOBwfSpFd1mUgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163692; bh=f4MoMPPmVx/AxSz61j/XiKBN5jHjqq
    WrwvdoJDPtUss=; b=XlmAs2waifmul2C3UvXxiIOeS4vyGwmQC34QFsSWFdTAvV
    y5rE856YM91ZwYYLg6tVG1aV7eAibiwFBKEWymieWFk6XGpkJc5OLyN9sK4oF1Co
    ocl4K3nSlQvDS1rgyxUNSiMvU/RY/uGZYZbSn8ldA3wTE6Ll25NK+QuQH8KAZT9V
    ZNL/sKpl7xOuqCsuPW4ABrLhwOCMuVKnrSdhnNpgoHTpcugve6DabApQSACqIPb4
    yFXnC8T315yPlJ29eBKySqJ6VeeA0da40eQvNDjsfkC9u+6kuQtwWzflo21ahsSN
    nerMjlu1AeG4WIMxjW+bmqDc9aebmPcu2z32kQ0A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=hJDlDIb5 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=hJDlDIb5 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfInr/a8a/RIqNfeDPNkM7vR6p876p0LxFWcAewvj01N4fzU+Bhvvafb4dBmgL+FLdofkCURCmAgfnSYRH8oI10IsmYCS+dqN04O0z6fnw7A40uMltiPj
    jW5d6NmE4UmCGvyqCSpzluuABt2WaamKPT106HgcWcgXuIsNt8m0xgQlmjAOC1q5TmKVI8bI8MGTo9QNubtZC0sDJ7bbxU7MDx0K3hnRvDLPIrBB39bb7dM4
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=PHq6YzTAAAAA:8 a=VnNF1IyMAAAA:8 a=CbDCq_QkAAAA:8 a=JfrnYn6hAAAA:8
    a=7CQSdrXTAAAA:8 a=WPyIoOwQAAAA:8 a=hAG5_4vcAAAA:8 a=VwQbUJbxAAAA:8
    a=wMNdZWldAAAA:8 a=pGLkceISAAAA:8 a=hGzw-44bAAAA:8 a=_A5TAQVKAAAA:8
    a=QyXUC8HyAAAA:8 a=u3DotqyyAAAA:8 a=o8mPgXn3AAAA:8 a=tOO0nKmCAAAA:8
    a=rWkr9Ua9AAAA:8 a=F-1i3n2SAAAA:8 a=LQ17Lw9wAAAA:8 a=jIQo8A4GAAAA:8
    a=LpQP-O61AAAA:8 a=voM4FWlXAAAA:8 a=J1Y8HTJGAAAA:8 a=1EsaE_6oAAAA:8
    a=ag1SF4gXAAAA:8 a=voR2qRYpTMh5qbxDg3UA:9 a=scNH69pj_gbX8d5L:21
    a=dq6cCWwbZXhYcmCE:21 a=QEXdDO2ut3YA:10 a=ZKzU8r6zoKMcqsNulkmm:22
    a=1qrBK16LubpBFNPVNq2M:22 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=S-HzPIwwDS8t1QcwSuWs:22 a=8Bh8Pg2EFav9IBZ9i9Tn:22 a=AjGcO6oz07-iQ99wixmX:22
    a=FUarYpL4UH3yWsho8X8J:22 a=HvKuF1_PTVFglORKqfwH:22 a=ypw9U9_ytwuNp2HAL0_X:22
    a=g3YQyp1ytkc1jtnOLIrM:22 a=yq995J0yQhm25FhVotX2:22 a=Gz67Kf0DkuxJ4rqyVRET:22
    a=Qv-QrLrHZjTXZfLJ-zom:22 a=DkFbxxcXd2AJf-O9kuUr:22 a=j77vJcMW1SzrPxEKBuqB:22
    a=Lf5xNeLK5dgiOs8hzIjU:22 a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966536AbeEXJnv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966470AbeEXJnk (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        peterz@infradead.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
        Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        linux-snps-arc@lists.infradead.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-xtensa@linux-xtensa.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Stafford Horne <shorne@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Chris Zankel <chris@zankel.net>,
        Michal Simek <monstr@monstr.eu>,
        Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
        Vineet Gupta <vgupta@synopsys.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Kuo <rkuo@codeaurora.org>, linux-alpha@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 25/92] futex: Remove duplicated code and fix undefined behaviour
Date: Thu, 24 May 2018 11:38:02 +0200
Message-Id: <20180524093201.354618799@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby <jslaby@suse.cz>

commit 30d6e0a4190d37740e9447e4e4815f06992dd8c3 upstream.

There is code duplicated over all architecture's headers for
futex_atomic_op_inuser. Namely op decoding, access_ok check for uaddr,
and comparison of the result.

Remove this duplication and leave up to the arches only the needed
assembly which is now in arch_futex_atomic_op_inuser.

This effectively distributes the Will Deacon's arm64 fix for undefined
behaviour reported by UBSAN to all architectures. The fix was done in
commit 5f16a046f8e1 (arm64: futex: Fix undefined behaviour with
FUTEX_OP_OPARG_SHIFT usage). Look there for an example dump.

And as suggested by Thomas, check for negative oparg too, because it was
also reported to cause undefined behaviour report.

Note that s390 removed access_ok check in d12a29703 ("s390/uaccess:
remove pointless access_ok() checks") as access_ok there returns true.
We introduce it back to the helper for the sake of simplicity (it gets
optimized away anyway).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> [s390]
Acked-by: Chris Metcalf <cmetcalf@mellanox.com> [for tile]
Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>
Reviewed-by: Will Deacon <will.deacon@arm.com> [core/arm64]
Cc: linux-mips@linux-mips.org
Cc: Rich Felker <dalias@libc.org>
Cc: linux-ia64@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: peterz@infradead.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: sparclinux@vger.kernel.org
Cc: Jonas Bonn <jonas@southpole.se>
Cc: linux-s390@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-hexagon@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-xtensa@linux-xtensa.org
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: openrisc@lists.librecores.org
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Stafford Horne <shorne@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Richard Henderson <rth@twiddle.net>
Cc: Chris Zankel <chris@zankel.net>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-parisc@vger.kernel.org
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-alpha@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: "David S. Miller" <davem@davemloft.net>
Link: http://lkml.kernel.org/r/20170824073105.3901-1-jslaby@suse.cz
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/alpha/include/asm/futex.h      |   26 +++---------------
 arch/arc/include/asm/futex.h        |   40 +++-------------------------
 arch/arm/include/asm/futex.h        |   26 ++----------------
 arch/arm64/include/asm/futex.h      |   26 ++----------------
 arch/frv/include/asm/futex.h        |    3 +-
 arch/frv/kernel/futex.c             |   27 ++-----------------
 arch/hexagon/include/asm/futex.h    |   38 ++-------------------------
 arch/ia64/include/asm/futex.h       |   25 ++----------------
 arch/microblaze/include/asm/futex.h |   38 ++-------------------------
 arch/mips/include/asm/futex.h       |   25 ++----------------
 arch/parisc/include/asm/futex.h     |   25 ++----------------
 arch/powerpc/include/asm/futex.h    |   26 +++---------------
 arch/s390/include/asm/futex.h       |   23 +++-------------
 arch/sh/include/asm/futex.h         |   26 ++----------------
 arch/sparc/include/asm/futex_64.h   |   26 +++---------------
 arch/tile/include/asm/futex.h       |   40 +++-------------------------
 arch/x86/include/asm/futex.h        |   40 +++-------------------------
 arch/xtensa/include/asm/futex.h     |   27 +++----------------
 include/asm-generic/futex.h         |   50 ++++++------------------------------
 kernel/futex.c                      |   39 ++++++++++++++++++++++++++++
 20 files changed, 126 insertions(+), 470 deletions(-)

--- a/arch/alpha/include/asm/futex.h
+++ b/arch/alpha/include/asm/futex.h
@@ -29,18 +29,10 @@
 	:	"r" (uaddr), "r"(oparg)				\
 	:	"memory")
 
-static inline int futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
+static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
+		u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
 
 	pagefault_disable();
 
@@ -66,17 +58,9 @@ static inline int futex_atomic_op_inuser
 
 	pagefault_enable();
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
+
 	return ret;
 }
 
--- a/arch/arc/include/asm/futex.h
+++ b/arch/arc/include/asm/futex.h
@@ -73,20 +73,11 @@
 
 #endif
 
-static inline int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
+static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
+		u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, ret;
 
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
 #ifndef CONFIG_ARC_HAS_LLSC
 	preempt_disable();	/* to guarantee atomic r-m-w of futex op */
 #endif
@@ -118,30 +109,9 @@ static inline int futex_atomic_op_inuser
 	preempt_enable();
 #endif
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ:
-			ret = (oldval == cmparg);
-			break;
-		case FUTEX_OP_CMP_NE:
-			ret = (oldval != cmparg);
-			break;
-		case FUTEX_OP_CMP_LT:
-			ret = (oldval < cmparg);
-			break;
-		case FUTEX_OP_CMP_GE:
-			ret = (oldval >= cmparg);
-			break;
-		case FUTEX_OP_CMP_LE:
-			ret = (oldval <= cmparg);
-			break;
-		case FUTEX_OP_CMP_GT:
-			ret = (oldval > cmparg);
-			break;
-		default:
-			ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
+
 	return ret;
 }
 
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -128,20 +128,10 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 #endif /* !SMP */
 
 static inline int
-futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, ret, tmp;
 
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
-
 #ifndef CONFIG_SMP
 	preempt_disable();
 #endif
@@ -172,17 +162,9 @@ futex_atomic_op_inuser (int encoded_op,
 	preempt_enable();
 #endif
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
+
 	return ret;
 }
 
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -53,20 +53,10 @@
 	: "memory")
 
 static inline int
-futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (int)(encoded_op << 8) >> 20;
-	int cmparg = (int)(encoded_op << 20) >> 20;
 	int oldval = 0, ret, tmp;
 
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1U << (oparg & 0x1f);
-
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
-
 	pagefault_disable();
 
 	switch (op) {
@@ -96,17 +86,9 @@ futex_atomic_op_inuser(unsigned int enco
 
 	pagefault_enable();
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
+
 	return ret;
 }
 
--- a/arch/frv/include/asm/futex.h
+++ b/arch/frv/include/asm/futex.h
@@ -7,7 +7,8 @@
 #include <asm/errno.h>
 #include <asm/uaccess.h>
 
-extern int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr);
+extern int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
+		u32 __user *uaddr);
 
 static inline int
 futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
--- a/arch/frv/kernel/futex.c
+++ b/arch/frv/kernel/futex.c
@@ -186,20 +186,10 @@ static inline int atomic_futex_op_xchg_x
 /*
  * do the futex operations
  */
-int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
+int arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, ret;
 
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
-
 	pagefault_disable();
 
 	switch (op) {
@@ -225,18 +215,9 @@ int futex_atomic_op_inuser(int encoded_o
 
 	pagefault_enable();
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS; break;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
 
 	return ret;
 
-} /* end futex_atomic_op_inuser() */
+} /* end arch_futex_atomic_op_inuser() */
--- a/arch/hexagon/include/asm/futex.h
+++ b/arch/hexagon/include/asm/futex.h
@@ -31,18 +31,9 @@
 
 
 static inline int
-futex_atomic_op_inuser(int encoded_op, int __user *uaddr)
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
 
 	pagefault_disable();
 
@@ -72,30 +63,9 @@ futex_atomic_op_inuser(int encoded_op, i
 
 	pagefault_enable();
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ:
-			ret = (oldval == cmparg);
-			break;
-		case FUTEX_OP_CMP_NE:
-			ret = (oldval != cmparg);
-			break;
-		case FUTEX_OP_CMP_LT:
-			ret = (oldval < cmparg);
-			break;
-		case FUTEX_OP_CMP_GE:
-			ret = (oldval >= cmparg);
-			break;
-		case FUTEX_OP_CMP_LE:
-			ret = (oldval <= cmparg);
-			break;
-		case FUTEX_OP_CMP_GT:
-			ret = (oldval > cmparg);
-			break;
-		default:
-			ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
+
 	return ret;
 }
 
--- a/arch/ia64/include/asm/futex.h
+++ b/arch/ia64/include/asm/futex.h
@@ -45,18 +45,9 @@ do {									\
 } while (0)
 
 static inline int
-futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
 
 	pagefault_disable();
 
@@ -84,17 +75,9 @@ futex_atomic_op_inuser (int encoded_op,
 
 	pagefault_enable();
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
+
 	return ret;
 }
 
--- a/arch/microblaze/include/asm/futex.h
+++ b/arch/microblaze/include/asm/futex.h
@@ -29,18 +29,9 @@
 })
 
 static inline int
-futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
 
 	pagefault_disable();
 
@@ -66,30 +57,9 @@ futex_atomic_op_inuser(int encoded_op, u
 
 	pagefault_enable();
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ:
-			ret = (oldval == cmparg);
-			break;
-		case FUTEX_OP_CMP_NE:
-			ret = (oldval != cmparg);
-			break;
-		case FUTEX_OP_CMP_LT:
-			ret = (oldval < cmparg);
-			break;
-		case FUTEX_OP_CMP_GE:
-			ret = (oldval >= cmparg);
-			break;
-		case FUTEX_OP_CMP_LE:
-			ret = (oldval <= cmparg);
-			break;
-		case FUTEX_OP_CMP_GT:
-			ret = (oldval > cmparg);
-			break;
-		default:
-			ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
+
 	return ret;
 }
 
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -83,18 +83,9 @@
 }
 
 static inline int
-futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
 
 	pagefault_disable();
 
@@ -125,17 +116,9 @@ futex_atomic_op_inuser(int encoded_op, u
 
 	pagefault_enable();
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
+
 	return ret;
 }
 
--- a/arch/parisc/include/asm/futex.h
+++ b/arch/parisc/include/asm/futex.h
@@ -32,20 +32,11 @@ _futex_spin_unlock_irqrestore(u32 __user
 }
 
 static inline int
-futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	unsigned long int flags;
 	u32 val;
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(*uaddr)))
-		return -EFAULT;
 
 	pagefault_disable();
 
@@ -98,17 +89,9 @@ futex_atomic_op_inuser (int encoded_op,
 
 	pagefault_enable();
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
+
 	return ret;
 }
 
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -31,18 +31,10 @@
 	: "b" (uaddr), "i" (-EFAULT), "r" (oparg) \
 	: "cr0", "memory")
 
-static inline int futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
+static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
+		u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
 
 	pagefault_disable();
 
@@ -68,17 +60,9 @@ static inline int futex_atomic_op_inuser
 
 	pagefault_enable();
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
+
 	return ret;
 }
 
--- a/arch/s390/include/asm/futex.h
+++ b/arch/s390/include/asm/futex.h
@@ -21,17 +21,12 @@
 		: "0" (-EFAULT), "d" (oparg), "a" (uaddr),		\
 		  "m" (*uaddr) : "cc");
 
-static inline int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
+static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
+		u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, newval, ret;
 
 	load_kernel_asce();
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
 
 	pagefault_disable();
 	switch (op) {
@@ -60,17 +55,9 @@ static inline int futex_atomic_op_inuser
 	}
 	pagefault_enable();
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
+
 	return ret;
 }
 
--- a/arch/sh/include/asm/futex.h
+++ b/arch/sh/include/asm/futex.h
@@ -10,20 +10,11 @@
 /* XXX: UP variants, fix for SH-4A and SMP.. */
 #include <asm/futex-irq.h>
 
-static inline int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
+static inline int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval,
+		u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, ret;
 
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
-
 	pagefault_disable();
 
 	switch (op) {
@@ -49,17 +40,8 @@ static inline int futex_atomic_op_inuser
 
 	pagefault_enable();
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
 
 	return ret;
 }
--- a/arch/sparc/include/asm/futex_64.h
+++ b/arch/sparc/include/asm/futex_64.h
@@ -29,22 +29,14 @@
 	: "r" (uaddr), "r" (oparg), "i" (-EFAULT)	\
 	: "memory")
 
-static inline int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
+static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
+		u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, ret, tem;
 
-	if (unlikely(!access_ok(VERIFY_WRITE, uaddr, sizeof(u32))))
-		return -EFAULT;
 	if (unlikely((((unsigned long) uaddr) & 0x3UL)))
 		return -EINVAL;
 
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
 	pagefault_disable();
 
 	switch (op) {
@@ -69,17 +61,9 @@ static inline int futex_atomic_op_inuser
 
 	pagefault_enable();
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
+
 	return ret;
 }
 
--- a/arch/tile/include/asm/futex.h
+++ b/arch/tile/include/asm/futex.h
@@ -106,12 +106,9 @@
 	lock = __atomic_hashed_lock((int __force *)uaddr)
 #endif
 
-static inline int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
+static inline int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval,
+		u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int uninitialized_var(val), ret;
 
 	__futex_prolog();
@@ -119,12 +116,6 @@ static inline int futex_atomic_op_inuser
 	/* The 32-bit futex code makes this assumption, so validate it here. */
 	BUILD_BUG_ON(sizeof(atomic_t) != sizeof(int));
 
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
-
 	pagefault_disable();
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -148,30 +139,9 @@ static inline int futex_atomic_op_inuser
 	}
 	pagefault_enable();
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ:
-			ret = (val == cmparg);
-			break;
-		case FUTEX_OP_CMP_NE:
-			ret = (val != cmparg);
-			break;
-		case FUTEX_OP_CMP_LT:
-			ret = (val < cmparg);
-			break;
-		case FUTEX_OP_CMP_GE:
-			ret = (val >= cmparg);
-			break;
-		case FUTEX_OP_CMP_LE:
-			ret = (val <= cmparg);
-			break;
-		case FUTEX_OP_CMP_GT:
-			ret = (val > cmparg);
-			break;
-		default:
-			ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = val;
+
 	return ret;
 }
 
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -41,20 +41,11 @@
 		       "+m" (*uaddr), "=&r" (tem)		\
 		     : "r" (oparg), "i" (-EFAULT), "1" (0))
 
-static inline int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
+static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
+		u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, ret, tem;
 
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
-
 	pagefault_disable();
 
 	switch (op) {
@@ -80,30 +71,9 @@ static inline int futex_atomic_op_inuser
 
 	pagefault_enable();
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ:
-			ret = (oldval == cmparg);
-			break;
-		case FUTEX_OP_CMP_NE:
-			ret = (oldval != cmparg);
-			break;
-		case FUTEX_OP_CMP_LT:
-			ret = (oldval < cmparg);
-			break;
-		case FUTEX_OP_CMP_GE:
-			ret = (oldval >= cmparg);
-			break;
-		case FUTEX_OP_CMP_LE:
-			ret = (oldval <= cmparg);
-			break;
-		case FUTEX_OP_CMP_GT:
-			ret = (oldval > cmparg);
-			break;
-		default:
-			ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
+
 	return ret;
 }
 
--- a/arch/xtensa/include/asm/futex.h
+++ b/arch/xtensa/include/asm/futex.h
@@ -44,18 +44,10 @@
 	: "r" (uaddr), "I" (-EFAULT), "r" (oparg)	\
 	: "memory")
 
-static inline int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
+static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
+		u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
 
 #if !XCHAL_HAVE_S32C1I
 	return -ENOSYS;
@@ -89,19 +81,10 @@ static inline int futex_atomic_op_inuser
 
 	pagefault_enable();
 
-	if (ret)
-		return ret;
-
-	switch (cmp) {
-	case FUTEX_OP_CMP_EQ: return (oldval == cmparg);
-	case FUTEX_OP_CMP_NE: return (oldval != cmparg);
-	case FUTEX_OP_CMP_LT: return (oldval < cmparg);
-	case FUTEX_OP_CMP_GE: return (oldval >= cmparg);
-	case FUTEX_OP_CMP_LE: return (oldval <= cmparg);
-	case FUTEX_OP_CMP_GT: return (oldval > cmparg);
-	}
+	if (!ret)
+		*oval = oldval;
 
-	return -ENOSYS;
+	return ret;
 }
 
 static inline int
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -13,7 +13,7 @@
  */
 
 /**
- * futex_atomic_op_inuser() - Atomic arithmetic operation with constant
+ * arch_futex_atomic_op_inuser() - Atomic arithmetic operation with constant
  *			  argument and comparison of the previous
  *			  futex value with another constant.
  *
@@ -25,18 +25,11 @@
  * <0 - On error
  */
 static inline int
-futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
+arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval, ret;
 	u32 tmp;
 
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
 	preempt_disable();
 	pagefault_disable();
 
@@ -74,17 +67,9 @@ out_pagefault_enable:
 	pagefault_enable();
 	preempt_enable();
 
-	if (ret == 0) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
+	if (ret == 0)
+		*oval = oldval;
+
 	return ret;
 }
 
@@ -126,18 +111,9 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 
 #else
 static inline int
-futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
+arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 {
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
 	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
 
 	pagefault_disable();
 
@@ -153,17 +129,9 @@ futex_atomic_op_inuser (int encoded_op,
 
 	pagefault_enable();
 
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
+	if (!ret)
+		*oval = oldval;
+
 	return ret;
 }
 
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1453,6 +1453,45 @@ out:
 	return ret;
 }
 
+static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
+{
+	unsigned int op =	  (encoded_op & 0x70000000) >> 28;
+	unsigned int cmp =	  (encoded_op & 0x0f000000) >> 24;
+	int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 12);
+	int cmparg = sign_extend32(encoded_op & 0x00000fff, 12);
+	int oldval, ret;
+
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28)) {
+		if (oparg < 0 || oparg > 31)
+			return -EINVAL;
+		oparg = 1 << oparg;
+	}
+
+	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
+		return -EFAULT;
+
+	ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
+	if (ret)
+		return ret;
+
+	switch (cmp) {
+	case FUTEX_OP_CMP_EQ:
+		return oldval == cmparg;
+	case FUTEX_OP_CMP_NE:
+		return oldval != cmparg;
+	case FUTEX_OP_CMP_LT:
+		return oldval < cmparg;
+	case FUTEX_OP_CMP_GE:
+		return oldval >= cmparg;
+	case FUTEX_OP_CMP_LE:
+		return oldval <= cmparg;
+	case FUTEX_OP_CMP_GT:
+		return oldval > cmparg;
+	default:
+		return -ENOSYS;
+	}
+}
+
 /*
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
