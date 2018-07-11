Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B59C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486572087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="szpFUiur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486572087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbeGKIqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbeGKIqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:46:52 -0400
Received: from dragon (unknown [45.56.152.98])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B5F8208E3;
        Wed, 11 Jul 2018 08:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531298619;
        bh=AveurC0RcrH8J64vH2fjxdVwuEsbX5l9Z70zqb+buas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=szpFUiurUUjHWtv6ZjYLPmhUDoKvT/4wudojwvipgjptZT64mE8eS8O+kk4OPrfOz
         XEC2a9+Gr6n5SXlR0MrfLsRgJycR/mwfn8q9HJdPqEQKQC6BKy6xhgajGgSNQHsoNF
         1zArNih+EdXS1M4iKAzkCXpHpudYX9Er5ZiFFpbU=
Date:   Wed, 11 Jul 2018 16:43:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>, aisheng.dong@nxp.com,
        fabio.estevam@nxp.com, kernel@pengutronix.de, mark.rutland@arm.com,
        mturquette@baylibre.com, ping.bai@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: imx6sll: add GPIO LPCGs
Message-ID: <20180711084302.GB6959@dragon>
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
 <153091072630.143105.2849049240391576710@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153091072630.143105.2849049240391576710@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 01:58:46PM -0700, Stephen Boyd wrote:
> Quoting Anson Huang (2018-06-21 23:32:33)
> > According to Reference Manual Rev.0, 06/2017,
> > there are GPIO LPCGs defined in CCM CCGRs,
> > add them into clock tree.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> 
> Applied to clk-next

Stephen,

If you can apply this patch to topic branch 'clk-imx-gpio-gates', I will
be able to pick up patch #2 for this cycle.

For future cycles, I think the topic branch can be named more generic,
so that any clk patches that DT ones have a dependency on can go there.
And then I can apply all those DT patches by pulling in this topic
branch.

Shawn
