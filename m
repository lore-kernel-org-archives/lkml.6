Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D98C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72242146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550690334;
	bh=eRPNh/bRa6C0yoDIx0S8voS4NjKQdfvhWqmC35Kco/g=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=L1h3VulzzCoWEkd3kmvDqpDbimKob3L8qyeGkE1akGRUHw0RXI9OfTQrYJr4r028i
	 UNCuIRbfIAKP8ITHorDJdf8bcTpRcRcvHGILzMfmiryfeGGL/3JX8qDOQPIgTRumgh
	 m/PfB6DXEdE9b3v2iqo9Z7loGZ6OGTshqm8NQJsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfBTTSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:18:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfBTTSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:18:51 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 130A12146E;
        Wed, 20 Feb 2019 19:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550690331;
        bh=eRPNh/bRa6C0yoDIx0S8voS4NjKQdfvhWqmC35Kco/g=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=KdeDsZ3+1noDRzPa9as3KBZst9Qo+Bsfx+dBJTkbE6Eityyt+uPaXcYRqevnYReHV
         4rm1XkdrcKPFtCCa5KXQteBHiBxe5KgEiuTHrl+mQKN9TlDlsyP9WiKN8ZYOxQoEPq
         +ZgTs/cLz1SY/aSzb1c3rPPVNzcmk2Y4aOX+zv74=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 00/12] Mediatek MT8183 clock and scpsys support
Message-ID: <155069033021.77512.14493210110678229730@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190201083016.25856-1-weiyi.lu@mediatek.com> <20190201083016.25856-2-weiyi.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190201083016.25856-2-weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org,
        Weiyi Lu <weiyi.lu@mediatek.com>
Date:   Wed, 20 Feb 2019 11:18:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2019-02-01 00:30:04)
> This series is based on v5.0-rc1 and most of changes are extracted from s=
eries below
> (clock/scpsys common changes for both MT8183 & MT6765)
> https://patchwork.kernel.org/patch/10528495/
> (clock support of MT8183)
> https://patchwork.kernel.org/patch/10549891/
>=20
> The whole series is composed of
> clock common changes for both MT8183 & MT6765 (PATCH 1-3),
> scpsys common changes for both MT8183 & MT6765 (PATCH 4),
> clock support of MT8183 (PATCH 5-8),
> scpsys support of MT8183 (PATCH 9-11) and
> resend a clock patch long time ago(PTACH 12).

What's the merge plan here? Do you want me to apply these patches to clk
tree? Will someone be sending me a pull request for mediatek clk changes
this cycle? It's getting pretty late for much of anything making this
upcoming merge window.

