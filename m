Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-662614-1526904574-2-1867273730235353633
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526904574; b=nYLAyMl/gIZnq2oh8rJh8ms77lfJtrA1aaEYFRS0UJ6oq1jufT
    2qmwMAwhgtvZe8MvTGIZDbKY31lv+G3XiudlHiv1GI5LI4HA+qaB3jr6fqhMK+1m
    /qH6CEEeA2zlkhNQsEf4EIiWNb8lH/38FIWwDAeVMWv1dFL7Udlx6UrO9L5DRp00
    /UzuMGpdGrNtYTDo6a3Yt0/yfXzLrfMI+G9jEDHRDJM1cFSwjyd6EK4NVYIEWii4
    PS4+S+7Er1R8fbSccg4sL/BFstZ/B2gZeVNtQ5+oY/U0Py3R6s7VU8iE3VP3EcHr
    ZhCqrkT1/+xuU7LaqXNl8HGVopwIFqT3AGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526904574; bh=U8el1psLliAjb5DI+53Fgaj0kT4c8z
    BzxVKO8jNitdI=; b=nwtmEcJSGeCdsRt2mxNXTCgKO8mzyev8RryUhVNEocPGg2
    enGTrKPEjgKC/DtYGAHKKHF1yU/SmGtYtxffOqdW124QKTidpihGZB7VtT/7sUqR
    Z0jkPCkOeN/ucCWuHw57qIxzWhk2o6tfWm/3mONOZZTRNhVQBphOCejarbk7DBqp
    U0FlsGWNXoU2nH3BKpoOkaX1ku4wx+vdekVfpucB8sk07xxmlMu0aa955J4Kwed+
    YyMRXjQFhVoSvyXmMKcr9FcnWkgX0u8/DiPu1+loJ7QkrqJAA3m/UJaOGvrjsshT
    cHp/vUQ6PshYg68QQX2fqtjW5MBzdcFBstxuGeYQ==
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
X-CM-Envelope: MS4wfDJxYlL7y7yNKuDZYupLT9vcLLXr8rxBVU36ExjAuXyChotnHor+3pB/CEJJSpY4IBLcGl5sHIXoMamgXOiCm/QQhXaJXDjKVUUJCUiQPCou1UbAl/0O
    4XMgYZPyRvwesGpL1BnHQK8f0LQwa4BlLhUcDP3HjR4KVhqv0NgdMnIExl1MuPvxxq1Cchf88O/AkA96NVgI9tyRZt6RzLvmprfJbPCIwBgIMDd2OSfqW++M
    lzqJTfOLXdktD8v3KzZGzA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Xg0H5i2kXJwA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=K6HrmWtEAAAA:8 a=hBqU3vQJAAAA:8
    a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=RUlW_sNmFCYKrgqXT6AA:9 a=x8gzFH9gYPwA:10
    a=yV38gEssg_2GhkhKF82i:22 a=WLjMIN4s_96MqnBbPenP:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeEUMJb (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 08:09:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752992AbeEUMJ0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 May 2018 08:09:26 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH 25/33] ima: use match_string() helper
Date: Mon, 21 May 2018 19:58:02 +0800
Message-ID: <1526903890-35761-26-git-send-email-xieyisheng1@huawei.com>
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

Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 security/integrity/ima/ima_main.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 74d0bd7..f807093 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -61,14 +61,11 @@ static int __init hash_setup(char *str)
 		goto out;
 	}
 
-	for (i = 0; i < HASH_ALGO__LAST; i++) {
-		if (strcmp(str, hash_algo_name[i]) == 0) {
-			ima_hash_algo = i;
-			break;
-		}
-	}
-	if (i == HASH_ALGO__LAST)
+	i = match_string(hash_algo_name, HASH_ALGO__LAST, str);
+	if (i < 0)
 		return 1;
+
+	ima_hash_algo = i;
 out:
 	hash_setup_done = 1;
 	return 1;
-- 
1.7.12.4

