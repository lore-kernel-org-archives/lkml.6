Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C3BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F79120830
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F79120830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbeKABzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:55:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36888 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbeKABzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:55:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id w66-v6so9912467oiw.4;
        Wed, 31 Oct 2018 09:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YcHrPScesMh0+OaPr8QrCgRct5i3YMVTYI6zQV6z4r8=;
        b=BI03DTFsQ5FCHKIWpif4B62pZ2sdJzE2Ju/FelsfvNviKmwR0RDBkrNtju4lPjWIFt
         d4Vg5Yw3vC6UApMnR2zJfb9ITlnPemzthXDSa3PdQDfMvBrHJvFDf2XkCD0V4EsJJZWM
         1h+rNpWs0+2Gi+Pnib0Am2+H6ouuWITdpoIGiV6/h7hqpbJNr2xY9rijPCIxJi3qncXi
         qlAAilqkKLoQuXEFKlyn/z5Z3lRdAuEYJ3g5frGKJ0dUh2jWca0ecPH5T9VS60bchkTI
         8S9W5GSlndawx1LQnNIXukf8cm6lH4r9CMUWDLqwFaZL0uZIHu4V5rX5HLf68hJGNpnK
         cFKA==
X-Gm-Message-State: AGRZ1gL6aks4WGaHqmHxgNvTL4dzePYXBNNxfqRj1tz7NB4FfrtWklYH
        6plJUNtB0NjHF0inJd/ZzQS8xWQOHBIsUfEZvjU=
X-Google-Smtp-Source: AJdET5ddThx1LesgD8T1MO4cbxo0CGKJwgqH6cfYUNGFpVHalMcwJnrxtoqmGuQKh5D9SyERKFu/UVvoLX4Y6pyL85k=
X-Received: by 2002:aca:d694:: with SMTP id n142-v6mr1085335oig.32.1541004979327;
 Wed, 31 Oct 2018 09:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
 <1540957223-30984-5-git-send-email-harini.katakam@xilinx.com> <f69c428d-565e-cf8e-de53-45850f2625cf@microchip.com>
In-Reply-To: <f69c428d-565e-cf8e-de53-45850f2625cf@microchip.com>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Wed, 31 Oct 2018 22:26:08 +0530
Message-ID: <CAFcVEC+SHLmQDG1_AZ8LtQR74bE-DwORew=qjCnCZBOZ1Bu01g@mail.gmail.com>
Subject: Re: [PATCH 4/4] net: macb: Add support for suspend/resume with full
 power down
To:     Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>, appanad@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

> Hi Harini,
>
> I applied these patches on net-next/master cloned from [1], updated this
> moment, but I don't have a phy_dev member in struct macb. Maybe you wanted
> to use netdev->phydev ?
>
> Thank you,
> Claudiu Beznea
>
I apologize. Yes, I'm using netdev->phydev and it was uncommitted on my branch
@@ -4264,8 +4264,8 @@ static int __maybe_unused macb_suspend(struct device *dev)
                netif_device_detach(netdev);
                for (q = 0, queue = bp->queues; q < bp->num_queues;
++q, ++queue)
                        napi_disable(&queue->napi);
-               phy_stop(bp->phy_dev);
-               phy_suspend(bp->phy_dev);
+               phy_stop(netdev->phydev);
+               phy_suspend(netdev->phydev);
                spin_lock_irqsave(&bp->lock, flags);
                macb_reset_hw(bp);
                spin_unlock_irqrestore(&bp->lock, flags);
@@ -4300,9 +4300,9 @@ static int __maybe_unused macb_resume(struct device *dev)
                macb_writel(bp, NCR, MACB_BIT(MPE));
                for (q = 0, queue = bp->queues; q < bp->num_queues;
++q, ++queue)
                        napi_enable(&queue->napi);
-               phy_resume(bp->phy_dev);
-               phy_init_hw(bp->phy_dev);
-               phy_start(bp->phy_dev);
+               phy_resume(netdev->phydev);
+               phy_init_hw(netdev->phydev);
+               phy_start(netdev->phydev);
Will fix in next set.

Regards,
Harini
