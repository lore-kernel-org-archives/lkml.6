Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E1FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C252221526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N66staWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C252221526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbeITUdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:33:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34006 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbeITUdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:33:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id t15so1786810wrx.1;
        Thu, 20 Sep 2018 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fy+GVyRUuu2PnZ3f1PPjKNqXxT0mn/XDILq5YDmPihE=;
        b=N66staWuSvR38dyQhm8Fv+3/3+2i4aQzKQGwxW0JwY73pUIGwH1bhh5R13puL3ire3
         aotcsjznF2DEN7w7mdvYdckR3j0DjtMN8C7484lyKgisdVgiHDYJvp30pZzwo1K8Z1NO
         wkb5x4xAMphC4Mt3puGtnqO+p6/2v4MoaDVM6uBw+bI7TySTerLMQgZZcJDIMWVaxvsy
         UNDh8e0akluf9BY3hEtyuiV3Qtoi/+Q7GTAjXmpTIFQ6Tt/C4dr5A1s/jN7uIxkEirxr
         ua2i2fjNqcy3RrQRmzXa1psUS7cnLcRlTX0UzzzkHb4T8W1hpM5vMPrzWp4DeRcdmJAE
         4/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fy+GVyRUuu2PnZ3f1PPjKNqXxT0mn/XDILq5YDmPihE=;
        b=bO0pm3m1EKIWKFQrZs+MP9SHSoD3FE3KS3FU6CiEnLZJER/o3mn4/CSAezTq4G+m2N
         Wv0XvhuUqXCR5nrDf4wA1btHbGLBcPDudCTKh07yENsUgb6NxAR/H3f40qHsfs5LQ4sJ
         BSIFL5M0tebGuVDAQjPpF9AbZ1ZZkQYpw64f2zxO44aUiNq7+tPYVR5zQ4+twCuBEayB
         YFJRL/U2kVQTUQL4Hs3FTJ5Qq5XUfIEIwkOuj8tFU5m23VliE76zxQbThURvAeA/E0lk
         DzUv4rOHQeMOL+BX4OqAbpuMps8xTkgyaUiaAItiDCTLd8OBDLh0/m1wTxjD4PHy5JZy
         0hJQ==
X-Gm-Message-State: APzg51CUsvhRon5WmPCgAbyaLTAMqMZrCcIB6Z078ojojJfnXoRtaH1J
        W8/HODiGS9Kf6aALbCAl1PI=
X-Google-Smtp-Source: ANB0VdZWFWw4tM/nMy6gaiEYuiV/bpRu2fjxE7dX8ZUtAAYH53LDgUWoa7dOPm2pVhu7a07tXoMyhg==
X-Received: by 2002:a5d:4185:: with SMTP id m5-v6mr8801523wrp.8.1537454951068;
        Thu, 20 Sep 2018 07:49:11 -0700 (PDT)
Received: from localhost.localdomain (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id y206-v6sm2590377wmg.14.2018.09.20.07.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 07:49:10 -0700 (PDT)
From:   Romain Izard <romain.izard.pro@gmail.com>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH] usb: cdc_acm: Do not leak URB buffers
Date:   Thu, 20 Sep 2018 16:49:04 +0200
Message-Id: <20180920144904.24911-1-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ACM TTY port is disconnected, the URBs it uses must be killed, and
then the buffers must be freed. Unfortunately a previous refactor removed
the code freeing the buffers because it looked extremely similar to the
code killing the URBs.

As a result, there were many new leaks for each plug/unplug cycle of a
CDC-ACM device, that were detected by kmemleak.

Restore the missing code, and the memory leak is removed.

Fixes: ba8c931ded8d ("cdc-acm: refactor killing urbs")
Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/usb/class/cdc-acm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index f9b40a9dc4d3..bc03b0a690b4 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1514,6 +1514,7 @@ static void acm_disconnect(struct usb_interface *intf)
 {
 	struct acm *acm = usb_get_intfdata(intf);
 	struct tty_struct *tty;
+	int i;
 
 	/* sibling interface is already cleaning up */
 	if (!acm)
@@ -1544,6 +1545,11 @@ static void acm_disconnect(struct usb_interface *intf)
 
 	tty_unregister_device(acm_tty_driver, acm->minor);
 
+	usb_free_urb(acm->ctrlurb);
+	for (i = 0; i < ACM_NW; i++)
+		usb_free_urb(acm->wb[i].urb);
+	for (i = 0; i < acm->rx_buflimit; i++)
+		usb_free_urb(acm->read_urbs[i]);
 	acm_write_buffers_free(acm);
 	usb_free_coherent(acm->dev, acm->ctrlsize, acm->ctrl_buffer, acm->ctrl_dma);
 	acm_read_buffers_free(acm);
-- 
2.17.1

