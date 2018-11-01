Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B74C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35ADC205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2BvM358"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35ADC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeKBBAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:00:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44406 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbeKBBAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:00:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3-v6so9209663pgs.11;
        Thu, 01 Nov 2018 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=p93oWtu3eqJqiSPxNmrisVvC1ICb9kWsNX+hzhnZn3M=;
        b=q2BvM358BAqq36bwGahkhhBSJQFVCuMg6AefJG6hyP4WZbpMdIcCbOGFZEcAeZ5qj9
         26sZQoi9qOQ1spzIEx0Xpk2HteCN7rCWT5ZhRvRuuVO6XXg2/fxJ+XBNEsG/fBjY/K+2
         bhQbpJwtXMx8x1qCJ4UtR2uucJOCRc2L903V2p0bHuRhkDb2HPy7mSzAe86J8jfSQBxO
         jth6X5tENliMN5dITMWoUMxX2Jzm+V2aBZvED9qKbqhsQmx+SxGAiKwo7vSKo9IDKyHo
         noGZuv282mjcQFSCWQMLmofCu9mQSemT/INl5kLnTEXJT6mu6bA8/TPyaWJuSsp4Z4vQ
         Z1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p93oWtu3eqJqiSPxNmrisVvC1ICb9kWsNX+hzhnZn3M=;
        b=s+9Dxv4m54qc6w0TYsUIaTlFjWV/+pHxq32RRtCjTVnIvaSjWl3yx8U2VOWwWqWPVJ
         4ihOhPdCv9GDKG6LxVSKnvOroi9/6anJIhOW7HL2Pe0S+OZLhpt/grnoV29j7uYWymey
         ah0iKVHruNG7xlf20emESSO6JHlxJQUuMKXzzfr9uJSV8zIn7XYFZot1Orl8nGj1dCE1
         OV7iY5yKvdrGYkRjazcVmAumaFeN9qBs8NlittwCoKyMN8ibIUmWdcYHnN9bB1+rxYLx
         KlMpI+eQLPTMAMbgPXmz7K5NixOuOXDsrARQ1yFklVMOLwg40TM8agMb9rp/Q9lYr9Nn
         b0Ag==
X-Gm-Message-State: AGRZ1gIvmSVVRtdsRVgsHjA/NPZ52Gmvh1gxOxGAoxA1Wx3uOFFt8N2j
        12zANuyJe4jbRJi2H0PxLhA=
X-Google-Smtp-Source: AJdET5fs/YtyD1EvKYRtbBV4bFK5bG/PHqTMZLBwkgKQv+dTIMBNRDOKAL85d76/aR/MTX5mO/2tNQ==
X-Received: by 2002:a65:520a:: with SMTP id o10mr7889922pgp.276.1541087790750;
        Thu, 01 Nov 2018 08:56:30 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id n17-v6sm36155395pfj.84.2018.11.01.08.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 08:56:30 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] usb: xhci: fix small typo
Date:   Thu,  1 Nov 2018 11:56:24 -0400
Message-Id: <20181101155624.23435-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/usb/host/xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 0420eefa647a..d4446dc46fd1 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4105,7 +4105,7 @@ static int xhci_enable_device(struct usb_hcd *hcd, struct usb_device *udev)
 
 /*
  * Transfer the port index into real index in the HW port status
- * registers. Caculate offset between the port's PORTSC register
+ * registers. Calculate offset between the port's PORTSC register
  * and port status base. Divide the number of per port register
  * to get the real index. The raw port number bases 1.
  */
-- 
2.17.0

