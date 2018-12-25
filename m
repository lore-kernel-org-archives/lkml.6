Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E76C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2098421773
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="a+C7Rqg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbeLYHhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 02:37:03 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:56156 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeLYHhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 02:37:03 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 7074AC23
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 07:37:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T-2KmsgOJVkr for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 01:37:01 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 497D8B15
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 01:37:01 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id o22so15940019iob.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 23:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JiJfleo6rJQmt0Cue6Ul+9uEjSUyPKKMsTea62cJlUo=;
        b=a+C7Rqg3GiAT+TNUpDxEJszJe1HQwLCVSaa58VY0Bll4Gl9ShH5xpXPBsALV8AqDTn
         SURyEZtKPlAHGEnQwH/NkjAywMQIPeG9OXECw4lUmY28BjLPUcbEWzPP0dGsHxsnZqz2
         u8QmcTG5gwopXYN+bSrAo2LcfOgLcxW6QF9g07/zyyA2w1LZmugw2RAi+z6VdZFo3oxT
         08IggZPH5i/Yk3FnLAe7g3cK30dKjKJ+aYnw1qINxWer7FB+gPsfIUFAJ2n2ozujvUPo
         2FTGr86YU9EPfs8VvtuokX+5NMJTZMD4ie35r1WZhTC9ydnxg1iPtBqayanGEoccN4a4
         11oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JiJfleo6rJQmt0Cue6Ul+9uEjSUyPKKMsTea62cJlUo=;
        b=tJPkqCwqnxv7z/DsGpBAkKU66WjZw54IlBWGelUf5vOf2r+Y+nY1YpI8Wf2Dcfv48X
         yoPgmY4a5r5N8BXGcX2c7SGQ6fLXslE6SEXBrpJYVZ9spUElbX9fUg7lDcY/ndrDvU8z
         CrsUnQDQFvTX1L8sO+UuBYMAkEIfvCGor3vcOgz8bd1qlEkmtjxO20iHJaSBwH1qpcH5
         CUGwj4skvAwIB0Cz71spC+MTYI6YzlA/fWjC2Dsj70cHdW0bxUUQiaWeadvYeBZvK+pR
         Ni1iLOozv4O0nIe1pbzNyatwj0ONEFS5Q/uIPCYqR+MaWAJHPl6iy/cZHhQn9i4IA7YH
         8sJQ==
X-Gm-Message-State: AJcUukcoABu492pTwxqWnvIOZ7vr0GcSufH+PO2Nb3RalCuvc7zOaxTX
        BIvDhsvFK6Io2IFMr1Ui3hTFfHkv9/j8Eqao1jVK3Eqbo7Y5+1ngkSm/F5bbrPL7NQj17uC/tCy
        arfvFruK/87TU5tD5SdmSsVv5Fe1s
X-Received: by 2002:a5e:d719:: with SMTP id v25mr10594308iom.244.1545723420749;
        Mon, 24 Dec 2018 23:37:00 -0800 (PST)
X-Google-Smtp-Source: ALg8bN44LUEhPv0xHUS0SzhwIkocNM6VO2CfrtQzB0kzYqRwOHtSpEz87YtDexw6G250AZYSJxpnmQ==
X-Received: by 2002:a5e:d719:: with SMTP id v25mr10594306iom.244.1545723420535;
        Mon, 24 Dec 2018 23:37:00 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id r21sm11362166ita.27.2018.12.24.23.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 23:36:59 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ethernet: (80003es2lan) fix missing checks for return value of reg write
Date:   Tue, 25 Dec 2018 01:36:19 -0600
Message-Id: <20181225073620.67962-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

e1000_write_kmrn_reg_80003es2lan() may fail. The fix checks its return
value and returns with its error code if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/intel/e1000e/80003es2lan.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/80003es2lan.c b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
index 257bd59bc9c6..7e2d4b9839bb 100644
--- a/drivers/net/ethernet/intel/e1000e/80003es2lan.c
+++ b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
@@ -699,8 +699,11 @@ static s32 e1000_reset_hw_80003es2lan(struct e1000_hw *hw)
 	if (ret_val)
 		return ret_val;
 	kum_reg_data |= E1000_KMRNCTRLSTA_IBIST_DISABLE;
-	e1000_write_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
-					 kum_reg_data);
+	ret_val =
+		e1000_write_kmrn_reg_80003es2lan(hw,
+				E1000_KMRNCTRLSTA_INBAND_PARAM, kum_reg_data);
+	if (ret_val)
+		return ret_val;
 
 	ret_val = e1000e_get_auto_rd_done(hw);
 	if (ret_val)
@@ -757,8 +760,11 @@ static s32 e1000_init_hw_80003es2lan(struct e1000_hw *hw)
 	e1000_read_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
 					&kum_reg_data);
 	kum_reg_data |= E1000_KMRNCTRLSTA_IBIST_DISABLE;
-	e1000_write_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
-					 kum_reg_data);
+	ret_val =
+		e1000_write_kmrn_reg_80003es2lan(hw,
+				E1000_KMRNCTRLSTA_INBAND_PARAM, kum_reg_data);
+	if (ret_val)
+		return ret_val;
 
 	/* Set the transmit descriptor write-back policy */
 	reg_data = er32(TXDCTL(0));
-- 
2.17.2 (Apple Git-113)

