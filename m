Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E95EECDFBF
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1336420862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3RJEbrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1336420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeG1Grd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 02:47:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45410 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeG1Grc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 02:47:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id i26-v6so2412922pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 22:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AEY7y7z1enbU0D6jMbwI5SZsrF3Cr+qqFGZ0RoVooHU=;
        b=o3RJEbrYuZ8fb0i+qfrzalUsYz+aZqa/rmmrEUWsDMyaUiwjx/qji09loCr7MdGBrA
         fZBSQnYWUSGzZ7HKUY8pOvnodB/RTCrbNkXHiiMmtSB0iub0uFVdDZVu12xp2FZ6J6Ch
         oy6PX4r/gYey+s3Tc0zh9gyi0ahrgb/73aGK5Cd2+JTVW65yC8QK0LEv3ITEjFvcaQWp
         phoUbxLfZH0RTd18K4FyJoWw8d58v61WJy/n6xpoimFSVlusWQXlnWz1L1vcrxvGxwKX
         0POebADHG7/KZ8aJnCGWEeEIaAl3KHAiXUgHs00hLhgTWV+dvd5TcM4Q0CgeU/DKLPjf
         Qq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AEY7y7z1enbU0D6jMbwI5SZsrF3Cr+qqFGZ0RoVooHU=;
        b=aauSDP2l0LEyWjFnuF9tNuQxYuUmOL4UKWfu5gi9Mxq9xSr4/fM4WwS2JK8hGwxJ7U
         e/Wg3tC/xASB+8XOWWNIsGAuQ0wtzAAvOzUWcsojOmkI9XUYccVv4oSdB3VqG5BQZZ38
         PbqAhHzqVeCm3DDsJii958xlZeB7xcoFiWkoE0cYPKaKwWJtW6XmAMu2L0eN58QjnTVh
         oIsbOObuPB9VBwAxZ909yMDflh9nVwljqhfhf3lE0IvdOfHy5XNcL7hTtrg/tvRAzsxi
         bg07tltIXzduRsdx1YI66vJChV9dFWWVCVR/iXyjnnsp22SsnU60hayJwVSsl9zJutET
         NktQ==
X-Gm-Message-State: AOUpUlHzTZvuFwgCHO4ImEUtzUcOvxWtZRa2dxMGXPH/168uZaxsj5Dw
        BHZ+UPL+iGBmmWPbL0MskXk=
X-Google-Smtp-Source: AAOMgpcZWG/7GrWb3+W8YvS/7rR3wF+n8e14v3BQYE2d9lMCnIDAuSdVoILfxxlfl8I9TAWIbvqQaA==
X-Received: by 2002:a63:4d06:: with SMTP id a6-v6mr8482575pgb.408.1532755345024;
        Fri, 27 Jul 2018 22:22:25 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id y85-v6sm8837195pfa.170.2018.07.27.22.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 22:22:24 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 5/5] staging: gasket: core: hold reference on device kobj while in use
Date:   Fri, 27 Jul 2018 22:22:00 -0700
Message-Id: <20180728052200.228796-6-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180728052200.228796-1-toddpoynor@gmail.com>
References: <20180728052200.228796-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Hold a reference on the struct device kobject while a pointer to that
device is in use by gasket.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 859a6df9e12df..1dc7273e38734 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -449,6 +449,7 @@ static int gasket_alloc_dev(
 	gasket_dev->dev_idx = dev_idx;
 	snprintf(gasket_dev->kobj_name, GASKET_NAME_MAX, "%s", kobj_name);
 	gasket_dev->dev = parent;
+	kobject_get(&gasket_dev->dev->kobj);
 	/* gasket_bar_data is uninitialized. */
 	gasket_dev->num_page_tables = driver_desc->num_page_tables;
 	/* max_page_table_size and *page table are uninit'ed */
@@ -487,7 +488,7 @@ static void gasket_free_dev(struct gasket_dev *gasket_dev)
 	mutex_lock(&internal_desc->mutex);
 	internal_desc->devs[gasket_dev->dev_idx] = NULL;
 	mutex_unlock(&internal_desc->mutex);
-
+	kobject_put(&gasket_dev->dev->kobj);
 	kfree(gasket_dev);
 }
 
-- 
2.18.0.345.g5c9ce644c3-goog

