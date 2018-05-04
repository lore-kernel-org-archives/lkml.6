Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZpP5ffOa8RmJm0tnwvErYJeP/tfMQCtOCPMw2MmX/DxR3DAm5MF1uMEG2yk4phDrObQDnYf
ARC-Seal: i=1; a=rsa-sha256; t=1525425466; cv=none;
        d=google.com; s=arc-20160816;
        b=kdTT6H4e0P243FEKSltjs+r3spfmFJrH6xYfyoydkkzR8NHUm5VMDepuVjXWn/+TUu
         /1sumyrk5/beXfYvjp4L/Ap6h17KP/hKFUAopJEBXGw7gr2XxSfWpsN1bsvDRKr8DlAZ
         lpBiidWFN1iMxCffLR9iIG9Nwi0EopJmtpekCLCy4HHthCKdzida9jAygj8WE0CcCqc4
         NhFI8jfH8DsrDLuAxubiBCpSvRhfufphNaaKW9dJGdVxsp8sRy4zJz0aJgED8KnVgrqS
         V8KUSEcikd5oAAkG56to96pbfFyR/nUX/Kbw1Ojn+lORoLM0Ac/MuE+ad0iOpMhpiN6L
         MQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=mcc8ADVlmcLDJd0ceAG53ZF/5WVQZNbS8PIzJjwxbQI=;
        b=oYkwsl+R4NN/Y+zZzgr3r6UtSvdifQfh4mRnwcG+wD0YRc4YDG0an+q5ePNNmuzhQJ
         c1fGuWxSTR9J/y9gSNITGgJg5dfob4yDpx0a/tfcSIbk2EVJLJb2QBNpGZaW9dqBhdKt
         I0n3u5XSRxK/ICnhe8r71hQ+QWFlqeL7i2yls0b/Bsup++NrsOKlU8Cyt/0bDsGSv4N9
         T1dhhlCsFSaVxgo7bkHknAAuoYxxhwmCyOeYMao0nFsmL1Q78HNhRx5NGUqdaJVqQSWj
         usDKFzXCHxvvVALCcofv1sc9mqtTSXpQHfpYN6+4LF+PND/iPe13GRod721+BeFMe5xD
         1i7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=M8kKuhSb;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=M8kKuhSb;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeEDJRc (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 4 May 2018 05:17:32 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42192 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbeEDJRb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 May 2018 05:17:31 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: davem@davemloft.net, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: net: add udpgso* to TEST_GEN_FILES
Date: Fri,  4 May 2018 11:17:25 +0200
Message-Id: <20180504091725.24977-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599524533579135762?=
X-GMAIL-MSGID: =?utf-8?q?1599524533579135762?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The generated files udpgso* shouldn't be part of TEST_PROGS, they are
used by udpgso.sh and udpgsp_bench.sh. They should be added to the
TEST_GEN_FILES to get installed without being added to the main
run_kselftest.sh script.

Fixes: 3a687bef148d ("selftests: udp gso benchmark")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/net/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 44895de1a0c4..f0363387ef2f 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -11,9 +11,9 @@ TEST_GEN_PROGS_EXTENDED := in_netns.sh
 TEST_GEN_FILES =  socket
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy
 TEST_GEN_FILES += tcp_mmap tcp_inq
+TEST_GEN_FILES += udpgso udpgso_bench_tx udpgso_bench_rx
 TEST_GEN_PROGS = reuseport_bpf reuseport_bpf_cpu reuseport_bpf_numa
 TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict
-TEST_GEN_PROGS += udpgso udpgso_bench_tx udpgso_bench_rx
 
 include ../lib.mk
 
-- 
2.11.0

