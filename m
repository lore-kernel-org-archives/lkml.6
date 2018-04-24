Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/yKgaAqgBlyURVFdIz5YD23nV3lmqVOkaZeBxQnsYTBGUK/H9g4mhpiKuQGT/7qZ1po6HF
ARC-Seal: i=1; a=rsa-sha256; t=1524608401; cv=none;
        d=google.com; s=arc-20160816;
        b=AX3CVYedmQaiVCKssJITgRXjgsM83HL8VMogvr3x4+HKvuQqbQioOz3PMASen/mvjy
         jzI27DdKBtT4FgKcOMpULvCFLl2P7aMhKDKnBErTmMXLzK15HLkOFmbds9miyqU+kIMR
         UISrLWSPefvqIwHPUFf0GxtVbei1Pa+NQeTlcN4WFRTzKPxkel4Zkt12yigf6n/xIL41
         2puDXDUPT8xi5Fm6iUoJxyhZYq1kMe/MYuvnsqu03uVHJ2evmJdgfC72H0txI1o0xSbr
         P2PHUwLBjdXnROR+E1zchQsDbMrF7QTPFLhFM7LffGaSvTKC/1lFkWq5jZnrdvnTHJJM
         j3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=nVvSYNp8+iZsumvscmx2tqO4tlMCFSmhIznXiJ9QO6U=;
        b=wSAiqiCjyMdKkicZ2HeICR6XR9FYrwQg+hyhbqbW8GS71xblqLoNyez/IKUhMBS1TZ
         cQifNSQqnBgfBhdw7Ssy5eQQso5Yvw0Nae0SltKuRBP6F5EAAhxIQyhHo0XZjVBoH1S6
         7hWd7RaMr5WOS0k4iSa5D+TwVGaW9rA+V+TPZbwiiNFYZdFh1u8lePbPOGVueC3mCPjk
         dHWuDuB4ysfc+E6HHNkNWj4bKbx9mGlmrxdsuZdSmjp+4EjDqPl9s4km2KegFsQW5saJ
         CiakQeEaBpviXV/ENgs+yEtmS1hfP6O5a2B7RQvXdNoFEfs63ORIB42nohQTysSDlOOt
         fqrw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=eC39BT6l;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=eC39BT6l;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750841AbeDXWUA (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 24 Apr 2018 18:20:00 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32783 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeDXWT7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Apr 2018 18:19:59 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: davem@davemloft.net, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: net: add in_netns.sh TEST_GEN_PROGS_EXTENDED
Date: Wed, 25 Apr 2018 00:19:52 +0200
Message-Id: <20180424221952.12081-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598667778719810638?=
X-GMAIL-MSGID: =?utf-8?q?1598667778719810638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Script in_netns.sh is a utility function and not its own test so it
shouldn't be part of the TEST_PROGS. The in_netns.sh get used by
run_afpackettests.
To install in_netns.sh without being added to the main run_kselftest.sh
script use the TEST_GEN_PROGS_EXTENDED variable.

Fixes: 5ff9c1a3dd92 ("selftests: net: add in_netns.sh to TEST_PROGS")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/net/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index c3761c35f542..4a8cfe8071a7 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -5,7 +5,8 @@ CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
 CFLAGS += -I../../../../usr/include/
 
 TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh rtnetlink.sh
-TEST_PROGS += fib_tests.sh fib-onlink-tests.sh in_netns.sh pmtu.sh
+TEST_PROGS += fib_tests.sh fib-onlink-tests.sh pmtu.sh
+TEST_GEN_PROGS_EXTENDED := in_netns.sh
 TEST_GEN_FILES =  socket
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy
 TEST_GEN_FILES += tcp_mmap
-- 
2.11.0

