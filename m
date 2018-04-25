Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653737-2-14845385540352045258
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653736; b=BCSc+14VPtTnIUmaKZqtc2ykeCpbE8bysQNm92+UjhYMI+22cM
    PmJ6uOvkAPuTglW19ce8LrCHq+IwAhyR+kTKb1bkqeItniIicnZINgXiR1imNL4x
    QbPmK19d/kZKNb4MPGZv5ZH7n6jhbFboLl960Y3EWsM0OGgvqIoZIUxtMoRrO+2L
    l1E6kIgnOSLoZi4A7PQn9Z/56SKHQkd0iT2xPbqV0Oa6fv8XuOwhrieHhOJacNHS
    unlQlI1+fo3UdDrMXGM4oTLgc3wZezGEkTcxI/YgKaQM1unWh2WQYtcxFBRGMTW1
    b7apk6trYnOiH6U9ZlhFBYxcYuUOh3282ejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653736; bh=9CLkNfYCcivcpZG4jgC6se2BJA4QJC
    qPYhAzyzZw3Os=; b=GB2oLWRW68snxuYswRATV9HNm2fxjRgbamPe16pMyhbfpN
    eAX5lMcJcVyDNk95R3Yst3JFNqch9asku23+tzb/MCRw1Wze0U74kSAKbs230L6L
    Thwkr38EHUziXhhrea1b2QDdvtZ9gvesxYFgvMLAnD3YGBWvl69w+0hDJ56J0Zm7
    ruMwIQw9kfImII5lUVD+Yz0eDymsf3BVKKvAs6hODIVL1+XcMKH/6ZImDptOYegF
    xhiazHZskDVpQPf54gIFSoypeusdpQpKTa6A+nFLB4uayHIgPkIdcreg6amrPV+K
    f01bkkteAkx25TtrUaisojeIhzafEKCNdNZ6oYUA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDwGaGZ/gb4ADTRcFy04XWK4NErujF0AxtM694uijlFuSS8YThHot8gx1VW697Q3whx/GF2caqes1wbgqCuor4xBQ4fyQI7mANUaRL3p0y0Xrf0I89RX
    C8aiiSLpMFouK60F4BDGV7zpzwdFH5ZLpMsaZIlb9F7ZbJdVXLvEfaXg+YisSrhY8rEpHIpsPkDYyqqF8XGtKiiWo3QOVcjorhNbqe+9Q7xrVG3i0/QIGmqJ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=NufY4J3AAAAA:8
    a=1XWaLZrsAAAA:8 a=nrACCIEEAAAA:8 a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=yuw3B8Qeb1bco88wqkMA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=TPcZfFuj8SYsoCJAFAiX:22 a=LP-oT3CeHzb3Kpa8nOvR:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeDYKzV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:55:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52978 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754202AbeDYKnW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:43:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yisheng Xie <xieyisheng1@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Chris Salls <salls@cs.ucsb.edu>,
        Christopher Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 112/183] mm/mempolicy: add nodes_empty check in SYSC_migrate_pages
Date: Wed, 25 Apr 2018 12:35:32 +0200
Message-Id: <20180425103246.947698207@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yisheng Xie <xieyisheng1@huawei.com>


[ Upstream commit 0486a38bcc4749808edbc848f1bcf232042770fc ]

As in manpage of migrate_pages, the errno should be set to EINVAL when
none of the node IDs specified by new_nodes are on-line and allowed by
the process's current cpuset context, or none of the specified nodes
contain memory.  However, when test by following case:

	new_nodes = 0;
	old_nodes = 0xf;
	ret = migrate_pages(pid, old_nodes, new_nodes, MAX);

The ret will be 0 and no errno is set.  As the new_nodes is empty, we
should expect EINVAL as documented.

To fix the case like above, this patch check whether target nodes AND
current task_nodes is empty, and then check whether AND
node_states[N_MEMORY] is empty.

Link: http://lkml.kernel.org/r/1510882624-44342-4-git-send-email-xieyisheng1@huawei.com
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chris Salls <salls@cs.ucsb.edu>
Cc: Christopher Lameter <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mempolicy.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1440,10 +1440,14 @@ SYSCALL_DEFINE4(migrate_pages, pid_t, pi
 		goto out_put;
 	}
 
-	if (!nodes_subset(*new, node_states[N_MEMORY])) {
-		err = -EINVAL;
+	task_nodes = cpuset_mems_allowed(current);
+	nodes_and(*new, *new, task_nodes);
+	if (nodes_empty(*new))
+		goto out_put;
+
+	nodes_and(*new, *new, node_states[N_MEMORY]);
+	if (nodes_empty(*new))
 		goto out_put;
-	}
 
 	err = security_task_movememory(task);
 	if (err)
