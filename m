Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C947C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6FE20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cJAEVvnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6FE20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbeKFRFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:05:25 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53120 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbeKFRFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vijH3MFvbNFbtFJRTMYJTu2DEaZIr8xNuLzyoM7y/MI=; b=cJAEVvnHycpz/AdvB+X4qkcO5I
        g91CktCCaK2jANpEmyE8iGqvQzIlyKCwvss4d5yUQdMfYznsNsFLh/KYIjWsCNARaOxuzv0tyeuAK
        91YUw7gPu48YomGyCamheAwtERIhx82Gna/jQTLBGI6kSJaxVKQUPknymtf1pcDVPIIsmUqMyW1Kt
        7D0nZbBxEOtgH/kaDfhmFon5GEkcJzXxP6LNqRTzIzQ7KMxe68IqC7Igkay/n7DUaG2bZ0TbeE8UQ
        AxVetFd3WKDrmqTWuaXJmrFGxd+IKgZzFOawz2rjf1Z+rgi7eZT8iSzl8VYq274Smkw2fL/jvKBFz
        lLD+2v4w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJvzM-00048K-Bg; Tue, 06 Nov 2018 07:41:28 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] driver core: fix comments for device_block_probing()
Message-ID: <bfd5f8f6-ff7d-cf85-239f-a9d4826fb2ab@infradead.org>
Date:   Mon, 5 Nov 2018 23:41:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Correct function name and spelling/typo for device_block_probing()
in drivers/base/dd.c.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/base/dd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-420-rc1.orig/drivers/base/dd.c
+++ lnx-420-rc1/drivers/base/dd.c
@@ -179,7 +179,7 @@ static void driver_deferred_probe_trigge
 }
 
 /**
- * device_block_probing() - Block/defere device's probes
+ * device_block_probing() - Block/defer device's probes
  *
  *	It will disable probing of devices and defer their probes instead.
  */
@@ -453,7 +453,7 @@ static int really_probe(struct device *d
 	if (defer_all_probes) {
 		/*
 		 * Value of defer_all_probes can be set only by
-		 * device_defer_all_probes_enable() which, in turn, will call
+		 * device_block_probing() which, in turn, will call
 		 * wait_for_device_probe() right after that to avoid any races.
 		 */
 		dev_dbg(dev, "Driver %s force probe deferral\n", drv->name);


