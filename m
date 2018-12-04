Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D48C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF402082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF402082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeLDVwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:52:33 -0500
Received: from muru.com ([72.249.23.125]:56442 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeLDVwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:52:33 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F055280FA;
        Tue,  4 Dec 2018 21:52:34 +0000 (UTC)
Date:   Tue, 4 Dec 2018 13:52:29 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc:     linux@armlinux.org.uk, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: omap2plus_defconfig: add networking over USB device
Message-ID: <20181204215229.GE6707@atomide.com>
References: <20181204205901.14620-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204205901.14620-1-michael.opdenacker@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Michael Opdenacker <michael.opdenacker@bootlin.com> [181204 12:59]:
> This adds support for networking over USB device,
> which allows boards such as the BeagleBoneBlack Wireless and
> Pocket Beagle to boot on an NFS root filesystem. Such boards
> have no Ethernet port.
> 
> This is for consistency with CONFIG_ROOT_NFS=y
> which makes no sense if there is no networking.

Hmm well this has few issues though:

1. We've had USB as loadable modules for years now to
   cut down on bloat and try to make things more
   distro friendly

2. MUSB has never worked well with PM and enabling
   it almost certainly would break PM for multiple
   devices

3. The USB gadget configuration should be done using
   configfs as it's device and policy  specific and
   Ethernet gadget may not be even desirable

So I suggest just doing what distros do and use a proper
initramfs :)

BTW what works quite nicely for devices with Ethernet
controller is to have u-boot load dtb, kernel and
modules.tar.gz over Ethernet and write it to mmc. That
way the loaded kernel and modules are available on
boot as long as some init script untars modules.tar.gz
first thing when init starts.

Regards,

Tony




