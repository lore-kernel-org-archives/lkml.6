Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89188C282C6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BCA21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGrv71G9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfAWU5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:57:44 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:47004 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfAWU5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:57:38 -0500
Received: by mail-pl1-f201.google.com with SMTP id t10so2336376plo.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b1uUbZsyhmSj82CJe/fFgzrboSy+IQsjI8LagdR/gaM=;
        b=UGrv71G90YQNeN5Vvdea+LRmvJ2MZnJhJOpfkZTfdIcOtavVJazMi0+Gw37w+Un9on
         M0vSFHl6xhJNXXr3vnSwaK5OLjVSgv1ZK2nDZI0BAx1iSOUkRdCfIw+3KFlsjbwP1E/I
         sozdRo4HJal7EgSWnckzLV66uoAn77pqWacV187BtF+XwrsqB425EGQLkQxCOqtX6MBd
         3pTOmueac2f/7tHoeBKrk/ul7gAFKyxjPnJZVoutBanZdqfSUGXlZU0sZEzBntoutC0V
         7VrKJNyf/tyN46FjHD9V/WMcuaB27K/24MTB7pkWSGu3TdwnqHVVv5CBr+EktXlbcdo5
         FIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b1uUbZsyhmSj82CJe/fFgzrboSy+IQsjI8LagdR/gaM=;
        b=D0NjmW+DY6o6g9IPdmmZwUPFYsfng0vKSZDcIBA+Boa7B+cQ6+NgvpmFSunJcEDLoj
         GFDsai9aMWf4o9zebkTT/2qoMHv0xuxzNtLbI4up4bhttafwemh4GOEUnmW9FwmrVsP3
         ANZvnj/Vxwb4mA9ObgLzLOqToJ+nHo0nvZes3IUW5uHdUdxh0BQfL02kwyA4/6AA9mj1
         8SA63AyY3VNAjCbFhj+AfJMXIzWltVXME3HKfVkTPs2nb5trssKIT9w4St2APabOQQkU
         YmFRAkVMmNtxwv8gM1tg/hkXU3PyTwus+f6y6QnccGhSaWoGgyBsiKLsoa7MIPOFGhkA
         FTpg==
X-Gm-Message-State: AJcUukdKFb+JzicLvyKAGsNUutpBGTqVFInPc+sldGVMz/1UaZLql+bv
        njgaBmXibrpd87TwbZEizPwmJQrciDv1
X-Google-Smtp-Source: ALg8bN4fb62tI1JN8/1GdsgJIFzKkowPGf7t+rbHtvK6Su1eMYtqXFjaphAT7mQ+h4NP+ysf0TcZAq4/KFU7
X-Received: by 2002:a62:1195:: with SMTP id 21mr1544185pfr.61.1548277057637;
 Wed, 23 Jan 2019 12:57:37 -0800 (PST)
Date:   Wed, 23 Jan 2019 12:57:24 -0800
In-Reply-To: <20190123205725.239661-1-rajatja@google.com>
Message-Id: <20190123205725.239661-3-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190123205725.239661-1-rajatja@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v5 3/4] Bluetooth: Allow driver specific cmd timeout handling
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

Add a hook to allow the BT driver to do device or command specific
handling in case of timeouts. This is to be used by Intel driver to
reset the device after certain number of timeouts.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v5: Drop the quirk, and rename the hook function to cmd_timeout()
v4: same as v1
v3: same as v1
v2: same as v1

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e5ea633ea368..624d5f2b1f36 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -437,6 +437,7 @@ struct hci_dev {
 	int (*post_init)(struct hci_dev *hdev);
 	int (*set_diag)(struct hci_dev *hdev, bool enable);
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+	void (*cmd_timeout)(struct hci_dev *hdev, struct hci_command_hdr *cmd);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7352fe85674b..c6917f57581a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2568,16 +2568,22 @@ static void hci_cmd_timeout(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    cmd_timer.work);
+	struct hci_command_hdr *sent = NULL;
 
 	if (hdev->sent_cmd) {
-		struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
-		u16 opcode = __le16_to_cpu(sent->opcode);
+		u16 opcode;
+
+		sent = (void *) hdev->sent_cmd->data;
+		opcode = __le16_to_cpu(sent->opcode);
 
 		bt_dev_err(hdev, "command 0x%4.4x tx timeout", opcode);
 	} else {
 		bt_dev_err(hdev, "command tx timeout");
 	}
 
+	if (hdev->cmd_timeout)
+		hdev->cmd_timeout(hdev, sent);
+
 	atomic_set(&hdev->cmd_cnt, 1);
 	queue_work(hdev->workqueue, &hdev->cmd_work);
 }
-- 
2.20.1.321.g9e740568ce-goog

