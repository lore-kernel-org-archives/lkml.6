Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A43C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179D820894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179D820894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389326AbeG0LYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:24:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34476 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388562AbeG0LYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:24:16 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E1F2ABB6;
        Fri, 27 Jul 2018 10:03:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.14 34/48] usb: cdc_acm: Add quirk for Castles VEGA3000
Date:   Fri, 27 Jul 2018 12:00:19 +0200
Message-Id: <20180727095922.077101637@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727095918.503549522@linuxfoundation.org>
References: <20180727095918.503549522@linuxfoundation.org>
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

From: Lubomir Rintel <lkundrak@v3.sk>

commit 1445cbe476fc3dd09c0b380b206526a49403c071 upstream.

The device (a POS terminal) implements CDC ACM, but has not union
descriptor.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1844,6 +1844,9 @@ static const struct usb_device_id acm_id
 	{ USB_DEVICE(0x09d8, 0x0320), /* Elatec GmbH TWN3 */
 	.driver_info = NO_UNION_NORMAL, /* has misplaced union descriptor */
 	},
+	{ USB_DEVICE(0x0ca6, 0xa050), /* Castles VEGA3000 */
+	.driver_info = NO_UNION_NORMAL, /* reports zero length descriptor */
+	},
 
 	{ USB_DEVICE(0x2912, 0x0001), /* ATOL FPrint */
 	.driver_info = CLEAR_HALT_CONDITIONS,


