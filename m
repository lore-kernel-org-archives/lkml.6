Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06208C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9211218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shmD9xAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfAXX2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 18:28:44 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:42943 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbfAXX21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 18:28:27 -0500
Received: by mail-io1-f74.google.com with SMTP id a2so6169155ioq.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 15:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dEGzE6ZUNinj7i2O6gc8hdUlWcvJ+gY38NNifJVHTbc=;
        b=shmD9xArlr1UCRljf6+W6ekzQnCm+lB7FPZ0c4aeyUDCITlowJhhtTz6eCuBoU58BW
         /LhQ1Yx9V3rSxr5pXrSn4KWRMrPhc8IO79HCmP/hCJT+Ao6X7wrWiB01S18Ni8dWOKPO
         +oIqSGruvfSXvFCNTu1nEh3nzVzSgarN2U0lzo2tktLxvAQ+h/T6i9KUcoXXzV68/vgx
         uhT2aPvFiV16Zh6lCEvKmmtozPbIHnizRqOxMGhgY9kmmH/Fv+uFcYFbWI68NvbB0c/2
         a1e9RfY2Y1bkGho3o+38osjpE/N+zsL9y1t1tEODqKSeyeJWxnYPOLPu0O6H7RUTbANF
         YbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dEGzE6ZUNinj7i2O6gc8hdUlWcvJ+gY38NNifJVHTbc=;
        b=YiejWd0jqCw3lAXiI2yyN02uE0uDKng8LodYUJW1yLEutm1SXYIqaJhsLCbop2OXUT
         oSbGlSSwBfIHHxBSgRcrPn0qL3bib3MeqkvWmhn0uCMalG0+0OpAyELthYhdbYkyDGyy
         Rw4GjU2cvtM1127yFYnJC+aypw/tbsqEV3Cx7OoU3z0Pm49kHCpWqQ/vrKsnGLTntXSz
         YZSwOqKYJTsf/ooE748l92ZXmZnuvQIc35GlOIGPYVMEnw+oPw63sDDzVvIVlWvrw4xK
         VXjP/xAG2PUJHd/IUP+dgTwMqBGHNxsWxyF4d9rWgbuMRkuyHTrBVTtrop0DXE2NGDPB
         hLGg==
X-Gm-Message-State: AJcUukdJXhcstG/4+4VamQfMFpgwNbGElTe1JuAYnBpmBwtCciaPX+sI
        aSn3Z/CeP/rEG+oC4OwJ+rg5IWG9rlmJ
X-Google-Smtp-Source: ALg8bN4Vg+vr7QJTQjTPcJOIJiQD7mXoxMohOlAKGdTRRmlINUqo0xIi5q58L/XCJgEWuuQfv9SgCFdBTQvc
X-Received: by 2002:a24:2951:: with SMTP id p78mr3654125itp.28.1548372506346;
 Thu, 24 Jan 2019 15:28:26 -0800 (PST)
Date:   Thu, 24 Jan 2019 15:28:13 -0800
In-Reply-To: <20190124232814.252661-1-rajatja@google.com>
Message-Id: <20190124232814.252661-3-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190124232814.252661-1-rajatja@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v6 3/4] Bluetooth: Allow driver specific cmd timeout handling
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
v6: Dropped the "sent command" parameter from cmd_timeout()
v5: Drop the quirk, and rename the hook function to cmd_timeout()
v4: same as v1
v3: same as v1
v2: same as v1

 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_core.c         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e5ea633ea368..094e61e07030 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -437,6 +437,7 @@ struct hci_dev {
 	int (*post_init)(struct hci_dev *hdev);
 	int (*set_diag)(struct hci_dev *hdev, bool enable);
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+	void (*cmd_timeout)(struct hci_dev *hdev);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7352fe85674b..75793265ba9e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2578,6 +2578,9 @@ static void hci_cmd_timeout(struct work_struct *work)
 		bt_dev_err(hdev, "command tx timeout");
 	}
 
+	if (hdev->cmd_timeout)
+		hdev->cmd_timeout(hdev);
+
 	atomic_set(&hdev->cmd_cnt, 1);
 	queue_work(hdev->workqueue, &hdev->cmd_work);
 }
-- 
2.20.1.321.g9e740568ce-goog

