Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFC2C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B13208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/YbPpk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B13208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeJPAcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbeJPAcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:32:00 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 773622064A;
        Mon, 15 Oct 2018 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539621958;
        bh=729qZ7IhqGix8Y9+mNSNwCGe24G6QW+RYwfMIlNBjkc=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=K/YbPpk+4B4ZHYIU1c0av9EJZNgoAyFKdx/EOn0+dBicj/vtsfQPlK58azZ1M8ggI
         seQp+c93t2sfoD1IekQw1Q28j8WVxk+gfJYADTF2jecXBqnlCfEE0Xv259XmWW1ddm
         cuyNa+21Co7nm3S06OqTu/LP9pwiVSkmeuOSDlQU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <DB3PR0402MB39169A3BA844F7833B62FF55F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB44813C7A3E0AF4F3BCFFCF0088390@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <153567894721.93865.4092113232222931488@swboyd.mtv.corp.google.com>
 <a6489bda-703f-207c-0b24-60f4044fe89f@linaro.org>
 <153573827629.93865.6200966443862432044@swboyd.mtv.corp.google.com>
 <AM6PR0402MB391120110A289BA5FB6B9F0DF50C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <153898445180.119890.15025812558797341532@swboyd.mtv.corp.google.com>
 <DB3PR0402MB391664354775DF42E90E67C9F5E60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <153937368201.5275.2313781259297807972@swboyd.mtv.corp.google.com>
 <DB3PR0402MB39169A3BA844F7833B62FF55F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Message-ID: <153962195779.5275.17500455384946496344@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
Date:   Mon, 15 Oct 2018 09:45:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-10-15 02:33:35)
> > > > >
> > > >
> > > > Why can't we add clks to the op-tee node in DT's /firmware containe=
r?
> > > > Then any clks in there can be turned on forever and left enabled by
> > > > the linux driver?
> > >
> > > I did NOT run op-tee with Linux-next kernel before, can you advise mo=
re?
> > =

> > Neither have I, so I can't advise more.
> > =

> > > And I think if op-tee has such requirement, can we have another patch
> > > to cover it?
> > =

> > Yes.
> > =

> > =

> > > I believe all other i.MX platforms also have same requirements if
> > > considering op-tee support, so I think it should be another topic, wh=
at do you
> > think?
> > >
> > =

> > I'm going to drop these patches from my review queue. Please resend them
> > and please include the op-tee patches too.
> =

> =

> I do NOT know how to include the op-tee patch to meet special requirement=
, should
> the op-tee related patch be added later when someone actually add the op-=
tee support for i.MX7?
> It should NOT block this patch set, do you think we can add this patch se=
t first?
> =


Please resend the two patches. In the commit text for the second patch,
describe the plan to remove CLK_IS_CRITICAL from these clks by adding an
OP-TEE device/driver to the kernel to keep these clks enabled. My
understanding is that there isn't an OP-TEE driver right now, but these
clks are used by the firmware and can't be turned off in Linux. If in
the future we want to be able to turn them on and off, we'll need to add
them to an OP-TEE device node and have that driver manage the clks.

How that will work when a system doesn't enable the OP-TEE driver I'm
not sure. We may need to develop some system whereby clks like this are
handed from the clk controller to the consumer driver when it's enabled
for further power managment, but if they're never handed off, they're
kept on forever like is done here. Anyway, please resend with a note
about why these are marked CLK_IS_CRITICAL.

