Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2068BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C832620895
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H4RD3vva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C832620895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757036AbeFQAga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 20:36:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756937AbeFQAg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 20:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hhOV2Gl15R+7rLB27ZLysOWRZjv41zY0bVfZiukkQyo=; b=H4RD3vva0te/Ghm8FbCLzuvCH
        orZ2E0nyH+WlrhsP7XnC4bRVsR/yFrUV7Sl3oSJQmukVJWKdGcViV1iDjUIpQ7HlUpMhbAjafUKkN
        Nrr/JFnngzBBCOGIxcT+upmziUnQJ/rsFSayhXhfVdH9uTMZiLU3RwQ9L3ifoh8W4qhGbO7fzYuCv
        PYcOXGulrW+1WBbjhe6fNTv22mO7qTl31YN4IrmTGzI7Cd1Xt361Y4bQ2E1kUv4CDaD0RDHNdlyvN
        vStyG2T7cwSVHZ5ObqNxE6Vgf1TboqDKangSTAt4DRK4pY3IzKjLlehY/kclZmpAwebqB6pZWfUOU
        BS/La2jsQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fULgA-0006Xl-Aj; Sun, 17 Jun 2018 00:36:26 +0000
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        aaron.f.brown@intel.com
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] net: fix e1000.rst Documentation build errors
Message-ID: <4e7a8aa5-cd19-3f57-cc60-6e6224d02a69@infradead.org>
Date:   Sat, 16 Jun 2018 17:36:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Documentation build errors in e1000.rst.  Several section titles and
their underlines should not be indented.

Documentation/networking/e1000.rst:358: (SEVERE/4) Unexpected section title.

Fixes: 228046e76189 ("Documentation: e1000: Update kernel documentation")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Aaron Brown <aaron.f.brown@intel.com>
---
Is there a Sphinx version problem here?  Tested-by: should indicate
that there was no error like I am seeing.

 Documentation/networking/e1000.rst |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- lnx-418-rc1.orig/Documentation/networking/e1000.rst
+++ lnx-418-rc1/Documentation/networking/e1000.rst
@@ -354,8 +354,8 @@ previously mentioned to force the adapte
 Additional Configurations
 =========================
 
-  Jumbo Frames
-  ------------
+Jumbo Frames
+------------
   Jumbo Frames support is enabled by changing the MTU to a value larger than
   the default of 1500.  Use the ifconfig command to increase the MTU size.
   For example::
@@ -389,8 +389,8 @@ Additional Configurations
      Intel(R) PRO/1000 Gigabit Server Adapter
      Intel(R) PRO/1000 PM Network Connection
 
-  ethtool
-  -------
+ethtool
+-------
   The driver utilizes the ethtool interface for driver configuration and
   diagnostics, as well as displaying statistical information.  The ethtool
   version 1.6 or later is required for this functionality.
@@ -398,8 +398,8 @@ Additional Configurations
   The latest release of ethtool can be found from
   https://www.kernel.org/pub/software/network/ethtool/
 
-  Enabling Wake on LAN* (WoL)
-  ---------------------------
+Enabling Wake on LAN* (WoL)
+---------------------------
   WoL is configured through the ethtool* utility.
 
   WoL will be enabled on the system during the next shut down or reboot.


