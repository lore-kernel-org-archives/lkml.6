Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C8DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934252086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550821692;
	bh=IWsGKyF6tSaXeD7/EpbCy6bONxy5c7yvq1SKZiasmCs=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=e4MI3AAeGu2ccsvFAGg2Yk3yvUj53BRD8effVliA6EtFu8X90+3uK7BzuuwJ5ZGHr
	 dWO6jh092CvLS+bAlRE2vGyNj/cVwOTyEqzxFWZroeHAmiy40uZQOY5eEYztNgJbFr
	 KR7ZzwgK6RkpokOCzILgIK5HnJ+wxKVDluzNpt2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfBVHsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:48:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:38254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfBVHsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:48:10 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF37D207E0;
        Fri, 22 Feb 2019 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550821689;
        bh=IWsGKyF6tSaXeD7/EpbCy6bONxy5c7yvq1SKZiasmCs=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=mHvlPgvXH8lhnQQ1MiSPkgg8nvk+Zdl0Mb0WdNqeFG4q1IHioJEte91aC+pPZ97FA
         pg7IaKaMq3tF5+/fx2rP08nVw3X2Jkeg5EHZt2el9yPHz8pDT7tcbuL3eS0UbK1okE
         Zr4iYUnV64ou6Om4hls2Zp0t6SKvB59wHEJm2U44=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 00/12] Mediatek MT8183 clock and scpsys support
Message-ID: <155082168901.77512.12893153125579041936@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190201083016.25856-1-weiyi.lu@mediatek.com> <20190201083016.25856-2-weiyi.lu@mediatek.com> <155069033021.77512.14493210110678229730@swboyd.mtv.corp.google.com> <b7abe484-71c1-5ec0-796c-544f1ac5d6f5@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <b7abe484-71c1-5ec0-796c-544f1ac5d6f5@gmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org
Date:   Thu, 21 Feb 2019 23:48:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Brugger (2019-02-21 00:36:24)
>=20
>=20
> On 20/02/2019 20:18, Stephen Boyd wrote:
> >=20
> > What's the merge plan here? Do you want me to apply these patches to clk
> > tree? Will someone be sending me a pull request for mediatek clk changes
> > this cycle? It's getting pretty late for much of anything making this
> > upcoming merge window.
> >=20
>=20
> As far as I can see, the clock patches are independent, so I think it is =
OK to
> take them. SCPSYS patches will go through my tree once they are in shape.

Ok great. When patches for clks are interspersed throughout the patch
series it makes me think that something later in the series depends on
something that isn't a clk patch so then I can't apply it.

>=20
> Do you prefer to get pull requests for clock patches? I wasn't aware of t=
hat.
> But if you prefer that, we can find someone who prepares every merge wind=
ow a
> pull request.
>=20

I don't really care one way or the other about pull requests vs.
manually applying patches. It helps if someone wants to pick the patches
up and send them along when there are complex dependencies between the
clk patches and dts bits or something like that. It also helps if
there's someone else with knowledge of the particular SoC saying "these
are good, please pull these patches". Subsystem maintainers obviously
aren't experts in all SoCs and their various quirks, plus datasheets
aren't always so widely available, so sharing the load with SoC
maintainers who are familiar with the hardware usually makes a lot of
sense.

Otherwise, if you just want to put your "Reviewed-by" tag on any patches
that look good and are sane then I'll quickly understand that these
patches are good and that I should pick them up into the clk tree from
the list. Just please communicate one way or the other about patches
that you care about because it helps to know if they've gotten attention
or not.

