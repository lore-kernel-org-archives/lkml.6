Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B296C43142
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BEC21761
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc3ysOMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BEC21761
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeHDF7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 01:59:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46525 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbeHDF7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 01:59:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id f14-v6so3198630pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 20:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=EDF4E0sr/cET/NRAHLBCWDqosfSilIAHE4mW/BMyzno=;
        b=Rc3ysOMZWK5HS318wUqIkmnazLNRxtx+dF0ZS/jCwQI6XGuA6U6WtkPmg4k6P3YR0B
         PgfjtlTqcQr8imce/uQLkTpUFTV3xlFK4UQNjZ0KX6YScE1Alwh3FCCZPufe9lhY/EIo
         84AxTHBKgoBKMLewHzBkXhsynfmPz2g1kS/baEpDfXjeEN4W6B5JizRsbsSgu+Txcnh9
         BQVkTroneanSVZK/bUk6+HeBvCiBq3/sCtxKF4YbcTFCqEfhorRhvXberPBfMf/yxRNE
         hVM6R8BV/f554qDInfSyh+aJlF+q+vsVOs1ZZtfKps+DX8cbZHC958MjSLNeNxYHAl2C
         QmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=EDF4E0sr/cET/NRAHLBCWDqosfSilIAHE4mW/BMyzno=;
        b=XZW0HT6gW3hq910EY99X0TW4IfHNoC5YM46X9k5Pzwe5eYLHBDAXk+G4vbAcAbOudV
         AFGiwTHqKoNTQyGqQNRchfWhzdr0gsVBcW7JfMSw4u7V7LK9oYz5z/onM9RNE64vkcAm
         cbXEt+Z3aU0AzIDuGAvqUbL673NJ4Cw64amXhhkD1Nt4+DUm2ATEJC3lotnWlEV5YL4y
         oQThJjDDAnZcU3in1htiMqm328xNCzEmMq5wBQSVdVVIGtmxqWL2lHjfZFlnr5mHsip3
         Pju4r9jx4mf9//7MefLiZNe8vz0HjHV6yzkToPrgOkC50rL+ZiDlBJL4QUOVgUBwCDrJ
         ObzQ==
X-Gm-Message-State: AOUpUlHD0PAPmboM3aIgxBmh1NTP+2cdPKHw2Rw/nKfhNPGQQwuzb0b5
        7FT67Ff9rZCv6LiSWW3CmdmDJnke
X-Google-Smtp-Source: AAOMgpf98CVln8PInMwC8satAg127VLECUAAuVY4G8P/enLTx8q+WBQQbSAEh8oiGhXXbdyrRftfsg==
X-Received: by 2002:a62:5a01:: with SMTP id o1-v6mr7508183pfb.0.1533355194268;
        Fri, 03 Aug 2018 20:59:54 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t19-v6sm11921887pfk.182.2018.08.03.20.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 20:59:53 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] mfd: sm501: Set coherent_dma_mask when creating subdevices
Date:   Fri,  3 Aug 2018 20:59:51 -0700
Message-Id: <1533355191-26512-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instantiating the sm501 OHCI subdevice results in a kernel warning.

sm501-usb sm501-usb: SM501 OHCI
sm501-usb sm501-usb: new USB bus registered, assigned bus number 1
WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516
ohci_init+0x194/0x2d8
Modules linked in:

CPU: 0 PID: 1 Comm: swapper Tainted: G        W
4.18.0-rc7-00178-g0b5b1f9a78b5 #1
PC is at ohci_init+0x194/0x2d8
PR is at ohci_init+0x168/0x2d8
PC  : 8c27844c SP  : 8f81dd94 SR  : 40008001
TEA : 29613060
R0  : 00000000 R1  : 00000000 R2  : 00000000 R3  : 00000202
R4  : 8fa98b88 R5  : 8c277e68 R6  : 00000000 R7  : 00000000
R8  : 8f965814 R9  : 8c388100 R10 : 8fa98800 R11 : 8fa98928
R12 : 8c48302c R13 : 8fa98920 R14 : 8c48302c
MACH: 00000096 MACL: 0000017c GBR : 00000000 PR  : 8c278420

Call trace:
 [<(ptrval)>] usb_add_hcd+0x1e8/0x6ec
 [<(ptrval)>] _dev_info+0x0/0x54
 [<(ptrval)>] arch_local_save_flags+0x0/0x8
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] ohci_hcd_sm501_drv_probe+0x114/0x2d8
...

Initialize coherent_dma_mask when creating SM501 subdevices to fix
the problem.

Fixes: b6d6454fdb66f ("mfd: SM501 core driver")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mfd/sm501.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 2a87b0d2f21f..a530972c5a7e 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -715,6 +715,7 @@ sm501_create_subdev(struct sm501_devdata *sm, char *name,
 	smdev->pdev.name = name;
 	smdev->pdev.id = sm->pdev_id;
 	smdev->pdev.dev.parent = sm->dev;
+	smdev->pdev.dev.coherent_dma_mask = 0xffffffff;
 
 	if (res_count) {
 		smdev->pdev.resource = (struct resource *)(smdev+1);
-- 
2.7.4

