Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF96C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3FC20989
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="eRdPUW4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbeLZDne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:43:34 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:52174 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeLZDne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 22:43:34 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 8E3C0C18
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 03:43:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Fq14FEqd3zUX for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 21:43:32 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 5909CBAE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:43:32 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id x82so18670599ita.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hOl5p+2T+SMz/8AEMgt4InNIGEFzNxBsbhO4HjquBZY=;
        b=eRdPUW4BpRTZB3BAgOzRsZdxwe8PFkFpACVrEywrIc06V3l4IWc/6FEl3IiaPCuKYJ
         4FssBkpdtNHFKLqLGcvBTb3mZRGAcj3fI+1YcQDzmJZ9RKSZIo4lRtnao0No14InraGc
         2EEvvOWOidNZ4mzPSrZTpAAYT+kWe4e6qYjc4V+qGN42OEcmrJcHA8HqnCiCHj05k5O9
         h0P7cRZ+rf0IQP62hUkL72GPDFEu1BvD2bAGj8iHtF9/brhs41tRKvCI+Y4hAzVhGSfr
         HPBUDbKxL1DY3Gwy02m1H8vr5tzK6PyOZR3eWU7cytA1auduRBgK5WLp/BXEzlsBQwiq
         Gn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hOl5p+2T+SMz/8AEMgt4InNIGEFzNxBsbhO4HjquBZY=;
        b=sRHZ9OKDFzNwqF45aUsQMSCEybKx+XfuHkBThTvSeA38nL3Z7vt7fvuiZFvpq2fxho
         R/5/MwwseW3zSGDnLBqmR2ji02nbNbzLGhn0wgVEGI1HZjAHcQP3vUbLN2rWFBZz+TWd
         K2PmffnGXLjW9lZe8ldLmR0Np8ASoPiYVvo6xaj9mmIJiMzv+n4VgRJJxQRbHpfdjhHv
         dKqL7RhMUujqmjMEwNBXasX+yz5inU7gSiJi55nawM0vi3zwQwX0l03jBysqQCx6lIim
         bDrDgMluKmxKzPEX1dOAxgqGiWaYkw8GiJVDjkNHk7eSLGmV9diS4t18rEVRwbw32BYV
         FUHQ==
X-Gm-Message-State: AJcUukdywc7j2CwSXiJAuDaQ90sDUUDFRydRCmZ/7XPw8SsrrfC/cg9G
        iH+YjPdkTs52QiR9sIq+C67R5B0go4ZppKVTsJT8Aw6Qc2uw2N5qLM9rU62VheNqC15vPOQ/WRb
        9CPBzLvrM77/lDmbAqzF0yvXay4Kv
X-Received: by 2002:a5d:8614:: with SMTP id f20mr143734iol.241.1545795811955;
        Tue, 25 Dec 2018 19:43:31 -0800 (PST)
X-Google-Smtp-Source: ALg8bN534rNwU19Ro9JJOu8+7q8bkZNReoaF9cOWN8bsLHV2smqMr9Fn14To3ldsAgFEZRbS5fyEfA==
X-Received: by 2002:a5d:8614:: with SMTP id f20mr143729iol.241.1545795811732;
        Tue, 25 Dec 2018 19:43:31 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id 195sm11918724itm.2.2018.12.25.19.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 19:43:30 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wireless: marvell: add checks for the return value of sysfs_create_group
Date:   Tue, 25 Dec 2018 21:43:03 -0600
Message-Id: <20181226034305.73411-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs_create_group() could fail, so let's check its return values and
issue error messages if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/wireless/marvell/libertas/mesh.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas/mesh.c b/drivers/net/wireless/marvell/libertas/mesh.c
index b0cb16ef8d1d..90b20618e0af 100644
--- a/drivers/net/wireless/marvell/libertas/mesh.c
+++ b/drivers/net/wireless/marvell/libertas/mesh.c
@@ -797,7 +797,11 @@ static void lbs_persist_config_init(struct net_device *dev)
 {
 	int ret;
 	ret = sysfs_create_group(&(dev->dev.kobj), &boot_opts_group);
+	if (ret)
+		pr_err("failed to create boot_opts_group.\n");
 	ret = sysfs_create_group(&(dev->dev.kobj), &mesh_ie_group);
+	if (ret)
+		pr_err("failed to create mesh_ie_group.\n");
 }
 
 static void lbs_persist_config_remove(struct net_device *dev)
-- 
2.17.2 (Apple Git-113)

