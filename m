Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903ECC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EB920878
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="c1vXYQGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbfALBeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:34:12 -0500
Received: from onstation.org ([52.200.56.107]:40690 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfALBeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:34:11 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id C5F0714C;
        Sat, 12 Jan 2019 01:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547256851;
        bh=czdSZf8Zuuo91pWJ2elml0DYNVEA7xtelEEZiBh7+G0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c1vXYQGamJTvwojyR0dEZP5w3z9z0QrQN+xf8qzH1Q5No4guU1Nbfx4c58HLnK7nb
         IakmqUI2vbQV9orJugeHflswW9BoX6nuiR+/m9IBFoI0Veoliedv4hV0IOpew6ottU
         vxGgfD6PrxeWd2tczfw5osarlOxayfq3AQfYrOb8=
Date:   Fri, 11 Jan 2019 20:34:10 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/6] spmi: pmic-arb: convert to v2 irq interfaces to
 support hierarchical IRQ chips
Message-ID: <20190112013410.GA6726@basecamp>
References: <20190110011258.17227-1-masneyb@onstation.org>
 <20190110011258.17227-3-masneyb@onstation.org>
 <154724442941.169631.5308212449003169927@swboyd.mtv.corp.google.com>
 <20190111230004.GA5805@basecamp>
 <154724996786.169631.3834576842560322500@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154724996786.169631.3834576842560322500@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 03:39:27PM -0800, Stephen Boyd wrote:
> Ok sounds good. Can you also fix all the spmi-gpio specifying dts files?
> There are more than just two PMIC dts files that need changes (per my
> grep results sent to the list earlier).

Yes, I'll take care of all of them in the next version.

Brian
