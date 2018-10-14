Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A189FC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748BC20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748BC20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbeJNXMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:34 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36448 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728297AbeJNXMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:08 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLu-0004cY-AS; Sun, 14 Oct 2018 16:30:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLW-0000U7-BH; Sun, 14 Oct 2018 16:30:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "=?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?=" 
        <sz.lin@moxa.com>, "=?UTF-8?Q?Bj=C3=B8rn=20?=Mork" <bjorn@mork.no>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.409892759@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 239/366] NET: usb: qmi_wwan: add support for ublox
 R410M PID 0x90b2
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: SZ Lin (林上智)
 <sz.lin@moxa.com>

commit 9306b38e42cb266f98bff6f6f4c1c652aa79ba45 upstream.

This patch adds support for PID 0x90b2 of ublox R410M.

qmicli -d /dev/cdc-wdm0 --dms-get-manufacturer
[/dev/cdc-wdm0] Device manufacturer retrieved:
        Manufacturer: 'u-blox'

qmicli -d /dev/cdc-wdm0 --dms-get-model
[/dev/cdc-wdm0] Device model retrieved:
        Model: 'SARA-R410M-02B'

Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -677,6 +677,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x05c6, 0x9080, 8)},
 	{QMI_FIXED_INTF(0x05c6, 0x9083, 3)},
 	{QMI_FIXED_INTF(0x05c6, 0x9084, 4)},
+	{QMI_FIXED_INTF(0x05c6, 0x90b2, 3)},    /* ublox R410M */
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 0)},
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 5)},
 	{QMI_FIXED_INTF(0x0846, 0x68a2, 8)},

