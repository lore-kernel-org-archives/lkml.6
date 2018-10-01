Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D1CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674CC2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJiAphgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674CC2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbeJAPPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:15:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34173 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeJAPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:15:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so8703915pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FUtAM4/PGlQ5AwZFr9TcZXJbLvGZLqWXiwgZBNGJ2T0=;
        b=KJiAphgL4EJFw4IGdZB2SC/SH0a1SlkUImsSv/G4iFs/G/Bjn+zVDpFbE96nPAbo3E
         JsBBpihuInBhXAWhgh+uS+7g3vxcWpNyoVjwZu13lcyrB5rbR6gOjYFG7V+avbxpnoQ1
         uqKmb2CvTM1+Vt8s+JGfRkiRDbXR8sG1YWYUjG0VRISZy2OUyeysBBhgYCbvZM3isW9W
         3aVVhOFL6EfQ986lY3TcK/bakiuUIplFJ4RB0cZLytUeRj7zG+f9soko+ZkeuoabKJC4
         bT5o95Vg2okNUxUcnREnnZ+PP8yp6gTDmN5fatv1sUOPE95fObm/hcqDC2YhAVkfkRkY
         MEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FUtAM4/PGlQ5AwZFr9TcZXJbLvGZLqWXiwgZBNGJ2T0=;
        b=uHslfK4WGH6rvjQewQV5l86z1QAP6a2liG8O00rsMCUy0EBIPKypesRBekvpfFu1Qg
         uK9Q+AoREQGx2ca59IJavj0bZYu9aKOHtdpiJEPqeW+PqBsPGwE19uNNhec1YA3EvOxM
         F6Hhruk93tIUsWJNnrvR33xeNpcdBPKj168vNOyggjITlv+olBVF20jYxrNkhjzKvvfQ
         DB/J1tsNP02VokCSt8g1gyGQgkbKDFq86TGvK9CbTEpLDQ7hkCjs2fzezsfuIK9HCmpc
         91PPOr3oBWof76QYfw4OtgfhMpMz5Ucu1+4sKrGqWm2Y8KoSUcRmX3NmAmjypyE/WvwF
         e6dA==
X-Gm-Message-State: ABuFfoj6Y4kHhKdKhMNoBA33H74uuYrHEiKmXPLu3ZnSrjvFEublv/ez
        fGh9VS6i164y6oW/G0YCvJogiSmOVs0=
X-Google-Smtp-Source: ACcGV61pHd2yS9FQgzjchpn8Lhjdf+IXb5CkVZIHRzVjiKI5Xz0jz5i2zWLew/+1f9NPM5tBCzuNjQ==
X-Received: by 2002:a17:902:d201:: with SMTP id t1-v6mr10627823ply.63.1538383151868;
        Mon, 01 Oct 2018 01:39:11 -0700 (PDT)
Received: from Sherlock.localdomain ([14.139.38.159])
        by smtp.gmail.com with ESMTPSA id u184-v6sm23562636pgd.27.2018.10.01.01.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 01:39:11 -0700 (PDT)
From:   Shubham Singh <dhoni.singh094@gmail.com>
To:     tglx@linutronix.de
Cc:     akpm@linux-foundation.org, jcline@redhat.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        shubhsherl <dhoni.singh094@gmail.com>
Subject: [PATCH] scripts: spdxcheck: resovle decode warning for python3
Date:   Mon,  1 Oct 2018 14:08:46 +0530
Message-Id: <20181001083846.9650-1-dhoni.singh094@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: shubhsherl <dhoni.singh094@gmail.com>

Resolve a warning issue by spdxcheck in Python3
FAIL: 'str' object has no attribute 'decode'

Signed-off-by: Shubham Singh <dhoni.singh094@gmail.com>
---
 scripts/spdxcheck.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 839e190bbd7a..6eea4073f28a 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -168,7 +168,8 @@ class id_parser(object):
         self.curline = 0
         try:
             for line in fd:
-                line = line.decode(locale.getpreferredencoding(False), errors='ignore')
+                if type(line) != str:
+                    line = line.decode(locale.getpreferredencoding(False), errors='ignore')
                 self.curline += 1
                 if self.curline > maxlines:
                     break
-- 
2.18.0

