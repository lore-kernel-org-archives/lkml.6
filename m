Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4886FC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38B625834
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1wfc5hB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38B625834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966493AbeF0UCY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:02:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54212 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964784AbeF0UCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:02:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id b188-v6so987073wme.3;
        Wed, 27 Jun 2018 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aex6PsXYeVory21xwDPeaGNQglt3ufvP6ibMORBX3pk=;
        b=a1wfc5hBIg2ZUhOocqpTSC9+ch9RaGcQWOGLynX+KUKJ0hPpsWEQUYzOUPqztkGvwG
         LtVgtZ1YBqAQiGK+rinFJCCiFy86wpf1TG0yxVCJQYNbB93exFtiApM9BFS16VUvIfNC
         euLMsyC/GknBDpeem6Hoh2uutjsQmRK4lIFsk9RtZIjQhtRtPjoo2dhajdw0PcAtnwvi
         jutbNVhOvp9bn0XAvPLrgHNFyCES7I0JVPNeYmDk0MsnpmIT+qEheEN3LOFmk2psyXTt
         yTITCksOpny5ZrGEpOAAnlBiSm+NC3IP+4OwhlbDOKQVgnRKkBVtBf6rotzKVKCkQwzv
         ZD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aex6PsXYeVory21xwDPeaGNQglt3ufvP6ibMORBX3pk=;
        b=X63PZxoEFIUhNHQsQk5iex+rLaX56eEkKjD7CMTxYSkt7Pz+EUGYqMZEtoTlbee1Ed
         0shNl9ZXTd5ooIK1QOWWNeCsppOz/SPay4pIxOnWeEZ81KJW6YUBkP1nCPAdlsCAGJcV
         NSVjrr8vaKW3P037Exe+2aYZccGC80jIx3Xe/Iuf/JnhbjKP4cQFmSPFJLoeiwbxjECk
         +RtiOY2jjrTPaOHsgtfhhXz6Oap3hx9N5HfyG5xIu8qoyBrINNWlC/219SYfANNNaAbV
         1J1wu+HY6HaL8NxHXcIlvLOJHgeckbxOtDltrVrRBniYAbiEaYTOsoN7Es1usmzAJN4A
         PSsQ==
X-Gm-Message-State: APt69E36VAviz6hNmRwq12EWO5+ccRDAEoQWeqi2MktWMGA3QhrpMiPw
        zweMjMXeOwCplL1wQT3Ot7tm
X-Google-Smtp-Source: AAOMgpdNCYVy6om2gEti1ZPD95vlc/cgP2KKayvwmSqU1rx44HVPK+3/yl3T5Oes2mJ4bujR3kMm/Q==
X-Received: by 2002:a1c:3448:: with SMTP id b69-v6mr6499377wma.0.1530129740738;
        Wed, 27 Jun 2018 13:02:20 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id a12-v6sm5688776wrs.26.2018.06.27.13.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 13:02:20 -0700 (PDT)
Date:   Wed, 27 Jun 2018 23:02:18 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH] proc: save 2 atomic ops on write to "/proc/*/attr/*"
Message-ID: <20180627200218.GF18113@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code checks if write is done by current to its own attributes.
For that get/put pair is unnecessary as it can be done under RCU.

Note: rcu_read_unlock() can be done even earlier since pointer to a task
is not dereferenced. It depends if /proc code should look scary or not:

	rcu_read_lock();
	task = pid_task(...);
	rcu_read_unlock();
	if (!task)
		return -ESRCH;
	if (task != current)
		return -EACCESS:

P.S.: rename "length" variable.	Code like this

	length = -EINVAL;

should not exist.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2517,47 +2517,47 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 				   size_t count, loff_t *ppos)
 {
 	struct inode * inode = file_inode(file);
+	struct task_struct *task;
 	void *page;
-	ssize_t length;
-	struct task_struct *task = get_proc_task(inode);
-
-	length = -ESRCH;
-	if (!task)
-		goto out_no_task;
+	int rv;
 
+	rcu_read_lock();
+	task = pid_task(proc_pid(inode), PIDTYPE_PID);
+	if (!task) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
 	/* A task may only write its own attributes. */
-	length = -EACCES;
-	if (current != task)
-		goto out;
+	if (current != task) {
+		rcu_read_unlock();
+		return -EACCES;
+	}
+	rcu_read_unlock();
 
 	if (count > PAGE_SIZE)
 		count = PAGE_SIZE;
 
 	/* No partial writes. */
-	length = -EINVAL;
 	if (*ppos != 0)
-		goto out;
+		return -EINVAL;
 
 	page = memdup_user(buf, count);
 	if (IS_ERR(page)) {
-		length = PTR_ERR(page);
+		rv = PTR_ERR(page);
 		goto out;
 	}
 
 	/* Guard against adverse ptrace interaction */
-	length = mutex_lock_interruptible(&current->signal->cred_guard_mutex);
-	if (length < 0)
+	rv = mutex_lock_interruptible(&current->signal->cred_guard_mutex);
+	if (rv < 0)
 		goto out_free;
 
-	length = security_setprocattr(file->f_path.dentry->d_name.name,
-				      page, count);
+	rv = security_setprocattr(file->f_path.dentry->d_name.name, page, count);
 	mutex_unlock(&current->signal->cred_guard_mutex);
 out_free:
 	kfree(page);
 out:
-	put_task_struct(task);
-out_no_task:
-	return length;
+	return rv;
 }
 
 static const struct file_operations proc_pid_attr_operations = {
