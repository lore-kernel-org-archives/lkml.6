Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3471498-1527237168-2-16820340050402500667
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527237168; b=jZy/GGrWLty3i9tlLIjdxEqYUo+qY2d61o3pL7Wqwd6A4a6WwD
    n6y4FSjQx5l9XS77Vz5GmJ6scBdV5j8MdJeiuw9bdMwQ6Px3i6nKr4yuGw85wJ5J
    aeKKy1yMyLipORcMzD32t7yOpxrzJwCBwQgjXA+jpCzQRlmhqu3qOASZlcGnTvtN
    87rnXJSDdbKgyxUyldAj3wuV0TFyOF0HKdok+cImmY6hMbpNa8Mt9C0Be4M71b3r
    l7QDEtQ0Xax6WIYHOuX2HIajLbVGwhhJoFCMAZ6T44On9VikiQpKtWhGoS6C4XCX
    NrGbe4etlSRRyN+3i8EJ9s8Wk6VxVmhaCO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527237168; bh=td+EdTLE1tqyLv6q4Jok87i5L0F5GI
    d9TXEPhiWG3B4=; b=j8EnychqVj4YqiEjMyzHdYC3rlTowZBx3glmJkniEBELLv
    QME7DPm5efNQbwAhF/mmy/gJdj7ugaLWSfFJzTtmp23KSE7kGC5Ra44hvwd/L01T
    Oq0ACHl9TIkTN1/6oTct0ew37VD2b7Am6hDGTXWt3HVgmREBSt+3e2382vGnBAG+
    +oHNwlmQJEGXn6UeEd6Jiwz3kj3lHmSER3FGYv9ve19Uv8GVt+wL6nJDnzm/iFKS
    pore/wyrjKg9rskO0KbGRu/cMs/GCPwj3zx3zfHSoZOu3E5PW38t3EzVmkNH7uF4
    6npcWkqMUCO11fuOqgy0+buM/z+CbPTwPZBWqddA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=NiDl/GZq
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=NiDl/GZq
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codeaurora.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=NiDl/GZq
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=NiDl/GZq
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codeaurora.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHRPXewv2sfdLewnJjlcjuTzphSVxL4tTKOXG4ZpHJMXO+l5whC2++NsdafgzEsHCIiagmXnsAsUTtpclOwbmD7uiXeLKXxRFaI01pJD5B4ViukWs4/F
    emGEGGGx0ildzUtsi+DrfgmLEQDnWWyk4joPsN9fOpPzls+wz3jnSWtPzbsQf3EXLlzO6oD9U4O3FA9l5+juLRHGT2dVp4Lc1Ro9JwNYjP7YFXf44iWEVuFv
    POQcviqmJz6lBo4rXuRpQw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=LpQP-O61AAAA:8
    a=VwQbUJbxAAAA:8 a=cOKtjSMsPr6CJoA07-gA:9 a=_7Y5M_xV4TNOc5gg:21
    a=tuVnGkAj3ExbXwyP:21 a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964790AbeEYIcq (ORCPT <rfc822;linux@kroah.com>);
        Fri, 25 May 2018 04:32:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55550 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935921AbeEYIcp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 25 May 2018 04:32:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF3A060290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sgrover@codeaurora.org
From: Sachin Grover <sgrover@codeaurora.org>
To: paul@paul-moore.com, sds@tycho.nsa.gov
Cc: linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        Sachin Grover <sgrover@codeaurora.org>
Subject: [PATCH] selinux: KASAN: slab-out-of-bounds in xattr_getsecurity
Date: Fri, 25 May 2018 14:01:39 +0530
Message-Id: <1527237099-9728-1-git-send-email-sgrover@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Call trace:
 [<ffffff9203a8d7a8>] dump_backtrace+0x0/0x428
 [<ffffff9203a8dbf8>] show_stack+0x28/0x38
 [<ffffff920409bfb8>] dump_stack+0xd4/0x124
 [<ffffff9203d187e8>] print_address_description+0x68/0x258
 [<ffffff9203d18c00>] kasan_report.part.2+0x228/0x2f0
 [<ffffff9203d1927c>] kasan_report+0x5c/0x70
 [<ffffff9203d1776c>] check_memory_region+0x12c/0x1c0
 [<ffffff9203d17cdc>] memcpy+0x34/0x68
 [<ffffff9203d75348>] xattr_getsecurity+0xe0/0x160
 [<ffffff9203d75490>] vfs_getxattr+0xc8/0x120
 [<ffffff9203d75d68>] getxattr+0x100/0x2c8
 [<ffffff9203d76fb4>] SyS_fgetxattr+0x64/0xa0
 [<ffffff9203a83f70>] el0_svc_naked+0x24/0x28

If user get root access and calls security.selinux setxattr() with an
embedded NUL on a file and then if some process performs a getxattr()
on that file with a length greater than the actual length of the string,
it would result in a panic.

To fix this, add the actual length of the string to the security context
instead of the length passed by the userspace process.

Signed-off-by: Sachin Grover <sgrover@codeaurora.org>
---
 security/selinux/ss/services.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 66ea81c..d17f5b4 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1434,7 +1434,7 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 				      scontext_len, &context, def_sid);
 	if (rc == -EINVAL && force) {
 		context.str = str;
-		context.len = scontext_len;
+		context.len = strlen(str) + 1;
 		str = NULL;
 	} else if (rc)
 		goto out_unlock;
-- 
1.9.1

