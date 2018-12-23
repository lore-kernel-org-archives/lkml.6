Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F8FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 17:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9889217F5
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 17:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbeLWRX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 12:23:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:19449 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbeLWRX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 12:23:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2018 09:23:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,388,1539673200"; 
   d="scan'208";a="120572638"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga002.jf.intel.com with ESMTP; 23 Dec 2018 09:23:56 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: squash single_recv_buf into one bit in client properties
Date:   Sun, 23 Dec 2018 20:17:51 +0200
Message-Id: <20181223181751.8913-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

single_recv_buf member of struct mei_client_properties has a boolean
value and can be represented in on bit, to free other 7 bits
for another usage.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index 2b7f7677f8cc..b7d2487b8409 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -311,7 +311,8 @@ struct mei_client_properties {
 	u8 protocol_version;
 	u8 max_number_of_connections;
 	u8 fixed_address;
-	u8 single_recv_buf;
+	u8 single_recv_buf:1;
+	u8 reserved:7;
 	u32 max_msg_length;
 } __packed;
 
-- 
2.20.1

