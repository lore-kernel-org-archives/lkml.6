Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2949FC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC24120854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC24120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeIMNvL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:51:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58381 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbeIMNvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:51:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8416220877; Thu, 13 Sep 2018 10:42:41 +0200 (CEST)
Received: from windsurf (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3AD1120719;
        Thu, 13 Sep 2018 10:42:41 +0200 (CEST)
Date:   Thu, 13 Sep 2018 10:42:41 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20180913104241.65db8243@windsurf>
In-Reply-To: <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
        <87zhwm4kl6.fsf@tkos.co.il>
        <20180912231050.GX30658@n2100.armlinux.org.uk>
        <20180913094515.351967bb@windsurf>
        <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, 13 Sep 2018 10:20:45 +0200, Jan Kundrát wrote:
> On čtvrtek 13. září 2018 9:45:15 CEST, Thomas Petazzoni wrote:
> > What about something like the below. I tested it, including the error
> > case by forcing an -EPROBE_DEFER. The new pci_unmap_io() is modeled
> > after pci_unmap_iospace(). Actually, I would prefer to use
> > pci_remap_iospace() and pci_unmap_iospace() but for now this API
> > doesn't allow overloading the memory type used for the mapping.  
> 
> Thanks for providing this fix so quickly, Thomas. I can confirm that this 
> patch -- tested on top of 54eda9df17f3215b9ed16629ee71ea07413efdaf ("Merge 
> tag 'pci-v4.19-fixes-1' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci"). Disclaimer: I 
> have zero familiarity with Linux' PCI code.
> 
> Tested-by: Jan Kundrát <jan.kundrat@cesnet.cz>

Thanks for the testing. I'll wait for Russell to say if he is happy
(or not) with the addition of pci_unmap_io() in the ARM code, if that's
the case, I'll send a proper patch to fix the issue.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
