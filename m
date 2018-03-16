Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELvno9DgQbRlBlNXfZ+w2yOBXVB6B8wy071O5hnUt0l0j4RmVORp6/Ej3BsanZxXvlIQME3f
ARC-Seal: i=1; a=rsa-sha256; t=1521228613; cv=none;
        d=google.com; s=arc-20160816;
        b=d1kJFw9DSJP63/v1JnuxbwN2pcVLcvqAVgTbtU+qMENv5jf93vjAUsLMw4doeDV82H
         CESC0eCglLiZn6fVqgt9AD9kAxMxGtxWBmJNyUNHs13eFlbT11kRNXwwg7iEbhnio05M
         OOvDDTKSbCcVMIx7f+82hXgHtfMUkyylHNnyRfiOY1+cGKZmykg2ju2tK3cASuwftW0u
         w49R8huKXokFlLk6HgK8XE/yRiunYpGCUmsBues3dVW5vTcY9HaAgPy5aDe2UJBYEUXA
         vTw8RInBX2NdlVdiC1iztWnYIFTCdXAXQ59dB9BL25kzFa4w0jpk9dwGui/n5Glr3UTY
         XDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=6pKXJr3dQB+EZKAI6Uh1IKsDamXmlHYF3SRvL1fh3Yw=;
        b=fkrMILaStRz3RzvRoLeJ+Vg8K+A2S6s/JXu3+BhOFI96OZNf+SG7EkhC03l2FzZZqf
         0hIrIixPA/jhfEihWOXqGlIDu6FBuZnRJwsSrj5aKxr3egOhEL3WzsMwX5BkeWdGuiOK
         LwWT/b9gXT5IibFMOECFG6qCaaH4hI3HXFbcPVznjvmaOGchRscy8L+pft3qW4mtdbfJ
         D/rBb6AontkAA5Uaa/JSMuTppp9uA6u7+VMIQOOL7HYpwOuq1KGMmr/dbuQ6tjctMPtT
         1quRm7GFBkQCjpu1X9VdaKJsSuo2JV2Jmoqd1/gT3uv+sscn35J3vOR6ILnf1RyIlmky
         P+yA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=NeSCcwVf;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=NeSCcwVf;
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
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 33/35] x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
Date: Fri, 16 Mar 2018 20:29:51 +0100
Message-Id: <1521228593-3820-34-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123814616371996?=
X-GMAIL-MSGID: =?utf-8?q?1595123814616371996?=
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
