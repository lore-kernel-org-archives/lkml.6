Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E462FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B87208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B87208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967698AbeFRIea (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:34:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35746 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967286AbeFRIe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:34:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4A974C8A;
        Mon, 18 Jun 2018 08:34:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 113/189] IB/hfi1 Use correct type for num_user_context
Date:   Mon, 18 Jun 2018 10:13:29 +0200
Message-Id: <20180618081213.798229505@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Michael J. Ruhl" <michael.j.ruhl@intel.com>

[ Upstream commit 5da9e742be44d9b7c68b1bf6e1aaf46a1aa7a52b ]

The module parameter num_user_context is defined as 'int' and
defaults to -1.  The module_param_named() says that it is uint.

Correct module_param_named() type information and update the modinfo
text to reflect the default value.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hfi1/init.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -88,9 +88,9 @@
  * pio buffers per ctxt, etc.)  Zero means use one user context per CPU.
  */
 int num_user_contexts = -1;
-module_param_named(num_user_contexts, num_user_contexts, uint, S_IRUGO);
+module_param_named(num_user_contexts, num_user_contexts, int, 0444);
 MODULE_PARM_DESC(
-	num_user_contexts, "Set max number of user contexts to use");
+	num_user_contexts, "Set max number of user contexts to use (default: -1 will use the real (non-HT) CPU count)");
 
 uint krcvqs[RXE_NUM_DATA_VL];
 int krcvqsset;


