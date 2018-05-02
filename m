Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1256816-1525291273-2-14501010285162989696
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='ISO-8859-15'
X-Attached: 0001-tracing-Fix-bad-use-of-igrab-in-trace_uprobe.c.patch
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525291272; b=WkSaIGN1x9VlT/gFVcj/C5LSblubeWRS/giZv+ftG4geMv9zPa
    k9pYlxJAyElJ82n9LKY37T61ugWqx8NsYnNzVne/Wrax04xvJn9vzdK67g7SSSWz
    pLG3EJCdIAsSs/b12doK4T8Yfz+zgIAhnvaOAsrU2keZE+qHBOZIZHydjctDQKKm
    dHMZaFng7BD5bJdXRBGhW9awkAnjLPd+ZR6k0o/VQYQh2fFua+LQLyoCsnPSu5t3
    Jzb0vsIqjOkVzAWNWcj2VoWucNGFlk+XM7mvmP25m7DTnWIsvMjqRxSfID8QIV0C
    jvCjbsrnU9sgVOkOclHHcmQhnCf/cYFTpjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:mime-version:content-type:sender:list-id; s=fm2; t=
    1525291272; bh=U+KSQkAebNzACVmpoyRAS1cGLne4S+CnUqhKFfvWvyo=; b=B
    vNqugxVHk7R0yVOatMIt17aOF4SrciVHvBi87Kr0n61/CVy5cK8umhAthfKaKuLW
    TlT/UH6XNjkiF4ilzG+U5kfFrHmgduQsSjwT9K4OKa9KFU3yo+Bx91sBSG8QH35/
    Cc2m/k7T3Jo+4xR26bwsIDs3wKexwFBlkp+I+Ud7y/PfxrfvbPmRPP5rvZS7ruW1
    D6rkCG1cqiliUFsTQe/Y8uRYJzikTJHqmeQhebZDquOtAGlSpODasvoz/UqskYZ7
    zYcXTWGMlGDC0Q1M0QkLdhRHEG/61g41caLEJO4sZZB73lkda5evVQlFr1hlgbtd
    e5KrsUrkZKBawhxJijxyA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHM/u5yA/2Mh46ac/GfyIvwu1Jd7zQ1IimIgeb99+Q2GwJT11uOXQDt9YrjR7ojxWAizcEOE1wVRJzo64bXGs8ndq1aOZGT0xJyEeK27eIdwppKpgawJ
    eqYHqh798L533QyHO3V19J7UQgbTZiVV7t9+HHY4ckaejd7/9dOYbzK0VZjuhT565VMb5972FMaHZWZ4ETJe4ZMz5kiG18Ga55MsYd4SRkuWEnvKfiWhrXq7
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Q9fys5e9bTEA:10 a=VUJBJC2UJ8kA:10
    a=FOH2dFAWAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
    a=meVymXHHAAAA:8 a=FguV8091q8AXxDbNPFYA:9 a=r3Q5AYK6TbaH4CVc:21
    a=BeyugcJ4Hbw-0rhS:21 a=PUjeQqilurYA:10 a=i3VuKzQdj-NEYjvDI-p3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbeEBUAo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 16:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbeEBUAm (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 2 May 2018 16:00:42 -0400
Message-Id: <20180502200041.378771529@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 02 May 2018 16:00:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Howard McLauchlan <hmclauchlan@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 1/7] tracing: Fix bad use of igrab in trace_uprobe.c
References: <20180502200003.592877274@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0001-tracing-Fix-bad-use-of-igrab-in-trace_uprobe.c.patch
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Song Liu <songliubraving@fb.com>

As Miklos reported and suggested:

  This pattern repeats two times in trace_uprobe.c and in
  kernel/events/core.c as well:

      ret = kern_path(filename, LOOKUP_FOLLOW, &path);
      if (ret)
          goto fail_address_parse;

      inode = igrab(d_inode(path.dentry));
      path_put(&path);

  And it's wrong.  You can only hold a reference to the inode if you
  have an active ref to the superblock as well (which is normally
  through path.mnt) or holding s_umount.

  This way unmounting the containing filesystem while the tracepoint is
  active will give you the "VFS: Busy inodes after unmount..." message
  and a crash when the inode is finally put.

  Solution: store path instead of inode.

This patch fixes two instances in trace_uprobe.c. struct path is added to
struct trace_uprobe to keep the inode and containing mount point
referenced.

Link: http://lkml.kernel.org/r/20180423172135.4050588-1-songliubraving@fb.com

Fixes: f3f096cfedf8 ("tracing: Provide trace events interface for uprobes")
Fixes: 33ea4b24277b ("perf/core: Implement the 'perf_uprobe' PMU")
Cc: stable@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Howard McLauchlan <hmclauchlan@fb.com>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Reported-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_uprobe.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 34fd0e0ec51d..ac892878dbe6 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -55,6 +55,7 @@ struct trace_uprobe {
 	struct list_head		list;
 	struct trace_uprobe_filter	filter;
 	struct uprobe_consumer		consumer;
+	struct path			path;
 	struct inode			*inode;
 	char				*filename;
 	unsigned long			offset;
@@ -289,7 +290,7 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
 	for (i = 0; i < tu->tp.nr_args; i++)
 		traceprobe_free_probe_arg(&tu->tp.args[i]);
 
-	iput(tu->inode);
+	path_put(&tu->path);
 	kfree(tu->tp.call.class->system);
 	kfree(tu->tp.call.name);
 	kfree(tu->filename);
@@ -363,7 +364,6 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 static int create_trace_uprobe(int argc, char **argv)
 {
 	struct trace_uprobe *tu;
-	struct inode *inode;
 	char *arg, *event, *group, *filename;
 	char buf[MAX_EVENT_NAME_LEN];
 	struct path path;
@@ -371,7 +371,6 @@ static int create_trace_uprobe(int argc, char **argv)
 	bool is_delete, is_return;
 	int i, ret;
 
-	inode = NULL;
 	ret = 0;
 	is_delete = false;
 	is_return = false;
@@ -437,21 +436,16 @@ static int create_trace_uprobe(int argc, char **argv)
 	}
 	/* Find the last occurrence, in case the path contains ':' too. */
 	arg = strrchr(argv[1], ':');
-	if (!arg) {
-		ret = -EINVAL;
-		goto fail_address_parse;
-	}
+	if (!arg)
+		return -EINVAL;
 
 	*arg++ = '\0';
 	filename = argv[1];
 	ret = kern_path(filename, LOOKUP_FOLLOW, &path);
 	if (ret)
-		goto fail_address_parse;
-
-	inode = igrab(d_real_inode(path.dentry));
-	path_put(&path);
+		return ret;
 
-	if (!inode || !S_ISREG(inode->i_mode)) {
+	if (!d_is_reg(path.dentry)) {
 		ret = -EINVAL;
 		goto fail_address_parse;
 	}
@@ -490,7 +484,7 @@ static int create_trace_uprobe(int argc, char **argv)
 		goto fail_address_parse;
 	}
 	tu->offset = offset;
-	tu->inode = inode;
+	tu->path = path;
 	tu->filename = kstrdup(filename, GFP_KERNEL);
 
 	if (!tu->filename) {
@@ -558,7 +552,7 @@ static int create_trace_uprobe(int argc, char **argv)
 	return ret;
 
 fail_address_parse:
-	iput(inode);
+	path_put(&path);
 
 	pr_info("Failed to parse address or file.\n");
 
@@ -922,6 +916,7 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
 		goto err_flags;
 
 	tu->consumer.filter = filter;
+	tu->inode = d_real_inode(tu->path.dentry);
 	ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
 	if (ret)
 		goto err_buffer;
@@ -967,6 +962,7 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
 	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
 
 	uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
+	tu->inode = NULL;
 	tu->tp.flags &= file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;
 
 	uprobe_buffer_disable();
@@ -1337,7 +1333,6 @@ struct trace_event_call *
 create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
 {
 	struct trace_uprobe *tu;
-	struct inode *inode;
 	struct path path;
 	int ret;
 
@@ -1345,11 +1340,8 @@ create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
 	if (ret)
 		return ERR_PTR(ret);
 
-	inode = igrab(d_inode(path.dentry));
-	path_put(&path);
-
-	if (!inode || !S_ISREG(inode->i_mode)) {
-		iput(inode);
+	if (!d_is_reg(path.dentry)) {
+		path_put(&path);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -1364,11 +1356,12 @@ create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
 	if (IS_ERR(tu)) {
 		pr_info("Failed to allocate trace_uprobe.(%d)\n",
 			(int)PTR_ERR(tu));
+		path_put(&path);
 		return ERR_CAST(tu);
 	}
 
 	tu->offset = offs;
-	tu->inode = inode;
+	tu->path = path;
 	tu->filename = kstrdup(name, GFP_KERNEL);
 	init_trace_event_call(tu, &tu->tp.call);
 
-- 
2.17.0
