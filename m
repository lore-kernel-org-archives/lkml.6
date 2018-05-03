Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525356952; cv=none;
        d=google.com; s=arc-20160816;
        b=Yfu8tCUpyS5cqGnkqSgEJk6SKkVtbsWxCroCrb0iW4WftxJe5Cor5AX5kbMV5g42pg
         ITeeSOxondRRCoXqL2gXDc74/E69+iOQtiqBMbW/XOJVpXoOeQ/IXMi1JerU0Lq43dlc
         WOUBQL/X+8MBchfQT/3FM/0MpU3krIC+2Mor0HKMNV9imLYXOQZTPr13820tZbneNgdK
         qveUj/GxvZWovzCEIkwjqdDNNVfH8Mt+zxZRUZbH5NUwPRKPuli8mOhOidwtZssEnSul
         PUIpBJq+qGFZTsZQ4wvJmlbNqesVenDS+q1PRniLjdwu1OPxXiZGDeFE/SNCtE3DYL2c
         589Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=wXNsOIULzRBowlkHlt/Dd2liRl3+STS0XzbkUxVElPM=;
        b=RJEptCgB8I8CpKJUixW7FDwz9jWQzgytK6TKBW5X3xXaCvxz9eDHeKki0XurScTA3r
         jAUwdALQ+pZRW8QcUud4hU7PSJLnASiETSS0lTiRM2LxOoL3nH54xUv+iDaoOie2NDZQ
         77xYp3xdV+dzqPkzqy9BR+kNMs4cEd24sqlnH3FVMOkcv1YsiFDxr0Fl3Mg1DKtvhTeO
         MREGn9eLcftApqT3xVXc9xSDYp6pGt9OLzBpcfxID1sZGo1cx/aJxUvP5IKoEiToW5nO
         OyatRg/haQucrcSE6hySvAwAxfs1QrINsKJWpPQNeaWdN0YFPXkfsO8RpINLZO/u8nve
         EGnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=cKfcqw7O;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=cKfcqw7O;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZoPsEixtvtPtjFL5/kf9+eJmruA8lLTNPHuSDxpygbMTUZneSzwIrOUpIYddWNTRGnTIGl+ig==
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrey Konovalov <andreyknvl@google.com>,
	James Morse <james.morse@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v2 2/6] uaccess: add untagged_addr definition for other arches
Date: Thu,  3 May 2018 16:15:40 +0200
Message-Id: <f63094e20c1eb163ba3ae6f3531e791d2675a2a5.1525356769.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525356769.git.andreyknvl@google.com>
References: <cover.1525356769.git.andreyknvl@google.com>
In-Reply-To: <cover.1525356769.git.andreyknvl@google.com>
References: <cover.1525356769.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599452691498173747?=
X-GMAIL-MSGID: =?utf-8?q?1599452691498173747?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To allow arm64 syscalls accept tagged pointers from userspace, we must
untag them when they are passed to the kernel. Since untagging is done in
generic parts of the kernel (like the mm subsystem), the untagged_addr
macro should be defined for all architectures.

Define it as a noop for other architectures besides arm64.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/uaccess.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index efe79c1cdd47..c045b4eff95e 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -13,6 +13,10 @@
 
 #include <asm/uaccess.h>
 
+#ifndef untagged_addr
+#define untagged_addr(addr) addr
+#endif
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
-- 
2.17.0.441.gb46fe60e1d-goog
