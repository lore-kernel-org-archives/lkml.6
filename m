Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZqWGv2bHkdvIdevSrWFyLaMN/NGLwcIz4sP4ceccXj94EB/o2RpSwt1z9LKuxVnNpSwCYxH
ARC-Seal: i=1; a=rsa-sha256; t=1525452483; cv=none;
        d=google.com; s=arc-20160816;
        b=ZxM+LtuKJe5p8bZVsW88yuBmjM2S5WbU4d94ClGrfeDmjdJM9V23WehcbDV4PvfKMA
         BS9uqrQ5AKMJ6BZJ3q54qI+7UTTctZj6z2OevJRJlwaus16fO6kfgIjVmVdGj5LoCB61
         hhJxFmTBbcEiuS8qPJCq9zpOGiKlvzN2PKYRSX+EV18CKrMMbMfboJCUdAfcGH6jX+2+
         /V8Ug7fLeYUNoG4o0rhcXHDxPWrMgIOVGOIbgvuKrozmqzB6gD4udAVCJziK+KsT4L5K
         WDRJycoitZhuMBkvJy5lVm1zgrGYdvQp/oIADX6ztkX2gBNkH1x0uLeEjuiqHVygZ1Wk
         Dfkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=crLM7n+0PkdmiX6TElwu3qXsFMY320gXi4+uWa8Oe5k=;
        b=BInsrgTG7NsT9HwVzdt8klaktBM8jatQPf8TP17EhkiGPX0UlqNl+n1HaA8gjhP0nk
         fH778EP0unVuKv65fVYBYQJSOHoXyBbL6gagHRf3KSJ6/P4idrF+OfKkq5WE1nto0wu+
         ZKApseNKpR1nb2Sa3mbwXcsn4pUzkyS8oaDOQvC9bosdbtkScWLqnzAJ2WbPsNe/XVMJ
         adXvkB8Qm0Tj/1gMahV+Ov/b8VB9DfDEnCz7oIVHnHAXumIvMQS0ABQk+o5R+t70+tSs
         z53DIWgBFd2+LLDVwHZCj6QgPGnDBGECbnO/vLxqaXwG3nQievwJkwIkBnm9+C+NjU0+
         JpWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=AOBKCdtl;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=AOBKCdtl;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeEDQrd (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 4 May 2018 12:47:33 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41218 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbeEDQrb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 May 2018 12:47:31 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: davem@davemloft.net, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: net: use TEST_PROGS_EXTENDED
Date: Fri,  4 May 2018 18:47:25 +0200
Message-Id: <20180504164725.13516-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599552863816594189?=
X-GMAIL-MSGID: =?utf-8?q?1599552863816594189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When a script file that isn't generated uses the variable
TEST_GEN_PROGS_EXTENDED and a 'make -C tools/testing/selftests clean' is
performed the script file gets removed and git shows the file as
deleted. For script files that isn't generated TEST_PROGS_EXTENDED
should be used.

Fixes: 9faedd643fd9 ("selftests: net: add in_netns.sh TEST_GEN_PROGS_EXTENDED")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/net/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 44895de1a0c4..eee47a4bc675 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -7,7 +7,7 @@ CFLAGS += -I../../../../usr/include/
 TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh rtnetlink.sh
 TEST_PROGS += fib_tests.sh fib-onlink-tests.sh pmtu.sh udpgso.sh
 TEST_PROGS += udpgso_bench.sh
-TEST_GEN_PROGS_EXTENDED := in_netns.sh
+TEST_PROGS_EXTENDED := in_netns.sh
 TEST_GEN_FILES =  socket
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy
 TEST_GEN_FILES += tcp_mmap tcp_inq
-- 
2.11.0

