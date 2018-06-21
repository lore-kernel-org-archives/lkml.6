Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DATE_IN_PAST_12_24,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F802C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8464208A4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5A5TrvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8464208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbeFUOCR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:02:17 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38235 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbeFUOCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:02:16 -0400
Received: by mail-wr0-f196.google.com with SMTP id e18-v6so3338990wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ztpjeygq1007uYB4aSOHH16pGxf34ClgcmLivn0BpDI=;
        b=U5A5TrvVX6/LWKbLv7xChLFXPw9/0hd+sNBWWjIIamGK8/3Vnpv6xOFnh5Sj4iHQp/
         MIUH7fcN9G8Eg5cG/W7nol3TBcOy90iAI2/SGY4SNs3CbPSQ1PPTAL4YgVIeVODYEg/T
         XU39RyFXOzqvsQ4EyVZSYtJB88+EccdxAdHJBx6fFZuAsi3HA4koWnBzDNSEeqMv/TVn
         t+JSKpNxWYPDhtPtgIi49dTMPOr+eydIDR4H8Se+N2iVYJbJFp3YK7sgKo5Bjl833aee
         mEktN7oDCVQTyVehTvDd0OMtnsEGjHIuSDTcg8UXsKD/fHiFEeGOPWtaprmlL30zvWbd
         9yRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ztpjeygq1007uYB4aSOHH16pGxf34ClgcmLivn0BpDI=;
        b=RCAjG5WKsn/TikvDOPW3t1H5erHMZtBFYb92zD8I3/P1xQDnH3flPLnHu/2XRm2Mk1
         M6z8cigX+uNPIYR964+XhnpLhDz2NEAHAqE5FWLQf5icZrqEqIl5R0bxRxOtw3bymNI2
         7mANGvaaVvSlLqRm8y1eqxq3FWa/ZueT2hRqnNyg4hc+KobR/CICgpHHtyOae9/e/vs8
         RfyAtO0cvU7+mGLjf74pkH/p6mIisG9Jt8X+iahUsFUH7A04kRCT73rQnIV3SzIEmITW
         9+cX0y3E2oLAtkepFZUcKkDQnhuqdfYWlAxXTHaORkOwnO9Slb21ZytG13i/QWsGa8uS
         JwrQ==
X-Gm-Message-State: APt69E0Fc8Tm2wrRRtAtDuJvgoSOhsRVG87xBUgwqymetKTSkVpf8yBt
        5FlAJOeAxqFpQf4+/ax3TLn8Mg==
X-Google-Smtp-Source: ADUXVKIrhpuhlS3Jl7ICRfgSWSnXM1SZGBnvu50k421zG5IbK7QdrHyvISlkJQb4rN9p4gKP+4Gctg==
X-Received: by 2002:adf:bb84:: with SMTP id q4-v6mr5847128wrg.183.1529589735065;
        Thu, 21 Jun 2018 07:02:15 -0700 (PDT)
Received: from lynn-ThinkPad-T400 ([196.43.135.103])
        by smtp.gmail.com with ESMTPSA id y3-v6sm5477290wro.21.2018.06.21.07.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 07:02:14 -0700 (PDT)
Date:   Thu, 21 Jun 2018 05:00:59 +0300
From:   Nabimanya Lynn <nabimanya000@gmail.com>
To:     jirislaby@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4.17.0-rc3 1/2] tty: add spaces
Message-ID: <20180621020059.GA10915@lynn-ThinkPad-T400>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernel@vger.kernel.org
Bcc: 
Subject: [PATCH 4.17.0-rc3 1/2] tty: add spaces 
Reply-To: 

Corrected error of missing space in the function PCI_VDEVICE. 

Signed-off-by: Nabimanya Lynn <nabimanya000@gmail.com>
---
 drivers/tty/mxser.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 8bc15cb..93965d4 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -152,14 +152,14 @@ static const struct pci_device_id mxser_pcibrds[] = {
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168U),	.driver_data = 13 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132U),	.driver_data = 14 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134U),	.driver_data = 15 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104JU),.driver_data = 16 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104JU), .driver_data = 16 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_RC7000),	.driver_data = 17 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118U),	.driver_data = 18 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102UL),.driver_data = 19 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102UL), .driver_data = 19 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102U),	.driver_data = 20 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL),.driver_data = 21 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL),.driver_data = 22 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL),.driver_data = 23 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL), .driver_data = 21 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL), .driver_data = 22 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL), .driver_data = 23 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB108),	.driver_data = 24 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB114),	.driver_data = 25 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB134I),	.driver_data = 26 },
-- 
2.7.4

