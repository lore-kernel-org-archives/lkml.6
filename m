Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-662614-1526904576-2-10065700626307370727
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526904576; b=LbmygLRmndo0aCAqvvjwlgE0OL2+1oWifdLAK4rBaSNnV6u3Pp
    qAIEVIE/v+w7UB+nTJGnjugyBNunlHS4MYXduZDj2Dwg3YF53tDt7LEGljP4X5D9
    JqGHdKpvJ3T1axmxGJZ+0T9z3yKE01flR9Zmqc+CDr7TCpFcF3qIWgwFEo855rmc
    o9qlaxIGYdh2MKtOUXOKKs5WsaOfFyFEjP8VNXbBfoMOh81riXkKKUs81pcyyC7F
    JoGgynSzpv6sfWcvRpYqATPz/wiM0IZ9AtKepjQxDRigJt1Hi5gs47QzE5fGMHT9
    V9S8It92lQzAooO8TNm9rbqnx+2iRc2zcExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526904576; bh=c5S22jlZ8Z7D3NnLI0mB3UPZsiCnXz
    RgyGc163uRcgY=; b=XPMU3zwL1k2gNENtEtPU5HtNOYiC516YYyYhfIX71n8iqu
    eh0AGR7cgqMk4RTafWyd/9623lRYo+kmuWvOWLlx8FhL3s1C5Q34PYG1OZoKSlq0
    5Vfg03Fof7LchWMG9VD4MPqJMNAs3XhOj4RfB5R2xVUZjVpMYawoDWFESuyG/7cC
    DpgLA7EqxJGjxSU+qfH2Ar7RDTc4abOtNpP4WyBDaq+P9Ba1cHF/0k/PZ8fcRvi2
    8JtwwT8gFgfH7SjzQd3I4DOtVdm8rAWxC2OdvsOYwERCOz9CNeN2LLIsKIzd0h/A
    3YuHJB2wTHvOwB5gHsxN1Fglmn5ARGKZUCXEaAiA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKhShobc2OOsonOn41AaFUEDiByMP6C7UGnyw/V1+blXf902sXU3CzsIPn7qHAKlR2vhRZ5aiYZ55aM28+AxxeTtmQuCesrPhhptgaM8CJS8e+XHyFrx
    UFaGY0ywEKN5lfjHIvPFuHLhj/9YFHr7EppvfUbTudzQaukhX1i+XTfKFSbY6nOqLqSh03qEo+d7rP3DQ47BhfiMeTCqAzD/Ood9sXOplY3ZUSmDGARacK+h
    WEVRGiTrOquqkhzl0Lzmsw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Xg0H5i2kXJwA:10 a=VUJBJC2UJ8kA:10
    a=DfNHnWVPAAAA:8 a=K6HrmWtEAAAA:8 a=hBqU3vQJAAAA:8 a=VwQbUJbxAAAA:8
    a=i0EeH86SAAAA:8 a=2N7LZ2YGnUxFU9Y0tUkA:9 a=x8gzFH9gYPwA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=yV38gEssg_2GhkhKF82i:22 a=WLjMIN4s_96MqnBbPenP:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeEUMJd (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 08:09:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752999AbeEUMJZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 May 2018 08:09:25 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH 26/33] apparmor: use match_string() helper
Date: Mon, 21 May 2018 19:58:03 +0800
Message-ID: <1526903890-35761-27-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: John Johansen <john.johansen@canonical.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 security/apparmor/lsm.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index ce2b89e..9b5904f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1378,14 +1378,12 @@ static int param_set_audit(const char *val, const struct kernel_param *kp)
 	if (apparmor_initialized && !policy_admin_capable(NULL))
 		return -EPERM;
 
-	for (i = 0; i < AUDIT_MAX_INDEX; i++) {
-		if (strcmp(val, audit_mode_names[i]) == 0) {
-			aa_g_audit = i;
-			return 0;
-		}
-	}
+	i = match_string(audit_mode_names, AUDIT_MAX_INDEX, val);
+	if (i < 0)
+		return -EINVAL;
 
-	return -EINVAL;
+	aa_g_audit = i;
+	return 0;
 }
 
 static int param_get_mode(char *buffer, const struct kernel_param *kp)
@@ -1409,14 +1407,13 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
 	if (apparmor_initialized && !policy_admin_capable(NULL))
 		return -EPERM;
 
-	for (i = 0; i < APPARMOR_MODE_NAMES_MAX_INDEX; i++) {
-		if (strcmp(val, aa_profile_mode_names[i]) == 0) {
-			aa_g_profile_mode = i;
-			return 0;
-		}
-	}
+	i = match_string(aa_profile_mode_names,
+			 APPARMOR_MODE_NAMES_MAX_INDEX, val);
+	if (i)
+		return -EINVAL;
 
-	return -EINVAL;
+	aa_g_profile_mode = i;
+	return 0;
 }
 
 /*
-- 
1.7.12.4

