Return-Path: <kernel-hardening-return-11754-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227qpt7LoULvEGlKBpWOHjDRvipzNc7eqBvTkk0vXNhRkWYmfs4GIb4Fj5PrQEzUu0kTB/EQ
ARC-Seal: i=1; a=rsa-sha256; t=1518632844; cv=none;
        d=google.com; s=arc-20160816;
        b=0i5uAr4nWe1VEnZZHD+G/5elLkm9dNSjmpwwFPjNQ1bzUkjDIeXlJpayyGvAwqtm7V
         Z4wddswwBUzkjjQ3ggA1dLEbUCyDJPX6tcT/rgY4YsQo2G3raVrW/6/brn1ifagoFQ1a
         rVnQ3SkqH7noCTVz5xwS1txvIk1Rg/9eWxZogvHIoZy29Otai2yIBZz1sziZhU+NjD3+
         7FuCrBrvM/IkHt60v5GaJM14+qLOekePbywaz/nup3+zk0z3RF84HeChBtcUNrQURyyQ
         ueHYZpGqJWrM8+GmHXIlzz6PkVZdSS58l4UKPsqNzEo/dwHmPBrrvVKfnqwGWqtbzzbP
         3lfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=GtO3WxoQVSWOI6IQefcpR9c8Itq0yVaxKFx0QZlzn6g=;
        b=ReEQ0pmMNfVXQPwJ8x0zfEaFWCWWaWw3vjIQ2fdWOyOArgZldFtYaPqy9KdtWApPz6
         MWtn0iQImexoFgAZiZ2qVOIHYLZ4Gn79dcTrdXNgFHSukVDMnsL7XTOzr9qkiBWLnN3Y
         dze7TECCIr/ezIeNvVZYvlqLvaEOt9RTf4yws/9U2QBwolTILTZeAJrVK9P4YZ1iqk7L
         qDW4bT/oWtzvQMJ6FyEp0nFQJzZSMmnqxqMZ52rmp6un3rpJjK+lQeKstnq14QgMZtwr
         63VtJM/zRnX77iAuwSyg+lVlSmFuwAuo5ZNzHcvSjsQuuHLPFQFm70pO4+ttidJ7acoB
         YCcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=XdrVJEst;
       spf=pass (google.com: domain of kernel-hardening-return-11754-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11754-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=XdrVJEst;
       spf=pass (google.com: domain of kernel-hardening-return-11754-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11754-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
	linux-mm@kvack.org,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH 1/2] mm: Add kernel-doc for kvfree
Date: Wed, 14 Feb 2018 10:26:17 -0800
Message-Id: <20180214182618.14627-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214182618.14627-1-willy@infradead.org>
References: <20180214182618.14627-1-willy@infradead.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401954146454631?=
X-GMAIL-MSGID: =?utf-8?q?1592401954146454631?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/util.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/util.c b/mm/util.c
index c1250501364f..dc4c7b551aaf 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -430,6 +430,16 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 }
 EXPORT_SYMBOL(kvmalloc_node);
 
+/**
+ * kvfree() - Free memory.
+ * @addr: Pointer to allocated memory.
+ *
+ * kvfree frees memory allocated by any of vmalloc(), kmalloc() or
+ * kvmalloc().  It is slightly more efficient to use kfree() or vfree()
+ * if you are certain that you know which one to use.
+ *
+ * Context: Any context except NMI.
+ */
 void kvfree(const void *addr)
 {
 	if (is_vmalloc_addr(addr))
-- 
2.15.1
