Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F14EC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A30B2585E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/rsWyJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A30B2585E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966516AbeF0UGT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:06:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51366 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932944AbeF0UGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:06:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id w137-v6so7153802wmw.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 13:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Qba6x5Mo9MqNCjEHjEr3j5LON/CQ2BtILWeziqYlfh0=;
        b=r/rsWyJGQVOtD7XiZcHYEhTJpOzmsPpK4SO60ypbWhkb9gKg6weKOQOuuS/BlMacpB
         1/5OMfWbrzpIRHVcbdy/a5kpfcj7vJk1QF4Zsf20RAlUmPHIL4qXNjxsX/wt4pDK1hoX
         AG5fcbr9pG+MtaCnVCwGQXJxf5fMXPfQL3P9g0aQHCylS5H4WpQqo0qnlP4D4bN8kpMj
         bNnkFBTOZt0MylnoljM+BiKr32m+bCr3clnF4VX3V7p+KiXRiUY1WoeTdrRbUf1dp5WK
         0X0Ukbo7vCpgfL3Do9MCmKozT20fFlyq81dNmB/D8uomPDtwcgggwTZ/CRKUE6sHfo6K
         fi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Qba6x5Mo9MqNCjEHjEr3j5LON/CQ2BtILWeziqYlfh0=;
        b=m2N3gqagc5O2Imo/ihHgdrPQ5D1JOnaZ4s/vTkxm9jlhGY0y/o3XKAPcLwRjGbncm/
         FFAJrtkj+YCrrss0fqKZPgfdNycJ5jySNFt8TZmygC0I6xMZtxZr86GZnH6id0nuLO2O
         ZnMTqEqFSt4lLIO3YKK/mz5Dt3w4ofnyxK5JtmHQlEMzHvV5KZa6RIturYeMPmVP80OL
         wQGJIFm0ZF0AuZNPnV8BESfq8IJIOVHvm7hv5nA07MM9HT5+2FuctcLloJXSE/mYpl5z
         PDsz9M8zcK06Ajyb8yNgirTxZyKWNOpt6ZetiRWzJPReCb8HDKPRAePWi0luSLt1qHDq
         eHsw==
X-Gm-Message-State: APt69E0QyttEoErkoKiqHST1GTViLPSsMPVfSx1PWmX99S6ldnusHOQB
        HWHsuQpwG3S1e3nGzx1CbQ==
X-Google-Smtp-Source: AAOMgpehsbKMwmFpI7QUSScZNEeAfi+CaLO0mtH5qlh4GFPPycruqcl1WkZCKPsG9jDTS5cLRCXO0A==
X-Received: by 2002:a1c:9ec5:: with SMTP id h188-v6mr2424016wme.76.1530129976989;
        Wed, 27 Jun 2018 13:06:16 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id 203-v6sm9380812wmp.23.2018.06.27.13.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 13:06:16 -0700 (PDT)
Date:   Wed, 27 Jun 2018 23:06:14 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: spread "const" a bit
Message-ID: <20180627200614.GB18434@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/internal.h      |    4 ++--
 include/linux/proc_fs.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -113,12 +113,12 @@ static inline void *__PDE_DATA(const struct inode *inode)
 	return PDE(inode)->data;
 }
 
-static inline struct pid *proc_pid(struct inode *inode)
+static inline struct pid *proc_pid(const struct inode *inode)
 {
 	return PROC_I(inode)->pid;
 }
 
-static inline struct task_struct *get_proc_task(struct inode *inode)
+static inline struct task_struct *get_proc_task(const struct inode *inode)
 {
 	return get_pid_task(proc_pid(inode), PIDTYPE_PID);
 }
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -129,7 +129,7 @@ int open_related_ns(struct ns_common *ns,
 		   struct ns_common *(*get_ns)(struct ns_common *ns));
 
 /* get the associated pid namespace for a file in procfs */
-static inline struct pid_namespace *proc_pid_ns(struct inode *inode)
+static inline struct pid_namespace *proc_pid_ns(const struct inode *inode)
 {
 	return inode->i_sb->s_fs_info;
 }
