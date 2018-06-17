Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BB0C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D5E208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn7qD1Xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D5E208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932321AbeFQHQo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 03:16:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932096AbeFQHQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 03:16:43 -0400
Received: from dragon (unknown [45.56.152.75])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC6320864;
        Sun, 17 Jun 2018 07:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529219802;
        bh=JYcCcIociiqxFaflSQtXKszJP026cXyTVO3bX0BApu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gn7qD1XrAsKz8mYqu56WrfufQIO76a3fJJbhXlhYvrqZA1AA7iLtcJEBqlVHhvoEj
         iTvnVhmENWjbxgcAdpwe7wwxpErqUpQ27dGTWJFFhGw8aNwnupXVvGrkFhbHF5eE+b
         wkbPEnJwGNEUOsxNWDjRnxVw4YSRSCWvaiFN8u9c=
Date:   Sun, 17 Jun 2018 15:15:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: imx51-zii-rdu1: Make sure SD1_WP is low
Message-ID: <20180617071550.GN16091@dragon>
References: <20180526021238.30753-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180526021238.30753-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 07:12:38PM -0700, Andrey Smirnov wrote:
> Make sure that MX51_PAD_GPIO1_1 does not remain configure as
> ALT0/SD1_WP (it is out of reset). This is needed because of external
> pull-up resistor attached to that pad that, when left unchanged, will
> drive SD1_WP high preventing eSDHC1/eMMC from working correctly.
> 
> To fix that add a pinmux configuration line configureing the pad to
> function as a GPIO. While we are at it, add a corresponding
> output-high GPIO hog in an effort to minimize current consumption.
> 
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Applied, thanks.
