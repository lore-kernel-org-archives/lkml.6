Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8188C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98FF21479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549863577;
	bh=FvQdnsYS6AZuendbS1RL03u7n4yaYMZ+qRCQPQqZkXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RW6xO1JT5swlP7R2UBmqReK8bRO14IrCUzYr/9UbywxeTG2iynf9IZ6VWuZC9aSMc
	 lJ/aXjtb/c7fPI4upyPd2B3rq7VH2ApHguRXihMd78xlFfqvK7BmEnWfqGOd4tbESH
	 6uI/vQwDD5tv3vyY+FzV/B4xHsnc70C1sXtbDlrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfBKFjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 00:39:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKFjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 00:39:36 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 642FF2146F;
        Mon, 11 Feb 2019 05:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549863574;
        bh=FvQdnsYS6AZuendbS1RL03u7n4yaYMZ+qRCQPQqZkXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fj1+dY2Gtu0lZIhnaHAbgyfqXPmB/heqFYFouuI31LdP34pZwL2o2aa/lKDOiIuJU
         S9LJhFjBh22m1BW3c839Z+dGYWumeJO95mcf3GJFgzMnMQ5sTe1NhxHN4/5H2sXiug
         Wytv44uboO1/yU3L1u15gTldguR7hmNXTNV2oU5Q=
Date:   Mon, 11 Feb 2019 13:39:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Andy Tang <andy.tang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v5 2/2] arm64: dts: lx2160a: add sata node support
Message-ID: <20190211053920.GM22487@dragon>
References: <20190125081013.21663-1-peng.ma@nxp.com>
 <20190125081013.21663-2-peng.ma@nxp.com>
 <20190201063011.GL19882@dragon>
 <VI1PR04MB44313B08539AA7081DC53BAFED640@VI1PR04MB4431.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB44313B08539AA7081DC53BAFED640@VI1PR04MB4431.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:53:18AM +0000, Peng Ma wrote:
> 
> 
> >-----Original Message-----
> >From: Shawn Guo <shawnguo@kernel.org>
> >Sent: 2019年2月1日 14:30
> >To: Peng Ma <peng.ma@nxp.com>
> >Cc: axboe@kernel.dk; robh+dt@kernel.org; mark.rutland@arm.com; Leo Li
> ><leoyang.li@nxp.com>; linux-ide@vger.kernel.org; devicetree@vger.kernel.org;
> >linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Andy Tang
> ><andy.tang@nxp.com>
> >Subject: Re: [v5 2/2] arm64: dts: lx2160a: add sata node support
> >
> >On Fri, Jan 25, 2019 at 08:10:13AM +0000, Peng Ma wrote:
> >> Add SATA device nodes for fsl-lx2160a and enable support for QDS and
> >> RDB boards.
> >>
> >> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> >> ---
> >> changed for V5:
> >> 	- no change
> >>
> >>  arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts |   16 +++++++
> >>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |   16 +++++++
> >>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    |   44
> >+++++++++++++++++++++
> >>  3 files changed, 76 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> >> b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> >> index 99a22ab..1a5acf6 100644
> >> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> >> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> >> @@ -95,6 +95,22 @@
> >>  	};
> >>  };
> >>
> >> +&sata0 {
> >> +	status = "okay";
> >> +};
> >> +
> >> +&sata1 {
> >> +	status = "okay";
> >> +};
> >> +
> >> +&sata2 {
> >> +	status = "okay";
> >> +};
> >> +
> >> +&sata3 {
> >> +	status = "okay";
> >> +};
> >> +
> >>  &uart0 {
> >>  	status = "okay";
> >>  };
> >> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> >> b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> >> index 6481e5f..5b6799e 100644
> >> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> >> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> >> @@ -102,6 +102,22 @@
> >>  	};
> >>  };
> >>
> >> +&sata0 {
> >> +	status = "okay";
> >> +};
> >> +
> >> +&sata1 {
> >> +	status = "okay";
> >> +};
> >> +
> >> +&sata2 {
> >> +	status = "okay";
> >> +};
> >> +
> >> +&sata3 {
> >> +	status = "okay";
> >> +};
> >> +
> >>  &uart0 {
> >>  	status = "okay";
> >>  };
> >> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> >> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> >> index a79f5c1..592034b 100644
> >> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> >> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> >> @@ -671,6 +671,50 @@
> >>  			status = "disabled";
> >>  		};
> >>
> >> +		sata0: sata@3200000 {
> >> +			compatible = "fsl,lx2160a-ahci";
> >
> >Has the kernel driver been patched to probe the compatible?
> >
> >Shawn
> Yes, the driver patch is http://patchwork.ozlabs.org/patch/1034083/

Ping me when the driver patch is accepted.  Ideally, we only accept dts
changes after the driver counterpart lands on mainline.

Shawn
