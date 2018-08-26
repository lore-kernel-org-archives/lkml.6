Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2057BC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E5F2170B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E5F2170B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeHZK1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 06:27:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53532 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeHZK1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 06:27:31 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F22079D3;
        Sun, 26 Aug 2018 06:45:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fathi Boudra <fathi.boudra@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 17/56] selftests: sync: add config fragment for testing sync framework
Date:   Sun, 26 Aug 2018 08:44:38 +0200
Message-Id: <20180826064233.194968457@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826064232.320669119@linuxfoundation.org>
References: <20180826064232.320669119@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fathi Boudra <fathi.boudra@linaro.org>

[ Upstream commit d6a3e55131fcb1e5ca1753f4b6f297a177b2fc91 ]

Unless the software synchronization objects (CONFIG_SW_SYNC) is enabled,
the sync test will be skipped:

TAP version 13
1..0 # Skipped: Sync framework not supported by kernel

Add a config fragment file to be able to run "make kselftest-merge" to
enable relevant configuration required in order to run the sync test.

Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
Link: https://lkml.org/lkml/2017/5/5/14
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/sync/config |    4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 tools/testing/selftests/sync/config

--- /dev/null
+++ b/tools/testing/selftests/sync/config
@@ -0,0 +1,4 @@
+CONFIG_STAGING=y
+CONFIG_ANDROID=y
+CONFIG_SYNC=y
+CONFIG_SW_SYNC=y


