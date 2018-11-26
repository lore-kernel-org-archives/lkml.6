Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A8FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8567D21104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE7cKCoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8567D21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbeKZVys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:54:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbeKZVyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:54:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4F342089F;
        Mon, 26 Nov 2018 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230062;
        bh=8xmfxdaDnz4aMlDHZ0d1+eQyWHPWFpJ9FP3ANfG+zNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lE7cKCoDtRax+cQ6vviL/5mHPVirfL8M68Pz59Hz4Ze1NWGKuuMGXiIvFV3zzIZBS
         3Aa3l1VNeKncwYoCNJ7PRoRV+VKU+7OW5VRF6OOk3o7NBPe1MNfwyKSXNWEKjYI+ek
         wwcM43pbmOm91+oL5JDYGuajfcRzSQ0Z+0FWCjSc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.14 56/62] misc: atmel-ssc: Fix section annotation on atmel_ssc_get_driver_data
Date:   Mon, 26 Nov 2018 11:51:37 +0100
Message-Id: <20181126105054.833001730@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <natechancellor@gmail.com>

commit 7c97301285b62a41d6bceded7d964085fc8cc50f upstream.

After building the kernel with Clang, the following section mismatch
warning appears:

WARNING: vmlinux.o(.text+0x3bf19a6): Section mismatch in reference from
the function ssc_probe() to the function
.init.text:atmel_ssc_get_driver_data()
The function ssc_probe() references
the function __init atmel_ssc_get_driver_data().
This is often because ssc_probe lacks a __init
annotation or the annotation of atmel_ssc_get_driver_data is wrong.

Remove __init from atmel_ssc_get_driver_data to get rid of the mismatch.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/atmel-ssc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -132,7 +132,7 @@ static const struct of_device_id atmel_s
 MODULE_DEVICE_TABLE(of, atmel_ssc_dt_ids);
 #endif
 
-static inline const struct atmel_ssc_platform_data * __init
+static inline const struct atmel_ssc_platform_data *
 	atmel_ssc_get_driver_data(struct platform_device *pdev)
 {
 	if (pdev->dev.of_node) {


