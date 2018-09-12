Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96731C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493D320880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493D320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeILX4o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:56:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37637 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbeILX4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:56:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 220E420756; Wed, 12 Sep 2018 20:50:53 +0200 (CEST)
Received: from windsurf (LFbn-1-10682-153.w90-89.abo.wanadoo.fr [90.89.35.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id D660C20701;
        Wed, 12 Sep 2018 20:50:52 +0200 (CEST)
Date:   Wed, 12 Sep 2018 20:50:52 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20180912205052.19de01a0@windsurf>
In-Reply-To: <87zhwm4kl6.fsf@tkos.co.il>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
        <87zhwm4kl6.fsf@tkos.co.il>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan, Baruch,

On Wed, 12 Sep 2018 21:49:41 +0300, Baruch Siach wrote:

> Jan Kundrát writes:
> > since commit ee1604381a371b3ea6aec7d5e43b6e3f5e153854 ("PCI: mvebu: Only
> > remap I/O space if configured"), my board (Solidrun Clearfog Base) won't
> > finish booting with 4.18-rc3 won't boot:  
> 
> You mean '4.19-rc3', right?
> 
> >> [    1.741458] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> >> [    1.748182] CPU: 1 PID: 72 Comm: kworker/1:2 Tainted: G        W         4.19.0-rc3 #1  
> 
> The 'W' taint means that there was a kernel warning before. Which
> warning was that?
> 
> I reproduced the same Oops on Clearfog Base without any taint:

Thanks for the report, I'll have a look tomorrow when I have to
ClearFog hardware.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
