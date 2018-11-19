Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C56C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0EB2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pt9I7orm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0EB2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbeKTJap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:30:45 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:51454 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732123AbeKTJab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:30:31 -0500
Received: by mail-pl1-f202.google.com with SMTP id 3-v6so24643284plc.18
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 15:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZerO0x85S+KXn/eWjn2EIwWcOtUjMTo6CrHKJ6cTlG0=;
        b=pt9I7ormK9h9+8r2hg8AmgjQkbcKJ9Yndj0BnG+HfwD8qxm9b0wYagZUP2IjG9OlzJ
         KEofOyQGFEvY2CVHlGOYU1U2KX9bhw3b/nj8AmJV4JcsIG/SbttDHAw3QcpXScZKIYuu
         Qtshz2DH3flU00r2o7CtXkB8rX7kY+2WbYXH3A3uRC+XBIB2mQuUHoP2ntMuo/c1nOxa
         pmGyVjwANThkHAEIHRmS9NmNvokgm3N637K/CnPv3f+kKMPvYGqzXSOfbWTHT4PDcFhW
         MAsoNoFlkgjNbPwCm9EvXb58vkBH6Y5JFCIzbLCIqshjyvfAFLAQT/8B2QrtXEU4BRyy
         f4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZerO0x85S+KXn/eWjn2EIwWcOtUjMTo6CrHKJ6cTlG0=;
        b=F5gC/Dq7hwsCHtka8S8jzuimMOzgvIVcX1orwk0U8zVJLdPbH4OB/urRwDfItxyOeA
         myRWDuCwPjCOiGxGj1WkLd740WByG4cVSF+auYgMyMjUn7xSEgdb/2YU+J4iil2mwc/W
         CrgcPm/DUkk0mMf6aQOP18OdP2qK3NlfiZUwgLZIRzZ702MjrphDelwYGlTCmKzAE1WG
         9grM5nNvpk82xL1BPMKtshyq/QoFWUM4C7kM/GG3NEwbdniDIXJpb8l58MWkwl6c9p5E
         JBKD0zdXYHLl1Q73IaLfu9idT745Ke+8lC1Oa4EjM0yRPVyagpzXlW7Q0icuqqN3Dnst
         WKJw==
X-Gm-Message-State: AGRZ1gIgRsiKrWr3nIg0AKsFXRIJ8ZuOya9XG2oBEmVqZk9k73nXj46Z
        pit+xjOYbhFhwyXIk779NrDGShid1ghJ
X-Google-Smtp-Source: AJdET5ecx09neK3Gebcooqd0Np39UZYoF7Xdhoi+LyR3KCIxcNPS6HXQaJmcJchFOO/wWeB6oXbZBERahsSM
X-Received: by 2002:a62:8a41:: with SMTP id y62-v6mr8164482pfd.70.1542668673264;
 Mon, 19 Nov 2018 15:04:33 -0800 (PST)
Date:   Mon, 19 Nov 2018 15:04:08 -0800
In-Reply-To: <20181119230409.258121-1-rajatja@google.com>
Message-Id: <20181119230409.258121-4-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20181119230409.258121-1-rajatja@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH v2 4/5] Bluetooth: btusb: Collect the common Intel assignments together
From:   Rajat Jain <rajatja@google.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Cc:     rajatxjain@gmail.com, dtor@google.com, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BTUSB_INTEL and BTUSB_INTEL_NEW have common functions & quirks are
assigned to hdev structure. Lets collect them together instead of
repeating them in different code branches.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: same as v1

 drivers/bluetooth/btusb.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7439a7eb50ac..e8e148480c91 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3077,28 +3077,25 @@ static int btusb_probe(struct usb_interface *intf,
 		data->diag = usb_ifnum_to_if(data->udev, ifnum_base + 2);
 	}
 #endif
+	if (id->driver_info & BTUSB_INTEL ||
+	    id->driver_info & BTUSB_INTEL_NEW) {
 
-	if (id->driver_info & BTUSB_INTEL) {
 		hdev->manufacturer = 2;
-		hdev->setup = btusb_setup_intel;
-		hdev->shutdown = btusb_shutdown_intel;
-		hdev->set_diag = btintel_set_diag_mfg;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
-	}
 
-	if (id->driver_info & BTUSB_INTEL_NEW) {
-		hdev->manufacturer = 2;
-		hdev->send = btusb_send_frame_intel;
-		hdev->setup = btusb_setup_intel_new;
-		hdev->hw_error = btintel_hw_error;
-		hdev->set_diag = btintel_set_diag;
-		hdev->set_bdaddr = btintel_set_bdaddr;
-		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
-		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
-		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+		if (id->driver_info & BTUSB_INTEL) {
+			hdev->setup = btusb_setup_intel;
+			hdev->shutdown = btusb_shutdown_intel;
+			hdev->set_diag = btintel_set_diag_mfg;
+		} else {
+			hdev->send = btusb_send_frame_intel;
+			hdev->setup = btusb_setup_intel_new;
+			hdev->hw_error = btintel_hw_error;
+			hdev->set_diag = btintel_set_diag;
+		}
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
-- 
2.19.1.1215.g8438c0b245-goog

