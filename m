Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D4BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDA9206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpd7iLCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDA9206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390751AbeKVK1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:27:10 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:42106 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390731AbeKVK1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:27:09 -0500
Received: by mail-it1-f201.google.com with SMTP id z195-v6so8768825itb.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 15:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ocDM1LbkKNji8o5absN8u+LSfXhmwVAzLCbs3C5cHds=;
        b=mpd7iLCah+Z9Gu6vxhKiFF10xJnX1KHQVw3lpU8SyL1suAVcHf8AF/KNn1OkJDg+yT
         gjkNvCIzW9xj2ove5q4YmnFiDcC/EIBbFNX0S1Irzl8ARWZfoDp+5W5XRA/YuCxXO/Dp
         NSKAZdc4hVs4AztyLeaWUoLHWHCgPcDSFKHtP5zSk1ZU+t2nIWRLlWqKWTxdBRy3HGzO
         lNtYrskbMkKcWPB0VAsmv0DW6SuHd3HxheJwujsRI3xBBS9UCYTXpWPL/QgU7p5qIyba
         huh59ItTGrMk6uIaXUEonH7Jn0caALosC5F0liOzTfX42VEMh1oJII87MRhQA68TZwbt
         jzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ocDM1LbkKNji8o5absN8u+LSfXhmwVAzLCbs3C5cHds=;
        b=FPJTWYO5JjgkD2Vi2tmLr6fC0sws3ZFYxK88wtTgLCCo45EBPn+QqYd3lkfgWNdoJa
         gBrJMIkh9WSab0imSvsU6S+sdhQc5VaGLX9IjWdwp6cewGgS9l1QdETJH/wzOwa26Vwd
         3IbGGpUhB5tYrCKlo+SooRLsmrPzxatyQw45UMNgVdYur3Gm4CwbRpiUbyMBFVLL+lA9
         v9fPUvLkK20ljrLT+sne8lIcnbx6UlFFMwvml3GHYmr9UALYkBX9enONUl/KNPk9Uh4i
         pZqJtl1YJjSEIKc7MWKdogtK1utHWG7YCPag7sUKtUUTrmFrvV0mflmVWawpYIJ8INS0
         ugsQ==
X-Gm-Message-State: AA+aEWaUVOLTHru6veQfIp0AudNAV0OyBOhY/krqoTLzfsmfXKIUA6d8
        jn4NkaUp32i4KzKKzxc7dG0xalVE7c4L
X-Google-Smtp-Source: AFSGD/VWHTw4LLRgcchZIk+vaapC6bhpBHLgFkmsbKMxr4zP6VfNpmzz3LYh/UzX6On2fcu40OBbMpoLwGpg
X-Received: by 2002:a24:41d4:: with SMTP id b81mr5300566itd.0.1542844232253;
 Wed, 21 Nov 2018 15:50:32 -0800 (PST)
Date:   Wed, 21 Nov 2018 15:50:18 -0800
In-Reply-To: <20181121235020.29461-1-rajatja@google.com>
Message-Id: <20181121235020.29461-3-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20181121235020.29461-1-rajatja@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH v3 3/5] Bluetooth: Reset Bluetooth chip after multiple command timeouts
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

Add a quirk and a hook to allow the HCI core to reset the BT chip
if needed (after a number of timed out commands). Use that new hook to
initiate BT chip reset if the controller fails to respond to certain
number of commands (currently 5) including the HCI reset commands.
This is done based on a newly introduced quirk. This is done based
on some initial work by Intel.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: same as v1
v2: same as v1

 include/net/bluetooth/hci.h      |  8 ++++++++
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 15 +++++++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c36dc1e20556..af02fa5ffe54 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -192,6 +192,14 @@ enum {
 	 *
 	 */
 	HCI_QUIRK_NON_PERSISTENT_SETUP,
+
+	/* When this quirk is set, hw_reset() would be run to reset the
+	 * hardware, after a certain number of commands (currently 5)
+	 * time out because the device fails to respond.
+	 *
+	 * This quirk should be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_HW_RESET_ON_TIMEOUT,
 };
 
 /* HCI device flags */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e5ea633ea368..b86218304b80 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -313,6 +313,7 @@ struct hci_dev {
 	unsigned int	acl_cnt;
 	unsigned int	sco_cnt;
 	unsigned int	le_cnt;
+	unsigned int	timeout_cnt;
 
 	unsigned int	acl_mtu;
 	unsigned int	sco_mtu;
@@ -437,6 +438,7 @@ struct hci_dev {
 	int (*post_init)(struct hci_dev *hdev);
 	int (*set_diag)(struct hci_dev *hdev, bool enable);
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+	void (*hw_reset)(struct hci_dev *hdev);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7352fe85674b..ab3a6a8b7ba6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2569,13 +2569,24 @@ static void hci_cmd_timeout(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    cmd_timer.work);
 
+	hdev->timeout_cnt++;
 	if (hdev->sent_cmd) {
 		struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
 		u16 opcode = __le16_to_cpu(sent->opcode);
 
-		bt_dev_err(hdev, "command 0x%4.4x tx timeout", opcode);
+		bt_dev_err(hdev, "command 0x%4.4x tx timeout (cnt = %u)",
+			   opcode, hdev->timeout_cnt);
 	} else {
-		bt_dev_err(hdev, "command tx timeout");
+		bt_dev_err(hdev, "command tx timeout (cnt = %u)",
+			   hdev->timeout_cnt);
+	}
+
+	if (test_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks) &&
+	    hdev->timeout_cnt >= 5) {
+		hdev->timeout_cnt = 0;
+		if (hdev->hw_reset)
+			hdev->hw_reset(hdev);
+		return;
 	}
 
 	atomic_set(&hdev->cmd_cnt, 1);
-- 
2.19.1.1215.g8438c0b245-goog

