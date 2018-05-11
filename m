Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-316107-1526070326-2-1759107135391654679
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526070325; b=ZsGC6pYg1selfjnl9K2Hy8590denoiWebpE0uSN7KPNbNgmTMI
    UbLlNRBE+1U/keqqhgdzcArM6Tc+guoHD639OKC1WvEcaXnu+zodN5NECD75jTJT
    h1F0N0xr0Lb6h2mVec/F+GlY4+mEH4OinE55ga/cb+g4u7zhKG2YVtpCpm13dHGT
    vy4tSbXrAewXuLhmn/HDc6lCjeZLU7x2dk5BIwadyHgaqlMIlDYcm4j7KTpZabcF
    aPSlvrGBDwZivT4+I5bEwNzIxkh8qhZ3uLjO0tjQ3mpiYrIxhyWxIBf88hGRmbQz
    Ck+SITXpUDzTWl29pOxC0MnD7mlaxNbpx8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526070325;
    bh=367vSNdPv6RLZm4XaoWv9ada1gm7WVLB9NErPO7kRIw=; b=gvsRgCZzj+Nl
    X7vwAkgwQZ6Lxksyi1unuGPewwnarsMkaT0mZ1ADK773tgLw3sU8UgfZVb2kJ1yt
    ecCMBMnRYUWrT8ElO6lXhQhrH7RcdJTEdBd+/q1tx5fm/mkjrai/V1NLOv1pGB6h
    KRkN/06sZYwMgH7qtnw7GmyyArp7XBv/WRKqmbY0CwwqLjCGOWjOSU8saryoYaw5
    Bum7sr2EevhbIhEOfuMUekvIRLkB59QT1/9uO0ZYEQDhZylWgv1Urer4qpCoHrVQ
    sHjMLSl3diZodIMpxjVVmcFvvCFtxd4P75flW0SpEfE6IYeJgTrF3tHG5BYJrz4R
    T9RGmCTmDw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=yahoo.com header.i=@yahoo.com header.b=GvXonRu5 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=schaufler-ca.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=yahoo.com header.i=@yahoo.com header.b=GvXonRu5 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=schaufler-ca.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLX8SyZG+bfYBTfyRoR5E4nxAkwRMyK71UwZUDp11EqNLB8XuwQn7iUpwtMx19JLcYbq24MugiB9mUT7VTEUv2r5M+6hkvBTZf9kf3TSpf8WGQgCwiJw
    wBuzwuvQfDz+0vReAtvEz7LMEXOHO/1niQRT5NuJWxYENjT4+wtVUzrABR+X5rAElp4XXzc+RPb+kEt9T76QtjCJwv/LOBr9AKyMf2HUPWo+GdohbF/l3FYQ
    YpJjY+IXwXsgywcRQfUJ+g==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=5HJ6KZJP-kkA:10
    a=VUJBJC2UJ8kA:10 a=qVXew_AoqLkA:10 a=3NGxsLzzGfgA:10 a=ZZnuYtJkoWoA:10
    a=vpqfxihKAAAA:8 a=VwQbUJbxAAAA:8 a=UgV29h08mzeG0Ji0h3EA:9
    a=piSucLzhK4WshZaX:21 a=15GvobKJ8ZoqxqrE:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AULIiLoY-XQsE5F6gcqX:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750798AbeEKUZW (ORCPT <rfc822;linux@kroah.com>);
        Fri, 11 May 2018 16:25:22 -0400
Received: from sonic313-17.consmr.mail.ne1.yahoo.com ([66.163.185.40]:46132
        "EHLO sonic313-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750711AbeEKUZV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 May 2018 16:25:21 -0400
X-YMail-OSG: nXVfdSkVM1lSVNUo.s04dM6x27bSGGgl69Nzh9ea6tlDM0NVHrDrbmnv8zMT9ou
 7NSrIfmB5O6xOmBXad2rcenHptsdqNJuHYghwqOj.2iDi4Pm3XCPixGBYvzcepRXukNHL5MAGcs9
 AXo.YgfAE.tfFB2vz_07939opsnPkBkUh3QTYZ9fBqWC2wNxAealFDO8KhX9JMfqgn6UbyvCoBiG
 YIcm9OLGonpi9NeLUp7iMHvaA4Hc6zA5b2.ZWjQZQKlk9KccKic88RwJTnWc4VKMcMTxHNMuEqv2
 uUxK6azRswcrSb5ZJFvsZuDvWWQUHyTLIht6bkWO4ObxdeKUurdRuYDxfUhdqmT8_.kkqptPbe6T
 4ZNd_Eur3PIqX9VjZZ4xK40X3g5M1_lrSXuYROgBd8oItv0isVRHCMxrPmc5k5CeSxWokBBONTlX
 uUX6wmfq3IaNtF.qx1P0ubiOpcjNmgn8S4qqk6Qa4RYOhLYlL9hQzgAeCxLxVShTcdXmX4cHPdo2
 jYNNQsm.Ds4ZimwjLGKdBlq6Pno.DVELR0989gJiJnbYtfST6F.QHnaGVIEZneX71wlxo64fIwgs
 0PfuZ0a08K._q55iZp1K41tyfUu3Oe0bD_io7unFwXz3418S3YXB1oDGyyYH5DQ0tms68gBptJmC
 fj1Y-
Subject: [PATCH 24/23] LSM: Functions for dealing with struct secids
To: LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e9e6a58e-e5f2-381d-fb5b-11178239cc48@schaufler-ca.com>
Date: Fri, 11 May 2018 13:25:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Fri, 11 May 2018 13:18:11 -0700
Subject: [PATCH 24/23] LSM: Functions for deling with struct secids

These are the functions that mainipulate the collection
of secids.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/stacking.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 security/stacking.c

diff --git a/security/stacking.c b/security/stacking.c
new file mode 100644
index 000000000000..7c9643323a1e
--- /dev/null
+++ b/security/stacking.c
@@ -0,0 +1,119 @@
+/*
+ * Security secid functions
+ *
+ * Copyright (C) 2018 Casey Schaufler <casey@schaufler-ca.com>
+ * Copyright (C) 2018 Intel
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License, or
+ *	(at your option) any later version.
+ */
+#include <linux/security.h>
+#include <linux/skbuff.h>
+#include <net/sock.h>
+#include <net/netlabel.h>
+
+/*
+ * A secids structure contains all of the modules specific
+ * secids and the secmark used to represent the combination
+ * of module specific secids. Code that uses secmarks won't
+ * know or care about module specific secids, and won't have
+ * set them in the secids nor will it look at the module specific
+ * values. Modules won't care about the secmark. If there's only
+ * one module that uses secids the mapping is one-to-one. The
+ * general case is not so simple.
+ */
+
+void secid_from_skb(struct secids *secid, const struct sk_buff *skb)
+{
+	struct secids *se;
+
+	se = skb->sk->sk_security;
+	if (se)
+		*secid = *se;
+}
+EXPORT_SYMBOL(secid_from_skb);
+
+void secid_to_skb(struct secids *secid, struct sk_buff *skb)
+{
+	struct secids *se;
+
+	se = skb->sk->sk_security;
+	if (se)
+		*se = *secid;
+}
+EXPORT_SYMBOL(secid_to_skb);
+
+bool secid_valid(const struct secids *secid)
+{
+#ifdef CONFIG_SECURITY_SELINUX
+	if (secid->selinux)
+		return true;
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	if (secid->smack)
+		return true;
+#endif
+	return false;
+}
+
+#ifdef CONFIG_NETLABEL
+/**
+ * lsm_sock_vet_attr - does the netlabel agree with what other LSMs want
+ * @sk: the socket in question
+ * @secattr: the desired netlabel security attributes
+ * @flags: which LSM is making the request
+ *
+ * Determine whether the calling LSM can set the security attributes
+ * on the socket without interferring with what has already been set
+ * by other LSMs. The first LSM calling will always be allowed. An
+ * LSM that resets itself will also be allowed. It will require careful
+ * configuration for any other case to succeed.
+ *
+ * If @secattr is NULL the check is for deleting the attribute.
+ *
+ * Returns 0 if there is agreement, -EACCES if there is conflict,
+ * and any error from the netlabel system.
+ */
+int lsm_sock_vet_attr(struct sock *sk, struct netlbl_lsm_secattr *secattr,
+		      u32 flags)
+{
+	struct secids *se = sk->sk_security;
+	struct netlbl_lsm_secattr asis;
+	int rc;
+
+	/*
+	 * First in always shows as allowed.
+	 * Changing what this module has set is OK, too.
+	 */
+	if (se->flags == 0 || se->flags == flags) {
+		se->flags = flags;
+		return 0;
+	}
+
+	netlbl_secattr_init(&asis);
+	rc = netlbl_sock_getattr(sk, &asis);
+
+	switch (rc) {
+	case 0:
+		/*
+		 * Can't delete another modules's attributes or
+		 * change them if they don't match well enough.
+		 */
+		if (secattr == NULL || !netlbl_secattr_equal(secattr, &asis))
+			rc = -EACCES;
+		else
+			se->flags = flags;
+		break;
+	case -ENOMSG:
+		se->flags = flags;
+		rc = 0;
+		break;
+	default:
+		break;
+	}
+	netlbl_secattr_destroy(&asis);
+	return rc;
+}
+#endif /* CONFIG_NETLABEL */
-- 
2.14.3


