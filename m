Return-Path: <daniel.diaz@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517955791; cv=none;
        d=google.com; s=arc-20160816;
        b=L30LaS80TIML2H/gLUl8/xwLVDAIOghSdwctiQSV7yBlRWbA4xf0uVmfRfJmGiH3Nt
         9ZimfnDylKsa3oaFpFDTq48oVFAmrxeB/qWB4YC9ZMabln+MlnuL4uaBdhwr/fYtpgXa
         a+Vp9k6nNXXZkPkZdQ5rWlcxi2HKybqsxxW6qz5ROzN0eOfsdwxT3jYPKD+9+lRzOVxd
         FIdL91mtksG6uD7y5HzcJ7451yXhNCKOV53zCxgDlnORtMFwvt2Ish9xuoSQgJEhpYOL
         C3rWJdHSLTz9QygdwwVI2KEZ8G8Uydi9akRl4fBm1bb7KngpahHYsvX6rRA8jPQKcwQN
         Gg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=j2kU5Pwj083P/9VsS3PFvYepm0JigsbWcsxY1hsdVJA=;
        b=PjaESmUJ5hZMyBIA52egx4+2AdnMAQ8PbJPITBuzxxPHeo5wU6BrkaAVXWbSP6zkIp
         xX5bKcnh1fxdIYctjzZw5LRqJPzGGad8061n00JhJzQpRBORHUSrWwoBfnU09mZ9p5Z6
         6D1simUDjna5ye1OCRZium1I/+WemhJXkUBg+sNsNYUnk0hX41zcU8rBd828bWDyh4CA
         /7X5BOWyRIUV3PS+bqKEtGochinvTNRM1v79PbBvjC+BN4987/I3hCrqVQXyRc8y95Ir
         Ektk5Cu7wjlITo3jZJ8152MyiQGD1xuXROjPnSLHYs5zmN7xjs2fpRyn12nDyEXk1GMG
         PgdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=FtrDVLq7;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=FtrDVLq7;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x226YrQB+RRZv0Tf3Rg/fGNitIBjHaMrbLf2nYuOQmhAomjMh9ZmruWWK5pQR/fGvYT0PNJx8oQ==
From: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: Anders Roxell <anders.roxell@linaro.org>,
	=?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	SeongJae Park <sj38.park@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/memfd: add run_fuse_test.sh to TEST_FILES
Date: Tue,  6 Feb 2018 16:22:57 -0600
Message-Id: <1517955779-11386-1-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591692011940276570?=
X-GMAIL-MSGID: =?utf-8?q?1591692011940276570?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anders Roxell <anders.roxell@linaro.org>

While testing memfd tests, there is a missing script, as reported by
kselftest:

./run_tests.sh: line 7: ./run_fuse_test.sh: No such file or directory

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/memfd/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index a5276a9..0862e6f 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -5,6 +5,7 @@ CFLAGS += -I../../../../include/
 CFLAGS += -I../../../../usr/include/
 
 TEST_PROGS := run_tests.sh
+TEST_FILES := run_fuse_test.sh
 TEST_GEN_FILES := memfd_test fuse_mnt fuse_test
 
 fuse_mnt.o: CFLAGS += $(shell pkg-config fuse --cflags)
-- 
2.7.4
