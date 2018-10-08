Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873D9C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507152087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb0vNN4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507152087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbeJICDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbeJICDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:03:31 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B41E2087D;
        Mon,  8 Oct 2018 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024623;
        bh=ez3WgfJyNGmw6vKExAJBad92V3aPK0l2+16BlahxA3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bb0vNN4c6IvjOpAckmJ2hpa586d71YwkUYcUQeNdFJz2e9WHWhxlKe0R2SDdr4Ziv
         /wBvcEsz0ZHF/Ex5hu8/bVEeR0MVVlXE2FA5OTadgwMmaOadKSJSk8bkfKxibMlPsV
         3ufZKzVDBBigtkXpg44XZTtHCok+uTij/TtZ4aw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Fernando D S Lima <fernandodsl@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 100/168] HID: sensor-hub: Restore fixup for Lenovo ThinkPad Helix 2 sensor hub report
Date:   Mon,  8 Oct 2018 20:31:20 +0200
Message-Id: <20181008175623.864452686@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit ade573eb1e03d1ee5abcb3359b1259469ab6e8ed ]

Commit b0f847e16c1e ("HID: hid-sensor-hub: Force logical minimum to 1 for
power and report state") not only replaced the descriptor fixup done for
devices with the HID_SENSOR_HUB_ENUM_QUIRK with a generic fix, but also
accidentally removed the unrelated descriptor fixup for the Lenovo ThinkPad
Helix 2 sensor hub. This commit restores this fixup.

Restoring this fixup not only fixes the Lenovo ThinkPad Helix 2's sensors,
but also the Lenovo ThinkPad 8's sensors.

Fixes: b0f847e16c1e ("HID: hid-sensor-hub: Force logical minimum ...")
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Fernando D S Lima <fernandodsl@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-sensor-hub.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -579,6 +579,28 @@ void sensor_hub_device_close(struct hid_
 }
 EXPORT_SYMBOL_GPL(sensor_hub_device_close);
 
+static __u8 *sensor_hub_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+		unsigned int *rsize)
+{
+	/*
+	 * Checks if the report descriptor of Thinkpad Helix 2 has a logical
+	 * minimum for magnetic flux axis greater than the maximum.
+	 */
+	if (hdev->product == USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA &&
+		*rsize == 2558 && rdesc[913] == 0x17 && rdesc[914] == 0x40 &&
+		rdesc[915] == 0x81 && rdesc[916] == 0x08 &&
+		rdesc[917] == 0x00 && rdesc[918] == 0x27 &&
+		rdesc[921] == 0x07 && rdesc[922] == 0x00) {
+		/* Sets negative logical minimum for mag x, y and z */
+		rdesc[914] = rdesc[935] = rdesc[956] = 0xc0;
+		rdesc[915] = rdesc[936] = rdesc[957] = 0x7e;
+		rdesc[916] = rdesc[937] = rdesc[958] = 0xf7;
+		rdesc[917] = rdesc[938] = rdesc[959] = 0xff;
+	}
+
+	return rdesc;
+}
+
 static int sensor_hub_probe(struct hid_device *hdev,
 				const struct hid_device_id *id)
 {
@@ -743,6 +765,7 @@ static struct hid_driver sensor_hub_driv
 	.probe = sensor_hub_probe,
 	.remove = sensor_hub_remove,
 	.raw_event = sensor_hub_raw_event,
+	.report_fixup = sensor_hub_report_fixup,
 #ifdef CONFIG_PM
 	.suspend = sensor_hub_suspend,
 	.resume = sensor_hub_resume,


