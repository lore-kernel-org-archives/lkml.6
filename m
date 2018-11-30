Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568F2C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E4A21473
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRvmMs1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E4A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeK3UKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:10:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbeK3UKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:10:13 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 302D22081C;
        Fri, 30 Nov 2018 09:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543568496;
        bh=z7ZMoAq19vmH3A1/zQs+6k+Ktk2GMcuznI9k8LAfS6o=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=bRvmMs1K3ppP2hC1UnOYDaFoq4nYEWzCw4miFwjtB4gFsB/OIqFCfFffbYiKrXPcI
         13ky3IA5G/G1vhE9Xv7DTwghfjH5m3U1n+UBvVOdifW7fRiTPL8/ifQ4Zywa4eTsrL
         IYqWoHUOnofEJUqlLpdCuB83uE6iFJP+zhPRSOrY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Douglas Anderson <dianders@chromium.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181127192443.136158-1-dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org
References: <20181127192443.136158-1-dianders@chromium.org>
Message-ID: <154356849500.88331.9932899465368459791@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] dt-bindings: clock: Require #reset-cells in sdm845-videocc
Date:   Fri, 30 Nov 2018 01:01:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-11-27 11:24:43)
> The #reset-cells was listed as optional in the bindings for
> qcom,sdm845-videocc.  There's no reason for it to be optional.  As per
> Stephen [1]:
> =

> > We should update the binding to make it a required property. It
> > doesn't make any sense why that property would be optional given
> > that the hardware either has support for resets or it doesn't.
> =

> sdm845 support is still in its infancy so we shouldn't be affecting
> any real device trees by modifying the bindings here.
> =

> [1] https://lkml.kernel.org/r/154330186815.88331.12720647562079303842@swb=
oyd.mtv.corp.google.com
> =

> Fixes: 84b66b211603 ("dt-bindings: clock: Introduce QCOM Video clock bind=
ings")
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Applied to clk-next

