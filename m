Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B72C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DCE2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRuISFDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DCE2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeK1H52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:57:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54709 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeK1H52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:57:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id z18so402039wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eyZC8zPrEB9GI4CEW3V1VMsUGZVDUymYiqjoz0/zm3w=;
        b=lRuISFDKTtL/GvmK33HqAdGh8Rddl+X8Uu+tsvHvSb0CoJsMcEDn5aHqVGDC0FvQbg
         H06ePByl+c7y6Bs/fHw/J8bALowFvU2aK9zsCeweHrMUyAhB3h9qbs087Vdjwi9vyFcd
         HHmsn7xGyem9+qIuWZIdlQsHwAoFxvo/czDl09eotUlddL86Cp16ncPjdIww4adjZ1vb
         NVAlvwO/2jC232xecT7Ddv4EpwE863OPs0Pq/3dkXwf1xxYAwbma5aADPg/u6NYJPMqZ
         cFGwB41FfMdlTcj6JCF7WZ4f4eiUXIbIYfsLSv8HYOlrM0s7Nu72OXjRmusHLxbTeafI
         d72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eyZC8zPrEB9GI4CEW3V1VMsUGZVDUymYiqjoz0/zm3w=;
        b=oriT4ld3bgJcxgYC7XolesXWNh8DXZBfVgfIcdFIrzkQnI88LF28qyk7lm4/YMgEld
         RAr/iAej+JQWCfbmrh+nn4mimdsUGFa5zENxOltR3Vc1ZaJ2RL8JqcbVMH1sICzyaZ1i
         Wg+PXcxl7dTTi64X+7R7lrDu5djYjmuFWK4t8Bw5zB1sB/QQ+d8p8r5Fc0LpvnxWD/hr
         USuIpyjF05HVtu8sw+yB6elObK+zL7nj95qTrv7472PDgVixHKAG9vepoLQYu4xg12LU
         OGQNXJwbitaf/RsqINngFkhl6eRbSTth11u7IKJe7rQDM9pu32IDoKPkVd4zAVpgGHR7
         dzVg==
X-Gm-Message-State: AA+aEWbxuMn3WzyuTwOodA9NfsixWIPnA8EVDY38kLYoSHz6zL7qEqkQ
        8nuN6/bg+l5zMP6T1gFkqIg=
X-Google-Smtp-Source: AFSGD/XqAjeoeM/8sq3ipf+QtNxppp6fpWWmP6G20+ObabLdxVETkUFpeWRb5t8n/CjS2/ycLPGhCg==
X-Received: by 2002:a1c:174f:: with SMTP id 76mr377044wmx.116.1543352297464;
        Tue, 27 Nov 2018 12:58:17 -0800 (PST)
Received: from localhost (host102-98-dynamic.181-80-r.retail.telecomitalia.it. [80.181.98.102])
        by smtp.gmail.com with ESMTPSA id b13sm6209307wrn.28.2018.11.27.12.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 12:58:16 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carmeli Tamir <carmeli.tamir@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arkadiusz Lis <areklis909@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Cristian Sicilia <sicilia.cristian@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: emxx_udc: Remove cast and move all in one line.
Date:   Tue, 27 Nov 2018 21:57:17 +0100
Message-Id: <1543352237-1978-3-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543352237-1978-1-git-send-email-sicilia.cristian@gmail.com>
References: <1543274351-25762-3-git-send-email-sicilia.cristian@gmail.com>
 <1543352237-1978-1-git-send-email-sicilia.cristian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the cast from IO_ADDRESS and use a single line.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
As suggested by Dan we can just remove the cast and use an
unique line.

 drivers/staging/emxx_udc/emxx_udc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index ebc622f..382683f 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -108,20 +108,16 @@ static void _nbu2ss_dump_register(struct nbu2ss_udc *udc)
 
 	dev_dbg(&udc->dev, "\n-USB REG-\n");
 	for (i = 0x0 ; i < USB_BASE_SIZE ; i += 16) {
-		reg_data =   _nbu2ss_readl(
-			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i));
+		reg_data = _nbu2ss_readl(IO_ADDRESS(USB_BASE_ADDRESS + i));
 		dev_dbg(&udc->dev, "USB%04x =%08x", i, (int)reg_data);
 
-		reg_data =  _nbu2ss_readl(
-			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i + 4));
+		reg_data = _nbu2ss_readl(IO_ADDRESS(USB_BASE_ADDRESS + i + 4));
 		dev_dbg(&udc->dev, " %08x", (int)reg_data);
 
-		reg_data =  _nbu2ss_readl(
-			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i + 8));
+		reg_data = _nbu2ss_readl(IO_ADDRESS(USB_BASE_ADDRESS + i + 8));
 		dev_dbg(&udc->dev, " %08x", (int)reg_data);
 
-		reg_data =  _nbu2ss_readl(
-			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i + 12));
+		reg_data = _nbu2ss_readl(IO_ADDRESS(USB_BASE_ADDRESS + i + 12));
 		dev_dbg(&udc->dev, " %08x\n", (int)reg_data);
 	}
 
-- 
2.7.4

