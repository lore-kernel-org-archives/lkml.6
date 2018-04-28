Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1897398-1524918942-2-6559765323059940998
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524918941; b=GanDobohWG+VzHRtX8jWE9tr3E9fPR/OdUYPJNjZFnlZMjj4pA
    rhW0gUxrBYzwLhp/qHa1iyoFBk1aOSBXm8n6DX//sDsoRSfWIvmzUj33vhQNQbKS
    hPbFJFJqSAuTh2+7BJVJRozgyfHwCKbFs10Okxdm53dD/mKan0jaq9YCQZdhSKQv
    Qj+eJCfo+u9XvaaXaDaRxKY1LdJMgTamM5Vft5z46vI6VSnRgYVZ0MbfgUpkLVQo
    7/+FS/MWPvmchrsPhoHkkSEZc3hlInR7JCi07z77dU0d/NMF5ztqa7D3b4sNYwM4
    PMGCybKnb7j7seGzGBtRFyu1cNB+6+1ZDICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524918941;
    bh=TERBZd3F5+c9Iiu2NLgq/KtRTuUcQoIQpJTEtEz4zoU=; b=fmpjqQbFsbhH
    0FMLT9kDVE6OizNh4/sF+cIO1AvCj9nKwdBEermCi04+vPK2iJLKqGQll5+vR2BT
    HMvTmMIHxuydfmE091hfdNaZWIYo2rWusLLnH1SWriPiOmYJKbQhTTcL3HG4Ntci
    UTIF1aGMxFrV7Hy5DZQVaQlEwvdfcLJBZtG+SyB+2SgyD1GK2h4bna1Zs/zJOQax
    w9QkLo3PjGMYY3E5TZ6xb03zqzqgCHmZQkuhMKD2vOArXl9ERUimkXZ+hBBHPSK2
    9+xP0eYVjOeRRgZuzGwakGiRaO/+gCl+CMj2PkUgOQFVYZhgeWLS9WM1uwGCDk8Y
    e+B7KUiY7A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJBOBVwR9T/7N8x9v3rJPHeaI1XVhGlvWxHoCx5xV0p+9sXrRh1sV7wsHvRrqlN7bRGx0zUEGUmUnQiNtptmP9nOIWvSBRhEYq5XUSdEckhIeHeN+aNO
    fF7WU9s/t+2ivnIXjkCQ/wXBYpK6QweOxtGsCawZoDqyaLK2y1iSdwJlBIRZs/RNMMt4tGKcYAElz3ndKxSUx1r+ySQvv1bGZMmWdM0cZOiqMX3Vwy3Ow8Mc
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=x9PI1KbnNgAxJWOJjEUA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759924AbeD1Mf2 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 08:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759699AbeD1Mf1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 08:35:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16E321A96
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jon Medhurst <tixy@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v4 1/7] kprobes: Make list and blacklist root user read only
Date: Sat, 28 Apr 2018 21:35:01 +0900
Message-Id: <152491890171.9916.5183693615601334087.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152491886943.9916.18051658590418236184.stgit@devbox>
References: <152491886943.9916.18051658590418236184.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since the blacklist and list files on debugfs indicates
a sensitive address information to reader, it should be
restricted to the root user.

Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 Changes in v4:
  - Fix "list" file's mode too.
---
 kernel/kprobes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ea619021d901..5eb42c82497c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2611,7 +2611,7 @@ static int __init debugfs_kprobe_init(void)
 	if (!dir)
 		return -ENOMEM;
 
-	file = debugfs_create_file("list", 0444, dir, NULL,
+	file = debugfs_create_file("list", 0400, dir, NULL,
 				&debugfs_kprobes_operations);
 	if (!file)
 		goto error;
@@ -2621,7 +2621,7 @@ static int __init debugfs_kprobe_init(void)
 	if (!file)
 		goto error;
 
-	file = debugfs_create_file("blacklist", 0444, dir, NULL,
+	file = debugfs_create_file("blacklist", 0400, dir, NULL,
 				&debugfs_kprobe_blacklist_ops);
 	if (!file)
 		goto error;
