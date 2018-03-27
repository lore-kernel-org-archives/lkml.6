Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522169870; cv=none;
        d=google.com; s=arc-20160816;
        b=AZGsOt7UqSteuFKyKjlCqhlm2eDaz8b8FC12bQH8ejmBXUVcpWWtddWdFLJ25yzr5j
         1ZigIudQIrfuVv3k2XIpG5gkBWBiAZIINcp+cUC96UXxjw0kH0/0mMtA/pYzvmg8c8Qk
         nXDzymvnyvi3Ml/3PT+I01ETURb2W5E8Dxk4BqNZvWREjZykjleHp74/3q6zYIgEU6U2
         ncYC3+WfxtKmoLKDOkl+2/ajXsq5/T4nNqDO7zWLug5awbqBauKiUQne6uZzvDordwYS
         4T/NgKqcz1R/1sqA+afs2kOhZYFEBWhwBM1XIYDiNBagO/vtzXdCjNzaKefIIDv/YRLu
         tLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=eJaUh+CmLgN3GGwHqK4N3gE7joHAOCvWBMJLvmKkuIs=;
        b=ap9GCEZpHCqi4Zr9lTmsxyxqqeR6oJfiMCMbga+ZyUK7seqoJPjG5ASdaVkK/CDWkS
         +oW3g4qjIfxSGTsOlo2zk+dBd2sovsYEyP1LbCFSu6xLgVSmMgA8bn5OO0sQrz0lmQL2
         pwCRNTyrWL5pbmZLZGu8SWIX5PiVgMZMSuhU5jEUK7HB6GSFeo5hmDmrPkByzjzDdWCq
         yg01MWYUHvSOeDxwLPf5pxGYkUax95rfWeGPFrxc5VXrtiJBmC2X6AbxGbw2q50cc/4Z
         QML56Su/8JjrAfO14Xuz6fjhxnLjB+3JwYSc45DwNxnc8gmSNF0+Dp5Yml3pOjDH8z5w
         AGZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=j0fTrT7H;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=j0fTrT7H;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx486DN8+yq+du0k+qQSl+nN6KjPkVcB/PM1Wof913SgviRcF5T935zJkvApGf4eM5HikxxMJWw==
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
Subject: [RFC PATCH v2 2/6] uaccess: add untagged_addr definition for other arches
Date: Tue, 27 Mar 2018 18:57:38 +0200
Message-Id: <82fadd039625707fea89668cd50cfae24d19681e.1522169685.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <cover.1522169685.git.andreyknvl@google.com>
References: <cover.1522169685.git.andreyknvl@google.com>
In-Reply-To: <cover.1522169685.git.andreyknvl@google.com>
References: <cover.1522169685.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596110794066694769?=
X-GMAIL-MSGID: =?utf-8?q?1596110794066694769?=
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
2.17.0.rc0.231.g781580f067-goog
