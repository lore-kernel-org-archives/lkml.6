Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x224AQMxJGhoJrcoRjJdSDe3AmEGepUXcR5pQ7L4+x5bkduDL6K/YuhovMb3b1XfTfRJPbFlp
ARC-Seal: i=1; a=rsa-sha256; t=1518168369; cv=none;
        d=google.com; s=arc-20160816;
        b=zFyOr9agl2o1z7lil1aBiFgZLSMkjtZh2Shrjk7b2YjGO2HNMhj9AL8ycoeLH9AoOG
         k2liY8JomqgMST0HR2QN3StiVwnYzShfll823JI1GkNEEAlM+XEa433cBM82nEhGoWZ/
         IPAaM/QaYrriieWdBP3AhkGDHjOdWbfXbgU/MogCGuW8BwZW4OJgW6Gc3dlZcDDAE+E6
         gF5QAKJ5DdhdL3W5KkWFP1JQn8QE7PK7cKzNb4yGCkj5Zk2tMDPMdypKZeevR4fqb5vW
         2v9rEv3yXmr+f/G6Je/ad3cpimq43Bucr5o+MkAeEhx8njzKolEFADZIHj+mqqP1Be7c
         tfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=6pKXJr3dQB+EZKAI6Uh1IKsDamXmlHYF3SRvL1fh3Yw=;
        b=ELg9ENJBOM5+g/BS90DziiXMc4LL6HpXP71lD6weuqfDT7QCEWZzaCjwYTMSaoJWnC
         8KFyYsfks4IrIslRNL26+t1JRExtYbqy3fmjdoi9ldOVuv+UfD2mahJVCQj2td8tgZnG
         wYucvL3op+/4N1yoEJKjMmJq4maAWAoSAxKHuZgEcA7II7zQmsJcV5d7hNYfnZchpzdC
         l0hBhc54qK3VvdnAnhT5zX3uu3OCRQgSPE7B7Dme/2/XfArkH/3id3j1khryeDkhPGGs
         hxHpsL1LPe+gq+3LtraDgDmzXal23EMEuRQCphCpWFpQWwCjeDjG4AxJ7qyPTiJU3f9X
         dV7A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=RVM7OXCt;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=RVM7OXCt;
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
Subject: [PATCH 31/31] x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
Date: Fri,  9 Feb 2018 10:25:40 +0100
Message-Id: <1518168340-9392-32-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914915327355934?=
X-GMAIL-MSGID: =?utf-8?q?1591914915327355934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Allow PTI to be compiled on x86_32.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 security/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig b/security/Kconfig
index b0cb9a5..93d85fd 100644
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
