Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F2EC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C4E25E24
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C4E25E24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934736AbeF0PUQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:20:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:43102 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934130AbeF0PUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:20:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 08:20:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,279,1526367600"; 
   d="scan'208";a="67768733"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2018 08:19:53 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] usb: pd: include kernel.h
Date:   Wed, 27 Jun 2018 18:19:46 +0300
Message-Id: <20180627151953.30942-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
References: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes life a bit easier for the drivers that include
pd.h. All pd_header_*_le() inline functions defined in pd.h
call le16_to_cpu(), and all *_LE() macros in pd.h call
cpu_to_le16().

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 include/linux/usb/pd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 09b570feb297..f2162e0fe531 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -15,6 +15,7 @@
 #ifndef __LINUX_USB_PD_H
 #define __LINUX_USB_PD_H
 
+#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/usb/typec.h>
 
-- 
2.18.0

