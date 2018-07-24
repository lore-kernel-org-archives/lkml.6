Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33691C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2E020852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2E020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388760AbeGXVCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:02:02 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44167 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388572AbeGXVCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:02:02 -0400
Received: by mail-qt0-f193.google.com with SMTP id b15-v6so5387233qtp.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 12:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oNjFS0dcLSG7SsDaWI6O7p5t9gTOEPyQqyv9R3BGNds=;
        b=KBZOr9qwPvNNebEtWUJOi9qNK+as01QOCfeapvP2LPQGsLenrFYQcGeRoaCeDa5phU
         WOUKVxbFyVOumgYHNNMfFKzqSU+QJMqOJA82zcuJjw2aKDp/ELcnfRokUzAZqXFIdjLA
         NpagfkI+E1HctBLLcrifyV2xaGusht8deKmdKnwlsC0O1avfCXMnwt6v1gpy+Av/pXtA
         frTekJVvuSiTRua3yC7s1AQeFSAK+4lO8eCiSfzNJvbqrOQBhpGzyLroqaGE27RNznpz
         aEb9+8udD+PZlNUU2pi+wImJ38Lh1+V1g8Cgt2ZZJJMUA8a50k31mEDs2/YxHBmlMnDJ
         3bfQ==
X-Gm-Message-State: AOUpUlHn2eoKAXFT3Tdd2vNOcYbwHXcShZqRSO7vzsQNk5aQThnBzbA8
        iFTlc5EhodS3M3OzkbrFIPXN+A==
X-Google-Smtp-Source: AAOMgpepz8WQcgqTx0P2U7oOMwt9sFBsV/JMSfup80T9jL6hRW55JplFmyJRJl9GUrX4I1Kj7g3kFQ==
X-Received: by 2002:ac8:21d2:: with SMTP id 18-v6mr18242818qtz.70.1532462039655;
        Tue, 24 Jul 2018 12:53:59 -0700 (PDT)
Received: from laptop.jcline.org.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id d12-v6sm8007755qtp.6.2018.07.24.12.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 12:53:58 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     Lawrence Brakmo <brakmo@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH v2] bpf: Add Python 3 support to selftests scripts for bpf
Date:   Tue, 24 Jul 2018 15:53:34 -0400
Message-Id: <20180724195334.13965-1-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust tcp_client.py and tcp_server.py to work with Python 3 by using
the print function, marking string literals as bytes, and using the
newer exception syntax. This should be functionally equivalent and
supports Python 3+.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---

Changes since v1:
  - Drop Python 2 support

 tools/testing/selftests/bpf/tcp_client.py | 12 ++++++------
 tools/testing/selftests/bpf/tcp_server.py | 16 ++++++++--------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/tcp_client.py b/tools/testing/selftests/bpf/tcp_client.py
index 481dccdf140c..7f8200a8702b 100755
--- a/tools/testing/selftests/bpf/tcp_client.py
+++ b/tools/testing/selftests/bpf/tcp_client.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python2
+#!/usr/bin/env python3
 #
 # SPDX-License-Identifier: GPL-2.0
 #
@@ -9,11 +9,11 @@ import subprocess
 import select
 
 def read(sock, n):
-    buf = ''
+    buf = b''
     while len(buf) < n:
         rem = n - len(buf)
         try: s = sock.recv(rem)
-        except (socket.error), e: return ''
+        except (socket.error) as e: return b''
         buf += s
     return buf
 
@@ -22,7 +22,7 @@ def send(sock, s):
     count = 0
     while count < total:
         try: n = sock.send(s)
-        except (socket.error), e: n = 0
+        except (socket.error) as e: n = 0
         if n == 0:
             return count;
         count += n
@@ -39,10 +39,10 @@ try:
 except socket.error as e:
     sys.exit(1)
 
-buf = ''
+buf = b''
 n = 0
 while n < 1000:
-    buf += '+'
+    buf += b'+'
     n += 1
 
 sock.settimeout(1);
diff --git a/tools/testing/selftests/bpf/tcp_server.py b/tools/testing/selftests/bpf/tcp_server.py
index bc454d7d0be2..b39903fca4c8 100755
--- a/tools/testing/selftests/bpf/tcp_server.py
+++ b/tools/testing/selftests/bpf/tcp_server.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python2
+#!/usr/bin/env python3
 #
 # SPDX-License-Identifier: GPL-2.0
 #
@@ -9,11 +9,11 @@ import subprocess
 import select
 
 def read(sock, n):
-    buf = ''
+    buf = b''
     while len(buf) < n:
         rem = n - len(buf)
         try: s = sock.recv(rem)
-        except (socket.error), e: return ''
+        except (socket.error) as e: return b''
         buf += s
     return buf
 
@@ -22,7 +22,7 @@ def send(sock, s):
     count = 0
     while count < total:
         try: n = sock.send(s)
-        except (socket.error), e: n = 0
+        except (socket.error) as e: n = 0
         if n == 0:
             return count;
         count += n
@@ -43,7 +43,7 @@ host = socket.gethostname()
 
 try: serverSocket.bind((host, 0))
 except socket.error as msg:
-    print 'bind fails: ', msg
+    print('bind fails: ' + str(msg))
 
 sn = serverSocket.getsockname()
 serverPort = sn[1]
@@ -51,10 +51,10 @@ serverPort = sn[1]
 cmdStr = ("./tcp_client.py %d &") % (serverPort)
 os.system(cmdStr)
 
-buf = ''
+buf = b''
 n = 0
 while n < 500:
-    buf += '.'
+    buf += b'.'
     n += 1
 
 serverSocket.listen(MAX_PORTS)
@@ -79,5 +79,5 @@ while True:
                 serverSocket.close()
                 sys.exit(0)
     else:
-        print 'Select timeout!'
+        print('Select timeout!')
         sys.exit(1)
-- 
2.17.1

