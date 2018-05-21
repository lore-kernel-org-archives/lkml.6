Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1090829-1526924396-2-5310071154929870403
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526924396; b=dQPTbc3zbXNyKvCfVhc62Iq9oADIhMcLhVS4CjxT2veTIYCa/B
    75va60OTeDOXwXDCWQcSWgb3Q/4YXiTYLpeZnkoCeJj4ISOSNQYV474LSHUdtsVJ
    nPa7/0v4Pu4KjMM7b//5p3WB+ZSxg0A/PI/R98mGqWhgzJDnkUy2oiBeNX+QgXkq
    jnG3zQWn2ssUvoJTtmIukjWkljQtfKLcfrgO002UqOiLs8Jr2YLIgibrq3T5/pXo
    S/UjDVbGDdVt0pRwcEKLqdX9veFoH2GxEkg4fZKu8KAujNVKtctiMK8ltd7zBsf4
    RWbuE8tuoCMeKC9imN6nKMlabmJQJPILRo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526924396; bh=
    9rhP+SBTJKYZQwnXuWJRqgoiY6nE2FKnofx2K1B2O9Q=; b=P+6jw4/H1LpHF3H+
    NnWwatJL5uD65/21faA/t0UoGcTJ6V9oNMJ5Ch1Gr7ouhgMr04ND9a0FLJjmbxD9
    yh7w73IVKXikHVh+5FXNGPvo4HDJhjVw5I/Rgv00ZN57/Vl7IX9t6HsQNH6WCR+E
    KJZIThXfvwUCWP7Ub4N4JtjmoaT54QQaSG/bC6SOqgCp/e5EySit8egN9njGGbDl
    sF7JC188FLqqRoOFVNPE+REqmalxp4TobMqtatP+xrHBvrCqsBdsgLQp2Zi8JMhU
    fW/f5syBkMA0mIyytit6nzw7GLPFBjgdC8XIiH2OGdNZSt7DO8p3ZgCzIa9zxAsM
    0skqpA==
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
X-CM-Envelope: MS4wfID7sp3wlqkUlXTHIkYu7WjKTLyqrPFhEaHO86z+US398zZpKI/Ncj6skGYpAEFNZG9lACf8ZJuYILOF3sjU5KC1Q6bk9ZQwfBwobDrmuEKnP5qBlJqD
    kg6PRSXtNOnpjQ2QcxUuLDZ0JnmcrOpxrVrBgSYqIdQGLovLf725G7v1rb/vk56bpuA0XQzZJ6Xy/B0nSx8K0Hg7DRA4SuHNTmjUIH0VnDLP3l9OTJ32pvXA
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=eJfxgxciAAAA:8
    a=gvl4HP8tAAAA:8 a=te1EGT4yAAAA:8 a=ylgZzIc2wjLLKePqvRYA:9
    a=GHhuhJD2cWfZ6DM7:21 a=pQzatsU9TKPWbW5S:21 a=8zTCMO8O4RsA:10
    a=xM9caqqi1sUkTy8OJ5Uh:22 a=tRkgsvjveJ3YVe9fnr1q:22 a=RRElR4r2U1jGY2dU47NL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbeEURjy (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 13:39:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45446 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753310AbeEURhU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 May 2018 13:37:20 -0400
From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
To: viro@ZenIV.linux.org.uk
Cc: jra@google.com, tytso@mit.edu, olaf@sgi.com,
        darrick.wong@oracle.com, kernel@lists.collabora.co.uk,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com, jack@suse.cz,
        linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: [PATCH v2 12/15] nls: utf8norm: Introduce code for UTF-8 normalization
Date: Mon, 21 May 2018 14:36:14 -0300
Message-Id: <20180521173617.31625-13-krisman@collabora.co.uk>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521173617.31625-1-krisman@collabora.co.uk>
References: <20180521173617.31625-1-krisman@collabora.co.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Olaf Weber <olaf@sgi.com>

Supporting functions for UTF-8 normalization are in utf8norm.c with the
header utf8norm.h. Two normalization forms are supported: nfkdi and
nfkdicf.

  nfkdi:
   - Apply unicode normalization form NFKD.
   - Remove any Default_Ignorable_Code_Point.

  nfkdicf:
   - Apply unicode normalization form NFKD.
   - Remove any Default_Ignorable_Code_Point.
   - Apply a full casefold (C + F).

For the purposes of the code, a string is valid UTF-8 if:

 - The values encoded are 0x1..0x10FFFF.
 - The surrogate codepoints 0xD800..0xDFFFF are not encoded.
 - The shortest possible encoding is used for all values.

The supporting functions work on null-terminated strings (utf8 prefix)
and on length-limited strings (utf8n prefix).

>From the original SGI patch and for conformity with coding standards,
the utf8data_t typedef was dropped, since it was just masking the struct
keyword.  On other occasions, namely utf8leaf_t and utf8trie_t, I
decided to keep it, since they are simple pointers to memory buffers,
and using uchars here wouldn't provide any more meaningful information.

Changes since RFC v2:
  - Merge to NLS system

Changes since RFC v1:
  - utf8_version_is_supported receives maj, min and rev as separate
  arguments. (Olaf Weber)

Signed-off-by: Olaf Weber <olaf@sgi.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
  [Rebase to Mainline]
  [Fix up checkpatch.pl warnings]
  [Drop typedefs]
  [Merge with NLS subsystem]
---
 fs/nls/Makefile         |   4 +
 fs/nls/nls_utf8n-norm.c | 640 ++++++++++++++++++++++++++++++++++++++++
 fs/nls/utf8n.h          | 112 +++++++
 3 files changed, 756 insertions(+)
 create mode 100644 fs/nls/nls_utf8n-norm.c
 create mode 100644 fs/nls/utf8n.h

diff --git a/fs/nls/Makefile b/fs/nls/Makefile
index 9eff2f058c7a..6ff62c0fe436 100644
--- a/fs/nls/Makefile
+++ b/fs/nls/Makefile
@@ -56,6 +56,10 @@ obj-$(CONFIG_NLS_MAC_ROMANIAN)  += mac-romanian.o
 obj-$(CONFIG_NLS_MAC_ROMAN)     += mac-roman.o
 obj-$(CONFIG_NLS_MAC_TURKISH)   += mac-turkish.o
 
+nls_utf8n-y += nls_utf8n-norm.o
+obj-$(CONFIG_NLS_UTF8_NORMALIZATION) += nls_utf8n.o
+
+$(obj)/nls_utf8n-norm.o: $(obj)/utf8data.h
 $(obj)/utf8data.h: $(srctree)/$(src)/ucd/*.txt $(objtree)/scripts/mkutf8data FORCE
 	$(call cmd,mkutf8data)
 quiet_cmd_mkutf8data = MKUTF8DATA $@
diff --git a/fs/nls/nls_utf8n-norm.c b/fs/nls/nls_utf8n-norm.c
new file mode 100644
index 000000000000..ca0bbf644b49
--- /dev/null
+++ b/fs/nls/nls_utf8n-norm.c
@@ -0,0 +1,640 @@
+/*
+ * Copyright (c) 2014 SGI.
+ * All rights reserved.
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
+#include "utf8n.h"
+
+struct utf8data {
+	unsigned int maxage;
+	unsigned int offset;
+};
+
+#define __INCLUDED_FROM_UTF8NORM_C__
+#include "utf8data.h"
+#undef __INCLUDED_FROM_UTF8NORM_C__
+
+int utf8version_is_supported(u8 maj, u8 min, u8 rev)
+{
+	int i = ARRAY_SIZE(utf8agetab) - 1;
+	unsigned int sb_utf8version = UNICODE_AGE(maj, min, rev);
+
+	while (i >= 0 && utf8agetab[i] != 0) {
+		if (sb_utf8version == utf8agetab[i])
+			return 1;
+		i--;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(utf8version_is_supported);
+
+/*
+ * UTF-8 valid ranges.
+ *
+ * The UTF-8 encoding spreads the bits of a 32bit word over several
+ * bytes. This table gives the ranges that can be held and how they'd
+ * be represented.
+ *
+ * 0x00000000 0x0000007F: 0xxxxxxx
+ * 0x00000000 0x000007FF: 110xxxxx 10xxxxxx
+ * 0x00000000 0x0000FFFF: 1110xxxx 10xxxxxx 10xxxxxx
+ * 0x00000000 0x001FFFFF: 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
+ * 0x00000000 0x03FFFFFF: 111110xx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
+ * 0x00000000 0x7FFFFFFF: 1111110x 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
+ *
+ * There is an additional requirement on UTF-8, in that only the
+ * shortest representation of a 32bit value is to be used.  A decoder
+ * must not decode sequences that do not satisfy this requirement.
+ * Thus the allowed ranges have a lower bound.
+ *
+ * 0x00000000 0x0000007F: 0xxxxxxx
+ * 0x00000080 0x000007FF: 110xxxxx 10xxxxxx
+ * 0x00000800 0x0000FFFF: 1110xxxx 10xxxxxx 10xxxxxx
+ * 0x00010000 0x001FFFFF: 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
+ * 0x00200000 0x03FFFFFF: 111110xx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
+ * 0x04000000 0x7FFFFFFF: 1111110x 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
+ *
+ * Actual unicode characters are limited to the range 0x0 - 0x10FFFF,
+ * 17 planes of 65536 values.  This limits the sequences actually seen
+ * even more, to just the following.
+ *
+ *          0 -     0x7F: 0                   - 0x7F
+ *       0x80 -    0x7FF: 0xC2 0x80           - 0xDF 0xBF
+ *      0x800 -   0xFFFF: 0xE0 0xA0 0x80      - 0xEF 0xBF 0xBF
+ *    0x10000 - 0x10FFFF: 0xF0 0x90 0x80 0x80 - 0xF4 0x8F 0xBF 0xBF
+ *
+ * Within those ranges the surrogates 0xD800 - 0xDFFF are not allowed.
+ *
+ * Note that the longest sequence seen with valid usage is 4 bytes,
+ * the same a single UTF-32 character.  This makes the UTF-8
+ * representation of Unicode strictly smaller than UTF-32.
+ *
+ * The shortest sequence requirement was introduced by:
+ *    Corrigendum #1: UTF-8 Shortest Form
+ * It can be found here:
+ *    http://www.unicode.org/versions/corrigendum1.html
+ *
+ */
+
+/*
+ * Return the number of bytes used by the current UTF-8 sequence.
+ * Assumes the input points to the first byte of a valid UTF-8
+ * sequence.
+ */
+static inline int utf8clen(const char *s)
+{
+	unsigned char c = *s;
+
+	return 1 + (c >= 0xC0) + (c >= 0xE0) + (c >= 0xF0);
+}
+
+/*
+ * utf8trie_t
+ *
+ * A compact binary tree, used to decode UTF-8 characters.
+ *
+ * Internal nodes are one byte for the node itself, and up to three
+ * bytes for an offset into the tree.  The first byte contains the
+ * following information:
+ *  NEXTBYTE  - flag        - advance to next byte if set
+ *  BITNUM    - 3 bit field - the bit number to tested
+ *  OFFLEN    - 2 bit field - number of bytes in the offset
+ * if offlen == 0 (non-branching node)
+ *  RIGHTPATH - 1 bit field - set if the following node is for the
+ *                            right-hand path (tested bit is set)
+ *  TRIENODE  - 1 bit field - set if the following node is an internal
+ *                            node, otherwise it is a leaf node
+ * if offlen != 0 (branching node)
+ *  LEFTNODE  - 1 bit field - set if the left-hand node is internal
+ *  RIGHTNODE - 1 bit field - set if the right-hand node is internal
+ *
+ * Due to the way utf8 works, there cannot be branching nodes with
+ * NEXTBYTE set, and moreover those nodes always have a righthand
+ * descendant.
+ */
+typedef const unsigned char utf8trie_t;
+#define BITNUM		0x07
+#define NEXTBYTE	0x08
+#define OFFLEN		0x30
+#define OFFLEN_SHIFT	4
+#define RIGHTPATH	0x40
+#define TRIENODE	0x80
+#define RIGHTNODE	0x40
+#define LEFTNODE	0x80
+
+/*
+ * utf8leaf_t
+ *
+ * The leaves of the trie are embedded in the trie, and so the same
+ * underlying datatype: unsigned char.
+ *
+ * leaf[0]: The unicode version, stored as a generation number that is
+ *          an index into utf8agetab[].  With this we can filter code
+ *          points based on the unicode version in which they were
+ *          defined.  The CCC of a non-defined code point is 0.
+ * leaf[1]: Canonical Combining Class. During normalization, we need
+ *          to do a stable sort into ascending order of all characters
+ *          with a non-zero CCC that occur between two characters with
+ *          a CCC of 0, or at the begin or end of a string.
+ *          The unicode standard guarantees that all CCC values are
+ *          between 0 and 254 inclusive, which leaves 255 available as
+ *          a special value.
+ *          Code points with CCC 0 are known as stoppers.
+ * leaf[2]: Decomposition. If leaf[1] == 255, then leaf[2] is the
+ *          start of a NUL-terminated string that is the decomposition
+ *          of the character.
+ *          The CCC of a decomposable character is the same as the CCC
+ *          of the first character of its decomposition.
+ *          Some characters decompose as the empty string: these are
+ *          characters with the Default_Ignorable_Code_Point property.
+ *          These do affect normalization, as they all have CCC 0.
+ *
+ * The decompositions in the trie have been fully expanded.
+ *
+ * Casefolding, if applicable, is also done using decompositions.
+ *
+ * The trie is constructed in such a way that leaves exist for all
+ * UTF-8 sequences that match the criteria from the "UTF-8 valid
+ * ranges" comment above, and only for those sequences.  Therefore a
+ * lookup in the trie can be used to validate the UTF-8 input.
+ */
+typedef const unsigned char utf8leaf_t;
+
+#define LEAF_GEN(LEAF)	((LEAF)[0])
+#define LEAF_CCC(LEAF)	((LEAF)[1])
+#define LEAF_STR(LEAF)	((const char *)((LEAF) + 2))
+
+#define MINCCC		(0)
+#define MAXCCC		(254)
+#define STOPPER		(0)
+#define	DECOMPOSE	(255)
+
+/*
+ * Use trie to scan s, touching at most len bytes.
+ * Returns the leaf if one exists, NULL otherwise.
+ *
+ * A non-NULL return guarantees that the UTF-8 sequence starting at s
+ * is well-formed and corresponds to a known unicode code point.  The
+ * shorthand for this will be "is valid UTF-8 unicode".
+ */
+static utf8leaf_t *utf8nlookup(const struct utf8data *data, const char *s,
+			       size_t len)
+{
+	utf8trie_t	*trie = utf8data + data->offset;
+	int		offlen;
+	int		offset;
+	int		mask;
+	int		node;
+
+	if (!data)
+		return NULL;
+	if (len == 0)
+		return NULL;
+	node = 1;
+	while (node) {
+		offlen = (*trie & OFFLEN) >> OFFLEN_SHIFT;
+		if (*trie & NEXTBYTE) {
+			if (--len == 0)
+				return NULL;
+			s++;
+		}
+		mask = 1 << (*trie & BITNUM);
+		if (*s & mask) {
+			/* Right leg */
+			if (offlen) {
+				/* Right node at offset of trie */
+				node = (*trie & RIGHTNODE);
+				offset = trie[offlen];
+				while (--offlen) {
+					offset <<= 8;
+					offset |= trie[offlen];
+				}
+				trie += offset;
+			} else if (*trie & RIGHTPATH) {
+				/* Right node after this node */
+				node = (*trie & TRIENODE);
+				trie++;
+			} else {
+				/* No right node. */
+				node = 0;
+				trie = NULL;
+			}
+		} else {
+			/* Left leg */
+			if (offlen) {
+				/* Left node after this node. */
+				node = (*trie & LEFTNODE);
+				trie += offlen + 1;
+			} else if (*trie & RIGHTPATH) {
+				/* No left node. */
+				node = 0;
+				trie = NULL;
+			} else {
+				/* Left node after this node */
+				node = (*trie & TRIENODE);
+				trie++;
+			}
+		}
+	}
+	return trie;
+}
+
+/*
+ * Use trie to scan s.
+ * Returns the leaf if one exists, NULL otherwise.
+ *
+ * Forwards to utf8nlookup().
+ */
+static utf8leaf_t *utf8lookup(const struct utf8data *data, const char *s)
+{
+	return utf8nlookup(data, s, (size_t)-1);
+}
+
+/*
+ * Maximum age of any character in s.
+ * Return -1 if s is not valid UTF-8 unicode.
+ * Return 0 if only non-assigned code points are used.
+ */
+int utf8agemax(const struct utf8data *data, const char *s)
+{
+	utf8leaf_t	*leaf;
+	int		age = 0;
+	int		leaf_age;
+
+	if (!data)
+		return -1;
+	while (*s) {
+		leaf = utf8lookup(data, s);
+		if (!leaf)
+			return -1;
+
+		leaf_age = utf8agetab[LEAF_GEN(leaf)];
+		if (leaf_age <= data->maxage && leaf_age > age)
+			age = leaf_age;
+		s += utf8clen(s);
+	}
+	return age;
+}
+EXPORT_SYMBOL(utf8agemax);
+
+/*
+ * Minimum age of any character in s.
+ * Return -1 if s is not valid UTF-8 unicode.
+ * Return 0 if non-assigned code points are used.
+ */
+int utf8agemin(const struct utf8data *data, const char *s)
+{
+	utf8leaf_t	*leaf;
+	int		age;
+	int		leaf_age;
+
+	if (!data)
+		return -1;
+	age = data->maxage;
+	while (*s) {
+		leaf = utf8lookup(data, s);
+		if (!leaf)
+			return -1;
+		leaf_age = utf8agetab[LEAF_GEN(leaf)];
+		if (leaf_age <= data->maxage && leaf_age < age)
+			age = leaf_age;
+		s += utf8clen(s);
+	}
+	return age;
+}
+EXPORT_SYMBOL(utf8agemin);
+
+/*
+ * Maximum age of any character in s, touch at most len bytes.
+ * Return -1 if s is not valid UTF-8 unicode.
+ */
+int utf8nagemax(const struct utf8data *data, const char *s, size_t len)
+{
+	utf8leaf_t	*leaf;
+	int		age = 0;
+	int		leaf_age;
+
+	if (!data)
+		return -1;
+	while (len && *s) {
+		leaf = utf8nlookup(data, s, len);
+		if (!leaf)
+			return -1;
+		leaf_age = utf8agetab[LEAF_GEN(leaf)];
+		if (leaf_age <= data->maxage && leaf_age > age)
+			age = leaf_age;
+		len -= utf8clen(s);
+		s += utf8clen(s);
+	}
+	return age;
+}
+EXPORT_SYMBOL(utf8nagemax);
+
+/*
+ * Maximum age of any character in s, touch at most len bytes.
+ * Return -1 if s is not valid UTF-8 unicode.
+ */
+int utf8nagemin(const struct utf8data *data, const char *s, size_t len)
+{
+	utf8leaf_t	*leaf;
+	int		leaf_age;
+	int		age;
+
+	if (!data)
+		return -1;
+	age = data->maxage;
+	while (len && *s) {
+		leaf = utf8nlookup(data, s, len);
+		if (!leaf)
+			return -1;
+		leaf_age = utf8agetab[LEAF_GEN(leaf)];
+		if (leaf_age <= data->maxage && leaf_age < age)
+			age = leaf_age;
+		len -= utf8clen(s);
+		s += utf8clen(s);
+	}
+	return age;
+}
+EXPORT_SYMBOL(utf8nagemin);
+
+/*
+ * Length of the normalization of s.
+ * Return -1 if s is not valid UTF-8 unicode.
+ *
+ * A string of Default_Ignorable_Code_Point has length 0.
+ */
+ssize_t utf8len(const struct utf8data *data, const char *s)
+{
+	utf8leaf_t	*leaf;
+	size_t		ret = 0;
+
+	if (!data)
+		return -1;
+	while (*s) {
+		leaf = utf8lookup(data, s);
+		if (!leaf)
+			return -1;
+		if (utf8agetab[LEAF_GEN(leaf)] > data->maxage)
+			ret += utf8clen(s);
+		else if (LEAF_CCC(leaf) == DECOMPOSE)
+			ret += strlen(LEAF_STR(leaf));
+		else
+			ret += utf8clen(s);
+		s += utf8clen(s);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(utf8len);
+
+/*
+ * Length of the normalization of s, touch at most len bytes.
+ * Return -1 if s is not valid UTF-8 unicode.
+ */
+ssize_t utf8nlen(const struct utf8data *data, const char *s, size_t len)
+{
+	utf8leaf_t	*leaf;
+	size_t		ret = 0;
+
+	if (!data)
+		return -1;
+	while (len && *s) {
+		leaf = utf8nlookup(data, s, len);
+		if (!leaf)
+			return -1;
+		if (utf8agetab[LEAF_GEN(leaf)] > data->maxage)
+			ret += utf8clen(s);
+		else if (LEAF_CCC(leaf) == DECOMPOSE)
+			ret += strlen(LEAF_STR(leaf));
+		else
+			ret += utf8clen(s);
+		len -= utf8clen(s);
+		s += utf8clen(s);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(utf8nlen);
+
+/*
+ * Set up an utf8cursor for use by utf8byte().
+ *
+ *   u8c    : pointer to cursor.
+ *   data   : const struct utf8data to use for normalization.
+ *   s      : string.
+ *   len    : length of s.
+ *
+ * Returns -1 on error, 0 on success.
+ */
+int utf8ncursor(struct utf8cursor *u8c, const struct utf8data *data,
+		const char *s, size_t len)
+{
+	if (!data)
+		return -1;
+	if (!s)
+		return -1;
+	u8c->data = data;
+	u8c->s = s;
+	u8c->p = NULL;
+	u8c->ss = NULL;
+	u8c->sp = NULL;
+	u8c->len = len;
+	u8c->slen = 0;
+	u8c->ccc = STOPPER;
+	u8c->nccc = STOPPER;
+	/* Check we didn't clobber the maximum length. */
+	if (u8c->len != len)
+		return -1;
+	/* The first byte of s may not be an utf8 continuation. */
+	if (len > 0 && (*s & 0xC0) == 0x80)
+		return -1;
+	return 0;
+}
+EXPORT_SYMBOL(utf8ncursor);
+
+/*
+ * Set up an utf8cursor for use by utf8byte().
+ *
+ *   u8c    : pointer to cursor.
+ *   data   : const struct utf8data to use for normalization.
+ *   s      : NUL-terminated string.
+ *
+ * Returns -1 on error, 0 on success.
+ */
+int utf8cursor(struct utf8cursor *u8c, const struct utf8data *data,
+	       const char *s)
+{
+	return utf8ncursor(u8c, data, s, (unsigned int)-1);
+}
+EXPORT_SYMBOL(utf8cursor);
+
+/*
+ * Get one byte from the normalized form of the string described by u8c.
+ *
+ * Returns the byte cast to an unsigned char on succes, and -1 on failure.
+ *
+ * The cursor keeps track of the location in the string in u8c->s.
+ * When a character is decomposed, the current location is stored in
+ * u8c->p, and u8c->s is set to the start of the decomposition. Note
+ * that bytes from a decomposition do not count against u8c->len.
+ *
+ * Characters are emitted if they match the current CCC in u8c->ccc.
+ * Hitting end-of-string while u8c->ccc == STOPPER means we're done,
+ * and the function returns 0 in that case.
+ *
+ * Sorting by CCC is done by repeatedly scanning the string.  The
+ * values of u8c->s and u8c->p are stored in u8c->ss and u8c->sp at
+ * the start of the scan.  The first pass finds the lowest CCC to be
+ * emitted and stores it in u8c->nccc, the second pass emits the
+ * characters with this CCC and finds the next lowest CCC. This limits
+ * the number of passes to 1 + the number of different CCCs in the
+ * sequence being scanned.
+ *
+ * Therefore:
+ *  u8c->p  != NULL -> a decomposition is being scanned.
+ *  u8c->ss != NULL -> this is a repeating scan.
+ *  u8c->ccc == -1   -> this is the first scan of a repeating scan.
+ */
+int utf8byte(struct utf8cursor *u8c)
+{
+	utf8leaf_t *leaf;
+	int ccc;
+
+	for (;;) {
+		/* Check for the end of a decomposed character. */
+		if (u8c->p && *u8c->s == '\0') {
+			u8c->s = u8c->p;
+			u8c->p = NULL;
+		}
+
+		/* Check for end-of-string. */
+		if (!u8c->p && (u8c->len == 0 || *u8c->s == '\0')) {
+			/* There is no next byte. */
+			if (u8c->ccc == STOPPER)
+				return 0;
+			/* End-of-string during a scan counts as a stopper. */
+			ccc = STOPPER;
+			goto ccc_mismatch;
+		} else if ((*u8c->s & 0xC0) == 0x80) {
+			/* This is a continuation of the current character. */
+			if (!u8c->p)
+				u8c->len--;
+			return (unsigned char)*u8c->s++;
+		}
+
+		/* Look up the data for the current character. */
+		if (u8c->p)
+			leaf = utf8lookup(u8c->data, u8c->s);
+		else
+			leaf = utf8nlookup(u8c->data, u8c->s, u8c->len);
+
+		/* No leaf found implies that the input is a binary blob. */
+		if (!leaf)
+			return -1;
+
+		ccc = LEAF_CCC(leaf);
+		/* Characters that are too new have CCC 0. */
+		if (utf8agetab[LEAF_GEN(leaf)] > u8c->data->maxage) {
+			ccc = STOPPER;
+		} else if (ccc == DECOMPOSE) {
+			u8c->len -= utf8clen(u8c->s);
+			u8c->p = u8c->s + utf8clen(u8c->s);
+			u8c->s = LEAF_STR(leaf);
+			/* Empty decomposition implies CCC 0. */
+			if (*u8c->s == '\0') {
+				if (u8c->ccc == STOPPER)
+					continue;
+				ccc = STOPPER;
+				goto ccc_mismatch;
+			}
+			leaf = utf8lookup(u8c->data, u8c->s);
+		}
+
+		/*
+		 * If this is not a stopper, then see if it updates
+		 * the next canonical class to be emitted.
+		 */
+		if (ccc != STOPPER && u8c->ccc < ccc && ccc < u8c->nccc)
+			u8c->nccc = ccc;
+
+		/*
+		 * Return the current byte if this is the current
+		 * combining class.
+		 */
+		if (ccc == u8c->ccc) {
+			if (!u8c->p)
+				u8c->len--;
+			return (unsigned char)*u8c->s++;
+		}
+
+		/* Current combining class mismatch. */
+ccc_mismatch:
+		if (u8c->nccc == STOPPER) {
+			/*
+			 * Scan forward for the first canonical class
+			 * to be emitted.  Save the position from
+			 * which to restart.
+			 */
+			u8c->ccc = MINCCC - 1;
+			u8c->nccc = ccc;
+			u8c->sp = u8c->p;
+			u8c->ss = u8c->s;
+			u8c->slen = u8c->len;
+			if (!u8c->p)
+				u8c->len -= utf8clen(u8c->s);
+			u8c->s += utf8clen(u8c->s);
+		} else if (ccc != STOPPER) {
+			/* Not a stopper, and not the ccc we're emitting. */
+			if (!u8c->p)
+				u8c->len -= utf8clen(u8c->s);
+			u8c->s += utf8clen(u8c->s);
+		} else if (u8c->nccc != MAXCCC + 1) {
+			/* At a stopper, restart for next ccc. */
+			u8c->ccc = u8c->nccc;
+			u8c->nccc = MAXCCC + 1;
+			u8c->s = u8c->ss;
+			u8c->p = u8c->sp;
+			u8c->len = u8c->slen;
+		} else {
+			/* All done, proceed from here. */
+			u8c->ccc = STOPPER;
+			u8c->nccc = STOPPER;
+			u8c->sp = NULL;
+			u8c->ss = NULL;
+			u8c->slen = 0;
+		}
+	}
+}
+EXPORT_SYMBOL(utf8byte);
+
+const struct utf8data *utf8nfkdi(unsigned int maxage)
+{
+	int i = ARRAY_SIZE(utf8nfkdidata) - 1;
+
+	while (maxage < utf8nfkdidata[i].maxage)
+		i--;
+	if (maxage > utf8nfkdidata[i].maxage)
+		return NULL;
+	return &utf8nfkdidata[i];
+}
+EXPORT_SYMBOL(utf8nfkdi);
+
+const struct utf8data *utf8nfkdicf(unsigned int maxage)
+{
+	int i = ARRAY_SIZE(utf8nfkdicfdata) - 1;
+
+	while (maxage < utf8nfkdicfdata[i].maxage)
+		i--;
+	if (maxage > utf8nfkdicfdata[i].maxage)
+		return NULL;
+	return &utf8nfkdicfdata[i];
+}
+EXPORT_SYMBOL(utf8nfkdicf);
diff --git a/fs/nls/utf8n.h b/fs/nls/utf8n.h
new file mode 100644
index 000000000000..0f5fc14d4fd2
--- /dev/null
+++ b/fs/nls/utf8n.h
@@ -0,0 +1,112 @@
+/*
+ * Copyright (c) 2014 SGI.
+ * All rights reserved.
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
+#ifndef UTF8NORM_H
+#define UTF8NORM_H
+
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/string.h>
+#include <linux/module.h>
+
+/* Encoding a unicode version number as a single unsigned int. */
+#define UNICODE_MAJ_SHIFT		(16)
+#define UNICODE_MIN_SHIFT		(8)
+
+#define UNICODE_AGE(MAJ, MIN, REV)			\
+	(((unsigned int)(MAJ) << UNICODE_MAJ_SHIFT) |	\
+	 ((unsigned int)(MIN) << UNICODE_MIN_SHIFT) |	\
+	 ((unsigned int)(REV)))
+
+/* Highest unicode version supported by the data tables. */
+extern int utf8version_is_supported(u8 maj, u8 min, u8 rev);
+
+/*
+ * Look for the correct const struct utf8data for a unicode version.
+ * Returns NULL if the version requested is too new.
+ *
+ * Two normalization forms are supported: nfkdi and nfkdicf.
+ *
+ * nfkdi:
+ *  - Apply unicode normalization form NFKD.
+ *  - Remove any Default_Ignorable_Code_Point.
+ *
+ * nfkdicf:
+ *  - Apply unicode normalization form NFKD.
+ *  - Remove any Default_Ignorable_Code_Point.
+ *  - Apply a full casefold (C + F).
+ */
+extern const struct utf8data *utf8nfkdi(unsigned int maxage);
+extern const struct utf8data *utf8nfkdicf(unsigned int maxage);
+
+/*
+ * Determine the maximum age of any unicode character in the string.
+ * Returns 0 if only unassigned code points are present.
+ * Returns -1 if the input is not valid UTF-8.
+ */
+extern int utf8agemax(const struct utf8data *data, const char *s);
+extern int utf8nagemax(const struct utf8data *data, const char *s, size_t len);
+
+/*
+ * Determine the minimum age of any unicode character in the string.
+ * Returns 0 if any unassigned code points are present.
+ * Returns -1 if the input is not valid UTF-8.
+ */
+extern int utf8agemin(const struct utf8data *data, const char *s);
+extern int utf8nagemin(const struct utf8data *data, const char *s, size_t len);
+
+/*
+ * Determine the length of the normalized from of the string,
+ * excluding any terminating NULL byte.
+ * Returns 0 if only ignorable code points are present.
+ * Returns -1 if the input is not valid UTF-8.
+ */
+extern ssize_t utf8len(const struct utf8data *data, const char *s);
+extern ssize_t utf8nlen(const struct utf8data *data, const char *s, size_t len);
+
+/*
+ * Cursor structure used by the normalizer.
+ */
+struct utf8cursor {
+	const struct utf8data	*data;
+	const char	*s;
+	const char	*p;
+	const char	*ss;
+	const char	*sp;
+	unsigned int	len;
+	unsigned int	slen;
+	short int	ccc;
+	short int	nccc;
+};
+
+/*
+ * Initialize a utf8cursor to normalize a string.
+ * Returns 0 on success.
+ * Returns -1 on failure.
+ */
+extern int utf8cursor(struct utf8cursor *u8c, const struct utf8data *data,
+		      const char *s);
+extern int utf8ncursor(struct utf8cursor *u8c, const struct utf8data *data,
+		       const char *s, size_t len);
+
+/*
+ * Get the next byte in the normalization.
+ * Returns a value > 0 && < 256 on success.
+ * Returns 0 when the end of the normalization is reached.
+ * Returns -1 if the string being normalized is not valid UTF-8.
+ */
+extern int utf8byte(struct utf8cursor *u8c);
+
+#endif /* UTF8NORM_H */
-- 
2.17.0
