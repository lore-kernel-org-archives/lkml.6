Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B53C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41E7206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBnXMpZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41E7206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403769AbeKVK1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:27:12 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:50835 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390731AbeKVK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:27:12 -0500
Received: by mail-pl1-f201.google.com with SMTP id d11-v6so11803586plo.17
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 15:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=llDdmAfd5neVL7V7AaHSFjHSVY2TklPB0DGlVFe6mac=;
        b=OBnXMpZ1eau311w8wuovXTZgOd7JgndO1bVATFdK9mETs3+bGpF7Wao8Sdke4W6wds
         q31Vb8IsNHnrb++0/wFGYx7TLOQPH50+44IEZ6UtgBje4Zca7kb3AlACezP8qwN/Qcaa
         VxCcjJfTxsGk2xTuQr7lUMmj7+9KGUi3RH2a7gXYnkuSXT570+cw9gcSer5nE/gueeoq
         rxCFVxpYuZdGuhmB8/1uY54FVDty7bdplAb7pXoesCUh9mHCP6IVuRWhZP8yy+VEAGSw
         V1x54Sd0roR4kYqwnP6LdOkfnxm+5BdmmzBJxBeB3yVMbnL31mgsyjGFuqm/+XWVjCRh
         Rl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=llDdmAfd5neVL7V7AaHSFjHSVY2TklPB0DGlVFe6mac=;
        b=BtLeKHxpBAy8V6p4P9eSurN/ESLiQO9eqI0P9/86Hg7pm/NHNloJLR7WTquKEElUkx
         StzM0VfYBPOf3vPYrh7xo9b7tIYkDoRZFymZedabG7QUF0TYDpBwOCJgscWNqx4Wiajh
         JRv3a5CRxe3+5h793fEm8dUDzGJ7ZVsFjE1sr2fyU+nxwOSLGvEsD8T+DF46WsYMNE/P
         yJn5u+/ggH3cSY6yQUWNvRiq6MelG94/d9D6YA/s3cWoBhDFw/5a86Yu3arG3HBsA3dQ
         SJcB7zgQS/EskpFObTXKQWWa7qepDM5muq2GkZVvhbC4zAUDjSuhfPo9ZKif4MQz8UwI
         JgdQ==
X-Gm-Message-State: AGRZ1gLzXVroImhD4QWqDc5rnk6yj+Oz30i+uzevJ20UQ9w5YOsglhUu
        ARINx+p+74Iqwe0zCJ9XhOe72KuwmYBr
X-Google-Smtp-Source: AJdET5fs+P1UUmSx0AyK/kmNUhbo6v6jNhIe8nVPh/v1JfQvGidUweh5dh2nKJnHABPZy2w9+GAMufyGUH0p
X-Received: by 2002:a62:f247:: with SMTP id y7mr3857992pfl.105.1542844235255;
 Wed, 21 Nov 2018 15:50:35 -0800 (PST)
Date:   Wed, 21 Nov 2018 15:50:19 -0800
In-Reply-To: <20181121235020.29461-1-rajatja@google.com>
Message-Id: <20181121235020.29461-4-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20181121235020.29461-1-rajatja@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH v3 4/5] Bluetooth: btusb: Collect the common Intel assignments together
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
v3: same as v1
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

