Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DD4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6478E21736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="oaiWO3Ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfAGLaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:30:09 -0500
Received: from onstation.org ([52.200.56.107]:48462 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfAGLaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:30:09 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 23A23347;
        Mon,  7 Jan 2019 11:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1546860608;
        bh=awfFrwnCuDopimp6qrJGoBJ4YMMI366NAohO/oPtqM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oaiWO3KaszqtgMTpyGUbjKj3PU3mR0G30juKHesSjglcCj+b5u2pbjueJ2Tf3uUeB
         8XzQ3m5X2Q37FJR2b9nOCUhF8o7wYHLDpk+TCJs1PS4Uk7VdzuxZ7vy5+KE+keBpbB
         9bommviaSZjsqQyoyYe0cp9IhaGDE8SpBKJvGnFo=
Date:   Mon, 7 Jan 2019 06:30:07 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] mfd: qcom-spmi-pmic: use devm_mfd_add_devices
 instead of devm_of_platform_populate
Message-ID: <20190107113007.GA1284@basecamp>
References: <20190107021145.6370-1-masneyb@onstation.org>
 <20190107021145.6370-3-masneyb@onstation.org>
 <CACRpkdbLU_2JC1wT=M7EPsx6gPxL=poj2Ci8zTa++51K2qGZ4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbLU_2JC1wT=M7EPsx6gPxL=poj2Ci8zTa++51K2qGZ4A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:53:07AM +0100, Linus Walleij wrote:
> I suppose Lee can merge this in orthogonal in the MFD tree,
> the end result will be functional after the v5.1 merge window.

To keep git bisect happy, it would be nice if either all of the patches
go in through the same tree (with the proper ACKs), or if the first four
patches are applied during the v5.1 merge window, and the last patch is
applied during the v5.2 merge window.

Brian
