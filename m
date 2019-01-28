Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6A9C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243FE20870
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfA1FBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 00:01:19 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43072 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726137AbfA1FBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 00:01:18 -0500
Received: from mr4.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0S4OvHP000687
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:24:57 -0500
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0S4Oqdg023807
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:24:57 -0500
Received: by mail-qk1-f197.google.com with SMTP id w185so17129041qka.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 20:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:date:message-id;
        bh=tf/ViSG1X+fWfX4ineCpozCh9veL6tmNUzzl13HY70k=;
        b=o6wcMrzhoFuxqzsvWOeK11PqQghuUNdygomzSNAGeQ0SfEjojcXqtwXWK2eFDPPCzP
         C8HFp3laZTUbJOst28h/qQGroB6mk6dW2+T2EUm7SQYpmQv63FWTH8cfxcvw0Ycmap5T
         d/nEUQw42GPntAFrT2bTn6eqsWV1oVcdK7488EaIfj9TBV7iyMPDL7DQK8mz5eVbnJVI
         smoec8x+mZzjpERK0sA7k8+yCpY9LfJHW8NK058T0o1ANy1AIs30BJak6dlafNBQ3KPu
         OUspAluJ3Me5zwsPUBKHw6j0ttr+AhRPBVrMva4b2aLOr72JlYsPIupPjW/W0Dq67CDi
         +Q6Q==
X-Gm-Message-State: AJcUukfRJLLCD9O9K9c1cyTSTpl+lacZJeIQGQ57hZS85VguwhrGXnJL
        37WwIrDn+tCBMT1pFJAP5e5O5Az9weZLl+/AXhWh0YkfAeV7qxT+BXy8FuK++3vuneY161ahDEE
        ispBf8pTIp8t8ppLpIVUcMUdqScjihY53wQM=
X-Received: by 2002:ac8:4a8e:: with SMTP id l14mr19595834qtq.135.1548649492401;
        Sun, 27 Jan 2019 20:24:52 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6JshhmRusjvQz38CFAnIwgiFfxLMp11YVCcwleEiC9jFmSLsoq6puZCtORv4nJ14HUBffMBQ==
X-Received: by 2002:ac8:4a8e:: with SMTP id l14mr19595828qtq.135.1548649492250;
        Sun, 27 Jan 2019 20:24:52 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id e17sm86796668qte.12.2019.01.27.20.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 20:24:51 -0800 (PST)
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
From:   valdis.kletnieks@vt.edu
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/hung_task.c - fix sparse warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sun, 27 Jan 2019 23:25:25 -0500
Message-ID: <467.1548649525@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse complains:

  CHECK   kernel/hung_task.c
kernel/hung_task.c:28:19: warning: symbol 'sysctl_hung_task_check_count' was not declared. Should it be static?
kernel/hung_task.c:42:29: warning: symbol 'sysctl_hung_task_timeout_secs' was not declared. Should it be static?
kernel/hung_task.c:47:29: warning: symbol 'sysctl_hung_task_check_interval_secs' was not declared. Should it be static?
kernel/hung_task.c:49:19: warning: symbol 'sysctl_hung_task_warnings' was not declared. Should it be static?
kernel/hung_task.c:61:28: warning: symbol 'sysctl_hung_task_panic' was not declared. Should it be static?
kernel/hung_task.c:219:5: warning: symbol 'proc_dohung_task_timeout_secs' was not declared. Should it be static?

Add the appropriate header file to provide declarations.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 4a9191617076..0c11216171c9 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -19,6 +19,7 @@
 #include <linux/utsname.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/sysctl.h>
 
 #include <trace/events/sched.h>
 


