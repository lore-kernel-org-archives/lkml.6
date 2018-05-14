Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526280868-2-7807568615648905837
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526280867; b=heTAf1ljfgupA1DdJVCV0jQeicWfx1NT69ogWRL/YuC7QCtESX
    B8LM2QONY8+tJFBMOuZXc8k8r/Fq00+FVLyV0uBqflOnN+Bdx8FUQCYwfAuTBO0i
    DjfS0jaZir3lahRQwudcLu9Wznco917YmW1IPTY61BPBFvoyxL0+fuuPlwRPBUE3
    CNJM/PHa1cnjPh7EwrTh8PXNb6Pa3szx31+Zszixviz4J2tDQHJKp+l0m8P1SBhQ
    rvldkGZZUQTLKT1uXONDXECGhfPIDa00KJmMfCUKDjWj6D1l6+t5ZJJKfB+I43Bv
    OELg1FahXbjuWsdreaAbPubeIaIrhTN+YHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526280867; bh=MkTIJ7bSc6XTHGA6d8EWECJQvMSVqA
    GEl5ntVbeq4cw=; b=BV4D270JysuH4xK2MZzKbuCahrZv8au7sAeV1dzn40C89J
    4J1qHqFsU3MzLvG1G6eRp3heakCqw5pk2mjtzukCI8hmaitNPly+KflHlwlbMMyx
    39IbPg3ABH6oVVzYp/ZuOthxeKVZzKIV08jB5VezMOsibqcdx4KLcogBwnVzobGV
    pV+QXZrgkP6ALjrG2OyqpbaT8xp13NwQD70Z+SJ7mcdobgMYM0FpfIrmbwYpfzi1
    qBiQl2xraS/Dy0STNHkL6AZVqFa6U1dhu1322TmP6n+bmZBMjW+QKIKGP8AQZVrl
    /5HKV/sVhO4/NUH9NgkctqlYqRnFJwSTrIOQJREA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ltskozXK x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ltskozXK x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLqjhhMnqxF9SKqb/2zM4eOH+OcqSmnJARhOfA6odQdcDyShwwut22jDhygZO+yhZmmTC72VnfXS8wXbjqVRMHgVJZpR4QAtBHtOobUSRUDKgMGlzxjt
    7oQI725EAs2KDYh1IZubGrsB94QFsYHLC5KvGKg+mBMzxhXI409xTvqus2uInjhVp1nS1ie5GQNXaWcc8pGxozQb20erulj5wkIzREetbhgCH3CPvnQkMdZp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=_Wotqz80AAAA:8 a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=-QvNB2h-U9C5Z4WaKAsA:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10
    a=NWVoK91CQyQA:10 a=buJP51TR1BpY-zbLSsyS:22 a=2RSlZUUhi9gRBrsHwhhZ:22
    a=AjGcO6oz07-iQ99wixmX:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753066AbeENGyW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 02:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753041AbeENGyU (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 02:54:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 27/36] atm: zatm: Fix potential Spectre v1
Date: Mon, 14 May 2018 08:49:01 +0200
Message-Id: <20180514064806.339753691@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 2be147f7459db5bbf292e0a6f135037b55e20b39 upstream.

pool can be indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/atm/zatm.c:1462 zatm_ioctl() warn: potential spectre issue
'zatm_dev->pool_info' (local cap)

Fix this by sanitizing pool before using it to index
zatm_dev->pool_info

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/atm/zatm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -23,6 +23,7 @@
 #include <linux/bitops.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
 #include <asm/byteorder.h>
 #include <asm/string.h>
 #include <asm/io.h>
@@ -1458,6 +1459,8 @@ static int zatm_ioctl(struct atm_dev *de
 					return -EFAULT;
 				if (pool < 0 || pool > ZATM_LAST_POOL)
 					return -EINVAL;
+				pool = array_index_nospec(pool,
+							  ZATM_LAST_POOL + 1);
 				spin_lock_irqsave(&zatm_dev->lock, flags);
 				info = zatm_dev->pool_info[pool];
 				if (cmd == ZATM_GETPOOLZ) {
