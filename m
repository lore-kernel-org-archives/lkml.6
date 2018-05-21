Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1059582-1526924395-2-16955539697248320393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526924395; b=diPEv1cvX+8G14siaOpQtq4psTlL+v3yikv/OE5Fq98l+NLMDI
    /snYI/GBWQakG+qNqJuJ7YVka0ku0XaTjDr8HQmET/rb+GIw9EBRB9Jk6qNL7niv
    px297GK/NqzVJ1s0pk1B4u1ljDAaVUMhReEaiCSdBQKUfCQMqF1/Zpns4rwO0wfe
    tFy5AEX0lm9+nw1Rif6qGC0WVwnT1geW9ro1up9/44Y1Nhwesg5ARJFEvoNO+QYR
    vaB/8PSXPF88GvCGeJ+RXROP+7dNM1wgK2LHLKbeiHfF7UvvJsWUbF9zdnYj2smy
    g/C+2cIBy3IWdh3HraVVC6F/s9y9F6y0kFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526924395; bh=
    y93jOlWhd7FxpDFZ0pghwXFInv9GSDSnE8GiSC3RxxM=; b=Y8wUKBW8NchFn8wt
    rTip9SAIMwpL5+iR3HHCI3dV9iuzFMgDiFBMVvlRquigXJy6Y3IOGwMskNHk0Yzi
    7orexz6hoiz0M8g11CM2mw53t9GvsZ9K4uQ1n/fwTYRRddvYtZpj+WnWeAooRK6V
    ivaR+XAdfajExZrQ1NSZZ1ZQ5VPMAWk2OOb88Ykem5AeUW9J5GRoqvwbX0LPlal6
    PEx/iYXOKfUXRSaW6I5B5Dxyfc+trqStsgJP7lZFx0Wa8L+KEdXVWdbz7KfqCtCm
    JIowti29PU9jcts/HDvqrp0h+d2EEAjMn+X36v7Pw3721qsigNlnCwIwPYCBCX4a
    BmyH5w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=collabora.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=51 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=collabora.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGQQdS6dO5N2Hil0QV/PdHyztZdDrDXmnPVS7QIMdW2udy00Rb6f/IJhd3GwISTknZxYT7ot3EBEp6qockDivg48Tr+ONJl7/GaW9IPbPkOOAl6gMFZP
    cJDFVNS+iIFV+e3E57GKrbs5am1xin4FPTjNUP4lykqEmgVcsX25SkeQUq46B1Je2EN/yOl3NYl1aBg6gNOGchcmdAXmvoyE4ps1VT38jLCf7Qlq0ArKiF/A
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=gvl4HP8tAAAA:8
    a=_uiOq3mmrNBbulGSq6IA:9 a=p7NskKJwjhxti7XZ:21 a=xykuUGHNRUkrmsUy:21
    a=tRkgsvjveJ3YVe9fnr1q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753564AbeEURju (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 13:39:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45344 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753296AbeEURhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 May 2018 13:37:34 -0400
From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
To: viro@ZenIV.linux.org.uk
Cc: jra@google.com, tytso@mit.edu, olaf@sgi.com,
        darrick.wong@oracle.com, kernel@lists.collabora.co.uk,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com, jack@suse.cz,
        linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: [PATCH v2 14/15] nls: utf8norm: Integrate utf8norm code with NLS subsystem
Date: Mon, 21 May 2018 14:36:16 -0300
Message-Id: <20180521173617.31625-15-krisman@collabora.co.uk>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521173617.31625-1-krisman@collabora.co.uk>
References: <20180521173617.31625-1-krisman@collabora.co.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changes since RFC v2:
  - Integrate with NLS

Changes since RFC v1:
  - Change error return code from EIO to EINVAL. (Olaf Weber)
  - Fix issues with strncmp/strcmp.  (Olaf Weber)
  - Remove stack buffer in normalization/casefold. (Olaf Weber)
  - Include length parameter for second string on comparison functions.
  - Change length type to size_t.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
---
 fs/nls/Makefile         |   2 +-
 fs/nls/nls_utf8n-core.c | 291 ++++++++++++++++++++++++++++++++++++++++
 fs/nls/nls_utf8n-norm.c |   6 +
 fs/nls/utf8n.h          |   1 +
 4 files changed, 299 insertions(+), 1 deletion(-)
 create mode 100644 fs/nls/nls_utf8n-core.c

diff --git a/fs/nls/Makefile b/fs/nls/Makefile
index 6ff62c0fe436..3650bb58534b 100644
--- a/fs/nls/Makefile
+++ b/fs/nls/Makefile
@@ -56,7 +56,7 @@ obj-$(CONFIG_NLS_MAC_ROMANIAN)  += mac-romanian.o
 obj-$(CONFIG_NLS_MAC_ROMAN)     += mac-roman.o
 obj-$(CONFIG_NLS_MAC_TURKISH)   += mac-turkish.o
 
-nls_utf8n-y += nls_utf8n-norm.o
+nls_utf8n-y += nls_utf8n-norm.o nls_utf8n-core.o
 obj-$(CONFIG_NLS_UTF8_NORMALIZATION) += nls_utf8n.o
 
 $(obj)/nls_utf8n-norm.o: $(obj)/utf8data.h
diff --git a/fs/nls/nls_utf8n-core.c b/fs/nls/nls_utf8n-core.c
new file mode 100644
index 000000000000..56e1dd07047c
--- /dev/null
+++ b/fs/nls/nls_utf8n-core.c
@@ -0,0 +1,291 @@
+/*
+ * Copyright (c) 2017 Collabora Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/nls.h>
+#include <linux/slab.h>
+#include <linux/parser.h>
+#include <linux/string.h>
+
+#include "utf8n.h"
+
+static struct nls_charset utf8norm_info;
+
+static int utf8_strncmp(const struct nls_table *charset,
+			const unsigned char *str1, size_t len1,
+			const unsigned char *str2, size_t len2)
+{
+	const struct utf8data *data = utf8nfkdi(charset->version);
+	struct utf8cursor cur1, cur2;
+	int c1, c2;
+	int r;
+
+	r = utf8ncursor(&cur1, data, str1, len1);
+	if (r < 0)
+		return -EINVAL;
+	r = utf8ncursor(&cur2, data, str2, len2);
+	if (r < 0)
+		return -EINVAL;
+
+	do {
+		c1 = utf8byte(&cur1);
+		c2 = utf8byte(&cur2);
+
+		if (c1 < 0 || c2 < 0)
+			return -EINVAL;
+		if (c1 != c2)
+			return 1;
+	} while (c1);
+
+	return 0;
+}
+
+static int utf8_strncasecmp(const struct nls_table *charset,
+			    const unsigned char *str1, size_t len1,
+			    const unsigned char *str2, size_t len2)
+{
+	const struct utf8data *data = utf8nfkdicf(charset->version);
+	struct utf8cursor cur1, cur2;
+	int c1, c2;
+	int r;
+
+	r = utf8ncursor(&cur1, data, str1, len1);
+	if (r < 0)
+		return -EINVAL;
+
+	r = utf8ncursor(&cur2, data, str2, len2);
+	if (r < 0)
+		return -EINVAL;
+
+	do {
+		c1 = utf8byte(&cur1);
+		c2 = utf8byte(&cur2);
+
+		if (c1 < 0 || c2 < 0)
+			return -EINVAL;
+		if (c1 != c2)
+			return 1;
+	} while (c1);
+
+	return 0;
+}
+
+static int utf8_casefold(const struct nls_table *charset,
+			 const unsigned char *str, size_t len,
+			 unsigned char **folded)
+{
+	const struct utf8data *data = utf8nfkdicf(charset->version);
+	struct utf8cursor cur;
+	char *s;
+	ssize_t nlen;
+
+	nlen = utf8nlen(data, str, len);
+	if (nlen < 0)
+		return -EINVAL;
+
+	s = kmalloc(nlen + 1, GFP_NOFS);
+	if (!s)
+		return -ENOMEM;
+	*folded = s;
+
+	utf8ncursor(&cur, data, str, len);
+	do {
+		*s = utf8byte(&cur);
+	} while (*s++);
+
+	return nlen;
+}
+
+static int utf8_normalize(const struct nls_table *charset,
+			  const unsigned char *str,
+			  size_t len, unsigned char **normalization)
+{
+	const struct utf8data *data = utf8nfkdi(charset->version);
+	struct utf8cursor cur;
+	char *s;
+	ssize_t nlen;
+
+	nlen = utf8nlen(data, str, len);
+	if (nlen < 0)
+		return -EINVAL;
+
+	s = kmalloc(nlen + 1, GFP_NOFS);
+	if (!s)
+		return -ENOMEM;
+	*normalization = s;
+
+	utf8ncursor(&cur, data, str, len);
+	do {
+		*s = utf8byte(&cur);
+	} while (*s++);
+
+	return nlen;
+}
+
+static int utf8_uni2char(wchar_t uni, unsigned char *out, int boundlen)
+{
+	int n;
+
+	if (boundlen <= 0)
+		return -ENAMETOOLONG;
+
+	n = utf32_to_utf8(uni, out, boundlen);
+	if (n < 0) {
+		*out = '?';
+		return -EINVAL;
+	}
+	return n;
+}
+
+static int utf8_char2uni(const unsigned char *rawstring, int boundlen,
+			 wchar_t *uni)
+{
+	int n;
+	unicode_t u;
+
+	n = utf8_to_utf32(rawstring, boundlen, &u);
+	if (n < 0 || u > MAX_WCHAR_T) {
+		*uni = 0x003f;	/* ? */
+		return -EINVAL;
+	}
+	*uni = (wchar_t) u;
+	return n;
+}
+
+static unsigned char utf8_tolower(const struct nls_table *table,
+				  unsigned int c)
+{
+	return c; /* Identity */
+}
+
+static unsigned char utf8_toupper(const struct nls_table *table,
+				  unsigned int c)
+{
+	return c; /* Identity */
+}
+
+static const struct nls_ops utf8_ops = {
+	.strncmp = utf8_strncmp,
+	.strncasecmp = utf8_strncasecmp,
+	.casefold = utf8_casefold,
+	.normalize = utf8_normalize,
+	.lowercase = utf8_tolower,
+	.uppercase = utf8_toupper,
+	.uni2char = utf8_uni2char,
+	.char2uni = utf8_char2uni,
+};
+
+static int utf8_parse_version(const char *version, unsigned int *maj,
+			      unsigned int *min, unsigned int *rev)
+{
+	substring_t args[3];
+	char *tmp;
+	const struct match_token token[] = {
+		{1, "%d.%d.%d"},
+		{0, NULL}
+	};
+	int ret = 0;
+
+	tmp = kstrdup(version, GFP_KERNEL);
+	if (match_token(tmp, token, args) != 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (match_int(&args[0], maj) || match_int(&args[1], min) ||
+	    match_int(&args[2], rev)) {
+		ret = -EINVAL;
+		goto out;
+	}
+out:
+	kfree(tmp);
+	return ret;
+}
+
+static struct nls_table *utf8_load_charset(const char *version)
+{
+	struct nls_table *tbl = NULL;
+	unsigned int nls_version;
+
+	if (version) {
+		unsigned int maj, min, rev;
+
+		if (utf8_parse_version(version, &maj, &min, &rev) < 0)
+			return ERR_PTR(-EINVAL);
+
+		if (!utf8version_is_supported(maj, min, rev))
+			return ERR_PTR(-EINVAL);
+
+		nls_version = UNICODE_AGE(maj, min, rev);
+	} else {
+		nls_version = utf8version_latest();
+		printk(KERN_WARNING"utf8norm version not specified. "
+		       "Assuming latest supported version (%d.%d.%d).",
+		       (nls_version >> 16) & 0xff, (nls_version >> 8) & 0xff,
+		       (nls_version & 0xff));
+	}
+
+	 /* Try an already loaded table first. */
+	for (tbl = utf8norm_info.tables; tbl; tbl = tbl->next) {
+		if (tbl->version == nls_version)
+			return tbl;
+	}
+
+	tbl = kmalloc(sizeof(struct nls_table), GFP_KERNEL);
+	if (!tbl)
+		return ERR_PTR(-ENOMEM);
+
+	tbl->charset = &utf8norm_info;
+	tbl->version = nls_version;
+	tbl->ops = &utf8_ops;
+
+	tbl->next = utf8norm_info.tables;
+	utf8norm_info.tables = tbl;
+
+	return tbl;
+}
+
+static void utf8_cleanup_tables(void)
+{
+	struct nls_table *tmp, *tbl = utf8norm_info.tables;
+
+	while (tbl) {
+		tmp = tbl;
+		tbl = tbl->next;
+		kfree(tmp);
+	}
+	utf8norm_info.tables = NULL;
+}
+
+static struct nls_charset utf8norm_info = {
+	.charset = "utf8n",
+	.load_table = utf8_load_charset,
+};
+
+static int __init init_utf8(void)
+{
+	register_nls(&utf8norm_info);
+	return 0;
+}
+
+static void __exit exit_utf8(void)
+{
+	unregister_nls(&utf8norm_info);
+	utf8_cleanup_tables();
+}
+
+module_init(init_utf8);
+module_exit(exit_utf8);
+MODULE_AUTHOR("SGI, Gabriel Krisman Bertazi");
+MODULE_DESCRIPTION("UTF-8 charset operations for filesystems");
+MODULE_LICENSE("GPL");
diff --git a/fs/nls/nls_utf8n-norm.c b/fs/nls/nls_utf8n-norm.c
index 64c3cc74a2ca..abee8b376a87 100644
--- a/fs/nls/nls_utf8n-norm.c
+++ b/fs/nls/nls_utf8n-norm.c
@@ -38,6 +38,12 @@ int utf8version_is_supported(u8 maj, u8 min, u8 rev)
 }
 EXPORT_SYMBOL(utf8version_is_supported);
 
+int utf8version_latest()
+{
+	return utf8vers;
+}
+EXPORT_SYMBOL(utf8version_latest);
+
 /*
  * UTF-8 valid ranges.
  *
diff --git a/fs/nls/utf8n.h b/fs/nls/utf8n.h
index f60827663503..b4697f9bfbab 100644
--- a/fs/nls/utf8n.h
+++ b/fs/nls/utf8n.h
@@ -32,6 +32,7 @@
 
 /* Highest unicode version supported by the data tables. */
 extern int utf8version_is_supported(u8 maj, u8 min, u8 rev);
+extern int utf8version_latest(void);
 
 /*
  * Look for the correct const struct utf8data for a unicode version.
-- 
2.17.0
