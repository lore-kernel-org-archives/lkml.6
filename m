Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355A4C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F9920870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548993125;
	bh=rhgHF5RLedZMnRabOaEfjkRX/2wgPbkQsDWtt7lw96Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QUup0dkNtQYEaeApT3EQviBsDVBFs+e/LBCnXit9vRSPPqYwDbO++mstrWIEwliNe
	 IytrKACZUfsGBnhxxgUVscBHvih8thLjbFsI5/28t00pFKJOPCQKaztfzl3lobiu5h
	 pcsTFYMxuUsKEwR6SOiFEKt1feI8p6FNjqU+8nIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfBADwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 22:52:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfBADwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 22:52:02 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16A9B20869;
        Fri,  1 Feb 2019 03:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548993122;
        bh=rhgHF5RLedZMnRabOaEfjkRX/2wgPbkQsDWtt7lw96Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mz917IEqjyn/7fznV0e/U0+45c5eowzWjHkXYfJEUxZQGEmwMZva0Pfuc04DS2biR
         YKO5RGsdZbb0ACsT5K6TF53+5AG8gCAAkT2MhQDyyTRTm8GKFVgboz6ilD18y/tkgq
         Ti/LtIc8aF61EgvwrEyXmgsLhtIPYomu4tO8h7QA=
Date:   Fri, 1 Feb 2019 11:51:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 5/5] arm64: dts: lx2160a: update fspi node
Message-ID: <20190201035148.GG19882@dragon>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547546584-5254-6-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547546584-5254-6-git-send-email-yogeshnarayan.gaur@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:05:35AM +0000, Yogesh Narayan Gaur wrote:
> Flash mt35xu512aba connected to FlexSPI controller supports
> 1-1-8/1-8-8 protocol.
> Added flag spi-rx-bus-width and spi-tx-bus-width with values as
> 8 and 8 respectively for both flashes connected at CS0 and CS1.
> 
> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>

Applied, thanks.
