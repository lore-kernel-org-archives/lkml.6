Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1FDECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBC720852
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBC720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbeGRMrg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:47:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35841 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeGRMrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:47:36 -0400
Received: from [192.168.0.117] (188.146.100.122.nat.umts.dynamic.t-mobile.pl [188.146.100.122])
        by mail.holtmann.org (Postfix) with ESMTPSA id D9182CF2B8;
        Wed, 18 Jul 2018 14:16:51 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] Bluetooth:hci_bcm:Check return value from devm_clk_get
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180717120635.25259-1-raghuhack78@gmail.com>
Date:   Wed, 18 Jul 2018 14:09:55 +0200
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <5018E00B-7642-435F-AB9E-1EEB7DD5A885@holtmann.org>
References: <5b4ddae5.1c69fb81.61055.042e.GMRIR@mx.google.com>
 <20180717120635.25259-1-raghuhack78@gmail.com>
To:     RAGHU Halharvi <raghuhack78@gmail.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raghu,

> * Check return value from devm_clk_get & return appropriate error.
> ---
> drivers/bluetooth/hci_bcm.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 441f5e1deb11..1295cc89d702 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -910,6 +910,8 @@ static int bcm_get_resources(struct bcm_device *dev)
> 		return 0;
> 
> 	dev->clk = devm_clk_get(dev->dev, NULL);
> +	if (IS_ERR(dev->clk))
> +		return PTR_ERR(dev->clk);

so I assumed this was not done on purpose and allow for dev->clk = NULL since all other clock handling functions will cope with it. Can someone NAK or ACK this patch?

Regards

Marcel

