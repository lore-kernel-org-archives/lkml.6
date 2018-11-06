Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FBBC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D939620862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D939620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbeKGGgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:36:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36839 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbeKGGgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:36:53 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 47B53207A3; Tue,  6 Nov 2018 22:09:43 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 10FFC2039F;
        Tue,  6 Nov 2018 22:09:33 +0100 (CET)
Date:   Tue, 6 Nov 2018 22:09:33 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     sre@kernel.org, Nicolas.Ferre@microchip.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] power: reset: at91-poweroff: move shdwc related data
 to one structure
Message-ID: <20181106210933.GU24212@piout.net>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541416443-4321-3-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On 05/11/2018 11:14:26+0000, Claudiu.Beznea@microchip.com wrote:
>  static int __init at91_poweroff_probe(struct platform_device *pdev)
> @@ -154,16 +160,22 @@ static int __init at91_poweroff_probe(struct platform_device *pdev)
>  	u32 ddr_type;
>  	int ret;
>  
> +	at91_shdwc = devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KERNEL);
> +	if (!at91_shdwc)
> +		return -ENOMEM;
> +

Is there any real benefit that will offset the time lost for that
allocation at boot time?

I understand you are then testing at91_shdwc to know whether the driver
already probed once. But, the driver will never probe twice as there is
only one shutdown controller on the SoC and anyway, If it was to probe
twice, it will still work as expected.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
