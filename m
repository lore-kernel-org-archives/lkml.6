Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4771C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 05:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867D221848
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 05:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="GW8q97pR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbeLYFDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 00:03:03 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:36214 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeLYFDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 00:03:03 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 8CA5DC2E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 05:03:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 88olrVzd2ndx for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 23:03:01 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 5BA91C18
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 23:03:01 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id v3so15243562itf.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 21:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vViBuDDkftAabvNz+DayYu2cHZI2BOQzoS6uqH7G8aI=;
        b=GW8q97pR2AhopyqoGeOeovPtlEqRfqxiRrN1NpSjMGO6Jggj5/eUNslQ3KEzk+I5kL
         hxkivXdShwrybMac23Aihw9GKv/uSld5+sOnHevHvfLbFAaQzYzxqxznmIz8nN85gfFE
         wh6uo0uaeNH6MtANN66/LoUmWz6G2U/4ODCtdExmn9kQUOA1fUOia62z3cu5hKNS7YzF
         WU1En9gskFRjHW6KDX+kjC+G/0cQhluZuqp0QbKQrEnGFMBJXZL+TumGFyem/mlmoOSw
         etRfQGPDWcQ8LD0EYqgou07Fd4VaERivJzQA2dRMtgk2fihvRDnuEkyhEFF38k3qb+8L
         gUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vViBuDDkftAabvNz+DayYu2cHZI2BOQzoS6uqH7G8aI=;
        b=oop3hbglw33xUvozMGxoiSEH/Nh2I0+/I+0eeqZ1pPUUXYsHMHukWnKYbEa+GMmRfo
         1HfeZmarkRqLopHR1KLvGZsvMQo45G+GeeUFzxV3f+enViexScfbAnJOyDxlw9QwOvr4
         LsdUNitCzcxWIs9FxO0WtdXGyWbtzl8xDSDWUf/sl51mzWZn7oeJzV5NXbakMPMC7WuV
         C+SRvehfrr2xu/FDr6lITf+4HYMWxQp+dew5b594WlVylho3KmyiKW0Cjt+w/VZqFrRS
         Ey8k+kEH57PtBr/rEujS2vjZWwmkq0W+Abm/CFFaLWPwM8wcZ4rGXKW1wVuhKWzuehnU
         sMyA==
X-Gm-Message-State: AJcUukeJcSHVLp9H1ZWUCXkegY546/zW/xxUJSOo7uw3swe0mXm9hbOM
        amoctJVV55ibgQfLbGiUwjsu+RfU34pJG50yK0z7ilDeb1E9D8SWOnHONWpT3WEJV/Res1t4ERf
        sDKjKcr4Wl6Mnwq4ZXmXP1i3Ixa6m
X-Received: by 2002:a5d:8c89:: with SMTP id g9mr253276ion.289.1545714180939;
        Mon, 24 Dec 2018 21:03:00 -0800 (PST)
X-Google-Smtp-Source: ALg8bN66B4yWKXWfFskZBBonYMPOmAU6yhSw4l0MqVptF8zjoSDoPr7yb21HwRysFKpXoGJ4t9psFg==
X-Received: by 2002:a5d:8c89:: with SMTP id g9mr253258ion.289.1545714180647;
        Mon, 24 Dec 2018 21:03:00 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id v202sm11167319ita.13.2018.12.24.21.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 21:02:59 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpu: anx7808: fix a missing check in anx78xx_poweron
Date:   Mon, 24 Dec 2018 23:02:34 -0600
Message-Id: <20181225050234.66210-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both anx78xx_set_bits() and anx78xx_clear_bits() in the poweron process
may fail. The fix inserts checks for their return values.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpu/drm/bridge/analogix-anx78xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index 3b0fe2b188db..4f35aced65a0 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -646,6 +646,7 @@ static void anx78xx_poweron(struct anx78xx *anx78xx)
 				err);
 		return;
 	}
+
 	err = anx78xx_clear_bits(anx78xx->map[I2C_IDX_TX_P2],
 			SP_POWERDOWN_CTRL_REG,
 			SP_REGISTER_PD | SP_TOTAL_PD);
-- 
2.17.2 (Apple Git-113)

