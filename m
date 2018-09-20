Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F2CC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E4721524
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzOgWTw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E4721524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbeITMvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:51:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36062 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731521AbeITMvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:51:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id f4-v6so6952639edq.3;
        Thu, 20 Sep 2018 00:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=EVXqG9TFNSdJftDH674RRhhZn1hGyeYCHYEDOQJMmWQ=;
        b=AzOgWTw8UE+69eJ7p81dhasLqs3sLqOb5Jj0TnQz9ePi48WLkqb79A2swjiwf2kMpe
         mAJxVtG8QBw7I6e1lQlFbJDxsPWkMAJTU/GfF+7K7xG4BgyqtYXwt3incVdczK3z+HYS
         idew4NiIDwwFU5KxZQxoLbRMDrRjwGE+3lCNCdkybn8DG9I1HQRd/VODojb8yG+cCP3E
         3UFxBxv640elBYRHHHdEQqIK5cJ3gVbd2ZgEp38gnae/tKwSlNl4eUQiyKnrNLkfyAEp
         ZEu4GzCwxeDxFplEX3W1+6LyG97f8qasB9obw2AiZAGt/ZR3ppeWkxASRhzod8S8dB9P
         3gGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=EVXqG9TFNSdJftDH674RRhhZn1hGyeYCHYEDOQJMmWQ=;
        b=YfwJLI36PEAFYypSGG9Vi6dwsMw7N7VGNWLKKFZE96YMk6yBoHJ1npy3U+NS+GqYoM
         o2SyI13K4O1dP9rotE7Q6EaQH0WozLPMJU5kY3EQcOhd4AloZNHNhFwMPcmPKIwUMQcd
         dUykH7rrgSGhEWIv2c5T92xhiv9GNzc55UV2uNqeEnJKP0oeF4X+XGRO0WZBI6gQtNil
         n/iRCjKfKF4EyY7E535wKZMQVqL3Kqo0ds8Q648cjbTd11cTuZq1nd4cjhvMokxPmkvN
         xqa4unDfbvHobRuQ+jr5mgQvZoF5mFwUelNFAUN62+jhCA+AnrGK3kp/35osddnu8IW2
         tfjw==
X-Gm-Message-State: APzg51C79VwV/Ph8NwwzOrknCU4sBS4eDY9jmHbfhZpzLt8C9iz+0BIX
        Gm9vbrg6xLbHHl0CZk+LOwZkeCneyJU=
X-Google-Smtp-Source: ANB0VdZSyKA1ToXAgD4fD6EXaV0pxM31aANwKJG70Ur2RF5zi7rs4beDAZ5ZOnd10EaTdcURDT8+/A==
X-Received: by 2002:a50:cc0a:: with SMTP id m10-v6mr2452622edi.81.1537427382352;
        Thu, 20 Sep 2018 00:09:42 -0700 (PDT)
Received: from localhost (84-199-88-153.iFiber.telenet-ops.be. [84.199.88.153])
        by smtp.gmail.com with ESMTPSA id c15-v6sm563198edm.21.2018.09.20.00.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 00:09:41 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>,
        Joe Perches <joe@perches.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: core: disable USB2 LPM when suspending
Date:   Thu, 20 Sep 2018 15:09:40 +0800
Message-Id: <20180920070940.14773-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found a S5 current leakage issue on Dell DW1820 WiFi/BT combo card
which uses Qualcomm QCA6174 SoC. It also comes with WiFi and BT failure
when encountered current leakage issue.
   1. Power on, both WiFi and BT work.
   2. Power off and found a current leakage issue(consumes ~0.5W)
   3. Power on, no WiFi and BT devices can be found in lspci and lsusb.
   4. Power off, there is no current leakage issue at S5.
   5. continue to 1.

From Qualcomm's report:
Based on the USB sniffer log, the difference between Linux and Windows
is USB LPM setting(no LPM transaction on Windows) which may leads to
the voltage leakage on Linux S5 state.

After checked the LPM related code and found, when system is going to
enter S5, it resumes the USB devices from runtime suspend and enables
USB2 LPM, and then it calls usb_dev_poweroff() -> usb_suspend(), and
leave USB2 LPM stays enabled.

Disable USB2 LPM in usb_suspend() fixes the issue mentioned above,
and try 30 times of s2idle, S3 and S5, the USB devices keep working
well. Disable USB2 LPM seems do no harm to the system.

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/usb/core/driver.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index e76e95f62f76..ac5e60d7104f 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1463,6 +1463,9 @@ int usb_suspend(struct device *dev, pm_message_t msg)
 	struct usb_device	*udev = to_usb_device(dev);
 	int r;
 
+	if (udev->usb2_hw_lpm_enabled == 1)
+		usb_set_usb2_hardware_lpm(udev, 0);
+
 	unbind_no_pm_drivers_interfaces(udev);
 
 	/* From now on we are sure all drivers support suspend/resume
-- 
2.17.1

