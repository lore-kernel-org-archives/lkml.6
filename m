Return-Path: <shuahkh@osg.samsung.com>
X-Google-Smtp-Source: AH8x227J2819ZQT29DT139N7emoY5rXRthOYsD3M8zezn/zE2ZumEozR+Lbv+16OFn/6386Szh7+
ARC-Seal: i=1; a=rsa-sha256; t=1518558276; cv=none;
        d=google.com; s=arc-20160816;
        b=FeH10lg1IZL3RosdHyhlpz3zuDwnFfnqtFdzd2hDlAHbx6Z82e+hiYTuGUoAmako2m
         Pvfe8Z4d5IqCEmYpZjXFlgTAy9fWE0SDTsmB/0FPJL7mLQScEy3ZkMs1BAKdHAL8rO6/
         UHqJzaa2IETOIDRdCQdGKK/pM/hDMdMENn8zAed3l2IJuwO+nu1oWY6+J/IH/j7SIU31
         HQ378sw0t59G1YxP1JJ5GiuG2KzIeI2w7F7BxXfXO9OlstXpk+mO48YbDovTXnfwDTtj
         A7ydOVQEEdbJQ3YryOa1vtDrs4tVCkN2QCYwpHOk7r0at6tYMGK+p0VMNWnaLbxHAgJt
         rkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=LpbEbj2hEiHSx0UDtDwvZHn1oo8ZpNxKJRtXsSa4SmQ=;
        b=0io9O0xlwgUglVlWPdP4Y9TNt2jufxCNzvme3WdktK29kCyYIDYBmXGBSY2iSIezvd
         oSzcckitwinkSYoXw697IzLuRHN6OzCWNO/96L5NzWLtY4/Plvke1vVUVDD8Ky/c0CBg
         G65FJYgcL9JrStEfuLK43Zpg//j0W5jeRpjXhNMfLuP1xKDlfEHXxgZhvAgFUvbjojxC
         CasFSHqCOkrIh4vHY1aD5NCEUhvs+pNCxA49tAJ8m7s67fEelaU9/VIbSK4GoZwntUX1
         ahfFRDXEmiicQO2ORDmOAAIP22I6v5JmQuBJJ49JM/noESb12+aFB9h4LNM44sTbnvcr
         Sp9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
From: Shuah Khan <shuahkh@osg.samsung.com>
To: shuah@kernel.org,
	lei.yang@windriver.com,
	tglx@linutronix.de
Cc: Shuah Khan <shuahkh@osg.samsung.com>,
	pombredanne@nexb.com,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: memory-hotplug: silence test command echo
Date: Tue, 13 Feb 2018 14:44:07 -0700
Message-Id: <20180213214407.21717-1-shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592323763418926951?=
X-GMAIL-MSGID: =?utf-8?q?1592323763418926951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Silence the following command being printed while running test.

./mem-on-off-test.sh -r 2 && echo "selftests: memory-hotplug [PASS]" ||
echo "selftests: memory-hotplug [FAIL]"

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 tools/testing/selftests/memory-hotplug/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memory-hotplug/Makefile b/tools/testing/selftests/memory-hotplug/Makefile
index 86636d207adf..183b46883875 100644
--- a/tools/testing/selftests/memory-hotplug/Makefile
+++ b/tools/testing/selftests/memory-hotplug/Makefile
@@ -4,7 +4,7 @@ all:
 include ../lib.mk
 
 TEST_PROGS := mem-on-off-test.sh
-override RUN_TESTS := ./mem-on-off-test.sh -r 2 && echo "selftests: memory-hotplug [PASS]" || echo "selftests: memory-hotplug [FAIL]"
+override RUN_TESTS := @./mem-on-off-test.sh -r 2 && echo "selftests: memory-hotplug [PASS]" || echo "selftests: memory-hotplug [FAIL]"
 override EMIT_TESTS := echo "$(RUN_TESTS)"
 
 run_full_test:
-- 
2.14.1
