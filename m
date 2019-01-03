Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BB8C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109E42184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZClz4h3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfACV5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:57:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38395 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfACV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:57:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so31738824wml.3;
        Thu, 03 Jan 2019 13:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sr/xeY2hQLyAuW0xzO0GFJQ5rzQ9GEkxYZSHxefPCe0=;
        b=MZClz4h3OEHyqK+OWM571Gyfp/F6mxZo+r42Kz007Birbb3zIP3/bMa9r8UgFQqkJu
         fPY678er7KjNcbVHFfTwvOrsV687VIXkriJM+FhvZU9VTfYUbdgeTIkHBck+6TvLn+aQ
         1GCnzVNr/bGGwEQ/KEi0bbm17Sn23JoLyrtDfaNtTZeEvnXlksCVR2TrcpKreRr/m4Kc
         ckQHZ/eQhX0hOmzdVHhTld1Dl7uZU5HUOmmCodw7xwQm5lTTRrK+xOpv3n6DW2WmWMV9
         7pQZSFS1xuYv13REkpEjI/6lbdi9xgZDfozDbmS0Q5arjCygSEPNadSViEyHXDeymzwb
         2wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sr/xeY2hQLyAuW0xzO0GFJQ5rzQ9GEkxYZSHxefPCe0=;
        b=DkBL/HCGnBeZVRVjWbxgbMjPvXU0iMCEJZuQn1TqUUTLF4l1mvmYE5d34G3EDfbrvW
         5yHrdM0xogNXc3pvw5v7pJP5t6mSRfmJmKMtywEZYFokN/xvu8hjvxvR9s2Q/MeM9lWh
         vsJuTid/B+xaxe1exa9niMaeB1ikVmEP6mKC33o/Gu5+T4VvV7xRVz9TRgXvKHKqRlSH
         X2IQE+3z1xQOf1J5L4i6oo6ECP9cbxALyl8pwYcab0qDIBw33mY9xIvXo7PFhKcIibjP
         03/sifDkEmmCTa4/+GP4G0BV8bTl32CBImjlajJnvXzWLEutIvSTrugk31AwV9Q4V9cC
         cdbg==
X-Gm-Message-State: AJcUukcQ8vyGizwnzx8iOjQzH6m0WWH+nDehCNnVObYtWX2/Fzx6jSjn
        hwXOIquNLpRoAKDpnhc3+NY=
X-Google-Smtp-Source: ALg8bN6yxQuPFFt3aE8Q99SUrRb3ExWgwOxNiHAhHBqp5lD1+HCspniLkT2o0F1fTrpcSLGNqKFNJA==
X-Received: by 2002:a1c:7c07:: with SMTP id x7mr167964wmc.82.1546552621475;
        Thu, 03 Jan 2019 13:57:01 -0800 (PST)
Received: from jack-All-Series.home (12.221.208.46.dyn.plus.net. [46.208.221.12])
        by smtp.gmail.com with ESMTPSA id d4sm33512920wmb.25.2019.01.03.13.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jan 2019 13:57:00 -0800 (PST)
From:   Jack Stocker <jackstocker.93@gmail.com>
Cc:     Jack Stocker <jackstocker.93@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Harry Pan <harry.pan@intel.com>,
        Kamil Lulko <kamilx.lulko@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Add USB_QUIRK_DELAY_CTRL_MSG quirk for Corsair K70 RGB
Date:   Thu,  3 Jan 2019 21:56:53 +0000
Message-Id: <1546552613-20176-1-git-send-email-jackstocker.93@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <68e03db778525f1d26d72a683bc0e0e2@dk-develop.de>
References: <68e03db778525f1d26d72a683bc0e0e2@dk-develop.de>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To match the Corsair Strafe RGB, the Corsair K70 RGB also requires
USB_QUIRK_DELAY_CTRL_MSG to completely resolve boot connection issues
discussed here: https://github.com/ckb-next/ckb-next/issues/42.
Otherwise roughly 1 in 10 boots the keyboard will fail to be detected.

Patch that applied delay control quirk for Corsair Strafe RGB:
cb88a0588717 ("usb: quirks: add control message delay for 1b1c:1b20")

Previous K70 RGB patch to add delay-init quirk:
7a1646d92257 ("Add delay-init quirk for Corsair K70 RGB keyboards")

Signed-off-by: Jack Stocker <jackstocker.93@gmail.com>
---
Changes in v2:
  - Added references to previous patches that affect this change.

 drivers/usb/core/quirks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 7909262..4a9267d 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -377,7 +377,8 @@ static const struct usb_device_id usb_quirk_list[] = {
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
 	/* Corsair K70 RGB */
-	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
+	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_DELAY_CTRL_MSG },
 
 	/* Corsair Strafe RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT |
-- 
2.7.4

