Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45F9C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AD6206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRJ9ktXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AD6206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbeKQLWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 06:22:51 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:46255 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731006AbeKQLWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 06:22:50 -0500
Received: by mail-pl1-f202.google.com with SMTP id m1-v6so18415874plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 17:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=otj/32ePMtp8zjyI9T3AOMCzqrhYC3AtvdJgM2y5xMU=;
        b=KRJ9ktXtxL92PTIPjGraoP+jZH+QxfyrW0XLo5P38qqRG5iXW4H0mbHVGrTJY01VVY
         5IQkgkU8oE7auKOf1UjR0ex9sDUtY3z6klXTaGvBm6z7jZ31hwKDLIfkIsCIGqQLj3qJ
         rRQYBIWTdtCd8UERr8EnmPR8+st0jufTbj853h8ul+nW3py4ooVTOUZYjzDRQH0jVfRn
         p3g5E2BWinWrcvlh8ET0/PqZW6pjQIdslKm93VXTCiau0BoZ2VXfgsofdeAMYzID9YTD
         07wb0FyHo6ZoJbIitMBhVaRKA0IfzjCQqu/ZtOzyLQPfcA35pHFgJXLSJcfCrIRIhz5r
         9BVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=otj/32ePMtp8zjyI9T3AOMCzqrhYC3AtvdJgM2y5xMU=;
        b=TbskN7r3DZNMcIqsf+yhuthkjdU9SHVg4mHfnF5qUh726BtMt6EZ+LeSRT0ChIdFPq
         hrfKgvslMALCIwU51xLvtzyq+ohP+1XRRQsr/eWxE7vOdk9KkI/seI0rMGSIEO7MEjsJ
         gH+QZKfmLma4rZ++YcoIMK+jbPzGnbT0DapbzC+ystFRvfK5/uKleP60yXQPxuECGrIx
         b88DqCE5fCfTi2fl3tED7CZiiZvk33z+Sb7QNSARhQNf08DdOBRrIGSH9nu8m1WusNxg
         /fpc1wcoExyQzqH1eujRlOnKtBvdA6GD+IrGYhL7VBnnGTyk3yOo7JpH7AVh2vDEu1vt
         1MkQ==
X-Gm-Message-State: AA+aEWa/NTZ8qcwiUaO1X7DCq+V6dUCosy/Id6k1QDs484xdS8vP7T5y
        No8Z5R64jXBkRouUW8fLRKbancCXAfgD
X-Google-Smtp-Source: AFSGD/XRJZoMm/pkhIcQK8n1ROMyqQENtXD0+5hcPxiq6+KXNTzOQ3LxFLcqSj/FLV/zvuQs2WbLKtVsxm0m
X-Received: by 2002:a63:e210:: with SMTP id q16mr64085pgh.132.1542416889258;
 Fri, 16 Nov 2018 17:08:09 -0800 (PST)
Date:   Fri, 16 Nov 2018 17:07:47 -0800
In-Reply-To: <20181117010748.24347-1-rajatja@google.com>
Message-Id: <20181117010748.24347-5-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 4/5] Bluetooth: btusb: Collect the common Intel assignments together
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

