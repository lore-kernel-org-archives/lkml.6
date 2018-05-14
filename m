Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526282347-2-10602510445253097977
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526282347; b=WWlCN0J7LFVhGrKzoeLuRClEddRw6DecJ5KzobFUIDqzhPucWs
    60dtGCEbW5TqgGjE8uPrag9nEexwGBlt54EOl0PzZtO1MdLpW5BKtYiDHsry98CW
    TsM8zvxe5L3sK+xEnkpZlKNYc/dFhbOpq4ynI0Lre3eihLUGDgc/jaMVdhwSDRlb
    vs8IkV+R3CZZq9L9wzH2lPbIQcxaLoGL5OaJPd6TGlYLZixlo/AuQu80b9o/hhm9
    TVKMjDKe+YFWvi2gpzKlU/4WrtlKLaz2Pv3DBn5i5Ptk4icof86klMN79PHlSrUL
    DYWAHIeui84VbnT+nMeyv81BmLqMu06+GpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526282347; bh=wSqF8qx1btMG+VbwkSOWyy+yEfjW85
    xRW0WzMfuFYOQ=; b=hd65A4tWRm4sAnbF7rA4k4L187aJghOT1u6Ih9N0Eyttzz
    TyqsuNEZ5uv7AFFDKG7Tj2+l42kWd4VLH5VIB7aoIzf1VUGjosrgcC4yJoev6cpA
    pqPqml4JDqXqP/iXMc774EuV0taOd42j/lswhLPELJbIrDC64Bgl55INqBBUk75n
    zmivTg9GTKVHNnDVYA/yVzLmF+scQS0XmgEyNYMgIqxJ/37av7qhbjED7Zus/ab7
    xBsWJ7styVHQbZRk5XbMkucPxJ38+FfIODnK2S7yc109dtK6RVtcTLsIpeCR/fjk
    dmjtQdnVr3oX3NN/uh5YxhHnKBNCmLVxUrjTMrTA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=OJ/vRHm5 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=OJ/vRHm5 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfNw37HRhkcOZTNIcqNPgRCucovqvH2Z+NiW/hnjxUzvlSOVneIV85WuAwcYSAiVd9aDgGeVycpdwXZagV9Q1mMv4SZ6Qt/91OeV/5/ASNJKqdeQMI9+e
    FvSuI8XjLdXxl+q/AY4nRT7jVoyyyH1moqomuVfnZe9gMN9Viab8+gaMZdHGTs2tMUC9O+NPNBBOcpsw+NbLRH7JN/qkw6UWs3B5hhxJJE01HPJRu63OTCyX
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=IXUdwdnP52qHNFmidd0A:9 a=QEXdDO2ut3YA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753613AbeENHTE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:19:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753554AbeENHSQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:18:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 66/72] sched/autogroup: Fix possible Spectre-v1 indexing for sched_prio_to_weight[]
Date: Mon, 14 May 2018 08:49:23 +0200
Message-Id: <20180514064827.795913150@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 354d7793070611b4df5a79fbb0f12752d0ed0cc5 upstream.

> kernel/sched/autogroup.c:230 proc_sched_autogroup_set_nice() warn: potential spectre issue 'sched_prio_to_weight'

Userspace controls @nice, sanitize the array index.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/autogroup.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -4,6 +4,7 @@
 #include <linux/utsname.h>
 #include <linux/security.h>
 #include <linux/export.h>
+#include <linux/nospec.h>
 
 #include "sched.h"
 
@@ -212,7 +213,7 @@ int proc_sched_autogroup_set_nice(struct
 	static unsigned long next = INITIAL_JIFFIES;
 	struct autogroup *ag;
 	unsigned long shares;
-	int err;
+	int err, idx;
 
 	if (nice < MIN_NICE || nice > MAX_NICE)
 		return -EINVAL;
@@ -230,7 +231,9 @@ int proc_sched_autogroup_set_nice(struct
 
 	next = HZ / 10 + jiffies;
 	ag = autogroup_task_get(p);
-	shares = scale_load(sched_prio_to_weight[nice + 20]);
+
+	idx = array_index_nospec(nice + 20, 40);
+	shares = scale_load(sched_prio_to_weight[idx]);
 
 	down_write(&ag->lock);
 	err = sched_group_set_shares(ag->tg, shares);
