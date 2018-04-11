Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/PjRjKMxHxAWLuLDw7iub3U/ayA4BTQRbvc9UAREqCj/BMMnCFUA1kWvgxJqZNZva8dVDo
ARC-Seal: i=1; a=rsa-sha256; t=1523459910; cv=none;
        d=google.com; s=arc-20160816;
        b=pS9jKSLn3UMQyyW8O0V3WoOHdmDq9uySMQ1FxFdEAy093AkKHy/sgo9znOc4P7bxlI
         0Q+qSBueZbteeocjGbZoTEuTdZfKJ+iHPL+M5mrbP3cZk/k3/Rb1v5lZB3sMQMuBuO9e
         Hq5wlIjwnd8pE/aFQbFe+5I7BoWQBNBImp53uQIMY6XEjAkLegpkJe8gwiMqF8txfbC6
         wBriMsX4WNC/X2dwd4ypYjA+aYdgHUGCUfj9Hek0D4N49O6VLePqHuGj09PS515jMbf9
         A3E5jPjK1tmHDdYi6wo54w1SM6Jznlo0zYfgW+6RCwMCIVM6sfzY94X9yX/ZqM8LVYat
         CRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=+sOYV2qJIPze1Cx5j/zEuEtxvF016x1bq/nEmFNBM58=;
        b=0nxUB1850SbQObQY8/W5zBz4qHblXkjdb+vc3uMix0GxBYjgWWMLHtGt1nzYq+mhMU
         4Szy8k7daYzIpkGuon+tKg9WAeIeJCAc3dxuY50dqTyZECS4QoxCkWUOXo1LSPfbnjtD
         IY97AbQi19QJFGLTkIGK0VT5bWltR2e6EhiTUzZGMntQNyKhVeFF1feKpSCoJIo+Waoz
         tmbFfa5gSkF4+pn/kcC6ZlZUoFATJ3voRBsoWIw/y6ZJeKfwROCasmyIzMyoJvzisSr1
         qRLq8NY6Zphp+kibw4Q6yYlgY6hFqaPA0nemlXdI83Uc16KtJWy/2S+oEdVdjYd+PojI
         YE4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=UW43flU6;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=UW43flU6;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753668AbeDKPS3 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 11 Apr 2018 11:18:29 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46286 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752870AbeDKPS2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Apr 2018 11:18:28 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: davem@davemloft.net, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: net: add in_netns.sh to TEST_PROGS
Date: Wed, 11 Apr 2018 17:17:34 +0200
Message-Id: <20180411151734.15507-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.16.3
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597463499107881201?=
X-GMAIL-MSGID: =?utf-8?q?1597463499107881201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Script in_netns.sh isn't installed.
--------------------
running psock_fanout test
--------------------
./run_afpackettests: line 12: ./in_netns.sh: No such file or directory
[FAIL]
--------------------
running psock_tpacket test
--------------------
./run_afpackettests: line 22: ./in_netns.sh: No such file or directory
[FAIL]

In current code added in_netns.sh to be installed.

Fixes: cc30c93fa020 ("selftests/net: ignore background traffic in psock_fanout")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/net/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 785fc18a16b4..8f1e13d2e547 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -5,7 +5,7 @@ CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
 CFLAGS += -I../../../../usr/include/
 
 TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh rtnetlink.sh
-TEST_PROGS += fib_tests.sh fib-onlink-tests.sh pmtu.sh
+TEST_PROGS += fib_tests.sh fib-onlink-tests.sh in_netns.sh pmtu.sh
 TEST_GEN_FILES =  socket
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy
 TEST_GEN_PROGS = reuseport_bpf reuseport_bpf_cpu reuseport_bpf_numa
-- 
2.16.3

