Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA4FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73A3214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OOiyka2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfBAVzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:55:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32933 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfBAVzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:55:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so3884227pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 13:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3/w3z281elUDHB66BYrIRMbB+OzwFk+UPUVgq6qnY1A=;
        b=OOiyka2X3iHwAGZhC99b+FmidvORNLOkkXBrzS8ARlnE6O3yAYto45qOrz/k/TQn+i
         DjWvSVwOhC+I3bGhpZZnkmsa5VpWJp/lC38Wmn/d5FT52bQ8SHx4wxU04FJRblV677VF
         6e4IuYnQ8/uuM3t9GLFUAEIda8WFvLxY/9UUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3/w3z281elUDHB66BYrIRMbB+OzwFk+UPUVgq6qnY1A=;
        b=mrP902RUD6Z/CkF60Cd3i5qMKyi0ayzmfTHQ5+aV7EKbHP0ivI9k3ggTiLR8hal/Sn
         Kh6S5G2kYb/nCmI06CY2cNBTXsatIggje7KLu6D02S37sqYT1QaScwfUNCsMP4fCVpwu
         jTdYnOsIqGGpNYANC6bRnmB4PaV2oJ66/0Rfq7KhHiwNgWOCjculgmetwHnW5N/AsXHT
         JgtppqHO5s0SKDBiH82oP2laDMm3jlTMCJ4WX5O1qgdZOUIU4Bg0i4JxifufpxSO2isD
         VBe/iW91QHjBhBMRceFrSctJ6vj2K5m05OdRxIMN5zCHwYz/Q2ckn7BAKVQ1shIAIuUE
         ixPQ==
X-Gm-Message-State: AHQUAub6Nojdy0QC7PsaBPA+cO/k8+3IDstzo59WFxiHaILBJ9iavphc
        qkoS9G3m62+CctKfj5MOxjF82g==
X-Google-Smtp-Source: AHgI3Ib3ejc4SF+h2p1J9zgtLY8PGAkWKInCSVnXRgb/i25qIxBro8CyBsTPuJZ2jYDKKjLYmoIHKw==
X-Received: by 2002:a63:5b1f:: with SMTP id p31mr3900148pgb.56.1549058113161;
        Fri, 01 Feb 2019 13:55:13 -0800 (PST)
Received: from flatbox9001.mtv.corp.google.com ([2620:15c:202:201:8a81:a957:49d:5968])
        by smtp.gmail.com with ESMTPSA id a195sm18270626pfa.7.2019.02.01.13.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 13:55:12 -0800 (PST)
From:   jflat@chromium.org
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        tianyu.lan@intel.com, Jon Flatley <jflat@chromium.org>
Subject: [PATCH] usb: Change "wired" to "hardwired" for connect_type
Date:   Fri,  1 Feb 2019 13:55:07 -0800
Message-Id: <20190201215507.15439-1-jflat@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Flatley <jflat@chromium.org>

The sysfs documentation for /sys/bus/usb/.../portX/connect_type has one
of the possible values listed as "wired" when the actual value should be
"hardwired".

Changes the ABI documentation for connect_type to match the strings in
port.c.

Signed-off-by: Jon Flatley <jflat@chromium.org>
---
 Documentation/ABI/testing/sysfs-bus-usb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 559baa5c418c..614d216dff1d 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -186,7 +186,7 @@ Contact:	Lan Tianyu <tianyu.lan@intel.com>
 Description:
 		Some platforms provide usb port connect types through ACPI.
 		This attribute is to expose these information to user space.
-		The file will read "hotplug", "wired" and "not used" if the
+		The file will read "hotplug", "hardwired" and "not used" if the
 		information is available, and "unknown" otherwise.
 
 What:		/sys/bus/usb/devices/.../(hub interface)/portX/location
-- 
2.20.1.611.gfbb209baf1-goog

