Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELuCRw71HEHyBHmZ1nLtr5I0eVE6/HWdVIOYphZ/vBe1RcqE3xKWoO+jbTTQyndyTWFVp/fd
ARC-Seal: i=1; a=rsa-sha256; t=1520245583; cv=none;
        d=google.com; s=arc-20160816;
        b=HHma8A3J1i4FuQ5IaG4/j8qLWB7gRkYq959odS3H3FlAi6OYq7apBjhWLBAHufjbOC
         65Nzq1pWMbCgjv4CJ3jkf356bqicS5s4TI5Y1DISo/Ad4fTnLE36kEXwcIBnz3znBqMl
         01ZQvuqyobCJUVzQWcSGk8jSYnwNETl7MBj/kMtScqKFkqacDzNDCF9OiPducr8jzaCV
         BQY/M55FbizyeDekp2f18oiOb12rIbYr5R1eoZpJ+Z9S6kIeHgFwtd/TcX3KfQWVZBeq
         E/K4I2IYk8jordiGEWaTgX6LfVZSKVYct1wRmheTJKKt2xzCyyMjqTGo12ZQUT3uHbNq
         /DFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=6pKXJr3dQB+EZKAI6Uh1IKsDamXmlHYF3SRvL1fh3Yw=;
        b=VCSyDJ6o//V5UA2socEbBlfgY2mBynjqZB/OUKuB5ePanUXcdD/HH/y3JoJAQbCKEh
         eTuvfThZqBy04FL5lmzH2zDx8ECVitxIKnPcJvkIkayLpT/Z1t6DsFSkI4Ecpq+FkhuQ
         TbWrhdalV7Lv3U5yFhaH6AQnvvHIVbysM9HguHG86xM7qbWjdvDV5HS4vB/5GhUFY6B9
         aRZ9/rs3ornQtn9iGtUJjqKPrhGREKLQ6KGg0YZNRGN0xeJmPeCxFVB7KXxDSNw+VXvb
         lnc5WWp/etL5xux7uq/BV8K+Ut9glrDWvDcd+yJqJIjS3dqQscn72VKLFpf8HAzvCfVl
         qaAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=kMq5PFi0;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=kMq5PFi0;
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
Subject: [PATCH 33/34] x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
Date: Mon,  5 Mar 2018 11:26:02 +0100
Message-Id: <1520245563-8444-34-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093033146659785?=
X-GMAIL-MSGID: =?utf-8?q?1594093033146659785?=
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
