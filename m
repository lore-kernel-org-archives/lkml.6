Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B99DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AE420936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67AE420936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389993AbeGJSgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:36:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389962AbeGJSgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:36:46 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DE7C1EE8;
        Tue, 10 Jul 2018 18:36:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.17 55/56] staging: comedi: quatech_daqp_cs: fix no-op loop daqp_ao_insn_write()
Date:   Tue, 10 Jul 2018 20:25:37 +0200
Message-Id: <20180710182506.157125104@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 1376b0a2160319125c3a2822e8c09bd283cd8141 upstream.

There is a '>' vs '<' typo so this loop is a no-op.

Fixes: d35dcc89fc93 ("staging: comedi: quatech_daqp_cs: fix daqp_ao_insn_write()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers/quatech_daqp_cs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/comedi/drivers/quatech_daqp_cs.c
+++ b/drivers/staging/comedi/drivers/quatech_daqp_cs.c
@@ -642,7 +642,7 @@ static int daqp_ao_insn_write(struct com
 	/* Make sure D/A update mode is direct update */
 	outb(0, dev->iobase + DAQP_AUX_REG);
 
-	for (i = 0; i > insn->n; i++) {
+	for (i = 0; i < insn->n; i++) {
 		unsigned int val = data[i];
 		int ret;
 


