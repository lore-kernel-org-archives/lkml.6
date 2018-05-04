Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-219062-1525443319-2-6482679312098356139
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525443319; b=N3tZNkJ/F70HsRkWfvbOxxI5DVg1GXzk7dLR67hx5+aMsjM4fi
    bMk+UOhVOn6QTbl191UjqWIK/NzxresBJR/oKzIKC3eavZ5I3vopVat+D1Dcj+Wy
    2g40rMOuT5TpU6j7c18usdA349NmnN/xoUsEbBnnDrG1cN9W5K0smpSwofmiTbiO
    mkBh5BfDXR91GwqJZhCjxzCFTTNKGh9S4F+CZBsXTUzwf8JPTHf9pf8rBPRkM/Q4
    uRnBX/5wLYAT1Ei2R5/NAB6I00Jsr/pwOABLzZXUMyo4zg2NjP3Wtq/115rNhCV3
    smqqST5dN3qGj2/JA3vZULoE51llWRyPPSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1525443319; bh=moPtA8c7R5IfzPaPte7UnhswUVlj3H
    h9ownumhnTeno=; b=BNp6HbzwmTvZz8fpAu91gyTmzWoVkR1Nkcjqb944cRAnw6
    yXKN5sg3Vz+Q+QBdOiqCGjXypUyaQxZvnJ6Hj3ZJSK9XxUMiF2hwvtu7y9Ts8xj3
    42jOynu8y80dy6Gi+T2liaGG5Num9KnA+RUCFmjDKMMr6DyCPx815PmQuw/vn4Rc
    8bOxbD3xGaGAmD1lmfSE1uMZmqg83el5HFQZy8PFe+M8HNvyj9uVdQ0XRfC2l9vO
    yRn7fNOE559Fb8Qjd5phCoWuIddlbPsE1D0iocQCcNyyCGXj+iU5aJToMjY8j5sG
    W0YJgt2Wg2wXBCTGhik4Q86/B8fV4Ose5Glc3t3Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA1O479pfbiSMTYkYkfCVvMapLg66MAdUAffaq2tCH28ipMIm9gN0xu3vg9GmlXHpVFd7iUJ2TI0AhVym0j6Wewl8YbythpCwF88msY07Pa0GGDDxwHs
    8z0LiCTxA1mSnphwq6sNlJDbXXreo6W9Ay4p04g+LazLN38Ay2QlwxBFtKTF1/JavsL4mHmuqPTStohNr9SvQFuN//qZuxp0rKhrpXdaRk3uuCtwUdzR9m8R
    /Rnpopi/HcjcnOVvCfbSCA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=kc_wMlJoc50rQlMN6tcA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeEDOPQ (ORCPT <rfc822;linux@kroah.com>);
        Fri, 4 May 2018 10:15:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34046 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEDOPP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 May 2018 10:15:15 -0400
From: Colin King <colin.king@canonical.com>
To: John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] apparmor: fix error return check with a u32 being less than zero
Date: Fri,  4 May 2018 15:15:11 +0100
Message-Id: <20180504141511.19793-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The check for *seclen being less than zero for an error condtion check
is never true as it is a u32 and hence cannot be less than zero. Fix
this by using an int ret for error return checking and assigning *seclen
to this.

Detected by CoverityScan, CID#1468514 ("Unsigned comparison against 0")

Fixes: c092921219d2 ("apparmor: add support for mapping secids and using secctxes")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/apparmor/secid.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 502924853986..9c431e9a9836 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -142,6 +142,7 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
 	struct aa_label *label = aa_secid_to_label(secid);
+	int ret;
 
 	AA_BUG(!secdata);
 	AA_BUG(!seclen);
@@ -150,16 +151,17 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 		return -EINVAL;
 
 	if (secdata)
-		*seclen = aa_label_asxprint(secdata, root_ns, label,
-					    FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
-					    FLAG_HIDDEN_UNCONFINED |
-					    FLAG_ABS_ROOT, GFP_ATOMIC);
+		ret = aa_label_asxprint(secdata, root_ns, label,
+					FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
+					FLAG_HIDDEN_UNCONFINED |
+					FLAG_ABS_ROOT, GFP_ATOMIC);
 	else
-		*seclen = aa_label_snxprint(NULL, 0, root_ns, label,
-					    FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
-					    FLAG_HIDDEN_UNCONFINED |
-					    FLAG_ABS_ROOT);
-	if (*seclen < 0)
+		ret = aa_label_snxprint(NULL, 0, root_ns, label,
+					FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
+					FLAG_HIDDEN_UNCONFINED |
+					FLAG_ABS_ROOT);
+	*seclen = ret;
+	if (ret < 0)
 		return -ENOMEM;
 
 	return 0;
-- 
2.17.0

