Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DBEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344A5218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="MvokJsnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbeLZGst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 01:48:49 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:59310 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeLZGss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 01:48:48 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 1424A9B8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 06:48:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P9DhY42flqnO for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 00:48:46 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id DA8BB9B2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 00:48:46 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id k4so18491762ioc.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 22:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/BUhnLS3W0iUtH++OCqlLSbIUCQXTYkZ1ohcju+tm+0=;
        b=MvokJsnh+yViCOcjsXyGwcGZxOBb2nJ3DMfyi1GXq/5wTe67QtnHOJ7VTuBRiqeNNw
         poI/Pf6kZa2SDaMF8s02vPA2t5ECpWTICx09IRC/XsDzgB0QwixgRFSVRKUY6tzrv8J6
         YAu+qqoH4xmaZ0LIuf5R1i7hRRB02IF473lguDMYytvvo+4POKU6gptV37mKQYcl+Y/T
         1Hx6UrX38y1ylPQcVVODHgcsEz3l0WHrQGkoYw53eu/Lfx+lSWRhzu62pcXYZ6ONWn51
         ogNApftOaY+pmtji53mwF5c1+7a0N38lJYGfvSKJIYIQEQRchNX0uA9w2zt4kMKlHhRw
         TFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/BUhnLS3W0iUtH++OCqlLSbIUCQXTYkZ1ohcju+tm+0=;
        b=cQjqHZqcmcFg3lB/CpzXjOBvt9ZtE3PTaUNRWFBKKZtgXGmfUHtiwE0MmVoCHFbRiO
         Ng6pOcAgxKTJIk6feZpzeCWCGWhYk7tPBMbcbwrlh+IUGmbNbOZm8ou1Suw+0A5NZa4B
         QSl4vHGNqBXssmhrpySPenDILAUR9Z3TtR5VFpZCtVwBZutftIG15t4xrLvcvmf28mHK
         pe3aJbZi2SeYebrGZLJS/2mx47w8UilHQdhkMsF1P/FfPJLrDcEjH+p/h3eW1SOaNjup
         AXOTjvbtfB3sLeRxcVhCOJWEkREE900rUO4VM1gVsIfhbs3W/aHb83MkuWUJpobOW7Ii
         j+dQ==
X-Gm-Message-State: AJcUukd/209wpWVN98yZvq4Zh/AM1TqqY/t/LS0JT8RTtIkWanmi6SIe
        XH9Dx3QKy9vLwbM+LX1SUJL50ncaKEs2VGsvBz8CHN1NV93+sNSPWCi1aW4Q9HfRNCOmx7pUPW/
        oN9VLUjljKSl3G1z1jBC7jTe4gGKn
X-Received: by 2002:a6b:f404:: with SMTP id i4mr10399423iog.281.1545806926323;
        Tue, 25 Dec 2018 22:48:46 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6sy3Yrmle+GtjzzoO7/WyaKy9x59D7Itp05PTW2oCTiE1J/w8UYOTH8XqXhTOwQ2k1JK06jQ==
X-Received: by 2002:a6b:f404:: with SMTP id i4mr10399414iog.281.1545806926110;
        Tue, 25 Dec 2018 22:48:46 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id i78sm11948467itb.6.2018.12.25.22.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 22:48:45 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] target: fix a missing check for match_int
Date:   Wed, 26 Dec 2018 00:48:18 -0600
Message-Id: <20181226064818.75984-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When match_int fails, "arg" is left uninitialized and may contain random
value, thus should not be used.
The fix checks if match_int fails, and if so, break.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/target/target_core_rd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_rd.c b/drivers/target/target_core_rd.c
index a6e8106abd6f..3138123143e8 100644
--- a/drivers/target/target_core_rd.c
+++ b/drivers/target/target_core_rd.c
@@ -573,7 +573,8 @@ static ssize_t rd_set_configfs_dev_params(struct se_device *dev,
 		token = match_token(ptr, tokens, args);
 		switch (token) {
 		case Opt_rd_pages:
-			match_int(args, &arg);
+			if (match_int(args, &arg))
+				break;
 			rd_dev->rd_page_count = arg;
 			pr_debug("RAMDISK: Referencing Page"
 				" Count: %u\n", rd_dev->rd_page_count);
-- 
2.17.2 (Apple Git-113)

