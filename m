Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21414C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D968F20840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198014;
	bh=PPcq0NoDP+MltGyd+PyfI2fMVaVNCxi/PSdZHVyrOYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ePRklTImHJGhKudN7xkFbEBKqbrArwGLx2zS8kL5hAPG10W2FnO1xmgmkrSRZ8J08
	 p11bDiI4HaRAbDNPoZNavarn52vwUX2bXAj8MhVtQBQ7q6yckLz9yesHW33Iqp5vGW
	 OS+yGFxpUnGNblmfi76KoiajZeYi56UQ/yG31MFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbfBOCdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:33:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389268AbfBOCL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EB7321B68;
        Fri, 15 Feb 2019 02:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196717;
        bh=PPcq0NoDP+MltGyd+PyfI2fMVaVNCxi/PSdZHVyrOYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xcsEBsSCdlRpylc/KTSsM8x9ePPAEhvBdxZZcLUhmGXGEjGBKFKcBmMlq1rzoiOpM
         MBFdS7pufTu4iUqPzVQVxR/6Ht1FQDThEetvrBQdkVywOQo+IZau6htZnts+DG7nd/
         0PPskQanFntKLhdmEeML/aTrfMEOxU/RrqUucbcg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 23/65] selftests: gpio-mockup-chardev: Check asprintf() for error
Date:   Thu, 14 Feb 2019 21:10:39 -0500
Message-Id: <20190215021121.177674-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 508cacd7da6659ae7b7bdd0a335f675422277758 ]

With gcc 7.3.0:

    gpio-mockup-chardev.c: In function ‘get_debugfs’:
    gpio-mockup-chardev.c:62:3: warning: ignoring return value of ‘asprintf’, declared with attribute warn_unused_result [-Wunused-result]
       asprintf(path, "%s/gpio", mnt_fs_get_target(fs));
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Handle asprintf() failures to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/gpio/gpio-mockup-chardev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-mockup-chardev.c b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
index f8d468f54e98..aaa1e9f083c3 100644
--- a/tools/testing/selftests/gpio/gpio-mockup-chardev.c
+++ b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
@@ -37,7 +37,7 @@ static int get_debugfs(char **path)
 	struct libmnt_table *tb;
 	struct libmnt_iter *itr = NULL;
 	struct libmnt_fs *fs;
-	int found = 0;
+	int found = 0, ret;
 
 	cxt = mnt_new_context();
 	if (!cxt)
@@ -58,8 +58,11 @@ static int get_debugfs(char **path)
 			break;
 		}
 	}
-	if (found)
-		asprintf(path, "%s/gpio", mnt_fs_get_target(fs));
+	if (found) {
+		ret = asprintf(path, "%s/gpio", mnt_fs_get_target(fs));
+		if (ret < 0)
+			err(EXIT_FAILURE, "failed to format string");
+	}
 
 	mnt_free_iter(itr);
 	mnt_free_context(cxt);
-- 
2.19.1

