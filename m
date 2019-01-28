Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129F8C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C8721741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690315;
	bh=GyYn+I/ayuTEeEBqIWMngxUA+5RZ3EjZpdkLEnVhJGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LS1QTsGaLqzw39EhLklS/ucWcQl6E/zbm6n78+OojYogrMTmiKkDYChMHIwCSifXQ
	 R2ZeZkMDxZIH4Bpm9u56z8x/PB/465IDU+zwWK2xBSB3V6F+5yb6GGwQBsah8xXv36
	 +YzoGpWM9o1PngkpueCLFJIxBjvvKCw+9y21COog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfA1PpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:45:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbfA1PpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:45:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEBF620880;
        Mon, 28 Jan 2019 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690310;
        bh=GyYn+I/ayuTEeEBqIWMngxUA+5RZ3EjZpdkLEnVhJGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krD7KwdzKxNAkqtL9OGPAuBwogOzTB1IvJCJwU2f9jnIgwGbffzSd1na7Vhd0CjKq
         YLbBhidweUd9xMfCJoNGc+qrxjqtBFL6hE9q2nJMkgftGhoehQr9zVdwmBTd+rW6U1
         f8pcUZR8v75sYkk+s33N+Fj2sfcevuoES4L2z0yY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@linuxdriverproject.org
Subject: [PATCH AUTOSEL 4.20 044/304] Tools: hv: kvp: Fix a warning of buffer overflow with gcc 8.0.1
Date:   Mon, 28 Jan 2019 10:39:21 -0500
Message-Id: <20190128154341.47195-44-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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

