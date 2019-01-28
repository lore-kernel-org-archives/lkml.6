Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB08C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD012175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691988;
	bh=mcFzueVP0Op9KTEvURO7HhuYgT//LQ9osPGkNuGA//Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0mU4DAArEvKkfNRvmOim60WNtTs399Yzjv/gVp4P1m+NY4Ud1YozWj18q8xhayf7A
	 0Jk/8rCiXaI78H6zvsdzLiOpJ9kS6dKx+ePJt7VaOS/I2Df04u4O9uD9CgWoFpplG8
	 qlmsDuSjzllWsyvZrVre8QdaFv5w+cCcVpwjSv1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbfA1QNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:13:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732720AbfA1QNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6AD22184D;
        Mon, 28 Jan 2019 16:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691981;
        bh=mcFzueVP0Op9KTEvURO7HhuYgT//LQ9osPGkNuGA//Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQl9JI2UBXVeKgoLhcnOBcNFTOGpuhUYvQgArNd7pfS3fpe4eXzS3Ml9GDI+WKohb
         pH3nC2tcu11POVHF6CpQPsAkLzJa82uh8hst5aSCOXw92Cgc9FmSyuucXvMGFq13Q9
         Sqe7YUbSSgc8l4evTHOf6gtFD0f1YjbDUjIN9yf8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@linuxdriverproject.org
Subject: [PATCH AUTOSEL 4.14 026/170] Tools: hv: kvp: Fix a warning of buffer overflow with gcc 8.0.1
Date:   Mon, 28 Jan 2019 11:09:36 -0500
Message-Id: <20190128161200.55107-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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
index 3965186b375a..62c9a503ae05 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -1172,6 +1172,7 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	FILE *file;
 	char cmd[PATH_MAX];
 	char *mac_addr;
+	int str_len;
 
 	/*
 	 * Set the configuration for the specified interface with
@@ -1295,8 +1296,18 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
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

