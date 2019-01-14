Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B694DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9B420657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547502914;
	bh=8xGbSw414rVINc77HwxSQPE88V4EOEo6pGoxgRcjJTQ=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=Gm2/Uy2Chp565uOHOcjjugdzKU8iuIQT6NhbHGgSsgj220h+/7PQQ0quFvGzkBayn
	 wbMEwWOTVLWFqxmGLuY1SWHx/NMQsgak67C6DnrPNP9cGs4x4z/5fUKqsbt19Z5dOD
	 8obYE+4xrVei0VgEPoZjIAPzESZQFzcqcnQFMK74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfANVzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:55:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfANVzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:55:12 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 266F520657;
        Mon, 14 Jan 2019 21:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547502911;
        bh=8xGbSw414rVINc77HwxSQPE88V4EOEo6pGoxgRcjJTQ=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=EXIGT37SMG06yPPTlbsFMkfS0YiL6Fr1c2r5sztdU7rJMADYnYW2ofTbM97vZKRVM
         QLJcoJ5sBos87VqIlS8Hk6uB/UB13aW4QN9CQP8+2ynhjCoeUvODCpp+RWJ95lU8vm
         Lg6LAFIWFBtxW3VS4lXGXTjsGpHAfUSQv+rbVhhc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/6] Add clock support for Actions Semi S500 SoC
User-Agent: alot/0.8
In-Reply-To: <20190114091850.GB13162@Mani-XPS-13-9360>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org> <154724706468.169631.2903523518830581075@swboyd.mtv.corp.google.com> <20190114091850.GB13162@Mani-XPS-13-9360>
Cc:     afaerber@suse.de, mturquette@baylibre.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Message-ID: <154750291027.169631.13825540584530234373@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Mon, 14 Jan 2019 13:55:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-01-14 01:18:50)
> Hi Stephen,
>=20
> On Fri, Jan 11, 2019 at 02:51:04PM -0800, Stephen Boyd wrote:
> > Quoting Manivannan Sadhasivam (2018-12-31 10:55:11)
> > > Hello,
> > >=20
> > > This patchset adds common clock support for Actions Semi S500 SoC of
> > > the Owl family SoCs. This series is based on the initial work done
> > > by Edgar Bernardi Righi. https://patchwork.kernel.org/cover/10587527/
> > >=20
> > > Since there isn't any update from him for long time, I took the liber=
ty
> > > to modify his patches, address review comments and send to list for r=
eview.
> > >=20
> > > This series has been tested on Allo Sparky SBC.
> > >=20
> > > Thanks,
> > > Mani
> > >=20
> > > Edgar Bernardi Righi (1):
> > >   dt-bindings: clock: Add DT bindings for Actions Semi S500 CMU
> > >=20
> > > Manivannan Sadhasivam (5):
> > >   clk: actions: Add configurable PLL delay
> > >   ARM: dts: Add CMU support for Actions Semi Owl S500 SoC
> > >   ARM: dts: Remove fake UART clock for S500 based SBCs
> > >   clk: actions: Add clock driver for S500 SoC
> > >   MAINTAINERS: Add linux-actions mailing list for Actions Semi
> >=20
> > What's the merge strategy for these patches? Some are for clk, others
> > are for arm-soc, etc. I see a sandwich of patches too so it sounds like
> > I can't even take just the clk ones for fear of breaking something that
> > the dts bits in the middle clear out of the way.
> >=20
>=20
> As we did with previous patchsets, clk patches will go through your tree
> and I'll take the ARM/MAINTAINERS patches through Actions sub-tree. Let's
> target these for 5.1. Even if your patches reach first, there won't be
> any regression with existing DTS.
>=20

Ok. I have just minor nits. Please resend and I will merge the clk
patches to clk tree.

