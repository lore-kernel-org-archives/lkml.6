Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED21C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D762083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWCFNJJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D762083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeIADMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:12:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39013 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbeIADMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:12:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so6687038wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qft1yxX6SUMf5r8UKH3M8nkBjgXqmLeZW2EJYvF59Os=;
        b=HWCFNJJ4QDyphw/9/smDD0OkcJi+cupmCAzPiw1iLxzui/Hx8CvCkurX8/aBsQSc40
         8CrsEIj0jdm7+2KiBJHCLGNl7KSPSbr70pjbnJGtMHN5btu+uTxi7bN3EjQiqGHwHQTy
         iEirMU7n7bSOPwgQ55ufAbd171gdeS3T5ra7tW1rnpd4MLpr5rowEeYsH4WbYw3BV4Es
         LfaZlBzjeOAfal7PPbxQLOiZwX4DfXwqYiSUzzghwmvDqbdbnc9l6QSlCrzm1BaFWXN5
         m8HN+dKH2pe4qOz8ubYGUCSKAYVIC2GbwPCwY8WLA9RAVIVOXFNe3FiFUo76lIuk++nl
         +H4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qft1yxX6SUMf5r8UKH3M8nkBjgXqmLeZW2EJYvF59Os=;
        b=eae1xHIUjil9F1mK43hIbD59GbUKKo2uT6A9lUenAvMbXX0cF7CxhgIy5Lsg3KGHPQ
         kfDUHDf0KOtfqjkwOlS4pc+/KbtZmC+OD81JARp5o772miCFf34wgcSPlRCvbxB3abrY
         94lHFS3mLncXfFJPMx3zWo4Otv2/h/4htnOqmyotiilWQ3iungXts4lGiIf9C+hrGXT9
         LEF0/irpXf7T2YMWF2CNzuoFtQ9AZpDjOjSBIqORGBoRzc5pZ43ho7PsKoKbmGwvhSd7
         rQEfj7+vyBvgSbacLIbHcS+loBlTHs0Z5dWCtBulhdAmoLa6uW7rcUTKh3ee/jRbmsoy
         5KKw==
X-Gm-Message-State: APzg51CjtoWQYDuo8/FyROrAZWoo8H5mvpsgsxnE8glSN1sIrPq/KA7r
        A0ga4qR+sBaGk3yDXNKZigNLY+VcT3E=
X-Google-Smtp-Source: ANB0VdYVGGYawCUmSdU2EmzvsBe6nDIVtmh9/Rpc5+q++W4GSchAfcrRGWzl/buvXZA8hfjBSti2MQ==
X-Received: by 2002:a1c:f516:: with SMTP id t22-v6mr5768876wmh.103.1535756578735;
        Fri, 31 Aug 2018 16:02:58 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.02.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:02:58 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/20] staging:rtl8192u: Remove read_cam() - Style
Date:   Sat,  1 Sep 2018 00:02:32 +0100
Message-Id: <20180831230250.16810-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the function read_cam(), as it is unused in code.

Simple style change which should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      | 2 --
 drivers/staging/rtl8192u/r8192U_core.c | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 77324a471de1..70bbd1fadcca 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -1091,8 +1091,6 @@ bool init_firmware(struct net_device *dev);
 short rtl819xU_tx_cmd(struct net_device *dev, struct sk_buff *skb);
 short rtl8192_tx(struct net_device *dev, struct sk_buff *skb);
 
-u32 read_cam(struct net_device *dev, u8 addr);
-
 int read_nic_byte(struct net_device *dev, int x, u8 *data);
 int read_nic_byte_E(struct net_device *dev, int x, u8 *data);
 int read_nic_dword(struct net_device *dev, int x, u32 *data);
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index caa618a845df..12783b88eb58 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -237,15 +237,6 @@ static void CamResetAllEntry(struct net_device *dev)
 	write_nic_dword(dev, RWCAM, ulcommand);
 }
 
-u32 read_cam(struct net_device *dev, u8 addr)
-{
-	u32 data;
-
-	write_nic_dword(dev, RWCAM, 0x80000000 | (addr & 0xff));
-	read_nic_dword(dev, 0xa8, &data);
-	return data;
-}
-
 int write_nic_byte_E(struct net_device *dev, int indx, u8 data)
 {
 	int status;
-- 
2.18.0

