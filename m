Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B98C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940A42098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXmIdJqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940A42098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeJQBEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeJQBEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:04:33 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 309572098A;
        Tue, 16 Oct 2018 17:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709990;
        bh=ZABxg84aMiG0TmeHyDZ5mDndxitLVdWJLISJ46KnZUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXmIdJqq9mj6RZeMWYNjMyO025OxsA8HolHsMVJtrVbSuARGEaHpsNNJ1N9LuvlVt
         DFC+oeRA5n3EW09SIZOJJxwCHCZv2ktRJZ/JVpeAf43sAEziJYBnJ5VnaL8dHBvIob
         2HZJAUrgv69FskhCGTAcnfYmhhFWL+eJlG01LB0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 066/135] selftests: android: move config up a level
Date:   Tue, 16 Oct 2018 19:04:56 +0200
Message-Id: <20181016170519.081121126@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anders Roxell <anders.roxell@linaro.org>

[ Upstream commit 88bc243a3f22b9938c0b53c577dee28025cdb920 ]

'make kselftest-merge' assumes that the config files for the tests are
located under the 'main' test dir, like tools/testing/selftests/android/
and not in a subdir to android.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/android/{ion => }/config | 0
 tools/testing/selftests/android/config     |    5 +++++
 tools/testing/selftests/android/ion/config |    5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)
 rename tools/testing/selftests/android/{ion => }/config (100%)

--- /dev/null
+++ b/tools/testing/selftests/android/config
@@ -0,0 +1,5 @@
+CONFIG_ANDROID=y
+CONFIG_STAGING=y
+CONFIG_ION=y
+CONFIG_ION_SYSTEM_HEAP=y
+CONFIG_DRM_VGEM=y
--- a/tools/testing/selftests/android/ion/config
+++ /dev/null
@@ -1,5 +0,0 @@
-CONFIG_ANDROID=y
-CONFIG_STAGING=y
-CONFIG_ION=y
-CONFIG_ION_SYSTEM_HEAP=y
-CONFIG_DRM_VGEM=y


