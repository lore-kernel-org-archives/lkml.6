Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x226A3fU0wGswIIr2ovwk6HUdQCW7rkjDHFY9MSLojXCIBr8H5bj0sEzpHHGIQSSH4h5OSdob
ARC-Seal: i=1; a=rsa-sha256; t=1518863535; cv=none;
        d=google.com; s=arc-20160816;
        b=kW6P00QjMOgGZeSi24Qo4FeNjPKD+Ynf3WY1moLXM+JtYKzWvJxbDQLqlwh+Kr3ATn
         KBPLmrV7YM5fnKOijUk9wHWpbj0+8WOLOy+DqRyPkc+ez/2+poKwjapC6AN2iVAtMBD4
         lDIpn9ZVYfR4VW8h6VLRs7AR4PC5c8zUcEtA2qoLruoxlANbJ2ZplZ5ifpWNm0wDJcVU
         WYGFgdfbizybiKkH7CSk80btyFGnkK/YbaWeLm7sUM5tcTgPK1qAyGDMnOnHfLV6XJ9p
         Fv+7sp2z1W1c8X7lGVpcWdhQDox09cOuNCmkJWOEhCQBReiITxg1+EjFTCBxKIkq8f2+
         mP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=FfzvKXQ2pRTaiUvuoRUeFsD3oEHTNul2fB4z74vjSmY=;
        b=vxAhVS4kkXjMy7fPQjNhLQ6II42QfI8RsOOaQZzqhv0dxlVsV5RzbwGnIoVEiRHDFj
         Rzno/dCvU4lbldqQbJCukgthfzxjjFRYMONWOI9aR1/KGzOsqc1mwR0DzlLEOY7Ikuv6
         /kgIf2dmGeoMLF2qm4R9ThkjpdxBqTSoHf6Sy8haYPPBJxg1fM206Qa9mqy/Q9vymQ7u
         ZaC5hxufn3qcBlEAFBGMNtszH2Bf9HDA5vHIWzUj7KNgiDEKFgf8wxz5Zu9PQNdI40Ae
         CfVJM2HnziqbpqtAq4vHMiqTQQHGRQtHSdmh0tVnPjYPq5ATKrdtwM1kZgzxkDkIv1Oj
         U4sA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sat, 17 Feb 2018 02:11:34 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-eb6174f6d1be16b19cfa43dac296bfed003ce1a6@git.kernel.org>
Cc: mingo@kernel.org, borntraeger@de.ibm.com, jpoimboe@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        arjan@linux.intel.com, peterz@infradead.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        luto@kernel.org, dwmw2@infradead.org, dan.j.williams@intel.com,
        tglx@linutronix.de, will.deacon@arm.com, dave.hansen@linux.intel.com
Reply-To: tglx@linutronix.de, dave.hansen@linux.intel.com, will.deacon@arm.com,
        arjan@linux.intel.com, luto@kernel.org, dan.j.williams@intel.com,
        dwmw2@infradead.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, peterz@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, borntraeger@de.ibm.com,
        mingo@kernel.org, jpoimboe@redhat.com
In-Reply-To: <151881605404.17395.1341935530792574707.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151881605404.17395.1341935530792574707.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] nospec: Include <asm/barrier.h> dependency
Git-Commit-ID: eb6174f6d1be16b19cfa43dac296bfed003ce1a6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592643850779332837?=
X-GMAIL-MSGID: =?utf-8?q?1592643850779332837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  eb6174f6d1be16b19cfa43dac296bfed003ce1a6
Gitweb:     https://git.kernel.org/tip/eb6174f6d1be16b19cfa43dac296bfed003ce1a6
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Fri, 16 Feb 2018 13:20:54 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 17 Feb 2018 08:40:59 +0100

nospec: Include <asm/barrier.h> dependency

The nospec.h header expects the per-architecture header file
<asm/barrier.h> to optionally define array_index_mask_nospec(). Include
that dependency to prevent inadvertent fallback to the default
array_index_mask_nospec() implementation.

The default implementation may not provide a full mitigation
on architectures that perform data value speculation.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/151881605404.17395.1341935530792574707.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/nospec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index 172a19d..e791ebc 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -5,6 +5,7 @@
 
 #ifndef _LINUX_NOSPEC_H
 #define _LINUX_NOSPEC_H
+#include <asm/barrier.h>
 
 /**
  * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
