Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1440AC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BF42175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691274;
	bh=GyYn+I/ayuTEeEBqIWMngxUA+5RZ3EjZpdkLEnVhJGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CbbLRvms429Lwc5oFPjTFaeW1L0eWhe9+a16c5f1Rl1sHC7ihKtfeEy2QDtXRpLdQ
	 TGoAl4545cyMvoVooGvn60D1jd1DD26o71/5bOJgsrO6uWq3SQYdGRDD6qxIBQnyFu
	 Ig3M8AF3UVCjWn60xzcf1tw8VQooyy+0StuG0e2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbfA1QBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:01:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730946AbfA1QBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:01:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C296E21852;
        Mon, 28 Jan 2019 16:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691266;
        bh=GyYn+I/ayuTEeEBqIWMngxUA+5RZ3EjZpdkLEnVhJGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SB0hc4trPCgMwkuavBUIuwjwzBoquJlbaxv7NuKw4P4tJKKcAmKzQw5e1H3Qfol2w
         xTFHNtR0XBAMvnFDGD8+4A4auSb+RRoaprnI1pownNVo3IybSWzbCnw77GqxnVhmCp
         hEdKxylAPlSTUa37W16mcVLQ8s2l0p2HZcgFoRi0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@linuxdriverproject.org
Subject: [PATCH AUTOSEL 4.19 038/258] Tools: hv: kvp: Fix a warning of buffer overflow with gcc 8.0.1
Date:   Mon, 28 Jan 2019 10:55:44 -0500
Message-Id: <20190128155924.51521-38-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit 4fcba7802c3e15a6e56e255871d6c72f829b9dd8 ]

The patch fixes:

hv_kvp_daemon.c: In function 'kvp_set_ip_info':
hv_kvp_daemon.c:1305:2: note: 'snprintf' output between 41 and 4136 bytes
into a destination of size 4096

The "(unsigned int)str_len" is to avoid:

hv_kvp_daemon.c:1309:30: warning: comparison of integer expressions of
different signedness: 'int' and 'long unsigned int' [-Wsign-compare]

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/hv/hv_kvp_daemon.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index bbb2a8ef367c..d7e06fe0270e 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -1178,6 +1178,7 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	FILE *file;
 	char cmd[PATH_MAX];
 	char *mac_addr;
+	int str_len;
 
 	/*
 	 * Set the configuration for the specified interface with
@@ -1301,8 +1302,18 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	 * invoke the external script to do its magic.
 	 */
 
-	snprintf(cmd, sizeof(cmd), KVP_SCRIPTS_PATH "%s %s",
-		 "hv_set_ifconfig", if_file);
+	str_len = snprintf(cmd, sizeof(cmd), KVP_SCRIPTS_PATH "%s %s",
+			   "hv_set_ifconfig", if_file);
+	/*
+	 * This is a little overcautious, but it's necessary to suppress some
+	 * false warnings from gcc 8.0.1.
+	 */
+	if (str_len <= 0 || (unsigned int)str_len >= sizeof(cmd)) {
+		syslog(LOG_ERR, "Cmd '%s' (len=%d) may be too long",
+		       cmd, str_len);
+		return HV_E_FAIL;
+	}
+
 	if (system(cmd)) {
 		syslog(LOG_ERR, "Failed to execute cmd '%s'; error: %d %s",
 				cmd, errno, strerror(errno));
-- 
2.19.1

