Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2B0C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C83222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJNDD4Ap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436735AbfBMVNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:13:50 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41414 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436704AbfBMVNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:13:47 -0500
Received: by mail-lf1-f66.google.com with SMTP id e27so2893579lfj.8;
        Wed, 13 Feb 2019 13:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbioa+abvo6fYtbM2Q5dGNjtBEFHN9sARKneIEKHgs8=;
        b=DJNDD4ApMbpqiVhjNuFefOFve2J8/BxUWO+pychzfhDELCKm+ZTW+eXkHwz0jdgMJz
         2Np7NqMTijoAZN8j9OYm1k4jK0BARyzLwQ8p7JdAoJMGU9ctyq17hXCKFQx0+XWFCzb1
         oP7OGcNX5pEUMohZYBjSVcKVpMaYpXl3YaqckYZ/IwrJuWfqeTn17ZpSBMSgPw01pr3j
         El4wpO47opIUdtNZAbvnCVZfryv7mXhe59oAepEWOF8zsDlEZXT5bN8cBPBHsNv1UbWP
         MR4Ka6G80JmyOcI2NCMgHIkXUsINJUmraJRna2HjP58o5u9qzpKIArtec/xtn5HtFbmt
         CpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbioa+abvo6fYtbM2Q5dGNjtBEFHN9sARKneIEKHgs8=;
        b=PBszfLBpD2RAC+DRBTyM2T86Wh4yGGRgFQqB0fXeG1hOGSg4pM46Rf2sY/Xt8g1q1R
         FQ9RcUx9JgdNNOavj7mKQusffYMyimORWejW1CXjduSgIMqNdw/HYaQ2XDS6crtkaKi8
         R8OBBKO+mr0llKsfhUivDjbDfwKFWdoiFgwUHQFsHfgg8MdgF9n7CGhWGEEiRu3GNScP
         yYqzj2MVenti7rEFB2mTRLrkE4dszg51RlEuHX+FVuMLf0Ytjq8pdkouCylRY3qVx3yn
         UBjjpF3CxOWRFgggXRuJlecaOHKf9kPfKWZ3U6KYLPp57xhDb7k2p636AA9fSUVxN/qS
         fiMQ==
X-Gm-Message-State: AHQUAuYV0n5fEQqimkfYdp40VafqUgQHio1Oho2PUfjxuGgBy5aqdLEV
        j7fV//EF90V9dHxhjAsdh6HAOk45VsQ=
X-Google-Smtp-Source: AHgI3IbIm0Qlm1wLwbjFW7NxhfNJksoCqVx7f5Vs3hEwQ3VzwiYI5/ooT7K2T560oHcMQJ6bw37n0A==
X-Received: by 2002:a19:4851:: with SMTP id v78mr113434lfa.98.1550092425427;
        Wed, 13 Feb 2019 13:13:45 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-226-91.is74.ru. [109.191.226.91])
        by smtp.gmail.com with ESMTPSA id p77-v6sm83857lja.0.2019.02.13.13.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:13:44 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Martin Liu <liumartin@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Benson Leung <bleung@chromium.org>,
        Harry Pan <harry.pan@intel.com>,
        Jack Stocker <jackstocker.93@gmail.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Samuel Sadok <samuel.sadok@bluewin.ch>,
        Ivan Mironov <mironov.ivan@gmail.com>
Subject: [RFC PATCH 2/2] usb: quirks: Add quirk to fix card reader and suspend on MacBooks
Date:   Thu, 14 Feb 2019 02:13:23 +0500
Message-Id: <20190213211323.6072-3-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213211323.6072-1-mironov.ivan@gmail.com>
References: <20190213211323.6072-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enabled USB_QUIRK_DISABLE_LINK_ON_SUSPEND for the embedded SD card
reader used in Apple MacBook laptops.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=111201
Link: https://bugzilla.kernel.org/show_bug.cgi?id=202509
Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index c26ba784dc54..818f949ff1b9 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -310,6 +310,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* appletouch */
 	{ USB_DEVICE(0x05ac, 0x021a), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* Apple Card Reader */
+	{ USB_DEVICE(0x05ac, 0x8406), .driver_info =
+	  USB_QUIRK_DISABLE_LINK_ON_SUSPEND },
+
 	/* Genesys Logic hub, internally used by KY-688 USB 3.1 Type-C Hub */
 	{ USB_DEVICE(0x05e3, 0x0612), .driver_info = USB_QUIRK_NO_LPM },
 
-- 
2.20.1

