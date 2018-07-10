Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3640EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D3020881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D3020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751715AbeGJGgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:36:42 -0400
Received: from shell.v3.sk ([90.176.6.54]:47465 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751194AbeGJGgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:36:40 -0400
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jul 2018 02:36:39 EDT
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 393C4AF814;
        Tue, 10 Jul 2018 08:28:55 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RWCaSS_rDWcV; Tue, 10 Jul 2018 08:28:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BF3EEAF84D;
        Tue, 10 Jul 2018 08:28:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WRNYEzkg7WeM; Tue, 10 Jul 2018 08:28:52 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 1A483AF814;
        Tue, 10 Jul 2018 08:28:52 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] usb: cdc_acm: Add quirk for Castles VEGA3000
Date:   Tue, 10 Jul 2018 08:28:49 +0200
Message-Id: <20180710062849.915863-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device (a POS terminal) implements CDC ACM, but has not union
descriptor.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/usb/class/cdc-acm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 998b32d0167e..75c4623ad779 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1831,6 +1831,9 @@ static const struct usb_device_id acm_ids[] = {
 	{ USB_DEVICE(0x09d8, 0x0320), /* Elatec GmbH TWN3 */
 	.driver_info = NO_UNION_NORMAL, /* has misplaced union descriptor */
 	},
+	{ USB_DEVICE(0x0ca6, 0xa050), /* Castles VEGA3000 */
+	.driver_info = NO_UNION_NORMAL, /* reports zero length descriptor */
+	},
 
 	{ USB_DEVICE(0x2912, 0x0001), /* ATOL FPrint */
 	.driver_info = CLEAR_HALT_CONDITIONS,
-- 
2.17.1

