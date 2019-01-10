Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF33C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7F22173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547102592;
	bh=RVtjTyJLKGFZRuEyHVwDNC25dNgB7DPh3M6yv0AsL0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ahelKt+MZeG5UmMWg8BSG9dHqhHP1NhUxCeH1MNSYoaRY3DU97yiJjrafy3erbLi8
	 ZYdrHBZNEAbmY4L8TqCSb3DNBidsQE5B1vjxFuRnsPWbtMOFkJ9slwXzWO0WedZinQ
	 hUPmEGyRiXP5p3RituJ8VRP1UmUp8+cyKi54gFhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfAJGnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:43:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAJGnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:43:10 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D3C8214DA;
        Thu, 10 Jan 2019 06:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547102589;
        bh=RVtjTyJLKGFZRuEyHVwDNC25dNgB7DPh3M6yv0AsL0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEC0+MYihO2xcOYklPJZ2ZAwMQn9gHz1qI2dN5IOd0aminomj7v2FH99hb7vho2jG
         h4Xz5yD8faC9jCETbZfSQUGFeU47X5slJpmp2VP2GPaVkDUWJE19ohXjEKa3Mu22aF
         Ibw5h3xxK5g2mBet7l395qed6BpaYq3WfkIZ50L0=
Date:   Thu, 10 Jan 2019 14:42:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Kumar Gala <kumar.gala@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 18/34] dt-bindings: arm: Convert FSL board/soc
 bindings to json-schema
Message-ID: <20190110064256.GA25218@dragon>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-19-robh@kernel.org>
 <20181206023140.GZ3987@dragon>
 <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
 <20181208015835.GM3987@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208015835.GM3987@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 09:58:37AM +0800, Shawn Guo wrote:
> On Thu, Dec 06, 2018 at 05:33:13PM -0600, Rob Herring wrote:
> > On Wed, Dec 5, 2018 at 8:32 PM Shawn Guo <shawnguo@kernel.org> wrote:
> > >
> > > On Mon, Dec 03, 2018 at 03:32:07PM -0600, Rob Herring wrote:
> > > > Convert Freescale SoC bindings to DT schema format using json-schema.
> > > >
> > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: devicetree@vger.kernel.org
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  .../devicetree/bindings/arm/armadeus.txt      |   6 -
> > > >  Documentation/devicetree/bindings/arm/bhf.txt |   6 -
> > > >  .../bindings/arm/compulab-boards.txt          |  25 --
> > > >  Documentation/devicetree/bindings/arm/fsl.txt | 229 ------------------
> > > >  .../devicetree/bindings/arm/fsl.yaml          | 214 ++++++++++++++++
> > >
> > > Rob,
> > >
> > > I do have any changes on bindings/arm/fsl.txt queued for 4.21 on my
> > > tree, so please send it via your tree.
> > 
> > What about:
> > 
> > c386f362957b dt-bindings: Add compatible string for LS1028A-QDS
> > 3671cd57de06 dt-bindings: ls1012a: Add FRWY-LS1012A device tree binding
> 
> Ah, sorry, I only checked on imx/dt branch and forgot imx/dt64.  I will
> drop the changes on fsl.txt and update fsl.yaml after it hits mainline.

What happened to this?  It seems the patch did not hit v5.0-rc1.

Shawn
