Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2924715-1524135382-2-15600927475537922735
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
    1524135381; b=p747oVs8BBpZPAZ2vpXzk+cxWjDyzhTvhtVy+vQjmjgI3rqgq1
    reBJkjSWX8Un9241XDDXWRbwHHZ23Z+BHLUXJqY0shva0jCMulB2sHCv6L31Ykqn
    ePqKH18eFCwbpBH3MIyov4j+jCRL+ArO54XBpPsy/8NtkMw69lDAimbce1sjDo/+
    +lDMCu50hihnp2txhJJh9Rfd4kKYgoCPXUEIC64I5jzl0ugDh5ngHGjxmXWMBY+n
    VWfJiTZmDmdYepHyDQ7RdlAvrwToU1Bg6iSrwkgm6d9/Pv5PjPNVgqQciJR5ToOj
    xSefm36+45pGc8mCn3OiVic2SfeAro+x/emQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524135381; bh=rQHZinOg0u+1TrnkN6pFszmvAHao7h
    u9OTqrubUbYLc=; b=cdU1Dmgmn6p7sdUMuQYenIVwgQZ2VL2HFF9wAUM0aBPEDa
    q6fkFeBVwb/PWt35YVbBUgAHGEXN8//rva/tCvAJwWl6l1LQ3vJ0zCwXNkW5IleG
    z+h+SEC/vr6RAM9A0sLdq/EQFkwM8oT3e8lN5FpqylJpYH3w7u/GRHz/62XlkaLD
    efVtcVu8Ai4EhXlLZnosbgdricWFFgzte3e1xluIs1NDuyxscZ3WylpIXZUwNrWI
    f3G/u1VKYXEUgwerXqwv36DJf78KcpS6awNKhgiJnVMRn81VcPSOcen8wQ3KqL40
    QvbmJyRQhkf859EyL3aoBxUIgCbOu3MTc8AGfrFg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIMi3rxQZHXtRBxtD7YytY2hclxrGj4fOew76qA6dSIaeyXH45iBPY7GUOrl+akuKcSg/AhIM+M+CByBDwXcASRCDF+CEvia5Ck2PHB/IWSi5Ry/3SQ5
    UF8Je3oksUmAR5SXu6EskWv05y+o7zXwRSbNVtS0+ZswUWsCasdBTy4Ln393N4sSuEwRLa3KH/ZQso5//QLxkW4ohT5ro7mamc7LLBpbK5wcQ/L4te4gtsWY
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=J1Y8HTJGAAAA:8 a=meVymXHHAAAA:8
    a=ww5qIvrlSSbEfUhZvcEA:9 a=nAUM5Cd-vjmbAWX7:21 a=AyBW54rlQHj31xK3:21
    a=AjGcO6oz07-iQ99wixmX:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbeDSK4T (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 06:56:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751420AbeDSK4S (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 06:56:18 -0400
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: heiko.carstens@de.ibm.com, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        stable@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David S Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>, acme@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] kprobes: Fix random address output of blacklist file
Date: Thu, 19 Apr 2018 12:55:56 +0200
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18041910-0008-0000-0000-000004ED0994
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041910-0009-0000-0000-00001E8119DA
Message-Id: <20180419105556.86664-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804190098
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
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David S Miller <davem@davemloft.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: acme@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>

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
