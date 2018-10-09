Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C3AC32788
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB64214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Vdy6DvZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB64214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeJJFkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:40:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46258 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbeJJFkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:40:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id v5-v6so1486204plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 15:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mSCp3IjXtO6KaCWkQ2EwPMcxQAzHpqecCP58DFd+0XQ=;
        b=Vdy6DvZH2nbFshP8qYD/ks+zBdEI8OFH1w8BCeB0V47R1wL2lOsyrVi+HOJ66+onyF
         oJCPdDRjWMRXav9ZvB6GF/UUM9BeNCA+kPT3sDnJiJY22C0+5n++fxUqp7iB2g8CvgfX
         mJ15DCGbAWj08HnKQVNkhTSIPdSz5T/Nf5Xb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mSCp3IjXtO6KaCWkQ2EwPMcxQAzHpqecCP58DFd+0XQ=;
        b=oOW8u2RGv98AdXMt6cbOru7nnphcf+bt5M5p4wkgODzkGWhwB1H6f/phI218902aAY
         ajTCukY73z65mdjW3AmPuPmUXp9rSI5itWhxr3LGBO0m5pEhbI3SqF3C/7DwakmuZWOS
         C2L1a2d1iwd6MXaxSGG6F9jxuRr7qNiKwHe5fhcrNzHKo2gl/8gYT1dkq0/GWng9wYEZ
         mqVrQW5EGhymRJ5yXVy+5XzGevo3desUssdIRHr8b7ZM4bgd0Naas6bvRhpE3uMtPpn0
         01RBPXT8FRyAnXeJQRw4UH7OhVIMYepJzCu7zQz1jMztgwfvGEpO0cuatR5K16RNL/t7
         UimA==
X-Gm-Message-State: ABuFfoi0XhrgTNNKi+3YIUJWgXF0JNo95u+k4iVVyFINhcY2MERXIfpe
        ck6dJPjjqOV5gKvs8x9X11o4FfpQiD4=
X-Google-Smtp-Source: ACcGV60yixQ7WkKtFoVo0a2iIypyOXeolvn18ZMkAH0fdyE9vdp77xXrrlRgW8IxyrNqeVzlUSyXbQ==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37-v6mr23489770pla.132.1539123665951;
        Tue, 09 Oct 2018 15:21:05 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id z15-v6sm26900856pfn.170.2018.10.09.15.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 15:21:04 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        dancol@google.com, minchan@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>, john.stultz@linaro.org,
        jreck@google.com, Khalid Aziz <khalid.aziz@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>, tkjos@google.com
Subject: [PATCH v2 2/2] selftests/memfd: Add tests for F_SEAL_FS_WRITE seal
Date:   Tue,  9 Oct 2018 15:20:42 -0700
Message-Id: <20181009222042.9781-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181009222042.9781-1-joel@joelfernandes.org>
References: <20181009222042.9781-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests to verify sealing memfds with the F_SEAL_FS_WRITE works as
expected.

Cc: dancol@google.com
Cc: minchan@google.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 51 +++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 10baa1652fc2..4bd2b6c87bb4 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -27,7 +27,7 @@
 
 #define MFD_DEF_SIZE 8192
 #define STACK_SIZE 65536
-
+#define F_SEAL_FS_WRITE         0x0010
 /*
  * Default is not to test hugetlbfs
  */
@@ -170,6 +170,24 @@ static void *mfd_assert_mmap_shared(int fd)
 	return p;
 }
 
+static void *mfd_fail_mmap_shared(int fd)
+{
+	void *p;
+
+	p = mmap(NULL,
+		 mfd_def_size,
+		 PROT_READ | PROT_WRITE,
+		 MAP_SHARED,
+		 fd,
+		 0);
+	if (p != MAP_FAILED) {
+		printf("mmap() didn't fail as expected\n");
+		abort();
+	}
+
+	return p;
+}
+
 static void *mfd_assert_mmap_private(int fd)
 {
 	void *p;
@@ -692,6 +710,36 @@ static void test_seal_write(void)
 	close(fd);
 }
 
+/*
+ * Test SEAL_WRITE
+ * Test whether SEAL_WRITE actually prevents modifications.
+ */
+static void test_seal_fs_write(void)
+{
+	int fd;
+	void *p;
+
+	printf("%s SEAL-FS-WRITE\n", memfd_str);
+
+	fd = mfd_assert_new("kern_memfd_seal_fs_write",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	p = mfd_assert_mmap_shared(fd);
+
+	/* FS_WRITE seal can be added even with existing
+	 * writeable mappings */
+	mfd_assert_has_seals(fd, 0);
+	mfd_assert_add_seals(fd, F_SEAL_FS_WRITE);
+	mfd_assert_has_seals(fd, F_SEAL_FS_WRITE);
+
+	mfd_assert_read(fd);
+	mfd_fail_write(fd);
+
+	munmap(p, mfd_def_size);
+	close(fd);
+}
+
 /*
  * Test SEAL_SHRINK
  * Test whether SEAL_SHRINK actually prevents shrinking
@@ -945,6 +993,7 @@ int main(int argc, char **argv)
 	test_basic();
 
 	test_seal_write();
+	test_seal_fs_write();
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
-- 
2.19.0.605.g01d371f741-goog

