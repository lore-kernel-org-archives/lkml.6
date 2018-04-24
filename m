Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2218510-1524537958-2-18195798080341377913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, RCVD_IN_SORBS_WEB 1.5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524537957; b=geZwTxQirHV8NQ6HCFXdBJ7pMbBHqczKttKBsm58OBkmmkD3k+
    4fEIAstg6duazMrh5qaYjODa2jGhd8KIisnWfYURnrS/epXbz9MbrMoVIM5C8IEs
    sBtJvgWm+rtLaWeTrQeeYzS3HwOq3DTuVxl9AhXVVVgMJNvIgCYPnuz8itmXvQVo
    Z6HyvARj70YSpYlGzeZHIvsJc8Il+QP3dayc3zQnweZC9j7WdxlHdSpYJ4odmZlN
    Dd8XFwyeMAbGr6YpqXDEYrmYVz0F/krzysQajBtFgYN2qcoefxLhOgfltCfR1IjX
    YXyGLt4vyNQWNAZO9xMtL+vsBQVm88/0FoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524537957; bh=
    bpCgWSpt0kOxlYFf+tVRVOnLgMyfBDCOaShSlgybNzM=; b=PKoX/brM8H2OrqLj
    3UgmJP0Q7Aqp/sZHZ7WaK6QIG3khd1S1SPnpCxtBfn974lI+FkOMyesKn9t6n4/p
    Gov+tRd96Zm91Rln6dpj+WMTCE01jQ6WFkrwZVFU3mG8QQxV6pauosfUShG1UiFt
    Vy6u6+aQHtRNWm0hg2OZuY6bl15TFO0ER8qIWtdCRo/Lv3aV5iIsNHNKR+60IbI8
    YVgi9xxcPY6NqcFLu9FLVfh/x3DDHoXmgHDYyGU191ZOrvrHjVRoZpgwszTmuxCI
    /teKYiQD0wwderJcIi4rqTpVfCt0b5it8viV0m9E8gm1Iq18td6tYdWwJSlYkeWN
    9CtXpQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rock-chips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rock-chips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA5UWW58EG+t885wjyBYT+P80zmGmCQlkylkb9ljn3oDVBcqMao3jc59YInVzoED6PuVs+K6K+QgTGxZ/OiU6Yjr3GddckW7X5m9SVMvYJpgdKphsqfZ
    li+ptl03gPHk18C2FyXRSfpR+0DhYuEHfbqoAdLdhb2aCag+OPYqIQw3tUbIMCfRQXYAuX6yhoECLrMjYk8fwNJ76P872UnhgA2li3DW0WTkmnh535U+DN03
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10
    a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=rPKZa8yPOa4RrKiXScsA:9
    a=UGYfKW25PYDzIkc5:21 a=Ahoje6AFERjQcf6F:21 a=x8gzFH9gYPwA:10
    a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeDXCpP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 22:45:15 -0400
Received: from regular1.263xmail.com ([211.150.99.141]:33375 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932772AbeDXCpO (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 22:45:14 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: william.wu@rock-chips.com
X-FST-TO: hminas@synopsys.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: william.wu@rock-chips.com
X-UNIQUE-TAG: <709dd1a09ae247b423eaff771f8a902b>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: William Wu <william.wu@rock-chips.com>
To: hminas@synopsys.com, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org
Cc: heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org,
        frank.wang@rock-chips.com, huangtao@rock-chips.com,
        dianders@google.com, daniel.meng@rock-chips.com,
        John.Youn@synopsys.com, william.wu@rock-chips.com,
        wzz@rock-chips.com, zsq@rock-chips.com, Allen.Hsu@quantatw.com,
        StanTsui@AOPEN.com
Subject: [PATCH 2/2] usb: dwc2: fix isoc split in transfer with no data
Date: Tue, 24 Apr 2018 10:43:44 +0800
Message-Id: <1524537824-22010-3-git-send-email-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1524537824-22010-1-git-send-email-william.wu@rock-chips.com>
References: <1524537824-22010-1-git-send-email-william.wu@rock-chips.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If isoc split in transfer with no data (the length of DATA0
packet is 0), we can't simply return immediately. Because the
DATA0 can be the first transaction or the second transaction for
the isoc split in transaction. If the DATA0 packet with on data
is in the first transaction, we can return immediately. But if
the the DATA0 packet with on data is in the second transaction
of isoc split in transaction sequence, we need to increase the
qtd->isoc_frame_index and giveback urb to device driver if needed,
otherwise, the MDATA packet will be lost.

A typical test case is that connect the dwc2 controller with an
usb hs Hub (GL852G-12), and plug an usb fs audio device (Plantronics
headset) into the downstream port of Hub. Then use the usb mic
to record, we can find noise when playback.

In the case, the isoc split in transaction sequence like this:

- SSPLIT IN transaction
- CSPLIT IN transaction
  - MDATA packet (176 bytes)
- CSPLIT IN transaction
  - DATA0 packet (0 byte)

This patch use both the length of DATA0 and qtd->isoc_split_offset
to check if the DATA0 is in the second transaction.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
 drivers/usb/dwc2/hcd_intr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index 5e2378f..479f628 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -930,7 +930,7 @@ static int dwc2_xfercomp_isoc_split_in(struct dwc2_hsotg *hsotg,
 	frame_desc = &qtd->urb->iso_descs[qtd->isoc_frame_index];
 	len = dwc2_get_actual_xfer_length(hsotg, chan, chnum, qtd,
 					  DWC2_HC_XFER_COMPLETE, NULL);
-	if (!len) {
+	if (!len && !qtd->isoc_split_offset) {
 		qtd->complete_split = 0;
 		qtd->isoc_split_offset = 0;
 		return 0;
-- 
2.0.0


