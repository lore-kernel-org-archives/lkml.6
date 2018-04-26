Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2888943-1524763952-2-463108238587333369
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='ISO-8859-15'
X-Attached: 0004-kprobes-Fix-random-address-output-of-blacklist-file.patch
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524763952; b=tM0NSoRfsR/9T8+tuabNxsw4PboAlg6MXO9ElzZ7vuDq7RmYvb
    V4yzmeB8ojOdu2jyZWnZjdv3eVrsmqZqeODvS7GWZzZXOzytDYTEvfsK3e+1RUm2
    Rl1IB3GEqla4DLVQF8F7Z8JDIzyu/rqndJHkIFfb6vL+JvPhx+t7yq7jUNZEFWUR
    YdK9ytbiMa+Kqv+tCZ0Hbyd2gLt0sLYCTRwz5XYYPYIe56Ntu7dj/xcLi54MvWq8
    NvYgxu20a6SFHiUFcdeqt6EK5+3L/4NBvL08c+ye5cKQlYkaoBrg1JeWc5Ie4MYZ
    dYfsoF4e84hLv9utQtcaCxQJ2GbCN7IBmudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:mime-version:content-type:sender:list-id; s=fm2; t=
    1524763952; bh=tUDoPYpDO6i9aIHfk46Z+ae7XmdlgYlgMuffnHcycI8=; b=X
    ioU8ASDJ+OGsON/BGoP01nxIDZaZbHaIxrOumKjkoRZU6svDkzML7DLaf1+xTRGZ
    JsPyY7Ge8UrdjDG0YAVqWqvduyJ8vIA2cnI0vNb1RKWQgJa1UrMc4TXY8pWwN0Hg
    BaZGOOS6dT0rPY2eCCszE/9sr6YiMYSNevWw3Yfs8J9lrH6B7UOLI7O9pE451P31
    fE+PdAlLrcJTBsFjCwXIZWQ9AwIIJ+TmYW04S9HB5KOLnPKq/x1EQUbk92L4fq6z
    c1r9+Wit7HAA5D4l3fnDY4NViYUxnBCFYy7CfHLhZVAzwyGysCpMM1nA9i5OAJxK
    4LKLHRHnhI3n8wz+V2V0Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIRc57HeoxrDot/XSbn94AGK4bo1xdN6jXRBNg9jmAvJRok7oUdeIkK/z8v5uPW4TvS34FhSljEmfSUuk0PQEWJ5/r7tAQLcEGqKriMjmwiWYsrWu61h
    Bxu+rMloIcWeiIMeZN3e1SUIRgZA92yJ7Y7NhIYBQ7v1duzB13b6g48LNXTGTJ2aNcCOyZzSnZtkQp6moL8MQj99MJ5LHGMn64PbocBruJvt88DiBERxW2B/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Q9fys5e9bTEA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=J1Y8HTJGAAAA:8
    a=meVymXHHAAAA:8 a=ww5qIvrlSSbEfUhZvcEA:9 a=eIdllpx3aPQ52tTZ:21
    a=fiRZSLlAwhvWP4so:21 a=PUjeQqilurYA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932135AbeDZRc3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 13:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756798AbeDZRcD (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 13:32:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333342183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180426173202.083173270@goodmis.org>
User-Agent: quilt/0.63-1
Date: Thu, 26 Apr 2018 13:30:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David S Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>, acme@kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 4/7] kprobes: Fix random address output of blacklist file
References: <20180426173039.426131207@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0004-kprobes-Fix-random-address-output-of-blacklist-file.patch
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Richter <tmricht@linux.ibm.com>

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

Link: http://lkml.kernel.org/r/20180419105556.86664-1-tmricht@linux.ibm.com

Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
Cc: stable@vger.kernel.org
Cc: <stable@vger.kernel.org> # v4.15+
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David S Miller <davem@davemloft.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: acme@kernel.org

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
2.16.3
