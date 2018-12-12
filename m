Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B4DC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75C320839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REYR/oLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75C320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeLLNMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:12:14 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36460 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeLLNMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:12:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so15517253edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 05:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6qt46qUfRiiduNIF9Ae1L7GqcRy2C24+/4DIYnGDNg=;
        b=REYR/oLaVVsfbiWS0j6SwDgVRBSwy/daPGUHhyaKyldlIWv/VM2jmqg2HKTRK0oYPj
         7I1qcoZ6/2g3LZqjYAGziw5i9mfyqOpIqDXFSWe0wGyY9s+1BZzkC+RibtCOF2LD+WIS
         170/cZo7jcm00J4Wd/VynoWb/qmEsOFss4v4s+49xkMtSuX3xXkuyPZc/VxlndghyTsH
         YO4tOY9NqFodlJ4qQq8/OUTKa8ZOiotK6gjLcUesbywjdo7SHFB8NI3aMl+bxOEXf0kG
         UtvpVmlUdtiIEaxZmybHAkKebKKnXhCcyANqR8MdNbjPpQMgh+yYNsUF+Y+NEQsmGuLG
         vuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6qt46qUfRiiduNIF9Ae1L7GqcRy2C24+/4DIYnGDNg=;
        b=tEZ7tUedR2oM3gptXG8zvW3gdhZLUFDcQZ1Qb9HBLydNon+J0zZd2yq/IQLzKdp8nE
         WR9pGIPf2/BfS39agb4d7Uon3DapCoxuB1oBaX1iYDbQRMpJh87zX30Kt1UF75p4AgDm
         cR6mcvfbV5Rz7ubzXNzPjR5h9uDrHrxrMMhdd0dt9Mc3LBAcPThOc+cvoywPaRY9p7eo
         De+DSS2no0Vx/uknd7kvsXOg2aok5EC7S6HgfotAPpINLA3lEDVdq1hi/eww8xCQD4K+
         1Q2fMW1or6k97zc0ectLbRiDD2vgowvMECTTxOyRK8HbKyCaYF7IhfVR51b/781fS/Co
         F2HA==
X-Gm-Message-State: AA+aEWYVVQYUwOh+Qz8asFcc8Xr6dxoNpolL7Gm56m8HX2gddHywebjz
        iQj3JVejq6wKd+MsfD8Y//Y=
X-Google-Smtp-Source: AFSGD/WY3CCtFyRvcsu9YUZYieAhglmrUtULM3DtFvu/lP6IFYSLD+zTztqc8PdV+FkN7Fcnb1nRxQ==
X-Received: by 2002:a17:906:2496:: with SMTP id e22-v6mr15141789ejb.84.1544620332178;
        Wed, 12 Dec 2018 05:12:12 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id f20sm4810225edf.19.2018.12.12.05.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 05:12:11 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, Joe Perches <joe@perches.com>,
        Jeremy Cline <jcline@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scripts/spdxcheck.py: Always open files in binary mode
Date:   Wed, 12 Dec 2018 14:12:09 +0100
Message-Id: <20181212131210.28024-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The spdxcheck script currently falls over when confronted with a binary
file (such as Documentation/logo.gif). To avoid that, always open files
in binary mode and decode line-by-line, ignoring encoding errors.

One tricky case is when piping data into the script and reading it from
standard input. By default, standard input will be opened in text mode,
so we need to reopen it in binary mode.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 scripts/spdxcheck.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 5056fb3b897d..e559c6294c39 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -168,6 +168,7 @@ class id_parser(object):
         self.curline = 0
         try:
             for line in fd:
+                line = line.decode(locale.getpreferredencoding(False), errors='ignore')
                 self.curline += 1
                 if self.curline > maxlines:
                     break
@@ -249,12 +250,13 @@ if __name__ == '__main__':
 
     try:
         if len(args.path) and args.path[0] == '-':
-            parser.parse_lines(sys.stdin, args.maxlines, '-')
+            stdin = os.fdopen(sys.stdin.fileno(), 'rb')
+            parser.parse_lines(stdin, args.maxlines, '-')
         else:
             if args.path:
                 for p in args.path:
                     if os.path.isfile(p):
-                        parser.parse_lines(open(p), args.maxlines, p)
+                        parser.parse_lines(open(p, 'rb'), args.maxlines, p)
                     elif os.path.isdir(p):
                         scan_git_subtree(repo.head.reference.commit.tree, p)
                     else:
-- 
2.19.1

