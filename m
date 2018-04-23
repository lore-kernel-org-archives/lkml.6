Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4+2Wf9Knpm5Bg6nYfkFYM3sv/3HTmbLa7X2IKarNsGZ+XOl3bZDrtk5kFRJtu7vd1LgH/PR
ARC-Seal: i=1; a=rsa-sha256; t=1524498482; cv=none;
        d=google.com; s=arc-20160816;
        b=aVcGOzg8vt9Nm9mNG7x9AUuVWpKb1fNI2WuxLJeQVxzUV66ir0ikhEJXv2B1S/0Wee
         /8E/GpnG9Z46/C9m2MqbDQyj2a3bjwlk4BijvDcDUYPMjsny/+M6NZPuEwklRD4dyMLF
         vIoL7OX3cDN8YpyrnAFbtsdjSCyRJZVq7rAZo4ncHEs+MkUMVQeWcc1bqtyqKPgfmyJs
         m6bdCrx8dHw+b4tbRbLffvXQrwaDn09Wo9vrHuZ9j6u64Ifg2rKQJdvu4FwDF7yAVSlc
         3eiyRitWDpqf4C19XDMzjEj/eD6VUyIbbnpYK/pH6pePpDZ8tUWQFroGjQ1TzoiFKYJW
         PEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=CliYgnZbmohA5O1xBxVSliAIvcy3J5hZOwxEIrmd3QM=;
        b=JxbhaAtIOd6h3djzahZE1Q38rt/bGkujG48N3LZAeeeZAmKf7H/XhAtxphFuhC4l/6
         4Ue1d3kbuM4N0lRb1q+0eMNY4m5IM/q84pD8kIWYKU0I+EQbPwXKDd1zz4PkAdmG5TQx
         WKAGyyb6xCpHKNk4GMERGO/Q0rNPYuqZryitsBOJpMFbM+IZbqs3JIIOz539/oM0eXmq
         64/a6FZfPgJsYl6cNIlHCN780gr7CuFQZP0ysaBDDflqsmEdsuFhBPIe/qmTPXRAl07r
         7vxzrRvEDGaNLCX2vZ6L7TYEmkP8pQ6F8jygZFJ41F+mmx5i8GwUuREasT4SU9metllW
         FXyw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=P3h+Mune;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=P3h+Mune;
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
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 35/37] x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
Date: Mon, 23 Apr 2018 17:47:38 +0200
Message-Id: <1524498460-25530-36-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552520514660983?=
X-GMAIL-MSGID: =?utf-8?q?1598552520514660983?=
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
