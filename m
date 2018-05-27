Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3530501-1527459311-2-7336991881888524824
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527459311; b=VJOTIyKmSCZWbLZ4MgmPDsd0X3a7eTSZYoN2vx7eZI3mMhx92X
    f9kr+sFnLcREbeVjL4zrGkY+6hRNS2d/fKralaC713837hZktdH4aDD/sk0wzM8b
    MoGtw4IkHC3StUTYg7R9cAa8GasCAimgHn2ocDqOu0TgegnejdWnDRSa5+kFIo50
    mFz/yVTr+yYltl5iQesHca9k9R3w51Dwa2QtFE1VOBFKQnlitfIyu1/BGlCAEe9+
    cvK7PLSKcKLBEWaHdj3RWq5YAOiefO4zaWZw1tN2POJG7LNla3T1U+vDftBY4kCe
    wWBhW5r6OeWgZaBtMAaM+zRxLapyYDqzfkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1527459311; bh=2VNhjCxV2h1XMaoVLher5h5YHGqdIu
    p7NNhL+vHYrHM=; b=SKgcf/zeA7E1XLW5vFAWKBSsaLIdsVDOQAwFQ1IuirSzzl
    IMQvwz7oYZeZADaA93v+EmwSLJC7YSKmbdF9MdjmJhepfapfCewLe64Z7WmkBjxQ
    uhOZ3ep8AAoZEBHEDStWS7fcLpfCniuBnxYszHyifv8i42Oo0K76yJoxVvBMlPM9
    XcG0Vpix1JKwE8hzT1QsoGYzxvEc5cV097vqxFqR5SlIjJCmVG+B3nO3nPuGOKSM
    9FvRonlfSqErki15zZl2vSYaVLu+ASmyieBwZQGPZs+/lNnkFWrGiSHDsNAbIwos
    Gi1i+Cxxvd0G37PglC3o1rrC7zxERygvz0iJU+ZA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfO7KwRJj8xK/z29eW2asmFAdAbb0FmP/8yVA1BCRiNxMijxkz5FL6jQrYLHAGqo8fSLmAVd5+ab/pGmqajkrS6XzhQQdAr6GBZ/xwI2ipSeF32ENzKim
    cqD5CYhq4xQl3tec3z7B1fKV5GcfF4KUmDNKrjP4fugIYKTZ33a+XsOdKYI2NrAP0oOEhFYDRAw8axK78zgz6QvU2DxjxDwVXjoTdrl88qoUUGY6MRJF5tXN
    wW5y6qRejEkB+yG6Pk6Gcw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=0Y_sIrUEXXJ0DDch8e8A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbeE0WPI (ORCPT <rfc822;linux@kroah.com>);
        Sun, 27 May 2018 18:15:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42332 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbeE0WPH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 27 May 2018 18:15:07 -0400
From: Colin King <colin.king@canonical.com>
To: Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] EVM: fix memory leak of temporary buffer 'temp'
Date: Sun, 27 May 2018 23:15:02 +0100
Message-Id: <20180527221502.25073-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The allocation of 'temp' is not kfree'd and hence there is a memory
leak on each call of evm_read_xattrs.  Fix this by kfree'ing it
after copying data from it back to the user space buffer 'buf'.

Detected by CoverityScan, CID#1469386 ("Resource Leak")

Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/integrity/evm/evm_secfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index a7a0a1acae99..fb8bc950aceb 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -158,6 +158,8 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
 	mutex_unlock(&xattr_list_mutex);
 	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
 
+	kfree(temp);
+
 	return rc;
 }
 
-- 
2.17.0

