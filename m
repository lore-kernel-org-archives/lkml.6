Return-Path: <kernel-hardening-return-11777-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226C3MLptrqnvW9/6lWlMHyAbP9o4HnSaCAEnUDyTaviLxdY9LpDg6dJe6oD5TwTAMgiSuCM
ARC-Seal: i=1; a=rsa-sha256; t=1518639160; cv=none;
        d=google.com; s=arc-20160816;
        b=G0jXLpGOupVmntZC8JOnyCNTDUZeIW23sZcWU+xjYsA4Sa5TFdGeV78M+1O86BQreh
         UWLhQh0rXrqlojiA8zFj/4VjaY0oj6YVSnUP3fgGBlCZuSAbsomW1LPvdJ5cqq2lJkjs
         Zmu/dlC/I7o+NIYvBFEm6rDBCEk7et/z6GZKbCeqRgDBMePMm2h6eJdmnKmVUd+4Vxbm
         boobSkPRJk71Hz7HCTZGhLfZOUVIGz6olcF4a7pdK2iPHBmMnobpTAQd615ZjmPhoUoQ
         l+Q+srRhPQeTIROjyPP/UtsFiomI3mfGhG+09NpyVLsLM3FmmfnDsbtJdpfxbaxrU0NY
         5vcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=GtO3WxoQVSWOI6IQefcpR9c8Itq0yVaxKFx0QZlzn6g=;
        b=YbDTDVdw97jKOT2L+rfRzzlqN0zS7NTEaApUMpHW4ZziP5XvmdodKnUFGcF3mHOMIw
         Ilnvf8hpB2gTDka5cLHcRJn/BCOrUBmq4oU9UgHTRvrnFmaiDiqz1kHNLnOxRdB4PxK0
         CMyhp0+mvuQBniv+LzPWBauxxONpiP/Rm1t8k6/S4cIuPFhHk5+1uw15bEJhdEqmB1cS
         1AKbb6SdCtKU15/hz8MCaXaYnZMT8mbe1cjVvoCrPY6ku6H9+U3yqSRRScbZ1ZpdRWiP
         M7DN1JLbvOqNtI/P77JFQGUc2GSze2jCfX6pZDIxV4chWxdkGg3w7BhC+jFO+tN6N8Ut
         baww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=ZlUsWub4;
       spf=pass (google.com: domain of kernel-hardening-return-11777-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11777-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=ZlUsWub4;
       spf=pass (google.com: domain of kernel-hardening-return-11777-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11777-gregkh=linuxfoundation.org@lists.openwall.com
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
	kernel-hardening@lists.openwall.com,
	Joe Perches <joe@perches.com>
Subject: [PATCH v2 1/8] mm: Add kernel-doc for kvfree
Date: Wed, 14 Feb 2018 12:11:47 -0800
Message-Id: <20180214201154.10186-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214201154.10186-1-willy@infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401954146454631?=
X-GMAIL-MSGID: =?utf-8?q?1592408576340711697?=
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
