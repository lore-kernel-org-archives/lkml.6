Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD51C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684FF20869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="aW45K2PI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbeL1TyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:54:03 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:37218 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732158AbeL1TyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:54:02 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 439DB912
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 19:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b1R5uKknBDd0 for <linux-kernel@vger.kernel.org>;
        Fri, 28 Dec 2018 13:54:01 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 156547AD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 13:54:01 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id b14so2889775itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 11:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OOQZ2gUP/hFWYwmXJPBuARknrljj37IHB2B7Qlx9Ggk=;
        b=aW45K2PIL7dj0eKXhxVNkgW8T8gjZ45Y5kbXS47Tl+6mJsOETOmTzjsj1AbXXpIh5y
         7ImbiF8NiAZlA1lLiC7IDOIx3oOQ/g2Kcb/PPiYrScEfkRHex72ZrOYJqWduP6XPO90B
         JHLrJjKTLIMEZCy0FSkQGwMrKElhfO4cHCou27brTxRgMOV0NWIQKo4tzu9E0julkCof
         7RX/lzhLaKiO3z+XlGlL1dPQAydxN6NIcY9PY3/0Ns6MTUGH3GF4cMNA2JlwK5NwpAtI
         uXUAhNN/00Xk1Q2+tPDHo4cVvusayoXjE4vv3x4FBTWg7W1L7kxq3yKnakVyx7YLtKUp
         soOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OOQZ2gUP/hFWYwmXJPBuARknrljj37IHB2B7Qlx9Ggk=;
        b=YJOjvrNkvMGXQbSTj2aXcFy4W5dUHlFo99h47H6RUGDs24Rkou00LuUfpiD75qJBxn
         +r2z4WlB2lzMg///pLUzZ12i5Ei8Fe/s6K8r72HXTH8hP4ZgalPWI6NOX33RDn54wkvf
         5Saz38U0qUOV4exqB7suzHZQMMuhvRQmRAGxUIm97cFjJOuTi8WIJ3BidDw+bO274dCA
         AV/Hj0B95CI/GTpqAQOxt9NahBaspWrm8Z0PkyHqzO9r7Fsoa6iML93WIPNMUdTjRXJd
         wbNnKNyQgUp0wu7RMbCZGtbMt/0osZhHYTjynmQ6n+liaKwHOmkXGT+PZiGwJii5mM8y
         eXdg==
X-Gm-Message-State: AA+aEWYHM+oJHJ9mIjLLufOsosCtaHkRaZYo2P/fhXEJ6UAkGd6+8o8Q
        abR3CKMDpXY3NF4ANE3l/eyWo7Jwpai7ls+0AYmn0O07JhbriXa4Rs97d7NJf/2YUeRTjstjQZg
        Uoe8Lfqi7RJRzBcUuWTp58//HnC7y
X-Received: by 2002:a24:d12:: with SMTP id 18mr17112160itx.31.1546026840232;
        Fri, 28 Dec 2018 11:54:00 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UVectugpd+Z8lQKCDdq7nqOfv32VdKWC2PxjK9Puw4KDUWVeZSDw/OzU8OS+tbwsrVCXpj7Q==
X-Received: by 2002:a24:d12:: with SMTP id 18mr17112148itx.31.1546026839974;
        Fri, 28 Dec 2018 11:53:59 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id v3sm1992206ioj.79.2018.12.28.11.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 11:53:59 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: hci_intel: Check for driver register failure
Date:   Fri, 28 Dec 2018 13:53:51 -0600
Message-Id: <20181228195351.11009-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While initializing the driver, the function platform_driver_register can
fail and return an error. Consistent with other invocations, this patch
returns the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/bluetooth/hci_intel.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index f31410526c57..8450389a2017 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -1242,7 +1242,11 @@ static struct platform_driver intel_driver = {
 
 int __init intel_init(void)
 {
-	platform_driver_register(&intel_driver);
+	int rc;
+
+	rc = platform_driver_register(&intel_driver);
+	if (rc)
+		return rc;
 
 	return hci_uart_register_proto(&intel_proto);
 }
-- 
2.17.1

