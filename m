Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774FFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442C320878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FES8mx92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfAKXcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:32:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33956 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfAKXcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:32:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so7425823plz.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cNHuyJjLgGY2SzNeaX8taNlv3eJmeNdz4kVHdnMkQTA=;
        b=FES8mx921DGAezNI68NYdXAOinzkwWWsd5/HiWqnI9+svNANNBZ0AA6o6zSSd9RMxc
         dOEDvbEKQ9QqtOhMzNWXCQ7ATBExRAQ5UVjuZh8YSP7PJtwpqAqpHJrlceInkNfPKQyN
         hmX9UyMd+y1H2MiuwiRoux83UVrX99GHMv/T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cNHuyJjLgGY2SzNeaX8taNlv3eJmeNdz4kVHdnMkQTA=;
        b=dGs07E9J35vhU8RAnB1RIPUAer9IsFP6BiloOW7WsZvJjD1lFd8joljwQNlVU5BQ8C
         PhjWeMkgB/x0x20aEGL5eXsegc9vQ1uE7fCvE+CwgHlQ1cHxekQBxAUNJgS/0TVxxPIv
         MRFAt6C/2G2kAcRljgxpn05hw7UYFSa0E6KHWTDbotg76LlLMXKZEDw25+63FqS3yH5r
         5BKxMBKYJyyi101C+dUGujMGOXt3uaKsmewusNV0j0a5zoKaZyTPFGiNd0mLQXfJuHDO
         Il0/XCpqhVRzbym1tDF84UBoYmtJ73ZSXxSDhCX80/M3NEhA1IATkbu+Q8+uqPj4TjUJ
         /K9Q==
X-Gm-Message-State: AJcUukf80K7oHwAc0iIITpUMsHELAHgUMNxVbNXYpen3FyzRHn2Ds+ra
        wEGt48bMD/7TI0aaqvRTQxuypQ==
X-Google-Smtp-Source: ALg8bN7cCVdPhESH5l30RimOG3HqPuQ0tR7Gg8wjibvgM1UW11ioM9WnpxbnbFG4HrByrTDwJp5j5g==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17mr16050647plo.119.1547249540673;
        Fri, 11 Jan 2019 15:32:20 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id p7sm120524615pfa.22.2019.01.11.15.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 15:32:19 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ufs: Remove select of phy-qcom-ufs from ufs-qcom
Date:   Fri, 11 Jan 2019 15:31:59 -0800
Message-Id: <20190111233159.218342-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SCSI_UFS_QCOM selects CONFIG_PHY_QCOM_UFS, assuming that
this was the only possible PHY driver Qualcomm's UFS controller
would use. But in SDM845, the UFS driver is bundled into phy-qcom-qmp,
and phy-qcom-ufs is unused.

Remove the select, since for SDM845 it adds useless drivers to the
build.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/scsi/ufs/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index 2ddbb26d9c265..6db37cf306b05 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -99,7 +99,6 @@ config SCSI_UFS_DWC_TC_PLATFORM
 config SCSI_UFS_QCOM
 	tristate "QCOM specific hooks to UFS controller platform driver"
 	depends on SCSI_UFSHCD_PLATFORM && ARCH_QCOM
-	select PHY_QCOM_UFS
 	help
 	  This selects the QCOM specific additions to UFSHCD platform driver.
 	  UFS host on QCOM needs some vendor specific configuration before
-- 
2.18.1

