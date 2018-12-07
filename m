Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96168C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E52C20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If1WW1Pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E52C20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeLGO1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:27:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52535 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbeLGO1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:27:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so4550752wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 06:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dVmBkONUlKGyF3kLuSD/LDbPlazMQe7m3dzTyCC6rfU=;
        b=If1WW1Pki5ZnY1lNTNjI00k3IDVq4yG5PZZAMqiHRzA5Bo79KVMgbAmF8rQa3eh6bp
         LQ7aBEvKB0e9/B9WBmT5cJxRIuNjUKPUQ/3GS6rfsDEb2pYKJ4Mhc3Ks2Sj6j0Bof+78
         57vfPmc2bUM+IyGMFgQ2sBE0PZFy3JwZM+K2Ds6DPCxME7TTsNHvj7gv4gzfawyL6poP
         tg4Ho4rPm6T8Txzjcs5NWHs3qHvN2rgyAjVzvGA4MMQ2fQvKBBhOf+pICib+MYrtrIIp
         fBcHFS3nFlCdR8n1FSsn6vyOZ5S0I3W/j7U5R/fcPx65tzVxp5JMJ4QJ9dPoXktg4AiV
         IMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dVmBkONUlKGyF3kLuSD/LDbPlazMQe7m3dzTyCC6rfU=;
        b=EJSW/yxjp1kPPEzle3i6DZU/2s6athojk7Q2QzRC9Ri/R4uNovHvKRMrLxX7SvxC1D
         26ZoHZaFsJB+I+iguVST21o32jUts9aGJJ02F9puV7bl2xmHH3lXt1VgT5/GKknkZlip
         fCZM/JC0dzzCJbSWuRrxJqPFmtVlYGHqShSH7cOSKB/+B4awKD9lpeyvtLKOmEWsb8NG
         V7hFxK8i5T117Cik+cRhe1hWRrSHZDK9S8VVbV7CvRg64zGfEMve6ulKa95hNPKEEN8s
         rhgGV3uDnP1nvAhOqv15AqHp2OFSnuuCUPVj9sHwl4o/U8emosua1hWW1OW1hXQv+Ddk
         4Qww==
X-Gm-Message-State: AA+aEWbLjFdNfh3jKiGf8ShR6MshSSRkfXgf3BtAmI+ZuvoRUNwxBG0b
        u7dHVWXqt1QGdQmFk45dIm4=
X-Google-Smtp-Source: AFSGD/Vh8HYmk80s1rXt1nVJn/35q8RJ2oxyEtNUX1TV8nuu/cWfw5uMrU8hwoBMR/kcNQIAzF/IRQ==
X-Received: by 2002:a1c:a895:: with SMTP id r143mr2304732wme.95.1544192862889;
        Fri, 07 Dec 2018 06:27:42 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id 60sm7172523wrb.81.2018.12.07.06.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 06:27:42 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4/5] char: lp: properly count the lp devices
Date:   Fri,  7 Dec 2018 14:27:33 +0000
Message-Id: <20181207142734.27370-4-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207142734.27370-1-sudipm.mukherjee@gmail.com>
References: <20181207142734.27370-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the parallel port is usb based and the lp attaches to it based on
LP_PARPORT_AUTO, we do get /dev/lp0 and when we remove the usb device
/dev/lp0 is unregistered. If we now reconnect the usb device we get
our /dev/lp0 back. But if we now disconnect and reconnect eight times
we donot get any lp device and dmesg shows:

    lp: ignoring parallel port (max. 8)

Decrement the lp_count when the device detaches as this represents the
number of lp devices connected to the system.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/char/lp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 0e081f521f51..cef2ea386f5e 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -993,6 +993,7 @@ static void lp_detach(struct parport *port)
 	for (n = 0; n < LP_NO; n++) {
 		if (port_num[n] == port->number) {
 			port_num[n] = -1;
+			lp_count--;
 			device_destroy(lp_class, MKDEV(LP_MAJOR, n));
 			parport_unregister_device(lp_table[n].dev);
 		}
-- 
2.11.0

