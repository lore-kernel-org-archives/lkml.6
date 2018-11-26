Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F6AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAA020663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY2671V6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAA020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeK0Es5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:48:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54826 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeK0Es4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:48:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id z18so4496767wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 09:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qt8vTDogqDRK/VtFgS6V2pWKTLJWdSShzpfjQXMw3nw=;
        b=WY2671V6JpwCrw7pfDGrqS/a/I81IvSIhfjG34CX67cJcqBw+KQtGHJmR1fNoYQ8VY
         Q+vkEvRE1aChO82UMHFkeKWfe86onUhdQukmUADbsA/Rv9nDj0sDvhIa22QeF9AxROfi
         IjSGFr0wuhr5fxmJ2q54G6OLjYZVzqJKbp+liKcQaINOMIuRxPeAu6Q68MILyEQpNduC
         pUPmfBZ1Y8ACrSSRLAEHo9wlcVXtwUC12N2vUW/zB0+fX0d1T3T2ZOdV06Sfbf/pnndV
         pTfO1tnElpUmqnmG12GbxzZsbyayzHGcpcIfKPqHfV6V6V5zljUAKxFOostGLr4cyESI
         2DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qt8vTDogqDRK/VtFgS6V2pWKTLJWdSShzpfjQXMw3nw=;
        b=Kz5PAHf+/kymuXF4+Q2w4rdVFyzhwntQPYymcTPxWA+/ibyJ0ao0dKAy1SCSBqh1BE
         YmBBhgL32tOkofdfwOm+loFps2VQyYXG19c9G5kiJWvY88l24SPoSw2oDBR13Jrt9GP4
         v386wy3qzRTyDEKNssJsBjrnZI4cxgPQbClgHAOgBcRFW8I9HWojtM3g9jyLhkdwU+7K
         M+PWsMig3K8taqJo02wM3ujJU6AtL2EZmH2RMMx+2OMfNzMpII/65u1nvNGck/4r8pzz
         XCDEcDr31v2THEYmYIgRw/vMg+WYFQg+XCXHAiMLFap7Po4w6ie7Pk3AOCh9NM8GC3JF
         OoAw==
X-Gm-Message-State: AA+aEWbk6ZkuDYuxjcuGljSgdkSNw1PzXE4w0wYzog2e+R9R83nU1m9n
        +RRMsLk+rNMCZ7p8Jb1Oji59x85x
X-Google-Smtp-Source: AFSGD/XBDEV6lY96vCus86/lbz+Lzq2RVEolT0GLWAKeekkZU9UGM/AYbVk/7aHM1NLdYJxe+LX5wA==
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr25110161wmh.55.1543254844868;
        Mon, 26 Nov 2018 09:54:04 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i16sm1886898wmd.28.2018.11.26.09.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 09:54:04 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux@wolf-entwicklungen.de, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: pi433: add missing call to cdev_del()
Date:   Mon, 26 Nov 2018 18:53:55 +0100
Message-Id: <20181126175355.18800-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cdev_add() fails, cdev_del() should be called.
Add the missing cdev_del() call as pointed out by
Dan Carpenter.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index d72de2105053..abc98a544929 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1254,6 +1254,7 @@ static int pi433_probe(struct spi_device *spi)
 	retval = cdev_add(device->cdev, device->devt, 1);
 	if (retval) {
 		dev_dbg(device->dev, "register of cdev failed");
+		cdev_del(device->cdev);
 		goto cdev_failed;
 	}
 
-- 
2.19.2

