Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C22C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E4F20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ+sooAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E4F20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeLKLzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:55:47 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:35818 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeLKLzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:55:47 -0500
Received: by mail-pg1-f177.google.com with SMTP id s198so6544589pgs.2;
        Tue, 11 Dec 2018 03:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SlJCnY5DeXCwcqWwl1Fo1heqQs1jJancafkPG5apsCE=;
        b=AQ+sooAPKlIg/i0xOI3aQWJtXEtgnx7Hej+YK9TzuqWNLt1wrRaJHUVcotomRSVwZD
         uD7cYqI3olvoeqaJVMfN+xRXUqcJ2iVbsNS3hsuyhGaeOTyP5d3AYjHNJiPP9GLLJVDp
         /q0Op02cM/3uIXeBJoVoRWokMqr/wE7R0XUiX2qqSihrCDM/SiJaUdPY4c3WR80JBFU6
         aceip08xGfrGQBvh8nMGZCVmCWAeGfZQkqyULLjfw5p9U3PShgapski60Pbdhn8gk27X
         IsMw92sWb8yMtCFe+xbB9ZW3zP19QjVyEuq+J6JKA7Zomvg3BdDONuK5P3+44ESjmMsy
         fXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SlJCnY5DeXCwcqWwl1Fo1heqQs1jJancafkPG5apsCE=;
        b=Jflow7dY5VJlr7zx92PhY0Z0DZKk/mteem09yaj6IZb1n5JS/dg8fz8OBAf2/Td9UU
         AB7+KIbbEePxUwrrNP2XG4r5CiPfEp7p6FfMi6JECp/nTkgobksc1L+T3XGOKUhoIhAg
         lm6720ndyydoht29RQBOThRAJ5NB8RY0VPztjWakZEcwEGKBjZsw2iBAvLC89wyM8+lQ
         ARx6GuIWqh3cvvfOsuAq7myi6gm3LMg5D//tOTKH4jU54bS2kDt505PNNBdWdzpxz+U/
         uOyH0LygdQXABvNCY8WbjgO7T7gZD4QwcyUCwav+HGj1XrUMUQAzua6pAh0G5W4sJzOI
         FnLQ==
X-Gm-Message-State: AA+aEWbpD79/WAtbiD9ZffGtWpq9fG2EbSc9syTXCnTGc37r61qxqdWG
        VvwLelpQr+qGpx46Fsz4gbE=
X-Google-Smtp-Source: AFSGD/XX1VPlPbjKbTpa9TlMWBd9A8cM6IBuNZUH4ikPgXaTklxN7C+AQB/sxPNA0xj9Pt+FDJsO/A==
X-Received: by 2002:a63:2784:: with SMTP id n126mr14653571pgn.48.1544529346345;
        Tue, 11 Dec 2018 03:55:46 -0800 (PST)
Received: from localhost (219x123x27x194.ap219.ftth.ucom.ne.jp. [219.123.27.194])
        by smtp.gmail.com with ESMTPSA id 85sm20227525pfw.17.2018.12.11.03.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 03:55:45 -0800 (PST)
From:   Alice Ferrazzi <alice.ferrazzi@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>
Subject: [PATCH 3/7] selftest/bpf: PEP 8: multiple statements on one line (colon)
Date:   Tue, 11 Dec 2018 20:56:03 +0900
Message-Id: <20181211115607.13774-4-alice.ferrazzi@gmail.com>
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

Reformat the file for fixing PEP 8 style

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@gmail.com>
---
 tools/testing/selftests/bpf/tcp_client.py | 13 +++++++++----
 tools/testing/selftests/bpf/tcp_server.py | 16 +++++++++++-----
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/tcp_client.py b/tools/testing/selftests/bpf/tcp_client.py
index ad3de27cd605..31f022bf06fa 100755
--- a/tools/testing/selftests/bpf/tcp_client.py
+++ b/tools/testing/selftests/bpf/tcp_client.py
@@ -11,17 +11,22 @@ def read(sock, n):
     buf = b''
     while len(buf) < n:
         rem = n - len(buf)
-        try: s = sock.recv(rem)
-        except (socket.error) as e: return b''
+        try:
+            s = sock.recv(rem)
+        except (socket.error) as e:
+            return b''
         buf += s
     return buf
 
+
 def send(sock, s):
     total = len(s)
     count = 0
     while count < total:
-        try: n = sock.send(s)
-        except (socket.error) as e: n = 0
+        try:
+            n = sock.send(s)
+        except (socket.error) as e:
+            n = 0
         if n == 0:
             return count
         count += n
diff --git a/tools/testing/selftests/bpf/tcp_server.py b/tools/testing/selftests/bpf/tcp_server.py
index f7491517cc49..af79210249af 100755
--- a/tools/testing/selftests/bpf/tcp_server.py
+++ b/tools/testing/selftests/bpf/tcp_server.py
@@ -13,17 +13,22 @@ def read(sock, n):
     buf = b''
     while len(buf) < n:
         rem = n - len(buf)
-        try: s = sock.recv(rem)
-        except (socket.error) as e: return b''
+        try:
+            s = sock.recv(rem)
+        except (socket.error) as e:
+            return b''
         buf += s
     return buf
 
+
 def send(sock, s):
     total = len(s)
     count = 0
     while count < total:
-        try: n = sock.send(s)
-        except (socket.error) as e: n = 0
+        try:
+            n = sock.send(s)
+        except (socket.error) as e:
+            n = 0
         if n == 0:
             return count
         count += n
@@ -42,7 +47,8 @@ HostName = socket.gethostname()
 serverSocket = socket.socket(socket.AF_INET6, socket.SOCK_STREAM)
 host = socket.gethostname()
 
-try: serverSocket.bind((host, 0))
+try:
+    serverSocket.bind((host, 0))
 except socket.error as msg:
     print('bind fails: ' + str(msg))
 
-- 
2.19.2

