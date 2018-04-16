Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx48IyVjMTADA5bSAzU1G4pX9j3mG6laZ/iiLN5fKST5PGoiEKe9A9EEuFxNHop0MVy5B/R8Q
ARC-Seal: i=1; a=rsa-sha256; t=1523892354; cv=none;
        d=google.com; s=arc-20160816;
        b=C3YXvXS5FYVWQaOFh0Mx63R5yvBNMXLe/eMrhl7jymisAU8FMhQLEY4oh5Fu/QN7TH
         IZHsCCRCbCJx91DaA4PNhhMXwHIMr18AkNmUBKX548+t7W/BO6n08MKUWLu7WYCFI4/A
         EUe4rWOoOOsoW3+8Y7/c8CSsWHNlvCC61zQLXjhbvVy9NgK3foSeptLZGCSHfQEBD1Mg
         7aypysLFTiugIB0mBdBwnC8xJ2UPgrA6AOQEmLXoylA1Qxse6SNawyCzPDlyPtqcK2ZK
         ItuH8m9tfceC/zNy8qLhCUVJ6A9lRl2trWQqmuUsrgcmM6UH4/sr5xEESS2k0hAWiHar
         4GZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=CliYgnZbmohA5O1xBxVSliAIvcy3J5hZOwxEIrmd3QM=;
        b=mDjm+ZySbepep2hTbyLCZrjEmqmDrA0hlUgqr7ry6nKo74RftHnl6eQAUbD5/dE5Eg
         +voihGs3x7r7K/zJGzuen4s7wyFv7yE6z31JMkPyVUj5D9lq7JlWTPdvBLx0PfvR0gjQ
         S7Tglpv79qDgB868LT4UJb6a7lV4GxcV+B6/vYaxcOeL0hmfRztizEY8fFJANHwIBt/0
         Trt0FhE1jtQ1ZaF1YfFQcGv2qp7zVt/8eZxSUJFA/6+/WWi1tp5xh4B8ylApwT19YSuX
         ElFD35MvOs9G/K+IwUj80tVnqVFGQ8J26T0vdS1XWjA1Fi66KHvGJ70Q5lcpv14bhqum
         PbmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=QJTpCh5p;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=QJTpCh5p;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
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
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 33/35] x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
Date: Mon, 16 Apr 2018 17:25:21 +0200
Message-Id: <1523892323-14741-34-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916949996737074?=
X-GMAIL-MSGID: =?utf-8?q?1597916949996737074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Allow PTI to be compiled on x86_32.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 security/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig b/security/Kconfig
index c430206..afa91c6 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -57,7 +57,7 @@ config SECURITY_NETWORK
 config PAGE_TABLE_ISOLATION
 	bool "Remove the kernel mapping in user mode"
 	default y
-	depends on X86_64 && !UML
+	depends on X86 && !UML
 	help
 	  This feature reduces the number of hardware side channels by
 	  ensuring that the majority of kernel addresses are not mapped
-- 
2.7.4
