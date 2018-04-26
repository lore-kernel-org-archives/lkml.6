Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2141624-1524727237-2-16434565437886845560
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524727236; b=TnygTltX03Ax9XUJ6BGGcUfZXOB4pXbn3F0efSyYfI052hbq8P
    fpbcOLmjWxDgvmEqXZZdPom8vVNBdlRSA6NCMQ6tyXUTRwMdGeu7K6T2l3Ctg272
    fPiFmpvn8fy4upoEXbwjgNbLyiHKTl3XZlc7tiG0dZrhSNWPam8jPzLexqqYtUG+
    s0+XErwyt3/WlMOcuLB5vO8c5imDtEBVTsMm8FrDpSBwthKIY7V2L0uUL6CVDRsy
    P09ieZK0bMvaizs1HHkoNTsvKk+yoXzq8nJyaJ6Oy9mYLDFeYO863+B1xXmHUdaE
    7bnjOQglGyjheSgXKMOcTl1WKnaWwJCYUD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524727236; bh=u0mg2CgYtZT/0An2JRPCx1XV1vcgnl
    HmnXdZMc464Cg=; b=jYTVFiYNM9zXg4YcnhTDoxOlVlQkTJqw2AuHsa1wR9NGzG
    UvMpOAoZAO9OqFdLK1f7n4DXlYo7F/AoD6t9ij/JXBHPQV9UNECCdSHnaop1CC5s
    BqvkkCnD/ZKV4fbSD1O3CWsdSokf1asVUINf2hFix+P9QEqZSLn4b4CSQ7FG7w73
    fldlH+F0j12kcE4yVR/GUIj2EWNhXGN6Gdll4YgIONNktUciTT1BPq98W29aaSlK
    Ek2/qwI1+o6two6uCEGGxrO+NBFIZoLzA+lA+y1+JjE6rgxJ+yhYciyzLyZSN+gi
    lQGOKIjZbDoJskZlp6EmEcWFo103k/1GMYo5YfiA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD4JhkVagPQnulhYBYV5FWKnqRJRbjZg9AySzo1EuUGg95Qao/NobKst1y1FVz3PUscMrIcqwf8EJl1ZZIZQqUWJhcZvhF/fa1mOorP8XyelEJ2h7xQv
    tCZqHN7BQIgvW2EQH+Jiry6lrANZPD9gSLkJ5BcFLP4m00eyD8UeGW8kzy9JekmFmgyRcfQs5FwF+OloFcJqTlkZqH5q60njBzPmfbRsxo0gNBH8oUpHVCGf
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=J1Y8HTJGAAAA:8 a=Z4Rwk6OoAAAA:8
    a=meVymXHHAAAA:8 a=ww5qIvrlSSbEfUhZvcEA:9 a=MKcUjSIGLDunbuxz:21
    a=p0gX8jTDFxmkRsUV:21 a=AjGcO6oz07-iQ99wixmX:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbeDZHUW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 03:20:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753993AbeDZHUV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 03:20:21 -0400
From: Thomas Richter <tmricht@linux.ibm.com>
To: ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org,
        akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kprobes: Fix random address output of blacklist file
Date: Thu, 26 Apr 2018 09:19:59 +0200
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18042607-0020-0000-0000-000004163846
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042607-0021-0000-0000-000042AB3BD9
Message-Id: <20180426071959.82407-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-26_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804260071
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

File /sys/kernel/debug/kprobes/blacklist displays random addresses:

[root@s8360046 linux]# cat /sys/kernel/debug/kprobes/blacklist
0x0000000047149a90-0x00000000bfcb099a	print_type_x8
....

This breaks 'perf probe' which uses the blacklist file to prohibit
probes on certain functions by checking the address range.

Fix this by printing the correct (unhashed) address.

The file mode is read all but this is not an issue as the file
hierarchy points out:
 # ls -ld /sys/ /sys/kernel/ /sys/kernel/debug/ /sys/kernel/debug/kprobes/
	/sys/kernel/debug/kprobes/blacklist
dr-xr-xr-x 12 root root 0 Apr 19 07:56 /sys/
drwxr-xr-x  8 root root 0 Apr 19 07:56 /sys/kernel/
drwx------ 16 root root 0 Apr 19 06:56 /sys/kernel/debug/
drwxr-xr-x  2 root root 0 Apr 19 06:56 /sys/kernel/debug/kprobes/
-r--r--r--  1 root root 0 Apr 19 06:56 /sys/kernel/debug/kprobes/blacklist

Everything in and below /sys/kernel/debug is rwx to root only,
no group or others have access.

Background:
Directory /sys/kernel/debug/kprobes is created by debugfs_create_dir()
which sets the mode bits to rwxr-xr-x. Maybe change that to use the
parent's directory mode bits instead?

Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
Cc: <stable@vger.kernel.org> # v4.15+
Cc: <linux-kernel@vger.kernel.org>
To: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
To: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: David S Miller <davem@davemloft.net>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
To: acme@kernel.org
To: Steven Rostedt <rostedt@goodmis.org>

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 102160ff5c66..ea619021d901 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2428,7 +2428,7 @@ static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
 	struct kprobe_blacklist_entry *ent =
 		list_entry(v, struct kprobe_blacklist_entry, list);
 
-	seq_printf(m, "0x%p-0x%p\t%ps\n", (void *)ent->start_addr,
+	seq_printf(m, "0x%px-0x%px\t%ps\n", (void *)ent->start_addr,
 		   (void *)ent->end_addr, (void *)ent->start_addr);
 	return 0;
 }
-- 
2.14.3
