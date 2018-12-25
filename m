Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CD1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 19:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8714A2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 19:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="NXXpPoTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbeLYTQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 14:16:52 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:45560 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeLYTQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 14:16:52 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id B0300A3E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:16:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8mLSq2eu6RHK for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 13:16:50 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 88D50A2E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 13:16:50 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id 123so17726309itv.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 11:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aOcb1rSaAuolZQok5mKAqnoHh574DGL+u9tGkAvs8b8=;
        b=NXXpPoTxJf7zV/j131IQ61VDLLwf5MFYjs4S4jZyAxeNPRGcgXhxDirne1Aq23/2yS
         35cKGAckM8bPuqPx26wpywkOXcUViiattaM0t/SRqrmbTanumeyePYDS5ZapKuw4mkvO
         OISUoOsxFWK8TbECych47p2D69vRG1Bk29fHpv5aIX1tXU+kkb8Ge9QQAPdoVghdtYIJ
         YhfI3Mg3krdHXz4+iqeYoj6142JpOBO9pnxChZCozXNYHFtUYWZHW4MKhUvQYtJyp0EI
         0BPKi3SH4OG1wtNs+j2/6GZDMVAqZh75/vXiIaZgREfNOyW21/1ZMOjT1uuy+zXCuJId
         ZN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aOcb1rSaAuolZQok5mKAqnoHh574DGL+u9tGkAvs8b8=;
        b=HZ16itoZai6fthevST4LLFp/n/jQa/1FOUa0/EXFiM1R3U00G8/rikmwc1qKTfRdZP
         FQac1+3suAoPWyvD/LkaICaVsKgadHvsKFufTCLKg/dWBQRc+edN39+dnah5P4p05dxi
         wdTQDfIdZz8BvdZol6md/atTktNPU90e7skS35Ff+fGRYbb8iDuVkefzcgYQmRvr/prk
         N/x/QYtSA9AQBuTy5BsdPsbloAC3g9aaDLpnpcls9voE7ud46pO0R0NgZiOUg71E3I05
         V+XT7pSLEir+D2DImxJeO6Nji0nKW6iZuQgm74C5PJ1xonPt79DjUpAIuArtYD75WDEl
         1c0Q==
X-Gm-Message-State: AJcUukee6OaMaDuheJV/+93vjk/9JSRV7pfa0nUkwOj4jJC4AFVwZzns
        yw+/iHUa7EF0nKPctiHPQTuyHJWE4KpfBzwsiDkjVVMJPDxz81VG1lkQy2z7xeg7+a4Sl7W7wRL
        p32ff1CT/kIocWZ3UAJiSVhTTe2Nd
X-Received: by 2002:a6b:e512:: with SMTP id y18mr8919951ioc.145.1545765410140;
        Tue, 25 Dec 2018 11:16:50 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4ptse/qqQE3BXXxIVaNYb1Qbrxx81SIdsN1iwWWIQQgHpDWWtn2XXHNoyPLpVspn5xaNiPgg==
X-Received: by 2002:a6b:e512:: with SMTP id y18mr8919945ioc.145.1545765409900;
        Tue, 25 Dec 2018 11:16:49 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id i201sm16217191ioa.1.2018.12.25.11.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 11:16:49 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jan Harkes <jaharkes@cs.cmu.edu>,
        coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: coda: fix a double-fetch case when copy data to req->uc_data
Date:   Tue, 25 Dec 2018 13:16:21 -0600
Message-Id: <20181225191621.69120-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"hdr" has been copied in from user space and "hdr.opcode" is checked.
The code copies it again. User space data between the two copies is
subject to modification if the user-space code is multithreaded and
malicious. The modification may invalidate the check. The fix  avoids
copying the header from user space again.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 fs/coda/psdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index fb4d1c654773..248d21f84b54 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -174,7 +174,10 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 				hdr.opcode, hdr.unique);
 		nbytes = req->uc_outSize; /* don't have more space! */
 	}
-	if (copy_from_user(req->uc_data, buf, nbytes)) {
+	*((struct coda_in_hdr *)req->uc_data) = hdr;
+	if (copy_from_user(req->uc_data + sizeof(hdr),
+				buf + sizeof(hdr),
+				nbytes - sizeof(hdr))) {
 		req->uc_flags |= CODA_REQ_ABORT;
 		wake_up(&req->uc_sleep);
 		retval = -EFAULT;
-- 
2.17.2 (Apple Git-113)

