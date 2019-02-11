Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC677C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CDA21B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="n2zBE/cH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfBKRT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:19:29 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:53462 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfBKRT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IaifvgE3C68wFMRpEQ9J8azCgMgk0pBDjLk3DXUQCmI=; b=n2zBE/cH1FK6nlfk0LNww5mAA
        Mv/xwJBbco+oSBYjLGTCPnJG6J1COa3f5q1yawfIy/r8/I1vHjloTRVoTI2wAjfvcdcc2fuq0QALe
        gTPq9B5Jx35Hg7Kg0Y3yi4ewwkxBIX7TgB3eWNZmRTsEfMqSnwMTHVc55n9bv6wCTL/J0=;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:36704)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gtFEk-0007nV-4S; Mon, 11 Feb 2019 17:19:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gtFEh-0001Ld-4q; Mon, 11 Feb 2019 17:19:15 +0000
Date:   Mon, 11 Feb 2019 17:19:15 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Alexander Syring <alex@asyring.de>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: marvell: mcbin: Adding SPI-NOR Flash
 Config
Message-ID: <20190211171914.3leychqcdgfg4xlm@shell.armlinux.org.uk>
References: <20190211171401.434-1-alex@asyring.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211171401.434-1-alex@asyring.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 06:14:01PM +0100, Alexander Syring wrote:
> According to U-Boot dts file enabling the SPI-NOR flash for use in
> Linux

Some of us already use u-boot on Macchiatobin, and have u-boot in SPI
NOR flash.  The u-boot environment is stored at 0x3f0000 currently.

Merging this will break existing setups, especially when we use
u-boot-tools to access the environment from within Linux.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
