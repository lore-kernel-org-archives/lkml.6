Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98459C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFF420849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSNLipqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFF420849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbeLKLzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:55:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39106 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeLKLzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:55:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so7022469pfc.6;
        Tue, 11 Dec 2018 03:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z8fi+4hZoWoOB0xXjU5wSf479DpIZ2+IWk4s+qeP434=;
        b=XSNLipqvcnMbY0Jt0NojebOIxcVtc2V8Yc13+IqzPjFNnNTwsmgstBtnqchoK5f49e
         /w+yZNCf95Eg6VaVw/X/XbR03o2N1XfBu+Zuj18qoLtTAP4knfyZtlgwsx0GaN8g1oe+
         EU399lY0ipep0/zS2BmBQ0S6mSQYDrefBmQns9CKiORkQ0TGRmvRuPnX9Uvs/wlQ+hn8
         gugVKcTCxMjG6MzUY2glkXu06mc+QPBUpswhIri/W1qzjEMPBV9s91kkmrojmKNayb0L
         pjPmsDqgoGIVkfXreOfGaOZ64RRrK657Hh29uHByV5Sjsw0tTlP5fApy3SIHTuwzEsdI
         +Nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z8fi+4hZoWoOB0xXjU5wSf479DpIZ2+IWk4s+qeP434=;
        b=le15a4v8W/LJgtLbdBmI3AHG4arYROYmXw8tk/yj8NAzZrZdSS49HVpswPqYMGyioM
         yi0ZLSZ15iKbvIXyJ6/gI6wBTKxtL1XgYzVHdeedZyAGJyVb8Fwlsf6wbEbRRz9SMRQD
         HEzsvdMZuA/C8Dx7LzJTsnGirCQ0l2cftSz91wUcehPnrGJoDHyJXUx1avAwS5GU5lVQ
         IEFRoRoZphEVDeLhZmdmt7e1KxT9QK/xonY3NVe/exr9IM5ghvv1QCnN45+axuFlAXws
         cgdRfchUc9rc2BskLXPTobzJO0odW8UuJx3/6DWbaczaNbCY594cFfJ9DIcv8jzCTtUj
         G1FA==
X-Gm-Message-State: AA+aEWabRD7YbIuHWrdSPe9+l5BKE4qvolNkdQPLg6LC6pa1SzI4Izcu
        oHSuf5pGV6++w97RdWf/FBbFPx6m
X-Google-Smtp-Source: AFSGD/U1VhThH/XT2E40lJEaSj0angzvYtlqLJhCAy59sfb+zSPiz0oMyoulANFYRlFsuW2KTezLpA==
X-Received: by 2002:a65:6447:: with SMTP id s7mr14212956pgv.226.1544529338951;
        Tue, 11 Dec 2018 03:55:38 -0800 (PST)
Received: from localhost (219x123x27x194.ap219.ftth.ucom.ne.jp. [219.123.27.194])
        by smtp.gmail.com with ESMTPSA id r12sm15395880pgv.83.2018.12.11.03.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 03:55:38 -0800 (PST)
From:   Alice Ferrazzi <alice.ferrazzi@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>
Subject: [PATCH 2/7] selftest/bpf: optimize import
Date:   Tue, 11 Dec 2018 20:56:02 +0900
Message-Id: <20181211115607.13774-3-alice.ferrazzi@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211115607.13774-1-alice.ferrazzi@gmail.com>
References: <20181211115607.13774-1-alice.ferrazzi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix PEP8 warnings

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@gmail.com>
---
 tools/testing/selftests/bpf/tcp_client.py | 7 +++----
 tools/testing/selftests/bpf/tcp_server.py | 7 ++++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/tcp_client.py b/tools/testing/selftests/bpf/tcp_client.py
index c3c44633c801..ad3de27cd605 100755
--- a/tools/testing/selftests/bpf/tcp_client.py
+++ b/tools/testing/selftests/bpf/tcp_client.py
@@ -3,10 +3,9 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-import sys, os, os.path, getopt
-import socket, time
-import subprocess
-import select
+import socket
+import sys
+
 
 def read(sock, n):
     buf = b''
diff --git a/tools/testing/selftests/bpf/tcp_server.py b/tools/testing/selftests/bpf/tcp_server.py
index 183d07509a0a..f7491517cc49 100755
--- a/tools/testing/selftests/bpf/tcp_server.py
+++ b/tools/testing/selftests/bpf/tcp_server.py
@@ -3,10 +3,11 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-import sys, os, os.path, getopt
-import socket, time
-import subprocess
+import socket
+import os.path
 import select
+import sys
+
 
 def read(sock, n):
     buf = b''
-- 
2.19.2

