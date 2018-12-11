Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239BAC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0102084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544118;
	bh=udwFmnrLpJTNwrC9NMr7XKU9rBbrGoMF0fX5rgR800E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PT9t3enUE35B+5a4dtHn5Xxl4QfVt2SxSLAOEj5ecwOacRDByabYMgNJTLUb0VbFJ
	 kF3syd+wunIuR0sWWEgisBqXF6uinpmsLgDk4OMmP/27mYu9Lb4n7wS47rvexYXu6i
	 yiGgLTvxUsFz8TypG3Zu7pE0bEyF7KtA6nAdg8hM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0102084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbeLKQB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:01:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:46086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730748AbeLKP5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D645E205C9;
        Tue, 11 Dec 2018 15:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543829;
        bh=udwFmnrLpJTNwrC9NMr7XKU9rBbrGoMF0fX5rgR800E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+nkLEo9fa3+IQvWxxzDNO06e3RMWGjGDwtE0oDFNBOPr+CbfAtM6I5esqi66llZn
         tzrd9Ti8YjKmJb2mpwH4NXAUxS3580VxhliOaHEglj7FOu520Ce3xvKSeXizEZkA95
         Pf7cwMXjRI+qrPNjlhZCMNa6XRGalUyxlLiKAzew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Bates <lucasb@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 035/118] tc-testing: tdc.py: ignore errors when decoding stdout/stderr
Date:   Tue, 11 Dec 2018 16:40:54 +0100
Message-Id: <20181211151645.652891414@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5aaf6428526bcad98d6f51f2f679c919bb75d7e9 ]

Prevent exceptions from being raised while decoding output
from an executed command. There is no impact on tdc's
execution and the verify command phase would fail the pattern
match.

Signed-off-by: Lucas Bates <lucasb@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/tc-testing/tdc.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index 87a04a8a5945..9b3f414ff1e9 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -134,9 +134,9 @@ def exec_cmd(args, pm, stage, command):
     (rawout, serr) = proc.communicate()
 
     if proc.returncode != 0 and len(serr) > 0:
-        foutput = serr.decode("utf-8")
+        foutput = serr.decode("utf-8", errors="ignore")
     else:
-        foutput = rawout.decode("utf-8")
+        foutput = rawout.decode("utf-8", errors="ignore")
 
     proc.stdout.close()
     proc.stderr.close()
-- 
2.19.1



