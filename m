Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F284BC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBA024850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEp7k2WY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBA024850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934518AbeFVUCG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:02:06 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41396 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934393AbeFVUCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:02:04 -0400
Received: by mail-pg0-f67.google.com with SMTP id l65-v6so3411859pgl.8;
        Fri, 22 Jun 2018 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZarrWeOtfLOvtpADNHhMMYBFW0YiDE+qy2ObmHNx7M0=;
        b=ZEp7k2WYbxCFqK8VU0uc24LMKAAphO7lttaA34xKvsQ/rqGYRzP885Pj6O8Z8EqM/M
         YnMKP3NjB4Q153c+6HhWWXVRZm3gOE4OHtazqIV1pWPdCE2BhEQ+ZWXuSHbHIVINB2n5
         15sVD1evtOo+R1ImBfd4Ho3rmKiALGjmsh/BrtsLt+otMvIWqOzr6v1bCIW2N+MyNJip
         krYwsZOkNPBaSKke+nln8it5nePBIJIPAT2W2xxsR87in7542buInZC7jg/wp99/j8Qn
         jL8NfCe0orIixEUYxuK6NBPiYMHfM6zRGWSZveR+DtTB8GmDoJ3OhVtSMVYimlhGC/Hm
         Kncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZarrWeOtfLOvtpADNHhMMYBFW0YiDE+qy2ObmHNx7M0=;
        b=MNOiA7lWcm38jnX73M5g1ebaAc1qz62AWlJACY/fFTcP2MgYNeiSu4YF9LNqn6WWQO
         NoUd06ZbVnsFouKQpgcNtBdhYxvf5N8Abcyv+x7hrCMFmtBnjvzCjcvmfUZI4zMDo5mK
         LeCgvDK4+FN8DWBYXYRdkx/nAIHhYld+3QCujkswWHYpRe7Pri6HgTb5E2Nt5lwu4wVj
         4qZ+JiuqsZVYwCWgs883OPmojwXA7E2QU29Wgv4GqhBeFW+ZeUBhIPVIrvC+zT7dpH+5
         36qxVV5NJt6iWogj6iiaZ3C7/2ucL3bsdD/RJhnrYvt2A7WlpjDy7grIW9oUwAYFO9vh
         yO/g==
X-Gm-Message-State: APt69E1h4Znp0UcDFiUtOmr5+sLqKykUgqpu9qbzH48zeUN9spOK5OQJ
        Tws/dG9GoLrLalTPGI450PHBtdR2
X-Google-Smtp-Source: ADUXVKLqWBc6ZytmTcsrWhruzv+zlM0GEGzEvpui40r76Bqhp7kQ7sER2mw3DuQDTkGx/al3g9CVJw==
X-Received: by 2002:a63:41c1:: with SMTP id o184-v6mr2651038pga.323.1529697724350;
        Fri, 22 Jun 2018 13:02:04 -0700 (PDT)
Received: from localhost.localdomain ([122.174.152.149])
        by smtp.gmail.com with ESMTPSA id m21-v6sm10352370pgv.27.2018.06.22.13.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 13:02:03 -0700 (PDT)
From:   Jeffrin Jose T <ahiliation@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jeffrin Jose T <ahiliation@gmail.com>
Subject: [PATCH] selftests: bpf: notification about privilege required to run test_lwt_seg6local.sh testing script
Date:   Sat, 23 Jun 2018 01:30:53 +0530
Message-Id: <20180622200053.4957-1-ahiliation@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test_lwt_seg6local.sh will execute with root privilege.

This patch is atleast used to notify the user about the privilege
required related to smooth execution of the script.

Signed-off-by: Jeffrin Jose T (Rajagiri SET) <ahiliation@gmail.com>
---
 tools/testing/selftests/bpf/test_lwt_seg6local.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_lwt_seg6local.sh b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
index 1c77994b5e71..30575577a8b2 100755
--- a/tools/testing/selftests/bpf/test_lwt_seg6local.sh
+++ b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
@@ -21,6 +21,15 @@
 # An UDP datagram is sent from fb00::1 to fb00::6. The test succeeds if this
 # datagram can be read on NS6 when binding to fb00::6.
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+msg="skip all tests:"
+if [ $UID != 0 ]; then
+    echo $msg please run this as root >&2
+    exit $ksft_skip
+fi
+
 TMP_FILE="/tmp/selftest_lwt_seg6local.txt"
 
 cleanup()
-- 
2.17.0

