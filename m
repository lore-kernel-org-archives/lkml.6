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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAE7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAEF20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hr4oYcGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAEF20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeLKLzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:55:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42078 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeLKLzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:55:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so7011642pfr.9;
        Tue, 11 Dec 2018 03:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BcU/PensVZQ/3s9/UpUArjYA7/LB9SQLVIT05ofsJ2M=;
        b=Hr4oYcGAa4fW3BOEQJzJQ9OMmjKP61ivoOX7jLSnXzFGD2dyTcrinTjoScmrYEEhP/
         PDcD7HakU3PWBAJ8MsmfDEwGxo1mZauDmpR+0O2mQ06XjUBzfAz1KvnkHSC3k61C8EGY
         ZR0TwqNqqXrmerpCHxUivDrzNPQYsP8ZftOHxNCw0j5mcNvuxdaV5v/vM4NOim3KjJI4
         wtIJKZ66PgZfFAOo6blE7yI3LG0j19tiEyfO9+j4w24NyRzHsCzcbLTxI2GvyCe478sc
         BckkALDJX7kY0Z5uQp0G/PKr4Gox5ANzqZOFrUoOIVTK8ZvPh/AtZGmlU1V7CbXYSuDq
         qs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BcU/PensVZQ/3s9/UpUArjYA7/LB9SQLVIT05ofsJ2M=;
        b=igsR6lVxWnj0Hr5+VJJwrCYkeQQhW4jRwikk7nuoYSVQtg4PSWFlvJRsmCFzSPl9qk
         68BU4bCHUVrcxsDnsXw3p+i82DO75HOlvt9qPs8PS/WY+3sG9gLl22kwzFE8xTZnfBXh
         mvKxAiIUOkkDRAWeWmq/3h6ywv47K2KUmeAZW34u1Rw2ufv3MbFGRSWXCRCqII2YRx5t
         1NC3qrXDA00oLLCEghKSzB28Cu18OihfNWQjwR1yQ1pXWeOHi72dv5Vrp6X8aUQztVXx
         40I3CAsTTH0IGhZh+A0lT7Fzdtyht59FTLQW1ky+ts81So6ohkQ0w3TFpFwMbHhdKsJF
         5R7A==
X-Gm-Message-State: AA+aEWb9QwdwCmwsVnRspV29gUpkbf1LuNHzYcAAVSNWuVIDzGoCert4
        b7NMPDUc2x7biKAWJ3oFom0=
X-Google-Smtp-Source: AFSGD/VXWCzpaFH7d/IdlwQgkt/hn7KAIY1RVZ3Ol3oSta610Up8ZQm/qfPsS7AR8pmdZCl02HWhaA==
X-Received: by 2002:a63:62c3:: with SMTP id w186mr14420679pgb.345.1544529329257;
        Tue, 11 Dec 2018 03:55:29 -0800 (PST)
Received: from localhost (219x123x27x194.ap219.ftth.ucom.ne.jp. [219.123.27.194])
        by smtp.gmail.com with ESMTPSA id u6sm15804540pgr.79.2018.12.11.03.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 03:55:28 -0800 (PST)
From:   Alice Ferrazzi <alice.ferrazzi@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>
Subject: [PATCH 1/7] selftest/bpf: Fix trailing semicolon in the statement
Date:   Tue, 11 Dec 2018 20:56:01 +0900
Message-Id: <20181211115607.13774-2-alice.ferrazzi@gmail.com>
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

fix python PEP8 style issue

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@gmail.com>
---
 tools/testing/selftests/bpf/tcp_client.py | 4 ++--
 tools/testing/selftests/bpf/tcp_server.py | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/tcp_client.py b/tools/testing/selftests/bpf/tcp_client.py
index 7f8200a8702b..c3c44633c801 100755
--- a/tools/testing/selftests/bpf/tcp_client.py
+++ b/tools/testing/selftests/bpf/tcp_client.py
@@ -24,7 +24,7 @@ def send(sock, s):
         try: n = sock.send(s)
         except (socket.error) as e: n = 0
         if n == 0:
-            return count;
+            return count
         count += n
     return count
 
@@ -45,7 +45,7 @@ while n < 1000:
     buf += b'+'
     n += 1
 
-sock.settimeout(1);
+sock.settimeout(1)
 n = send(sock, buf)
 n = read(sock, 500)
 sys.exit(0)
diff --git a/tools/testing/selftests/bpf/tcp_server.py b/tools/testing/selftests/bpf/tcp_server.py
index b39903fca4c8..183d07509a0a 100755
--- a/tools/testing/selftests/bpf/tcp_server.py
+++ b/tools/testing/selftests/bpf/tcp_server.py
@@ -24,7 +24,7 @@ def send(sock, s):
         try: n = sock.send(s)
         except (socket.error) as e: n = 0
         if n == 0:
-            return count;
+            return count
         count += n
     return count
 
@@ -72,7 +72,7 @@ while True:
                 address = str(address[0])
                 readList.append(clientSocket)
             else:
-                sock.settimeout(1);
+                sock.settimeout(1)
                 s = read(sock, 1000)
                 n = send(sock, buf)
                 sock.close()
-- 
2.19.2

