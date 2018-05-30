Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-473191-1527724633-2-17450279467151494979
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527724632; b=hHy6oI+34OaqCtn0IeJ5LeMQDeg00g3vThes9ljAQD1zHSPTXd
    b0ERq1I0ZioitqWD3n3sr08Pe+hvk0KW2nfr9nHBN1eUs9ad110nk6OcoC3mQkV/
    mv0EAnMcbyk0X+2wArmPu4laS0W8wmh83qJ07Vs7fEJsyPXQsJmRB0CMTsypKA7g
    aYRVf+2Ix4rXUNRVKS7XWWGIPz1wlhGE0EFlLq7bSEdqgW+89ZGpbmO3TUIgIYAQ
    UGUv6myI7J/Q21zfiRNQUOCL5Rf5QtVt6yauzXOLU+vGQCT38VwWMVY5cXvhbwLp
    EDMxCxbMQ6MuS9fnfjljjXMg8PF0JiZsKlwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527724632; bh=jbjOIsn95L40oVwrRkl3LAkhblpMYT
    7IVMiOVaoea28=; b=hVQ/TYTiM6BO9Bwhsr1jjFJ2egdrKzAJ/LZ1Qha+0FYd3K
    IrvXCV+35o/GFLgXvGEZnGrSjTGKs45ouq4s7kbphrau6efVUdWVbJ3dHLGFcRZd
    mECQzgDiwkm/iqy/16HB8VbNigfPqPG86nIgCIAZvLJvfusPNNITPPpBxGVhlXi/
    YkKGq77smfHZnEA8zN0g4zkLzUeK8ySgPMnXCbdKVe2oxf5OokWeNwB/L07bzSn5
    RfDiJpdvKPcSleogQN+X0W/2vy5cmjlOlZ9yB5MbrFB0dKwEgPs9TkGbEk9PjrRI
    LV/BQbl3V1rsheucDlqV8wU5hyjMlCgyPSCJ7HCw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.alibaba.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.alibaba.com header.result=pass
    header_org.domain=alibaba.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.alibaba.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.alibaba.com header.result=pass
      header_org.domain=alibaba.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGfLs0CKu+vUizJsC5DIJQ+yMreEaI2NPz8WQfFl59ic3TMZ76hUapLo7rQjcbVPovfOLD9O6E2tB0mRN85fuueJrIJCy2plXaw9KcJhrhspf6rjHBia
    AFGUXntRfhH5CjWCkDTOzuJpjV8s3djfXCFYvYiPc9+qmApJ9tX/zjgnpUa+HnF40wLxtr9b8i7b9AFed3LGqal1jmdUwFjyKcPz2RvkoBgTqJh532xtON+w
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=BqgCfznX7MUA:10 a=VUJBJC2UJ8kA:10
    a=ZZnuYtJkoWoA:10 a=SRrdq9N9AAAA:8 a=ENa_orxBO1iobWnNHEkA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932570AbeE3X5H (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 19:57:07 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:59784 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932091AbeE3X5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 May 2018 19:57:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T1uApIh_1527724613;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: tytso@mit.edu, corbet@lwn.net, akpm@linux-foundation.org
Cc: yang.shi@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: add description to dirtytime_expire_seconds
Date: Thu, 31 May 2018 07:56:53 +0800
Message-Id: <1527724613-17768-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 1efff914afac8a965ad63817ecf8861a927c2ace ("fs: add
dirtytime_expire_seconds sysctl") introduced dirtytime_expire_seconds
knob, but there is not description about it in
Documentation/sysctl/vm.txt.

Add the description for it.

Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
I didn't dig into the old review discussion about why the description
was not added at the first place. I'm supposed every knob under /proc/sys
should have a brief description.

 Documentation/sysctl/vm.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
index 17256f2..f4f4f9c 100644
--- a/Documentation/sysctl/vm.txt
+++ b/Documentation/sysctl/vm.txt
@@ -27,6 +27,7 @@ Currently, these files are in /proc/sys/vm:
 - dirty_bytes
 - dirty_expire_centisecs
 - dirty_ratio
+- dirtytime_expire_seconds
 - dirty_writeback_centisecs
 - drop_caches
 - extfrag_threshold
@@ -178,6 +179,16 @@ The total available memory is not equal to total system memory.
 
 ==============================================================
 
+dirtytime_expire_seconds
+
+When a lazytime inode is constantly having its pages dirtied, it with an
+updated timestamp will never get chance to be written out.  This tunable
+is used to define when dirty inode is old enough to be eligible for
+writeback by the kernel flusher threads. And, it is also used as the
+interval to wakeup dirtytime_writeback thread. It is expressed in seconds.
+
+==============================================================
+
 dirty_writeback_centisecs
 
 The kernel flusher threads will periodically wake up and write `old' data
-- 
1.8.3.1
