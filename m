Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950A2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4D72156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4D72156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeI0MOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:14:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:7879 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeI0MN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 08:13:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 22:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,309,1534834800"; 
   d="scan'208";a="95188812"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by orsmga002.jf.intel.com with ESMTP; 26 Sep 2018 22:57:10 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        James Hogan <jhogan@kernel.org>, Alban Bedel <albeu@free.fr>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 4/5] usb: host: Add XHCI driver for Broadcom STB SoCs
In-Reply-To: <1538000414-24873-5-git-send-email-alcooperx@gmail.com>
References: <1538000414-24873-1-git-send-email-alcooperx@gmail.com> <1538000414-24873-5-git-send-email-alcooperx@gmail.com>
Date:   Thu, 27 Sep 2018 08:57:09 +0300
Message-ID: <87a7o3scsq.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Al Cooper <alcooperx@gmail.com> writes:

> This driver enables USB XHCI on Broadcom ARM STB SoCs.
> The drivers depend on a matching "brcm,brcmstb-usb-phy"
> Broadcom STB USB Phy driver.
>
> The standard platform driver can't be used because of differences
> in PHY and Clock handling. The standard PHY handling in hcd.c will
> do a phy_exit/phy_init on suspend/resume and this will end up
> shutting down the PHYs to the point that the host controller
> registers are no longer accessible and will cause suspend to crash.
> The clocks specified in device tree for these drivers are not
> available in mainline so instead of returning EPROBE_DEFER when
> the specified clock is not found and eventually failing probe,
> the clock pointer is set to NULL which disables all clock handling.
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/usb/host/xhci-brcm.c | 294 +++++++++++++++++++++++++++++++++++++++++++

this looks a lot like xhci-plat.c, why don't you use that instead?

- 
balbi
