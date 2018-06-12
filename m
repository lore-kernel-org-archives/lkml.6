Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A8466C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594E8208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLjdTwh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594E8208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933642AbeFLIGK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932448AbeFLIGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:06:07 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79290208AE;
        Tue, 12 Jun 2018 08:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528790766;
        bh=5MPTtyPLiYyKcB+P773fbgkaUcTxiGa+T3/9wU23G4Q=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=jLjdTwh+UZ6rBKBJUIoDHPXWz8zHgpXgIOim7ko5n4BpLudVccT0N7Krxt6gq1tMr
         hT5yPKD34tl3vZkJZGxPsyBEsy7M/Dk66OwOQlpOt6mtk+dT42YbIplJ2rpFccHjJ8
         S+HlKaCyUOVgVZPvNmSQAsg3o6e3+VfSl6tmjpKs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <18f6871e-794d-3ea2-487e-32399a8b89b4@microchip.com>
Cc:     devicetree@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Cristian.Birsan@microchip.com
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
 <1527251668-31396-2-git-send-email-codrin.ciubotariu@microchip.com>
 <20180531005827.GA17203@rob-hp-laptop>
 <4f2e6e6a-df3a-b645-093c-b4467b3aa843@microchip.com>
 <CAL_JsqJ=T0p17hHg6=obtydt7T-yrAeOr7C2XAEnDFQ-c0b5XQ@mail.gmail.com>
 <152778070837.144038.4555982304713569160@swboyd.mtv.corp.google.com>
 <CAL_JsqJu6=ORfutZ5tAyNp2q2rH6P+fgJMRKw750RyFy=ptjPw@mail.gmail.com>
 <18f6871e-794d-3ea2-487e-32399a8b89b4@microchip.com>
Message-ID: <152879076578.16708.6230985334183790836@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 1/7] dt-bindings: clk: at91: add an I2S mux clock
Date:   Tue, 12 Jun 2018 01:06:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Codrin Ciubotariu (2018-06-07 03:30:14)
> > =

> > Seems to me that clock additions could use a new binding and we start
> > with a new driver that handles these few clocks initially. But I
> > haven't looked whether both can coexist.
> =

> Mark already applied to broonie/sound.git the I2S bindings that have a =

> phandle to this clock. If I am to change #clock-cells to 1, I will have =

> to change the bindings to include the clock-id.
> Which approach should I take now?
> =


You're talking about changing the example in the binding doc? That
doesn't really matter. Consumer side of the provider has to match the
cell count from the provider so it doesn't really need to be 'fixed' in
the example at all.

