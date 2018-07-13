Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A17ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D8C2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D8C2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeGMJ45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:56:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59449 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeGMJ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:56:57 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fdubO-0006Te-0q; Fri, 13 Jul 2018 09:43:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: host: whci: remove redundant variable t
Date:   Fri, 13 Jul 2018 10:43:01 +0100
Message-Id: <20180713094301.18585-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable t is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 't' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/host/whci/pzl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/host/whci/pzl.c b/drivers/usb/host/whci/pzl.c
index bb84366f7bd3..ef52aeb02fde 100644
--- a/drivers/usb/host/whci/pzl.c
+++ b/drivers/usb/host/whci/pzl.c
@@ -96,9 +96,7 @@ static enum whc_update pzl_process_qset(struct whc *whc, struct whc_qset *qset)
 
 	while (qset->ntds) {
 		struct whc_qtd *td;
-		int t;
 
-		t = qset->td_start;
 		td = &qset->qtd[qset->td_start];
 		status = le32_to_cpu(td->status);
 
-- 
2.17.1

