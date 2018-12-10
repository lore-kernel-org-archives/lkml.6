Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FD6C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7DA2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="phgxi0CT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7DA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeLJLM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:12:29 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:40675 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLJLM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:12:29 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 3062825B7DC;
        Mon, 10 Dec 2018 22:12:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544440345; bh=oRoU1UtWG/hI2sAcfvjea8bkUbn17Pq3e+Jpna+LddI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=phgxi0CTBMi1DTjVtsTkARUZs8Y+JxwjNDhNdG5Eo+HHO7J3YQdvUWvwdw8Vcazkv
         a2Rua12uj1v9EoivlakOXeyZ88Wlg3/R1Fl6JLDg0VfbtlHM5WVHodlI9z1Tr1az92
         g+yRRZI9HmagkS9futK/GHru3ZjlJnASvIXQzkiw=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 8D7B59402E1; Mon, 10 Dec 2018 12:12:23 +0100 (CET)
Date:   Mon, 10 Dec 2018 12:12:23 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Kumar Gala <kumar.gala@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 26/34] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
Message-ID: <20181210111223.fstjmazyo3vof7kc@verge.net.au>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-27-robh@kernel.org>
 <20181204144822.uqonsto45u7ysdu5@verge.net.au>
 <CAMuHMdV5brJyAmP0Bj7Bp7wruLNM1tSWkj_AyN5HCx4vdg-nrg@mail.gmail.com>
 <CAL_JsqJX9eb58piavQayXM5j5GXxsGxmy93m5oRKtghMFvkhuA@mail.gmail.com>
 <20181205194419.p6u56h57yk63xshj@verge.net.au>
 <CAL_JsqKHwYhHSb7GNFgOtBCqEeMshbRnU+0ONe_yW8OOiRC=SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKHwYhHSb7GNFgOtBCqEeMshbRnU+0ONe_yW8OOiRC=SA@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 01:38:42PM -0600, Rob Herring wrote:
> On Wed, Dec 5, 2018 at 1:44 PM Simon Horman <horms@verge.net.au> wrote:
> >
> > On Tue, Dec 04, 2018 at 09:08:57AM -0600, Rob Herring wrote:
> > > On Tue, Dec 4, 2018 at 8:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Tue, Dec 4, 2018 at 3:48 PM Simon Horman <horms@verge.net.au> wrote:
> > > > > On Mon, Dec 03, 2018 at 03:32:15PM -0600, Rob Herring wrote:
> > > > > > Convert Renesas SoC bindings to DT schema format using json-schema.
> > > > > >
> > > > > > Cc: Simon Horman <horms@verge.net.au>
> > > > > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > > Cc: linux-renesas-soc@vger.kernel.org
> > > > > > Cc: devicetree@vger.kernel.org
> > > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > > > ---
> > > > > >  .../devicetree/bindings/arm/shmobile.txt      | 151 ------------
> > > > > >  .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++++++++++++
> > > > > >  2 files changed, 218 insertions(+), 151 deletions(-)
> > > > > >  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
> > > > > >  create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > what is this based on? I get a conflict when applying the .txt change
> > > > > and if I knew the base for this patch it would be rather easy to work
> > > > > out what has changed.
> > >
> > > 4.20-rc2
> > >
> > > > >
> > > > > Also, should we do an s/shmobile.txt/shmobile.yaml/ in MAINTAINERS?
> > >
> > > Yes. Though it was pointed out that get_maintainers.pl can pull emails
> > > out of this file. We'd need to get that to work by default though.
> > >
> > > > Probably even s/shmobile.yaml/renesas.yaml/, while at it?
> > >
> > > Sure, if that's what you all want.
> >
> > How about this?
> 
> LGTM

Thanks.

As my tree is already closed for v4.21 I have applied this for v4.22.
