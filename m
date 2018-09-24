Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F79DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FDF21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FDF21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbeIXSAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:00:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52402 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbeIXSAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:00:30 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2519DD64;
        Mon, 24 Sep 2018 11:58:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        David Binderman <dcb314@hotmail.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 4.4 33/70] Tools: hv: Fix a bug in the key delete code
Date:   Mon, 24 Sep 2018 13:52:32 +0200
Message-Id: <20180924113102.584761362@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113058.420454070@linuxfoundation.org>
References: <20180924113058.420454070@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: K. Y. Srinivasan <kys@microsoft.com>

commit 86503bd35dec0ce363e9fdbf5299927422ed3899 upstream.

Fix a bug in the key delete code - the num_records range
from 0 to num_records-1.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reported-by: David Binderman <dcb314@hotmail.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/hv/hv_kvp_daemon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -286,7 +286,7 @@ static int kvp_key_delete(int pool, cons
 		 * Found a match; just move the remaining
 		 * entries up.
 		 */
-		if (i == num_records) {
+		if (i == (num_records - 1)) {
 			kvp_file_info[pool].num_records--;
 			kvp_update_file(pool);
 			return 0;


