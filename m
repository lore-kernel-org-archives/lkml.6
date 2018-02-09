Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x226Da/2Mmm+5IQzyCOEWlOUOhpjDiRF0LAhsc1LUQGV2N9jj+kfuJt1zZFudvU5iQEv3VJyt
ARC-Seal: i=1; a=rsa-sha256; t=1518168355; cv=none;
        d=google.com; s=arc-20160816;
        b=tOU5GjcSDjgIBRupcUwcKiEG8qkh/Abgm/7HBke1TdznXJD/YoIL48jI5xD+FlsxLK
         wQqig7+HmpZCVmsLEd5Kjzqp2MJpQpKUXc7ZB81HQzh5Efh6DwKDjDYUmE8Ub8/J96Ub
         9wYGsIMmTh5ezFnAEKi089kxk2EJ65dFSvwu+7GE1+GvIiFHZUOBIYDh/4RIyAHcVRU3
         ePY7KXxzN/bkmEjBPdq4C5F9uIUl3fTVABmwGKjYFLhU3QsQyptwMPiz6zepqulKy5+N
         nEepvZ99VfNQDLEIU4L2/LeHyXjZXghl5PA829n3Kf45SphtumaKop/uuBM3BOFcTE9i
         TvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=JA4ft/zbEQyrYYEDRQTfooNSsNBYYyu6NoZlpHRNmDU=;
        b=yVB4XC0CkhQ4WU08u/TCuKSPtJThLz4N3v+Kf8LGr7iOQGTSPembfkO0GwQ9sQrLBD
         CRz5hLprSbqs+u2Aw4wZnZMC/XymSIp+HDVZmbirSARtKTTMgGzGPqb6vx0lWFj41Hw8
         Vw9VP7hxryNClwTvFBNYeFcflrdCdMx3Zt4duJ1p5imnxDSvThrG6AAI9FvBoSYyBITr
         T/aJcB17AYQKllpiQABTn2iVcHhQEeI2mS/3RL0OvCG1bmJut88TPoE5LM6vl+nyWk65
         JPDY+7kuXcx2QYNQIX5YsJHqehkucuW+aOEYbeiqe2dlr4OtUaoqpmJy9T+o2qaTRYUP
         /5pw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=IizrX642;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=IizrX642;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 01/31] x86/asm-offsets: Move TSS_sp0 and TSS_sp1 to asm-offsets.c
Date: Fri,  9 Feb 2018 10:25:10 +0100
Message-Id: <1518168340-9392-2-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900723369343?=
X-GMAIL-MSGID: =?utf-8?q?1591914900723369343?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

These offsets will be used in 32 bit assembly code as well,
so make them available for all of x86 code.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/asm-offsets.c    | 4 ++++
 arch/x86/kernel/asm-offsets_64.c | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 76417a9..232152c 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -103,4 +103,8 @@ void common(void) {
 	OFFSET(CPU_ENTRY_AREA_entry_trampoline, cpu_entry_area, entry_trampoline);
 	OFFSET(CPU_ENTRY_AREA_entry_stack, cpu_entry_area, entry_stack_page);
 	DEFINE(SIZEOF_entry_stack, sizeof(struct entry_stack));
+
+	/* Offset for sp0 and sp1 into the tss_struct */
+	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
+	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 }
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index bf51e51..d2eba73 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -65,8 +65,6 @@ int main(void)
 #undef ENTRY
 
 	OFFSET(TSS_ist, tss_struct, x86_tss.ist);
-	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
-	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	BLANK();
 
 #ifdef CONFIG_CC_STACKPROTECTOR
-- 
2.7.4
