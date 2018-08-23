Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF22C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3299F213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3299F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeHWLZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:25:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41588 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeHWLZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:25:52 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 421599D2;
        Thu, 23 Aug 2018 07:57:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fathi Boudra <fathi.boudra@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 07/79] selftests: sync: add config fragment for testing sync framework
Date:   Thu, 23 Aug 2018 09:52:43 +0200
Message-Id: <20180823074919.121023069@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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


