Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD51ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023D920850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023D920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbeGRWQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:16:30 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:43183 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeGRWQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:16:28 -0400
Received: by mail-qt0-f175.google.com with SMTP id f18-v6so5434650qtp.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WnQEd0ZhVezFb2KO/X5flI43ziSJjnemW3TeHBZ8x+Q=;
        b=Ik5rx0jhzHEWT9pIlDWySwl9H3pXEGU4NsRWH+C1TALd+ymkY0g5bUSijXDkMyC7T5
         j5glBlnBUm6ZFUnMDtEwIJhA9U9vzrkY04043tDDMnT60Uwb28XdDqxolcWKRNT0fmPY
         Rd7qYqHdnrvKWkpdnNd5lPKdhisIXCieZqg8yYsR6mo1AD4lJl0/ptZ/PCUZnyWtF+d5
         5sXbXdNg8wzjcYgV+TyFVWiKqZC99oQFhkCp4uBSKmk8b3RH65y0aG/A5Z59rap18/zx
         IP88pP4cQaUxGytUYDWuMDNDEJu6Vk+elBBJxXyarVJ3Z2KSsHRWn2IPqaiU/tgDG2h3
         o2bg==
X-Gm-Message-State: AOUpUlFMzKboZ2+mILqRtE6i44iIRQBJjKikEnyr2I6TUjHXqHEDNkCI
        OQbZ0ld5jJmdljhnanLNupr3/g==
X-Google-Smtp-Source: AAOMgpeTweAiiC/uRXEa3oV5KC6hRlHPmZxxNL+a0xVr1egEGztMJU+oHF4mQK4zgULG3JOWlM4Uyw==
X-Received: by 2002:a0c:c963:: with SMTP id v32-v6mr8227245qvj.215.1531949799993;
        Wed, 18 Jul 2018 14:36:39 -0700 (PDT)
Received: from laptop.jcline.org.com (cpe-2606-A000-1127-D1-82A4-FE7D-5832-CB87.dyn6.twc.com. [2606:a000:1127:d1:82a4:fe7d:5832:cb87])
        by smtp.gmail.com with ESMTPSA id f70-v6sm2692540qke.77.2018.07.18.14.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 14:36:39 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Jeremy Cline <jcline@redhat.com>
Subject: [PATCH] bpf: Add Python 3 support to selftests scripts for bpf
Date:   Wed, 18 Jul 2018 17:36:10 -0400
Message-Id: <20180718213610.19618-1-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust tcp_client.py and tcp_server.py to work with Python 3 by using
the print function, marking string literals as bytes, and using the
newer exception syntax. This should be functionally equivalent and
support Python 2.6 through Python 3.7.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 tools/testing/selftests/bpf/tcp_client.py | 12 ++++++------
 tools/testing/selftests/bpf/tcp_server.py | 17 +++++++++--------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/tcp_client.py b/tools/testing/selftests/bpf/tcp_client.py
index 481dccdf140c..9fe5f1b5c020 100755
--- a/tools/testing/selftests/bpf/tcp_client.py
+++ b/tools/testing/selftests/bpf/tcp_client.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python2
+#!/usr/bin/env python
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
index bc454d7d0be2..1d4a40a6584b 100755
--- a/tools/testing/selftests/bpf/tcp_server.py
+++ b/tools/testing/selftests/bpf/tcp_server.py
@@ -1,7 +1,8 @@
-#!/usr/bin/env python2
+#!/usr/bin/env python
 #
 # SPDX-License-Identifier: GPL-2.0
 #
+from __future__ import print_function
 
 import sys, os, os.path, getopt
 import socket, time
@@ -9,11 +10,11 @@ import subprocess
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
 
@@ -22,7 +23,7 @@ def send(sock, s):
     count = 0
     while count < total:
         try: n = sock.send(s)
-        except (socket.error), e: n = 0
+        except (socket.error) as e: n = 0
         if n == 0:
             return count;
         count += n
@@ -43,7 +44,7 @@ host = socket.gethostname()
 
 try: serverSocket.bind((host, 0))
 except socket.error as msg:
-    print 'bind fails: ', msg
+    print('bind fails: ' + str(msg))
 
 sn = serverSocket.getsockname()
 serverPort = sn[1]
@@ -51,10 +52,10 @@ serverPort = sn[1]
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
@@ -79,5 +80,5 @@ while True:
                 serverSocket.close()
                 sys.exit(0)
     else:
-        print 'Select timeout!'
+        print('Select timeout!')
         sys.exit(1)
-- 
2.17.1

