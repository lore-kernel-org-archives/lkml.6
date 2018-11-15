Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAF6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2527D223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2527D223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeKOSPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:15:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:65293 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbeKOSPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:15:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 00:09:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,235,1539673200"; 
   d="scan'208";a="106436208"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.97])
  by fmsmga004.fm.intel.com with ESMTP; 15 Nov 2018 00:09:06 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Todor Tomov <todor.tomov@linaro.org>,
        Roger Quadros <rogerq@ti.com>, linux-usb@vger.kernel.org
Cc:     vigneshr@ti.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        "linux-stable # \= v4 . 13" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND] usb: dwc3: core: Fix ULPI PHYs and prevent phy_get/ulpi_init during suspend/resume
In-Reply-To: <606dbc68-2014-8590-ce47-83c175d4cd41@linaro.org>
References: <1515667087-4110-1-git-send-email-rogerq@ti.com> <ee73347b-e996-4052-6a9d-dd94edd4a61a@ti.com> <606dbc68-2014-8590-ce47-83c175d4cd41@linaro.org>
Date:   Thu, 15 Nov 2018 10:09:05 +0200
Message-ID: <87efbm92zi.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Todor Tomov <todor.tomov@linaro.org> writes:

> Hello,
>
> After I apply this patch on 4.14 (or receive it with 4.14.70) I see a regression with
> the Qualcomm QUSB2 phy driver. I'm testing on a Dragonboard 820c.
> In boot log I get:
>
> [    4.525502] phy phy-7412000.phy.6: QUSB2PHY pll lock failed: status reg = 0
> [    4.529232] phy phy-7412000.phy.6: phy init failed --> -16
> [    4.536170] dwc3 7600000.dwc3: failed to initialize core
> [    4.541743] dwc3: probe of 7600000.dwc3 failed with error -16
> [    4.549979] phy phy-7411000.phy.5: QUSB2PHY pll lock failed: status reg = 0
> [    4.552843] phy phy-7411000.phy.5: phy init failed --> -16
> [    4.559606] dwc3 6a00000.dwc3: failed to initialize core
> [    4.565181] dwc3: probe of 6a00000.dwc3 failed with error -16
>
> I can provide a full log if needed.

please do. Also, try mainline and let us know if the problem
persists. Why do you get -EBUSY from the PHY driver?

- 
balbi
