Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD6CC1B0FD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F252920823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKBLVT+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfARWe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:34:26 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:34372 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbfARWeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:34:25 -0500
Received: by mail-vk1-f201.google.com with SMTP id l202so3500006vke.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8MIi8gu7z+i/YfVXWgocUhpPLp3jAxogC5eMTHVicfw=;
        b=SKBLVT+tM+i4aFJrnO5hJGrV8iIRjBdcLFpH1h+nF74lBeSkijVZ7a/CY4b1XLBc2P
         M8InEFFF3r6BI7YFemEag2pyBoY2jNd6jRVgoS9iBYbU1R6t6IhJg1SjZMleyiHtLg60
         mlDk9aILfGb/hLVc0k34bGsE2I8NuGnSaSt4ib2Z99Rl2u90hSbwWkL88QZxr0H1xZYH
         miVTsvzVSVI9WcxbS611j1Bz+QiaAkhf/k6IJLFZEgU9WCOJ+EMpSRSrIPCFntLhBqzI
         tmhEgInUooYMrARGPWQLdBvZ/YHzLr9TwmJC6GhUSkWI5LMRhxz7T5CAqIjy6/XNFosd
         kDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8MIi8gu7z+i/YfVXWgocUhpPLp3jAxogC5eMTHVicfw=;
        b=tSuq8s5f5eEXmLyg5EWGyatQQPl2/vZ7brLE5pIowsq56wsTrOyQ5yxmlp2m3mczmo
         lN+nYI30azKpSu89h3wPY6xbNjvTB89N29NJ/7L5AqboE1sacNBqPtWhA+og5kyPgJND
         LH1OUqIVoNDPPbzJY3nEO3qSGyDh14RdrMmuCxH+2ghqZOjWLYYnt6OjuegFtT6+T7yV
         K9wmXi0W9B00e+iIfKXF9wSCSzNOh/deS2pFORW6C+dobE1BcD8XxmAApQ0KEdrGT3Fm
         0saLe9BHEmrw5b8qvutf/Q/ri2il+w6rxhufI+UZ5PrcMDDRtpYCeFCo/eL2j9Ww9osJ
         WSIw==
X-Gm-Message-State: AJcUukfgW3PCsXJwIfVfJWOD/eBSEd4xre13YAxHIjcbVnWvheWybqUp
        KcZRNeycMH8Uc5F8B4TD2IRp8cTM6twF
X-Google-Smtp-Source: ALg8bN41kTDqj7CBYC9jZrqyjwjFxAeP3fgMWQ/r20O74dWceCGbjiVpwhZuU45MatlNuNxOpe1z6B9oEsEl
X-Received: by 2002:a67:7ac5:: with SMTP id v188mr15143415vsc.31.1547850864359;
 Fri, 18 Jan 2019 14:34:24 -0800 (PST)
Date:   Fri, 18 Jan 2019 14:34:05 -0800
In-Reply-To: <20190118223407.64818-1-rajatja@google.com>
Message-Id: <20190118223407.64818-3-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190118223407.64818-1-rajatja@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v4 3/5] Bluetooth: Reset Bluetooth chip after multiple command timeouts
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
v4: same as v1
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
2.20.1.321.g9e740568ce-goog

