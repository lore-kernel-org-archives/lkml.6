Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA68DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701812083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701812083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbeHWMMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:12:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50288 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeHWMMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:12:18 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2DAE37F6;
        Thu, 23 Aug 2018 08:43:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Jeffrin Jose T (Rajagiri SET)" <ahiliation@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 087/324] selftests: bpf: notification about privilege required to run test_kmod.sh testing script
Date:   Thu, 23 Aug 2018 09:52:33 +0200
Message-Id: <20180823075000.224199368@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeffrin Jose T <ahiliation@gmail.com>

[ Upstream commit 81e167c2a216e7b54e6add9d2badcda267fe33b1 ]

The test_kmod.sh script require root privilege for the successful
execution of the test.

This patch is to notify the user about the privilege the script
demands for the successful execution of the test.

Signed-off-by: Jeffrin Jose T (Rajagiri SET) <ahiliation@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/bpf/test_kmod.sh |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/tools/testing/selftests/bpf/test_kmod.sh
+++ b/tools/testing/selftests/bpf/test_kmod.sh
@@ -1,6 +1,15 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+msg="skip all tests:"
+if [ "$(id -u)" != "0" ]; then
+	echo $msg please run this as root >&2
+	exit $ksft_skip
+fi
+
 SRC_TREE=../../../../
 
 test_run()


