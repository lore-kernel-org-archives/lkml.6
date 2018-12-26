Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF0DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48AF20449
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="dKXPlvXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeLZDHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:07:12 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:45280 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeLZDHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 22:07:12 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 74967BC9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 03:07:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uaMSmBtoVnWx for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 21:07:10 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 43B03923
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:07:10 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id p66so17589424itc.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LhRU0wMug2gxITDlzmtL48zridTwZEWJxDKC9s+/s6k=;
        b=dKXPlvXqsSqzvRsMggqukHpIsvS4rVWUFk4Ix2Un9GTeqBI0V8wNwzzG/73U0pglgb
         YC3Pun4UJUERRq6rndM629HL414HdqYopLWjTF+uqPmKBupLOQquFqCkQFAwf0D7/mQ/
         GSA2g4XG+dQww4eEpowFbAS/zzJgrin3Ja3C+x8eOEOuOMf9DAcPrFEfIFTdljabzeGb
         TkkFvRIr7iDp/lADagn2YBXfZ/U9bxMfjbG8Ie0UeZv5N7+pdlwVSjfb7dcb8uIP6gZv
         fA94Z5nadXJUuz6xsxKoTi3RTllznKcVcsimIEnHEBaebMcpH+dy+iab86qIIoR1SQW7
         +qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LhRU0wMug2gxITDlzmtL48zridTwZEWJxDKC9s+/s6k=;
        b=ipaRycECtc+8HHbfj8KsFxTIDThRcG/QO8Gw554SAZiUtg9ep2Jqu3jg5oSP3X2mBI
         IaPAG1FsYraJVGkc5+ArBMkyA1aIN285S7v9e+Hb7ftQ3qa/HE7t2fOmYur1lhVtxVrx
         gbPVxwzntWssmxawdiJer+/uVuKxPm6RdmdWv1ZV+ZZ0s8KoYi9nQS51hXdA4SJDEV7n
         oLt4l7qfW/lCD+gXBG8gXBDF8jc53PJ024E/ULYDHOlNTXU78Lxm4sMSceDK9cdPaPC5
         Mz447QllkuUXJtlIq447OOzQkPgZwi2lq9IBQnxDpogCZAbJkxY4VhjY2BmwZC0FC4ph
         vqJA==
X-Gm-Message-State: AA+aEWbNCuFaV1WbyV54NLd8lDS+c7iHhOFJpN3eW/il0VasojowkB5M
        KpR0uWHbBvx6jnoofSdawa1mtYIQxlhJ4vMTlHWt2p+62/5JUaYezBT/kpf6LFZ3UZxpTJO9gS7
        EeyVt3oP6KuPh4zHpyzweCNOIAhCT
X-Received: by 2002:a02:13c6:: with SMTP id 189mr11943110jaz.117.1545793629858;
        Tue, 25 Dec 2018 19:07:09 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VeH++B1DjGUaMFYkI1G8QzaRpqcTJ4lOjw6UImLKNlQ1R8Ugh3J/oSuM8UNPkIA4bH1IoGgA==
X-Received: by 2002:a02:13c6:: with SMTP id 189mr11943101jaz.117.1545793629621;
        Tue, 25 Dec 2018 19:07:09 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id g21sm6325883itg.44.2018.12.25.19.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 19:07:08 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: proc: check status of register_filesystem
Date:   Tue, 25 Dec 2018 21:06:40 -0600
Message-Id: <20181226030642.72757-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

register_filesystem() could fail. The fix issues an error message if it
fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 fs/proc/root.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index f4b1a9d2eca6..7dcd947cba23 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -141,7 +141,8 @@ void __init proc_root_init(void)
 	proc_mkdir("bus", NULL);
 	proc_sys_init();
 
-	register_filesystem(&proc_fs_type);
+	if (register_filesystem(&proc_fs_type))
+		pr_err("failed to register the filesystem.\n");
 }
 
 static int proc_root_getattr(const struct path *path, struct kstat *stat,
-- 
2.17.2 (Apple Git-113)

