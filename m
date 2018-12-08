Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D089C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 01:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BFC208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 01:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544234364;
	bh=3ww473EUpiQ8Yk4SLFmXFffC7WSJZKms8gyXDBI3jkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0iTJ9xAL7aj0OXcbzlLvHYv8TwIz5cU2nefTrkeuV0IF+SkilpHytmyre9hi5lO4e
	 2eTaDk4EES3J5F2KtkNW2szCApLHmoZP1dg9dUhro1o9eiYCGyQg7NSxWNFjHD77t+
	 2LqwPaZMdf6jb8VfijG4YxsfUw4+9AtS0T4c9Vuk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BFC208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeLHB7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 20:59:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbeLHB7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 20:59:22 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A4120868;
        Sat,  8 Dec 2018 01:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544234361;
        bh=3ww473EUpiQ8Yk4SLFmXFffC7WSJZKms8gyXDBI3jkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hq+LB5HRgreQXXjD3feH96P6iHCjOFajJi/mi+isJsKaf0mmF8lsogPERyTW4Pbof
         CRLQsbZY+m47bLTw3cdqwuPmKguNQH3w0Psz4H374kVnpOWADbMAU11UpCwMqpsLeb
         fw0L6qMZHFpZ0E1m87/ICl/4f90MiVA8Dx2PC7Jc=
Date:   Sat, 8 Dec 2018 09:58:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 18/34] dt-bindings: arm: Convert FSL board/soc
 bindings to json-schema
Message-ID: <20181208015835.GM3987@dragon>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-19-robh@kernel.org>
 <20181206023140.GZ3987@dragon>
 <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 05:33:13PM -0600, Rob Herring wrote:
> On Wed, Dec 5, 2018 at 8:32 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Mon, Dec 03, 2018 at 03:32:07PM -0600, Rob Herring wrote:
> > > Convert Freescale SoC bindings to DT schema format using json-schema.
> > >
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/arm/armadeus.txt      |   6 -
> > >  Documentation/devicetree/bindings/arm/bhf.txt |   6 -
> > >  .../bindings/arm/compulab-boards.txt          |  25 --
> > >  Documentation/devicetree/bindings/arm/fsl.txt | 229 ------------------
> > >  .../devicetree/bindings/arm/fsl.yaml          | 214 ++++++++++++++++
> >
> > Rob,
> >
> > I do have any changes on bindings/arm/fsl.txt queued for 4.21 on my
> > tree, so please send it via your tree.
> 
> What about:
> 
> c386f362957b dt-bindings: Add compatible string for LS1028A-QDS
> 3671cd57de06 dt-bindings: ls1012a: Add FRWY-LS1012A device tree binding

Ah, sorry, I only checked on imx/dt branch and forgot imx/dt64.  I will
drop the changes on fsl.txt and update fsl.yaml after it hits mainline.

Shawn
