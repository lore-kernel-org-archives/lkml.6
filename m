Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+UrUMRtUrumLeYiKS2aFMTkWjyWRLI27GRZN8MzD8Wuj3Tsi7qz129tuUj1doCoNJAbG7Y
ARC-Seal: i=1; a=rsa-sha256; t=1524691966; cv=none;
        d=google.com; s=arc-20160816;
        b=pGeI0n7pC2ufIymozIK8LZCpJisb7+UCKMzNU04u/kcCUNuZ2hyVYTsHRVOuSWKZp+
         7cPvAS/oUbqRWXrL/LR7unmRDKp072QMRoVjtLq2efNTHHejV0PFj1TOT48iw6aqCAPS
         nr71xSGTRHAs55zmxcOL6r7jmXib4IsFIUWMAGZceOEDsfUH2UYgLyfy8DF416lWV1Wz
         uwGem1yRvgGmSvWU3bMISiZ6ylasXSyIfqFS/U2GtOqdVzgh7I8oWqD9duia5apwOnJg
         hqKuANLWsyRZKZ67S8nf1Q/4vQDXENDG4xL6KyagXl9tSVUFEPFSkhIGkzVWzIMTdJo4
         o69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=WPkablBMSAr593z+yLFLpMN1zwD8YQ8lkzosX1lJDLI=;
        b=yRRYGNyPBOlAzpWYasDh9VesD+GJcKH79fj+SzMg9xBLepSVxwoLP73fX14HSTBxat
         4XX2mg8TNIvAbebXYHnZsRsxcaeamQwY+4JHTrVV/gAeJBAWFDGbb4GjXm7Y4shFef7J
         q2gr2A0+S9L7TAhcvpbJ+wLGoZs+/RogHLkWFVhHx01JtRmeOyxn/wOVXsUyUTbrJy2Z
         azwsaQ7ygKSWMP6BZym1CtZ0RQVQ05QcJ0aLlup516oWW59FUK8lExHCC/aZgpN02Vc4
         bzrD982TeKnzgZKED6ItSRmjDYAYljDHoZMl/+4AjQ+Jz5Kgq8PLbupElaBrDj5g32Bi
         sfHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=A2WUO0Pz;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=A2WUO0Pz;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeDYVcM (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 25 Apr 2018 17:32:12 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39277 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752207AbeDYVcL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Apr 2018 17:32:11 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: davem@davemloft.net, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] selftests: net: add in_netns.sh TEST_GEN_PROGS_EXTENDED
Date: Wed, 25 Apr 2018 23:32:06 +0200
Message-Id: <20180425213206.7531-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180425.132513.1786379382285267245.davem@davemloft.net>
References: <20180425.132513.1786379382285267245.davem@davemloft.net>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598667778719810638?=
X-GMAIL-MSGID: =?utf-8?q?1598755403549271340?=
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

respin against the 'net' tree.

 tools/testing/selftests/net/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 8f1e13d2e547..daf5effec3f0 100644
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
 TEST_GEN_PROGS = reuseport_bpf reuseport_bpf_cpu reuseport_bpf_numa
-- 
2.11.0

