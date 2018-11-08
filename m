Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ED4C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D5620857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D5620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeKHSKX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:10:23 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:53247 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKHSKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:10:23 -0500
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id A654CCF2B8;
        Thu,  8 Nov 2018 09:43:26 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH 15/15] arm64: dts: allwinner: a64: bananapi-m64: Add
 Bluetooth device node
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181107101308.7626-16-wens@csie.org>
Date:   Thu, 8 Nov 2018 09:35:57 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi@googlegroups.com,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BB1D82EC-3F84-4C02-B230-32B331887F08@holtmann.org>
References: <20181107101308.7626-1-wens@csie.org>
 <20181107101308.7626-16-wens@csie.org>
To:     Chen-Yu Tsai <wens@csie.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

> The AP6212 is based on the Broadcom BCM43430 or BCM43438. The WiFi side
> identifies as BCM43430, while the Bluetooth side identifies as BCM43438.
> 
> The Bluetooth side is connected to UART1 in a 4 wire configuration. Same
> as the WiFi side, due to being the same chip and package, DLDO2 provides
> overall power via VBAT, and DLDO4 provides I/O power via VDDIO. The RTC
> clock output provides the LPO low power clock at 32.768 kHz.
> 
> This patch enables Bluetooth on this board, and also adds the missing
> LPO clock on the WiFi side. There is also a PCM connection for Bluetooth,
> but this is not covered here.

we need to figure out on how we want to describe the Bluetooth PCM settings in DT and how things are wired up. For the Bluetooth driver, we just have to send a few Broadcom commands to set up the Bluetooth side correctly.

Regards

Marcel

