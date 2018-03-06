Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELs2Ss/uezts0LE4hYJRpbFDtSDrQ+YYMd+j4HZl3tsY61s4Vkj7I9K3YjwsmbJxY1quWsv/
ARC-Seal: i=1; a=rsa-sha256; t=1520349031; cv=none;
        d=google.com; s=arc-20160816;
        b=gvyGp0MqkPuIfAsBJvn4BdZLhzp3lkNm+DqTwRbU2cOnNTDm7+AuMu6WH9THJoELoh
         ZRAJwEh7UJD8dHK+ib9ar9HyCz3BiwXIjnFLQdIr2+3Yl9uFBsUy9TvEjL93/SE6fvfl
         9CtYDVxS2Xk4hqZ5XmqMQze8XikOTLiPR6E3nt4NTFHqUl7FRMiG4eMv4xiecF0eYgF+
         5z5GdWRQyVrckmQdXTobkFW86gVgJKSweRNN/q15ht819TkKTeqToLIiJHmtEIoaSpZj
         IbkQlZ6kl576eLZpcLYidUpyy9hupO7w2YBihfQMgERxxVinXMSITkdxioz7rCs+B2Xv
         JyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=MQdGUh2hMmrmp8V1cDllnXRmzasD9C12JDgmjOIKgeU=;
        b=y7vumPqNZVkA0WimcugEUw5gb1eOI0/aF1g+FNjjrgoPq5Q9Kf8rg4RHhrXuplzR6F
         Adaposz95FIRGE1r1en/TaazAIqFf3XRHl7lc5E6zaRnQN8C9qhEkon3jg6yKrvkOQBn
         PbgkEun9SOrQkru9aSFxAGjjA9smv2lV1hYZEyH/Z3GgUtBHYQV52/MNEs5ha0ixbrS4
         Bh9LAC/vZWU9V9PKXvDuIdFciaU6epjR5NjqOD8u3mxq+q72WqTYQ/bmTzc+bsh547A3
         7vJpVhael9GpoJ9vMlNEMgKQ+iW3aJmLBJDlJYW+cQe3nDKXK2F+Yq5Y05gTVCRgNP7H
         QWhg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=cNVYxO5K;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=cNVYxO5K;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeCFPKO (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 6 Mar 2018 10:10:14 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38083 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeCFPKM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Mar 2018 10:10:12 -0500
From: Anders Roxell <anders.roxell@linaro.org>
To: davem@davemloft.net, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftest: net: reuseport_bpf_numa: don't fail if no numa support
Date: Tue,  6 Mar 2018 16:10:04 +0100
Message-Id: <20180306151004.31336-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594201505777703046?=
X-GMAIL-MSGID: =?utf-8?q?1594201505777703046?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The reuseport_bpf_numa test case fails there's no numa support.  The
test shouldn't fail if there's no support it should be skipped with a
pass.

Fixes: 3c2c3c16aaf6 ("reuseport, bpf: add test case for bpf_get_numa_node_id")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/net/reuseport_bpf_numa.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.c b/tools/testing/selftests/net/reuseport_bpf_numa.c
index 365c32e84189..9245c14165b7 100644
--- a/tools/testing/selftests/net/reuseport_bpf_numa.c
+++ b/tools/testing/selftests/net/reuseport_bpf_numa.c
@@ -228,8 +228,10 @@ int main(void)
 {
 	int *rcv_fd, nodes;
 
-	if (numa_available() < 0)
-		error(1, errno, "no numa api support");
+	if (numa_available() < 0) {
+		fprintf(stderr, "no numa api support");
+		return 0;
+	}
 
 	nodes = numa_max_node() + 1;
 
-- 
2.11.0

