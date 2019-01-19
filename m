Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70D2C5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B3C2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="bQ8O+JdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbfASAM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:12:59 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46324 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbfASAMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:12:53 -0500
Received: by mail-qt1-f193.google.com with SMTP id y20so17149239qtm.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 16:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8jItW+uLvTQKdFnkClt3MYaSALrSUtjdvWxFm2Tp+V0=;
        b=bQ8O+JdJk1X0CF7iLtOfUpCBekB4305Uki+lD67KBlRIRFieL653YusBS493IosQoR
         1ZFVyoA3CdY2ojprp1a6L5V52u+ML03r8jZEj0yvDJlPDUNrDF/4tvjUKingM1+TDqwt
         Is9jL9VkOuPJ1T1e72Mt8Tjk2ABw45hef4SG7wiAjgdQliq2gTnQk4fM5jYURO4KD1Oh
         s/eHsuPbseJHcy8lgkJ/ifyF3RHwlB2TEkp2L7STJY7rOide7a0ljIAwE490vIBmIo8R
         WEHRCRnvcp/+ikCl7O1cWgeBW04DVvV10TuRie07IdFp2cQipwUKls9YfErkxevfLsJZ
         tLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8jItW+uLvTQKdFnkClt3MYaSALrSUtjdvWxFm2Tp+V0=;
        b=YZWzU9zje8iUZk/elNQxm08rCwouArLH0r/vmZY+4aJRy9JsR/1icOswadiNugv8q2
         qEbEC5nKD+z1J20CfW0q72jxuvIQqChpFjBZGaFtnjAAm5l5fFl7k9ezUKEOg5VvGmPz
         LG5PYC6ZkW/oe8PgI3Lzc3cyhafB4N9EguChVDSzc3pGZY8IAGG+ukk/cGTriAoLL2fH
         HlrwwRER2dn02zEjMsP0QkEbNSJSjPCMNsbZgxsJ25j24+eopxpnoTr6SqmueFNJdbSC
         PMisZfGuFLZwLmaPfZ1YnZXj2UxK7/ZIqPA5FzOWBHVB+Qp2XZ36UzU9geL+9hNo7Q3w
         ITRg==
X-Gm-Message-State: AJcUukdmCuOqolZe7OtjsTddab0/9LBMaocDYfzW1fcYDlvhqEu8Fdoq
        IoMd0N24nngmCQi3zj6v+Nwkq07+ilM=
X-Google-Smtp-Source: ALg8bN5xF7YwqxNt5eBLPsVuK+1XD27YPDIMSsNo+pgqTX3SkYj1w2XBiSgsVlUACKH1tm7G7JvPlg==
X-Received: by 2002:ac8:17f0:: with SMTP id r45mr17946900qtk.206.1547856772225;
        Fri, 18 Jan 2019 16:12:52 -0800 (PST)
Received: from localhost.localdomain ([64.125.109.186])
        by smtp.gmail.com with ESMTPSA id m14sm41140501qka.21.2019.01.18.16.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:12:51 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 4/6] selftests: skip seccomp get_metadata test if not real root
Date:   Fri, 18 Jan 2019 17:12:15 -0700
Message-Id: <20190119001217.12660-5-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190119001217.12660-1-tycho@tycho.ws>
References: <20190119001217.12660-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_metadata() test requires real root, so let's skip it if we're not
real root.

Note that I used XFAIL here because that's what the test does later if
CONFIG_CHEKCKPOINT_RESTORE happens to not be enabled. After looking at the
code, there doesn't seem to be a nice way to skip tests defined as TEST(),
since there's no return code (I tried exit(KSFT_SKIP), but that didn't work
either...). So let's do it this way to be consistent, and easier to fix
when someone comes along and fixes it.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 912a2a5430dc..ab6b6620f522 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -2929,6 +2929,12 @@ TEST(get_metadata)
 	struct seccomp_metadata md;
 	long ret;
 
+	/* Only real root can get metadata. */
+	if (geteuid()) {
+		XFAIL(return, "get_metadata requires real root");
+		return;
+	}
+
 	ASSERT_EQ(0, pipe(pipefd));
 
 	pid = fork();
-- 
2.19.1

