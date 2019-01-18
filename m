Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF6BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDFD20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BME3C63u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfAROEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:04:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40597 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfARODk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:03:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so15192884wrt.7;
        Fri, 18 Jan 2019 06:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IrXf9aiRakHb+ciyKcO/4OLDAyZp5iDcsk5OFIZkBaA=;
        b=BME3C63u5T7m0M4cxqVV4yvUDQDw8S1K8PHbxgke2dvfTWiaAkUKTHMIYaVi60qHZj
         SJps5ddXj2o/c2XDeaVGfQ+lNx4WFZmRJ2WPJAU6zrtFVCRReMwtGkYCNyusrnwa72Hn
         fZ9VXB+QvsClBSc+7KDn4O1O9lpwfJ+Ja5kZuJKbIuUf0FEyNDp7wUXUfPetEObSlWa7
         TkTIcfzHDpl6Rdwylfkt9mnVIiuGH9YyVeR1KubQNFmBziNRGLTn34z0C7/2NzOAFgsP
         eiHw8NezVL6UebwUD0AS/hKrEVZ0G0VZUAm2rC0dst9Al0EibBBRb3BGfpXW1ux5tfz9
         85lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IrXf9aiRakHb+ciyKcO/4OLDAyZp5iDcsk5OFIZkBaA=;
        b=dNUVqqCttxqSf+OSVFEZEiefLMOWMRRTghEo7hgOS9i/+X4bJkg4RIWA6jypNGiv0D
         uHQ1sQZXbb+ZIJ5mDuSTrW3amA6UDPuHSMqKOZPXpQZX4GsXwRvsaJWoR+WNMXv7GgE8
         AE2j/eaPUpe/B9b1GaP17KbRAREuYrZRFNyJ2VZI7JncVhy/HKzC6I+94FyZMM4Htd+H
         5ZOR/WFtwPua5MhTNj15AviliufxoXgINy8AWXOf9ocBHDXaVYsuNuQLi87Zdrdd7Ul9
         rn3Iux4JXGD4PbsCIgqmjIP54F2vj34bnBVECrq/M/shTlDnBTRBePPkGu4JwjjoCadR
         yd6w==
X-Gm-Message-State: AJcUukc1WdXhDe70S5VPa3/ztfRDjA9i0tdp7yTZRmMVqvWpC1JrK+BG
        k7QeiTe9ealpNlcaOmsBgwE=
X-Google-Smtp-Source: ALg8bN4Ibfx1SpkQFYRPqhuitnopJ4YSpYZl0vWwqxLVq0Ek3uBVrusTSd9ilf3e3+WbdO9BxO2qFA==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr16283513wro.208.1547820218147;
        Fri, 18 Jan 2019 06:03:38 -0800 (PST)
Received: from Red.local ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id g197sm8464676wmd.29.2019.01.18.06.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:03:37 -0800 (PST)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 2/7] hwmon: adm1029: Add SPDX header
Date:   Fri, 18 Jan 2019 15:03:24 +0100
Message-Id: <20190118140329.18970-3-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
References: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addes SPDX header to adm1029

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/hwmon/adm1029.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 3dd4c84ec89e..381bfae6b04b 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * adm1029.c - Part of lm_sensors, Linux kernel modules for hardware monitoring
  *
-- 
2.19.2

