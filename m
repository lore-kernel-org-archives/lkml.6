Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E4CC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF0A208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWgkl4El"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF0A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeJAC1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:27:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50350 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbeJAC1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id s12-v6so6665324wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pwv72PXZZQ0QYrpRAdnnCIIkzDEGp5zh9s23oMkcnng=;
        b=NWgkl4EljfmyaRMFSsaw82xXf/DAXXLIGnlRbvxWd2lkJJO8wer//5KZ7LE+kHUyP7
         CHeTU5TB7ZO1hjOjZQJrqIkyV2h2prAlZWb6xPK/vyuzPG/toJDTebSHQyR//bJs+uew
         NG7L7gmV+IzRhf2wgGFHZHyrQhrjvkaDjw68nI+sfcmHd3L907mtm/nYl+tJYW0lCqE0
         xEBZU7ZNEBie0PAY3IYwls6Wzx/nbPblN8tWThp8dJNX1Lu73Wo8QcoG8HkQ3xwBakxq
         QuqbPcweT0zb2ICcR/SL26lkjd9HSgTo9kiOXOKIjNkSIkapS06IIB7wZqz3VJXnLscE
         ONOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pwv72PXZZQ0QYrpRAdnnCIIkzDEGp5zh9s23oMkcnng=;
        b=Gs6LxEzDFPVR0CqVcbRKizlYQihIpd3tDhrPz0s9nHeayWBORMB1VNh7ldtzwTFTc9
         4L4nIn4QPOqGsnlulia7f01N/0zJNSrySwA2Od3VldcEoR+v2aEa0lfP/o3T8pv/vd+3
         RlFeAH6XgEYLaa7A73ER0WNs65mh0YzG/QH0nVl/covkwoyoxuYFzwCjZhnmbS1i/Xnz
         k/n0Ds5H4ACcTIZ3sZlPEZXYmBVigUl4lAj1yMVDbMjoHQcNRcIepT0BrXLmfeXf+Ok3
         SFr0xsC1NGz5CMqDsqQRgFoQXDqaExYnBU1LVtyn9DK40D3k0RI8lWDvhQiCk4sf4I1B
         acJw==
X-Gm-Message-State: ABuFfojGzMSRYMtQ67I5JdcS+9CvN5TBXvmOPMtE9+Uzcp7mZilW27uW
        rGYvg1cvr+lyfYCesC6zsI4=
X-Google-Smtp-Source: ACcGV61KCuFzigse0YonHhI8IY8ftpcQmL+RSsMOfpUlbiMRt5jnsG4TG0DxzlPCcRTKeccBQObQXg==
X-Received: by 2002:a1c:a794:: with SMTP id q142-v6mr3457997wme.77.1538337206300;
        Sun, 30 Sep 2018 12:53:26 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/19] staging: rtl8188eu: replace tabs with spaces in odm_hwconfig.c
Date:   Sun, 30 Sep 2018 21:52:57 +0200
Message-Id: <20180930195310.1531-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces in odm_hwconfig.c where appropriate.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index e9e5d2a6a06c..ada59a671da4 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -17,9 +17,9 @@
 static u8 odm_QueryRxPwrPercentage(s8 AntPower)
 {
 	if ((AntPower <= -100) || (AntPower >= 20))
-		return	0;
+		return 0;
 	else if (AntPower >= 0)
-		return	100;
+		return 100;
 	else
 		return 100 + AntPower;
 }
-- 
2.19.0

