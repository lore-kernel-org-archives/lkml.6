Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 22514C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CF5208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp0t8AAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CF5208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964841AbeFLDJl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:09:41 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32877 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935193AbeFLDJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:09:39 -0400
Received: by mail-pl0-f66.google.com with SMTP id n10-v6so13494607plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 20:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FeSs9z2tOvd9LpmD0hBtuH9rGnCqqNaLK9dCQT5zjvA=;
        b=Sp0t8AAaCMZMHhQsyGRCzlW8D78KBvNpDEOtzHzQFzUX5h962EXga6N+l2K9kNmfnO
         r2AcS3ho/s3XbDSk/2NhbB3b6WM3o2E6ugiT5o/IzR4FrIwk6RszpYfF+QEkEoULSX9V
         uDpWKUiCHjbKsfHb3UDWe1jFnWvZ4MZ/chXMxVmK89Sz6gIU4Nl7NDVz32nJx0dy085t
         FzDYm/EOixlR/tYWSwjMAK2kh5JYwflcYII2T3Xemh5qgd5tJau7VEoYoD1YsWscDEY2
         iykUEsJdcIwLm7Rv+wT8HKEqzQuVvL7MlLIUpVwUEB0EChMxwrOA4GNaTDYjkiRO9u3n
         VHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FeSs9z2tOvd9LpmD0hBtuH9rGnCqqNaLK9dCQT5zjvA=;
        b=mg4aWZyW1YTkG9jm53NVB3hN0DLJ2iBctNGtI3il26GjTBBKiluYgrkoIVVI/8KbDC
         MQm427nBLsyJoBdG2E8uxF8e6ZDn9e+3F2uHUaXV86rMfhwMbRxmVjnKZ736HtMQswlI
         vMp94d9xhkQlaU7tV43wCkNhpvZTCEodhvpY/5mDegud2GJiqFDkcHFZtm/RNVxF9wVs
         uI48V9cyakcFyAXOGmbZZrCYWdbMnMI4QPZJWgyTTuTJTctAgcFx9wzarkZXRVYlHo13
         WQyoNxvahnaAAF2xUqWH2vDckYWNlMjTPtqtODJ7vStQ7mXsc6JAeLQTdt+yTIl/En/B
         asTQ==
X-Gm-Message-State: APt69E3m4Pjolx7UsWpzuJ82iR6ilUJIGlSLXI+fGsIs8vYcEj5tgc+L
        8sW3+Wsz6j1+Kx1JDLjU54I=
X-Google-Smtp-Source: ADUXVKI3qQSnijZY+ShEVinelsh4doMOmG1+jC+z1iAsaKk2N1/6h7s02zyELNZpZIS3EJM4xxlg3A==
X-Received: by 2002:a17:902:6acc:: with SMTP id i12-v6mr1968754plt.278.1528772979253;
        Mon, 11 Jun 2018 20:09:39 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id l14-v6sm40985662pfi.6.2018.06.11.20.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:09:38 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipack: add error handling for ioremap_nocache
Date:   Tue, 12 Jun 2018 11:07:21 +0800
Message-Id: <1528772844-36988-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ioremap_nocache fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling ioremap_nocache.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/ipack/carriers/tpci200.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ipack/carriers/tpci200.c b/drivers/ipack/carriers/tpci200.c
index 9b23843..1612f51 100644
--- a/drivers/ipack/carriers/tpci200.c
+++ b/drivers/ipack/carriers/tpci200.c
@@ -304,6 +304,13 @@ static int tpci200_register(struct tpci200_board *tpci200)
 		ioremap_nocache(pci_resource_start(tpci200->info->pdev,
 					   TPCI200_IP_INTERFACE_BAR),
 			TPCI200_IFACE_SIZE);
+	if (!tpci200->info->interface_regs) {
+		dev_err(&tpci200->info->pdev->dev,
+			"(bn 0x%X, sn 0x%X) failed to map driver user space!",
+			tpci200->info->pdev->bus->number,
+			tpci200->info->pdev->devfn);
+		goto out_release_mem8_space;
+	}
 
 	/* Initialize lock that protects interface_regs */
 	spin_lock_init(&tpci200->regs_lock);
-- 
2.7.4

