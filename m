Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eIM0OJD8HVvGSAAAmS7hNA
	; Mon, 11 Jun 2018 04:39:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D4BD960792; Mon, 11 Jun 2018 04:39:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB9oG6gb"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 601F4606FA;
	Mon, 11 Jun 2018 04:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 601F4606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753925AbeFKEjy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 00:39:54 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37978 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753801AbeFKEjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 00:39:52 -0400
Received: by mail-pl0-f65.google.com with SMTP id b14-v6so11588520pls.5;
        Sun, 10 Jun 2018 21:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/9w/5uETKNwh15sAPtYyMo+0lDixTdw3GlH3t18lCbw=;
        b=VB9oG6gb892rYInFSSq9+E+PhNl6Rkbf2lQok8E8+ZbHk0b1zItnpRvIDeafxy+OSi
         QKFeMH+wvO8+YZ/Vcn2vmurFJp6YrUSmGH+miwXjvxIHyRlEmWqgzzw3f3hS+oQ9YPGK
         kgo3mOVmYFoAuWSozQAw0UwBBolhC4KKU2TDTOR0o0sKQ6EN/KkdVPQ6wq+L+o2QPxqr
         IFeM8vHtU0C0FtfRfeXpBHUlF62Kowln5/S54yJyUiw5MI9da0lusITJGSa8X2VCF5CL
         ox5YFOLljOa96jlqiATb0oKuqWfPQFREywjHKbPys2HmSatjOrpo6DXy+Qp0ImKMhZZc
         3B2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/9w/5uETKNwh15sAPtYyMo+0lDixTdw3GlH3t18lCbw=;
        b=U/4VE/JODllZjHS5wFb8a8jjdr1RF/giYyJpOtUe9OwoD4KR5UzZc6veKyHKVZXBi4
         mZoU7MFdTe1Qr7p76xm7CyR4p5aE/o8dN5cxPByw2zgdpA1D5Q/SdI7GmQUIH6XGzK7V
         4Vzn62qHPAM3YtP39mlC+AdELwOp2GvytV1Y1li7jSTrTEQktMofXC/09BFYms81VE1Q
         1pv237CUSQLTFbbYoWsYLT8VYf1lYjKBLA37EtU1LFnKGNPamAjvKO09h+sEsL+MMKmv
         h1kB/bi0k5xx7NIPv/WAXbA/lnebAwIXGGMy6FZ97OVIWP4ZlLVsNoYekbvjInk33+G5
         7dVw==
X-Gm-Message-State: APt69E25C5uV9DmsYOeKbuJ1LNitjEnwYzMrtYGDYtKxx3qicOtGbLEh
        1ZmKPQdNEAflTlRgNaWqjZo=
X-Google-Smtp-Source: ADUXVKK0UjE3tlyx///LSP/faQZOCa4rgfhieY0iHaIDuLgegPcfeKyNOFef3wVmXxAVxb4B10GNdA==
X-Received: by 2002:a17:902:b946:: with SMTP id h6-v6mr16426457pls.1.1528691992111;
        Sun, 10 Jun 2018 21:39:52 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id d22-v6sm89976294pfk.126.2018.06.10.21.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 21:39:51 -0700 (PDT)
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: tm6000: add error handling for dvb_register_adapter
Date: Mon, 11 Jun 2018 12:39:20 +0800
Message-Id: <1528691962-31010-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dvb_register_adapter fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling dvb_register_adapter.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/media/usb/tm6000/tm6000-dvb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/usb/tm6000/tm6000-dvb.c b/drivers/media/usb/tm6000/tm6000-dvb.c
index c811fc6..ff35d4b 100644
--- a/drivers/media/usb/tm6000/tm6000-dvb.c
+++ b/drivers/media/usb/tm6000/tm6000-dvb.c
@@ -266,6 +266,11 @@ static int register_dvb(struct tm6000_core *dev)
 
 	ret = dvb_register_adapter(&dvb->adapter, "Trident TVMaster 6000 DVB-T",
 					THIS_MODULE, &dev->udev->dev, adapter_nr);
+	if (ret < 0) {
+		printk(KERN_ERR "tm6000: couldn't register the adater!\n");
+		goto err;
+	}
+
 	dvb->adapter.priv = dev;
 
 	if (dvb->frontend) {
-- 
2.7.4
