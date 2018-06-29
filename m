Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2B5C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CF427B69
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0uNBb9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CF427B69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755433AbeF2Sjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752683AbeF2Sjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:39:40 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 737C127B65;
        Fri, 29 Jun 2018 18:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530297579;
        bh=rb+R4SudsnFv2Ety35jgpTThtRvJZg3IaZHQfSZbX4o=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=m0uNBb9ZdysN7wtVcaxKd7/JdjXqm3CqMuIsh1BNJniJg4hmCO0wrmwyBhmCP3XMx
         qI+HgEjywz+pV9qWVY3yeslZvpAPum2WHo0hTGPFsqkTfzBdTuux06UNNmTMmXvbWI
         oUnco3JPRkqPWbRWmG2ehQaO0V5iFWqRbY0dTe4M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Anson Huang <anson.huang@nxp.com>, Shawn Guo <shawnguo@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180628005217.GC22683@dragon>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "matteo.lisi@engicam.com" <matteo.lisi@engicam.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
 <1527990245-13619-2-git-send-email-Anson.Huang@nxp.com>
 <AM3PR04MB1315D8B57E1A5D47BECBDCD3F54A0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <20180628005217.GC22683@dragon>
Message-ID: <153029757874.143105.17774476792947607999@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2 2/2] ARM: dts: imx6ul: add GPIO clocks
Date:   Fri, 29 Jun 2018 11:39:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shawn Guo (2018-06-27 17:52:18)
> On Mon, Jun 25, 2018 at 03:14:39AM +0000, Anson Huang wrote:
> > Gentle Ping...
> =

> I cannot apply this dts patch until the clock patch is landed on
> mainline, because it has a dependency on new clock ID IMX6UL_CLK_GPIO1
> created by clock patch.
> =


Does it matter if that clk ID changes across branches? Or is everything
good if it just exists as some number? The patch adding the define
conflicts with another patch to fix the numbering scheme to be
incremental instead of changing IMX6UL and IMX6ULL which is annoying.
I'll probably make a topic branch just for the fix and merge it into
clk-fixes and this branch so you can pick it up from there if you like.
