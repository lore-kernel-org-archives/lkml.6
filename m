Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1561004-1525726768-2-14300859409270772053
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525726768; b=JuU7dJj78go8B1cn1WgQh+Da3gqtzm88FJtq0/ziBNl6DaoqfW
    p5BOWsSVkTenIoP6n6pTSl9pIAQQNZcB6jn1YYBvJVlw52gUzBarmySz5XY3OLma
    n43V5aBYkrdVJ8btF8nT59LKKnLgXJ/7Um3irP9sORONal/C8x9XyPsDm0zQmsV8
    rHGGyQMUgebBEoDdup0wp1YbiWAJeTV0/VFNvANArY842foAfajgigw9pUWJ54eT
    LIGryI1d4vQ30mYvniZ2ZL35Fh1+NeeIQA5390o4jvBHXtnwPQFNG2KqILS4eapv
    yuUESfzH6aSl5IXntFstr4FcI0z9DYvrNakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525726768; bh=
    r6ApJYDkF8idqwWHYMQ3naIFY2cV/Hv9Klz4bLcb8WY=; b=j/PGER/K8OwQp+vL
    gmk6RPduIc7rMlq708ztujE7gOwyL20Hu+w4bMT89KYLb7OfwAvrEhLZHfsOOrWB
    VNi6DbgPGLJXx52WzBGUBJNpAp13rcr3LG5PbFgN6gx+adSJGAaQmBJURP1Mzdkh
    VINAiMZqJaPg9J9nWXDgGebQ3HM1qD4aBUVTTei9PcdLuxDda+vtz18mX163BCxr
    Hh8PRI3lOHVwg45TiqLSL//3INu6ua8+oHW2+ETpxb/W4LoBJEbkA2ERc8Ltoe+E
    CabeInZLkQbJQNxlxFg2wdepzOXkFPLJ77cecuSrEUrus62D/z300lcmV2SzeMY7
    yUQL4A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGJnJpWBY2GTCCezjE7rHX/bRojrfWIbsx18ggM/V/G4wmG3keV8gbipgh5eHJJHI6PlxRJAUCcPyM/EoKnobFp6uXDEa53dtv95lgybSymy68EN8Ctn
    YwU65kCi0JQmrZ4k5nO5Ev6MdNOpBb0oEJvq2gnAQVfGxaAbrFk8opfDRC+kh8uyfO89skITpICELaCYEVDcbxs6HrvRJUv5oy4UcE95qxOYso8FW7ArvUTg
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=bJs4fFH83SZKsq4AS-UA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753305AbeEGU7X (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 16:59:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753005AbeEGU7V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 16:59:21 -0400
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v7 1/4] ipc: IPCMNI limit check for msgmni and shmmni
Date: Mon,  7 May 2018 16:59:09 -0400
Message-Id: <1525726752-29281-2-git-send-email-longman@redhat.com>
In-Reply-To: <1525726752-29281-1-git-send-email-longman@redhat.com>
References: <1525726752-29281-1-git-send-email-longman@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A user can write arbitrary integer values to msgmni and shmmni sysctl
parameters without getting error, but the actual limit is really
IPCMNI (32k). This can mislead users as they think they can get a
value that is not real.

The right limits are now set for msgmni and shmmni so that the users
will become aware if they set a value outside of the acceptable range.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 ipc/ipc_sysctl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 8ad93c2..f87cb29 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -99,6 +99,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 static int zero;
 static int one = 1;
 static int int_max = INT_MAX;
+static int ipc_mni = IPCMNI;
 
 static struct ctl_table ipc_kern_table[] = {
 	{
@@ -120,7 +121,9 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 		.data		= &init_ipc_ns.shm_ctlmni,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
 		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec,
+		.proc_handler	= proc_ipc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &ipc_mni,
 	},
 	{
 		.procname	= "shm_rmid_forced",
@@ -147,7 +150,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
 		.extra1		= &zero,
-		.extra2		= &int_max,
+		.extra2		= &ipc_mni,
 	},
 	{
 		.procname	= "auto_msgmni",
-- 
1.8.3.1
