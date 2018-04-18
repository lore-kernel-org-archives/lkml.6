Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524077602; cv=none;
        d=google.com; s=arc-20160816;
        b=aOH1V0ZZnv5ue5rvvsU2JC9jc5ZQ8Pg1GKK81pYmY3BCKL+lF1nJXkc0CP2fm3Uqnn
         VJCwEGdXEf2EA12AYFl0ZycbM5Td0Pv17A30Yd0b712/O7QqJg6Q4sSgUCmhdUQIk26m
         mU5sN0v2KiZiH/db23o7GfArrQ5Ya32SKH4zTBuyjcetm4oKTd9cLXksulP406zAtiHt
         pgB4WkTQT3L/D0tX0jacz8iiaI5VrTpg70yoO6P6SoG2SXJ5bY4p8upuSqEJbI2NZyCi
         TfpqqlDGfI1T9nclfApCPiHa+YDbRciEAM3iCdeVkdyoTFg1QnQkUM9IInr6NgzUkgi5
         bRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=7LqFHjLc9fmiJK6kWcf35NOcOGeLklJMrxXiJTH3PIY=;
        b=Kw3trnCGMwdOj+5HeXxQgsFYJsUEHy6XKr5Pmp/bUvbRyDqtgFanjLvfJDCWS4q5RY
         JZ3guSbXcUy4Lrc0EgAVMnqCPeU4oqZThOMllp2ijpLYsfAMT3UCDBZFdTKeRbzEaITf
         HJ/8Bxbp60TODyTVvY/mVLp9iSrYbdqzGWHBVB9/WnwohdeJhxXEhZ1ueAYMFsZklQAb
         DUg8KfHY4RHjw5M47lrQJvletNm4bwlw5k/51ezVr3Iv1XyHfkkXIaRZIU4bkfCpV/+z
         4yDZKxc6tuUt5ds9KqPfWrSx6Zj3+MZIwnz6ItDEzFcEh+fw9SHZWk+kxTkccGU3P1Ob
         qn6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Y5qNS+wH;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Y5qNS+wH;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4+B0pjbQyWKQY9fQR9K19/64zAuAzCr4KKSyoP7Syb44CYVgusfIIjx+clr3qT4sbFKWLN/pQ==
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
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
Subject: [PATCH 2/6] uaccess: add untagged_addr definition for other arches
Date: Wed, 18 Apr 2018 20:53:11 +0200
Message-Id: <3001f7c75f1f99b4c7b789cf91da06678df3435e.1524077494.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <cover.1524077494.git.andreyknvl@google.com>
References: <cover.1524077494.git.andreyknvl@google.com>
In-Reply-To: <cover.1524077494.git.andreyknvl@google.com>
References: <cover.1524077494.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111196280254794?=
X-GMAIL-MSGID: =?utf-8?q?1598111196280254794?=
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
2.17.0.484.g0c8726318c-goog
