Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13D5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7018B20866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="grn9uvAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbeL1Tsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:48:41 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:46778 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbeL1Tsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:48:40 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 45962D0F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 19:48:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FgSpZM0ax6WI for <linux-kernel@vger.kernel.org>;
        Fri, 28 Dec 2018 13:48:39 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 17E9DD03
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 13:48:39 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id f7so1398409ioo.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 11:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Lp8XQlPZ4KjlZz67Vnno91MYf4hrTNpeHT5+kKRXCFM=;
        b=grn9uvAqj4tN+RqUiVIBv8yfsoiX1x5rqR8sPYnfk5JxIQrXcoyjoABaFJr2u7Hswj
         2ZQKJAfIcU08X1k/hVUwnMLflJg5NN7iUn183Ui0OAviNkOJ1m8y9LxRI4D4hOlsyIri
         ghRuYOHUH2mmmj2yH9PQcz1MxxhCAASH4/R/9jWfTRqt55X0x1H5vHf5lD3TH/lq4477
         eUH1uIRSXcFa315Jd9vLF2UV8b55XjKp07f52KXwUjgyCNeUt60Cc30ouutcQpAzYwSz
         mRHzNPJVoCKXMgUl4Vse4rujmZCtKdJ0GlnAHlhbK521xn4RLz7LmpCyb/Ufy88GxtIO
         TaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lp8XQlPZ4KjlZz67Vnno91MYf4hrTNpeHT5+kKRXCFM=;
        b=dRrv8PuVx2gdRV/ZfQdXTwxQ1MozqQuOpesggfOfPrKHrJlLMSxncNldgo9vMYVZ8j
         OiuLPsTM6u5DK7iToSYzoPeLZk8Ojwzl0nHWqwiB9Ak2pALOk6+sMs+3OMIFdcm3URCG
         9X0PQu/QPsVm6jiCk4GlHQYZM8chJOn0gEvExe5LWDtK3I/Wmx9K2BZWSj+54HbLuwHm
         WKN+ddZDwUud2zIoRxH8M6DMCFbhr9M5GZNv+BEliltBHbiX8rQ4GXzIRtXCl3cMJ0zZ
         +DQRH3AsZsZcB6AgQHy4YyNyLG20O9cOyr4p5KKLXqd1IW/5WDq1/9Onze6rt32bGdLp
         1jlg==
X-Gm-Message-State: AJcUukfpuXvf1ivzvqZcyWBAS81u7oSek9zCbadNtwNawrZ05LJzeBWB
        Exs9YgfV0RJsNQNznv7imejqMkFr8OsPn6HwleWCpmy5REuD0tF3DeIwG61jY6BOZDC1pkpKuzh
        I2a/3GKsqaLzpspuYMTWHQU7vpsIc
X-Received: by 2002:a5e:9318:: with SMTP id k24mr19228356iom.70.1546026518693;
        Fri, 28 Dec 2018 11:48:38 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6QtCGGJzc8nb8hsNmuISMqd8zdnsp8vGQS73XAb7AF7s9IsWU1oP7n8xaxUdtboPpM99QOJQ==
X-Received: by 2002:a5e:9318:: with SMTP id k24mr19228346iom.70.1546026518445;
        Fri, 28 Dec 2018 11:48:38 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id i78sm15344727itb.6.2018.12.28.11.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 11:48:37 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: hci_bcm: Check for driver_register failure
Date:   Fri, 28 Dec 2018 13:48:27 -0600
Message-Id: <20181228194827.10504-1-pakki001@umn.edu>
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
 drivers/bluetooth/hci_bcm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ddbe518c3e5b..f5ddb0f19c31 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1442,7 +1442,12 @@ int __init bcm_init(void)
 	/* For now, we need to keep both platform device
 	 * driver (ACPI generated) and serdev driver (DT).
 	 */
-	platform_driver_register(&bcm_driver);
+	int rc;
+
+	rc = platform_driver_register(&bcm_driver);
+	if (rc)
+		return rc;
+
 	serdev_device_driver_register(&bcm_serdev_driver);
 
 	return hci_uart_register_proto(&bcm_proto);
-- 
2.17.1

