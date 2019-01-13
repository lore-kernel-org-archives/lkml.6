Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28329C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E1A20879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547350376;
	bh=1NZfcTJfy6jwehJMGMw2TXJUQ8ZC/HS2vJm9YzSTjFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d4eNKdnPs3Ldd4c2Zmp5qYJtM6E+e5aJpOxtWkJBNZsqAhEwjQaF9eqwtx8TOEm1V
	 U7UE9a05flgbuFn9l9D9bX/c6fi9LXFZEzzIAVKggq4PN0uKcJkE5wLJ8DkCHUZQOH
	 q3Bd9rDtV7C6Rci9RXIDrZMmBSDl+bHmOsQTsCk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfAMDcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 22:32:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfAMDcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 22:32:51 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E99920842;
        Sun, 13 Jan 2019 03:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547350371;
        bh=1NZfcTJfy6jwehJMGMw2TXJUQ8ZC/HS2vJm9YzSTjFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v2Bw7vNZbAjscU3NJVpMo/OcpuQNJpI4i1HP+TXXUZAblW8bXKoAZ54s9+TqS6U4Z
         7eyZrRAQpfGbmEGXQaRUFllkpAtuRwtvrES9pVvEsk/f2ZfBzTQMGZQyICx65cfaZm
         XCm8n678zEOvG0lR38K+HZVnoPPKSO2yT9tUOmXo=
Date:   Sun, 13 Jan 2019 11:32:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 6/7] ARM64: dts: ls1046a: Remove
 fsl,qspi-has-second-chip as it is not used
Message-ID: <20190113033231.GH11426@dragon>
References: <20190107092823.11188-1-frieder.schrempf@kontron.de>
 <20190107092823.11188-7-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107092823.11188-7-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 09:29:55AM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> After switching to the new FSL QSPI driver the property
> 'fsl,qspi-has-second-chip' is not needed anymore.
> 
> The driver now uses the 'reg' property to determine the bus and
> the chipselect.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Different from arm dts files, we use prefix 'arm64: dts: ...'.
I fixed it up and applied the patch.

Shawn
