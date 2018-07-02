Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB081C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7515723F23
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7515723F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbeGBJki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:40:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54745 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeGBJke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:40:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fZvJt-0002Bs-7P; Mon, 02 Jul 2018 09:40:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: intel-ish-hid: remove redundant variable num_frags
Date:   Mon,  2 Jul 2018 10:40:28 +0100
Message-Id: <20180702094028.15428-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable num_frags is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'num_frags' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/intel-ish-hid/ishtp/hbm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/hbm.c b/drivers/hid/intel-ish-hid/ishtp/hbm.c
index ae4a69f7f2f4..8b5dd580ceec 100644
--- a/drivers/hid/intel-ish-hid/ishtp/hbm.c
+++ b/drivers/hid/intel-ish-hid/ishtp/hbm.c
@@ -298,7 +298,6 @@ int ishtp_hbm_cl_flow_control_req(struct ishtp_device *dev,
 	struct ishtp_msg_hdr *ishtp_hdr = &hdr;
 	const size_t len = sizeof(struct hbm_flow_control);
 	int	rv;
-	unsigned int	num_frags;
 	unsigned long	flags;
 
 	spin_lock_irqsave(&cl->fc_spinlock, flags);
@@ -314,7 +313,6 @@ int ishtp_hbm_cl_flow_control_req(struct ishtp_device *dev,
 		return	0;
 	}
 
-	num_frags = cl->recv_msg_num_frags;
 	cl->recv_msg_num_frags = 0;
 
 	rv = ishtp_write_message(dev, ishtp_hdr, data);
-- 
2.17.1

