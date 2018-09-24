Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88173ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D7321486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D7321486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbeIXSgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:36:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeIXSg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:36:29 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4D0481018;
        Mon, 24 Sep 2018 12:34:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Bryant G. Ly" <bryantly@linux.ibm.com>,
        Bradley Warrum <bwarrum@us.ibm.com>
Subject: [PATCH 4.18 111/235] misc: ibmvsm: Fix wrong assignment of return code
Date:   Mon, 24 Sep 2018 13:51:37 +0200
Message-Id: <20180924113116.949207599@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bryant G. Ly <bryantly@linux.ibm.com>

commit c55e9318871cd06e4aa10f5023cc2dcdfbb08577 upstream.

Currently the assignment is flipped and rc is always 0.

Signed-off-by: Bryant G. Ly <bryantly@linux.ibm.com>
Fixes: 0eca353e7ae7 ("misc: IBM Virtual Management Channel Driver (VMC)")
Reviewed-by: Bradley Warrum <bwarrum@us.ibm.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/ibmvmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -2131,7 +2131,7 @@ static int ibmvmc_init_crq_queue(struct
 	retrc = plpar_hcall_norets(H_REG_CRQ,
 				   vdev->unit_address,
 				   queue->msg_token, PAGE_SIZE);
-	retrc = rc;
+	rc = retrc;
 
 	if (rc == H_RESOURCE)
 		rc = ibmvmc_reset_crq_queue(adapter);


