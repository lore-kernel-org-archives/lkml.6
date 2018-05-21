Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1090829-1526924330-2-7395866270724189151
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526924330; b=ZacsHVpLtZPYkpBGqcknqF2QC7z59bje7Y4lF8gjWiJOREX6GN
    A19M8x7umE+gc+4xrqsIHEh3MfmDxNWBCJYyfmmaoqMQkMReaRiaDMFjcibf+8T5
    m5Ttn+9DDdIQFpBh5O9M4U3+Itw7RGe5r6NQpcIZO+D0Oac8BmnBr71XPBRALF+r
    qWxU2W1PyuMnjnW/oCzDvlSKHXWTzmmj1UeHRkH2bq3lUqz5bMx9hIk8kPAB8rX/
    LIwfp99VHKfXiO2mtbGOzGDxmrZjuqr8yeDceRVgs2T5N9r0sDIf+/kbs+qg1xDu
    jwaDwtNHg/g+6SFqmbfJWAVKoIzz+stHPyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526924330; bh=
    Ri8OfKFGPSZI4aAnvvLfDBES7Xz7blRu/lt3o/nDYR4=; b=V1j6PJ0KtR31JYTF
    c1t32EI0/DmdCau9DlAAz1y35bWK8MhVrL9xE2dhX+gQ3wKOSCCasCG2oHpzkzd+
    N3vVRCVmL42ejJ7ZWDW42Dlp7k5ZlKdnSMDwhkUf+LPZe7bLneHqdmRPOCJEeLBE
    +0Fn8WM4jvYdlDtI/gtOhOMEMsgwi0p5LLBjoCKM4yeqSWl5us6MWcVwI4DWSQ+8
    iqXvDNnBuNCZ4UAuuJpv2Gtkhdp8GFcHLyW6s6dFm9o28XdohJdEKSKN30h4mEUP
    fyIYHacz6yZU4ai/DbdplMS024laYeLgOtJKujqx6Bf0i6wqL21sDelaXFMtu7U4
    nMj2Gg==
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
X-CM-Envelope: MS4wfAbmgcCrFf+ZCqgqSKxrsgsypKWe0aeD1sErjtnsRcz/Q3upDdqg9hGvM+DhpX014xdRRgWCw6EKMQNdK2KnwvOCx8nUmfh16kToLEae/hJIwINLUVoI
    kfk01g6xdEwoO9aNKIRvpVl48pH+wTq4Zfy4AEqME8IzcWqG33LzjAVV7fyABnDPAHjItbX2/93T5ziL/0hCJDF8XoQMEtD8TVwwUdmOoDu98j3xnHD0gmIE
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=gvl4HP8tAAAA:8
    a=cB4x_MgwbXJPB_XIh0oA:9 a=vuHTdfj5eMjVIoR3:21 a=NhMaoaTJU3GiQ-p4:21
    a=tRkgsvjveJ3YVe9fnr1q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753240AbeEURiq (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 13:38:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45366 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753683AbeEURgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 May 2018 13:36:46 -0400
From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
To: viro@ZenIV.linux.org.uk
Cc: jra@google.com, tytso@mit.edu, olaf@sgi.com,
        darrick.wong@oracle.com, kernel@lists.collabora.co.uk,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com, jack@suse.cz,
        linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: [PATCH v2 07/15] nls: Add new interface for string comparisons
Date: Mon, 21 May 2018 14:36:09 -0300
Message-Id: <20180521173617.31625-8-krisman@collabora.co.uk>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521173617.31625-1-krisman@collabora.co.uk>
References: <20180521173617.31625-1-krisman@collabora.co.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The existing stricmp() interface is limited by not accepting separated
length parameters for each string being compared.  This is a problem for
charsets doing normalization or full casefold comparison, since
different sized strings can still be matched.  To resolve this problem,
this patch implements a new interface, allowing charsets to do the
comparison, if needed.

The original stricmp is left in the code, while all callers are not
converted, but was rewritten the new interface.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
---
 include/linux/nls.h | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/linux/nls.h b/include/linux/nls.h
index 3766fbe6efc3..1a653b866a64 100644
--- a/include/linux/nls.h
+++ b/include/linux/nls.h
@@ -3,6 +3,7 @@
 #define _LINUX_NLS_H
 
 #include <linux/init.h>
+#include <linux/string.h>
 
 /* Unicode has changed over the years.  Unicode code points no longer
  * fit into 16 bits; as of Unicode 5 valid code points range from 0
@@ -21,11 +22,18 @@ typedef u16 wchar_t;
 
 /* Arbitrary Unicode character */
 typedef u32 unicode_t;
+struct nls_table;
 
 struct nls_ops {
 	int (*uni2char) (wchar_t uni, unsigned char *out, int boundlen);
 	int (*char2uni) (const unsigned char *rawstring, int boundlen,
 			 wchar_t *uni);
+	int (*strncmp)(const struct nls_table *charset,
+		       const unsigned char *str1, size_t len1,
+		       const unsigned char *str2, size_t len2);
+	int (*strncasecmp)(const struct nls_table *charset,
+			   const unsigned char *str1, size_t len1,
+			   const unsigned char *str2, size_t len2);
 };
 
 struct nls_table {
@@ -105,10 +113,17 @@ static inline unsigned char nls_toupper(struct nls_table *t, unsigned char c)
 	return nc ? nc : c;
 }
 
-static inline int nls_strnicmp(struct nls_table *t, const unsigned char *s1,
-		const unsigned char *s2, int len)
+static inline int nls_strncasecmp(struct nls_table *t,
+				  const unsigned char *s1, size_t len1,
+				  const unsigned char *s2, size_t len2)
 {
-	while (len--) {
+	if (t->ops->strncasecmp)
+		return t->ops->strncasecmp(t, s1, len1, s2, len2);
+
+	if (len1 != len2)
+		return 1;
+
+	while (len1--) {
 		if (nls_tolower(t, *s1++) != nls_tolower(t, *s2++))
 			return 1;
 	}
@@ -116,6 +131,27 @@ static inline int nls_strnicmp(struct nls_table *t, const unsigned char *s1,
 	return 0;
 }
 
+static inline int nls_strncmp(struct nls_table *t,
+			      const unsigned char *s1, size_t len1,
+			      const unsigned char *s2, size_t len2)
+{
+	if (t->ops->strncmp)
+		return t->ops->strncmp(t, s1, len1, s2, len2);
+
+	if (len1 != len2)
+		return 1;
+
+	/* strnicmp did not return negative values. So let's keep the
+	 * abi for now */
+	return !!memcmp(s1, s2, len1);
+}
+
+static inline int nls_strnicmp(struct nls_table *t, const unsigned char *s1,
+		const unsigned char *s2, int len)
+{
+	return nls_strncasecmp(t, s1, len, s2, len);
+}
+
 /*
  * nls_nullsize - return length of null character for codepage
  * @codepage - codepage for which to return length of NULL terminator
-- 
2.17.0
