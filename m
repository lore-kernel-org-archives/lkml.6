Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D136C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0267208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0267208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933729AbeGITHQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:07:16 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:44104 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932937AbeGITHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:07:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 56F48C0E93;
        Mon,  9 Jul 2018 19:07:14 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LI8CEE0mt5BF; Mon,  9 Jul 2018 19:07:14 +0000 (UTC)
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 2916BC0E97;
        Mon,  9 Jul 2018 19:07:05 +0000 (UTC)
From:   "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: usbip: remove test_bitmap noise
Date:   Mon,  9 Jul 2018 13:07:04 -0600
Message-Id: <20180709190704.20333-1-shuah@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove test_bitmap noise which is a result of cut and paste error.
There is no need for this modprobe -q -r test_bitmap noise in this
test.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/drivers/usb/usbip/usbip_test.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
index 1893d0f59ad7..a72df93cf1f8 100755
--- a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
+++ b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
@@ -46,7 +46,6 @@ if ! /sbin/modprobe -q -n usbip_host; then
 fi
 
 if /sbin/modprobe -q usbip_host; then
-	/sbin/modprobe -q -r test_bitmap
 	echo "usbip_test: module usbip_host is loaded [OK]"
 else
 	echo "usbip_test: module usbip_host failed to load [FAIL]"
@@ -56,7 +55,6 @@ fi
 
 echo "Load vhci_hcd module"
 if /sbin/modprobe -q vhci_hcd; then
-	/sbin/modprobe -q -r test_bitmap
 	echo "usbip_test: module vhci_hcd is loaded [OK]"
 else
 	echo "usbip_test: module vhci_hcd failed to load [FAIL]"
-- 
2.17.0

