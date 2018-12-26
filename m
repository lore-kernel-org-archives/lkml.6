Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DC8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2EA214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jGLyN11I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeLZCkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 21:40:25 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:45478 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLZCkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 21:40:25 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 89C4EA0C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 02:40:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vI1OwlIwkOGN for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 20:40:23 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 5B1F491D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:40:23 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id 128so18568076itw.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 18:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2BVNQD+lsODhxoYF5EvJL80XfwCgxfAdkoYjt2/0pT0=;
        b=jGLyN11IZprKSEBRpW6gN5xl5utOAyZBfq2VbcoRH3UQnJB3mPgq8bxHoFpivbtO/0
         tGdM4IgABKK4mVsQFGvjai/QlCD6AuC93pRhFggsitmA1iyNkXSVk9TYXUQJWhK2HNAX
         zUnwDJmKrMzpc2Bn9lyievZIRMRdBAxAg9nCNTIB5U6OA8BrOjNPfV2rir4SFsVbfzAu
         g1V/pYllUtlu/iMX7BkB8iGMo4dpgi0LKafF+Q2mIf1vOybepzdZH0luEQ/pgoDtvrhq
         zCRLYbGi9MjQxJYAYf2puU5Y7ol9PRQEE6mOPWUbqQ5IihgiD0w/kotemAtek9zOWXji
         MIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2BVNQD+lsODhxoYF5EvJL80XfwCgxfAdkoYjt2/0pT0=;
        b=lSP2jedALG0lX2cb8Gcp/0562Cwqwym73DN+IP4dEpH9Pn44ZgbW8QCaezO0SOL6ZP
         LFLQkbCpSGDVAZr3eZDfIeQ7FXtQC3iqQGfScQd/BKbx2TAqcUK8t26j08+WIV1kug7X
         /zdw16BkfZfRnVFaRmdLjWdbPS+S6Y470zmAEMR0UhzH66RG6WNWMRlJ35HUyY0hyHSD
         Mr3L9CvKELZkiZCKvWbQXZOZIEkXg/WnhQ7inSsSc8BqdZQEgNarTXmCSSEHODjC+z+s
         fk9tpqQIz8X120jSZCNGTLI3rU2n8GoBRArwCflbCZHVmtOkmP7vpTKfqihYvjMrzM1M
         629g==
X-Gm-Message-State: AA+aEWYe8atvYeLkmc5A3LxQv19xGisvvFlcMKdVhfXAt8BYKzU3Pf/T
        VxSWFWMLQAanRBq8UZfsj6a+L14F2QSAnqYPhKQZ04BUlXh8hvB+d7aAs/bnkMqNUU+nRqHYPqj
        n96KaFtEaIAxgbNw2pQjBlrcdSc3M
X-Received: by 2002:a02:708e:: with SMTP id f136mr11772186jac.118.1545792022963;
        Tue, 25 Dec 2018 18:40:22 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VtKc7G/NQ5jeMolhkoNMw8Uhbzf2/ftYLrhhWdqqPulL5iO4VCqtkfgFVqaQC4as3yLforsg==
X-Received: by 2002:a02:708e:: with SMTP id f136mr11772176jac.118.1545792022696;
        Tue, 25 Dec 2018 18:40:22 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id t69sm5809353itb.26.2018.12.25.18.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 18:40:22 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Andr=C3=A9=20Lehmann?= <lenneman@web.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtl8712: add a check for the status of register_netdev
Date:   Tue, 25 Dec 2018 20:39:53 -0600
Message-Id: <20181226023955.72139-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

register_netdev() may fail, so let's check its return value, and if it
fails, issue an error message.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/staging/rtl8712/hal_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
index 7cdd609cab6c..ca0858660a45 100644
--- a/drivers/staging/rtl8712/hal_init.c
+++ b/drivers/staging/rtl8712/hal_init.c
@@ -32,10 +32,10 @@
 static void rtl871x_load_fw_cb(const struct firmware *firmware, void *context)
 {
 	struct _adapter *padapter = context;
+	struct usb_device *udev = padapter->dvobjpriv.pusbdev;
 
 	complete(&padapter->rtl8712_fw_ready);
 	if (!firmware) {
-		struct usb_device *udev = padapter->dvobjpriv.pusbdev;
 		struct usb_interface *pusb_intf = padapter->pusb_intf;
 
 		dev_err(&udev->dev, "r8712u: Firmware request failed\n");
@@ -45,7 +45,8 @@ static void rtl871x_load_fw_cb(const struct firmware *firmware, void *context)
 	}
 	padapter->fw = firmware;
 	/* firmware available - start netdev */
-	register_netdev(padapter->pnetdev);
+	if (register_netdev(padapter->pnetdev))
+		dev_err(&udev->dev, "r8712u: Registering netdev failed\n");
 }
 
 static const char firmware_file[] = "rtlwifi/rtl8712u.bin";
-- 
2.17.2 (Apple Git-113)

