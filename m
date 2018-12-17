Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEC0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEED2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545072055;
	bh=/6TLKhoYmyr9xh25j31W+MHdowTtKqPQoal8ILNWY1I=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=Y3b0pjZXBl+guLqR7EkxQbZgA0rUPYqz0rHkKzl4sIZWLYudEJFn831gpsMTk1wti
	 Ec7U8CRrV35OiMGhapyWdU2NVK9C1TzQxoJ6PCimNLAlg56bK5t4Ttvx4YgOVet+x1
	 Gr9Ah/xzAL4RMHB+gR9C3XEOVhH2S/SvQZrcVwO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeLQSky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:40:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728155AbeLQSkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:40:53 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A71D2086C;
        Mon, 17 Dec 2018 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545072053;
        bh=/6TLKhoYmyr9xh25j31W+MHdowTtKqPQoal8ILNWY1I=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=CM6FSfh7U7P163eFsuMZMSLoNUcfcUc3+fCBAGWT7+zodqXvOGNwjOlwC531XnHqt
         ZEu3nlfB73CakgZq/2KAKOzz7xVt17p15Edf+4Ia1ijS2lOiQza824fkWIJbzmHASa
         /FQhJ+JFjrPQfQjQfui0P7obKfYjJ//KuA7v7Blg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181217113539.nfwp4knbx3luxoqn@fsr-ub1664-175>
Subject: Re: [PATCH 0/3] clk: imx: Make all the parent_names arrays be const pointers
To:     Abel Vesa <abel.vesa@nxp.com>
References: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com> <154482171780.19322.123667425822315496@swboyd.mtv.corp.google.com> <20181217113539.nfwp4knbx3luxoqn@fsr-ub1664-175>
Message-ID: <154507205230.19322.658078387500141910@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Date:   Mon, 17 Dec 2018 10:40:52 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-12-17 03:35:40)
> On 18-12-14 13:08:37, Stephen Boyd wrote:
> > Quoting Abel Vesa (2018-12-14 07:30:08)
> > > This is mainly to shut up the checkpatch.pl script warnings about the
> > > "static const char *" needing to be "static const char * const".
> > >=20
> > > Abel Vesa (3):
> > >   clk: imx: Make parent_names const pointer in composite-8m
> > >   clk: imx: Make parents const pointer in mux wrappers
> > >   clk: imx8mq: Make parent names arrays const pointers
> > >=20
> >=20
> > I still see warnings though so there seems to be some more work to do.
> >=20
> > drivers/clk/imx/clk-imx8mq.c:401:89: warning: passing argument 5 of 'im=
x_clk_mux2' discards 'const' qualifier from pointer target type [-Wdiscarde=
d-qualifiers]
> >   clks[IMX8MQ_CLK_GPU_SHADER_SRC] =3D imx_clk_mux2("gpu_shader_src", ba=
se + 0x8200, 24, 3, imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader_s=
els));
> >=20
> Hmm, I guess you applied this on top of clk-imx8mq, right ?
> This change is against linux-next. The actual problem is the imx_clk_mux2
> which looks like this on branch clk-imx8mq:

Yes. It would be great if you could indicate where patches are
generated. In fact, I see that 'git format-patch' now has an option to
do just this!

	git format-patch --base=3Dcommit

>=20
> static inline struct clk *imx_clk_mux2(const char *name, void __iomem *re=
g, =20
>                 u8 shift, u8 width, const char **parents, int num_parents=
)  =20
>=20
> but it looks like this on linux-next (which is exactly the same on clk-ne=
xt):
>=20
> static inline struct clk *imx_clk_mux2(const char *name, void __iomem *re=
g, =20
>                         u8 shift, u8 width, const char * const *parents, =
   =20
>                         int num_parents)                                 =
   =20

Hrmm ok. I'll have to rejigger things and I probably won't be getting to
it until early next year.

