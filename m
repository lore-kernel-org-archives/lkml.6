Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADDFC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC1F20883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEroMZfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC1F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeKHJvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 04:51:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbeKHJvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 04:51:24 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C221920857;
        Thu,  8 Nov 2018 00:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541636315;
        bh=5EcHBJnt2DElKwb4wIMaw0nqYsASQVDi5jteDm87mc4=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=nEroMZfuZSgpoUXwCujGYKuNCrjidcqMdgOzS5vyoXWFJUm+lGzTjNBhUqbH8H82S
         fYLigVB+kwLW7f/+VB3IIWdSUzYn4wQsoOxPdAbNXO8Ig64LvihzqY56ghGmHOpORN
         uewn2xci3UCpF4aboNvZlQGnjeuubvj2uJnLCKO0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Abel Vesa <abel.vesa@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181107202624.oya2runvbbwcilzu@fsr-ub1664-175>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abelvesa@linux.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-4-git-send-email-abel.vesa@nxp.com>
 <153980615257.5275.13866740376184829057@swboyd.mtv.corp.google.com>
 <20181107115444.gscxwud7e57nx3c7@fsr-ub1664-175>
 <154161726247.88331.15629902810537417880@swboyd.mtv.corp.google.com>
 <20181107202624.oya2runvbbwcilzu@fsr-ub1664-175>
Message-ID: <154163631513.88331.1765456171211364913@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v9 3/5] clk: imx: add SCCG PLL type
Date:   Wed, 07 Nov 2018 16:18:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-11-07 12:26:25)
> On Wed, Nov 07, 2018 at 11:01:02AM -0800, Stephen Boyd wrote:
> > =

> > =

> > What's the plan to clean it up?
> =

> So I'm doing this in our internal tree first to make sure I don't break t=
he
> other (newer) socs.
> =

> I already have a prototype in testing but it's a long way to upstream it.
> =

> Basically, I'm replacing all of this with a single, more like a composite,
> more complex, clock type that does all the magic inside.
> =

> One of the problems is the fact that the bypasses can have the same sourc=
es
> and in my case, I'm implementing that as a list of parents name, but the
> parent names list doesn't work with duplicates, so I have to find some ot=
her
> way to do it.
> =

> Once I have something clean and tested enough I'll send it upstream.

Ok. Thanks for the info.

