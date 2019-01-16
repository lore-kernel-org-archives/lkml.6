Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E08C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0BF20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547633712;
	bh=YEROV+6MnUwf6k5Mty8tQcmS9XNDA+2/kv68s0kIq1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gG/KVvMMqNhgPXm6gMxCeGpsPh+OuMwWEqN29fG8ihbrM89N6iSOWPXdx1RaBCYIF
	 JPRTXnVyGhED7VaCe0YuEOs2aGbkJoWGxdoqRpNqWatxXQsLyfW/1cWDoNSj8eDth2
	 PBOT4g9qac26+OJgLL4TQci39anq+xAzgqwwxIFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389454AbfAPKPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:15:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731943AbfAPKPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:15:10 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FF9820840;
        Wed, 16 Jan 2019 10:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547633709;
        bh=YEROV+6MnUwf6k5Mty8tQcmS9XNDA+2/kv68s0kIq1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RVvxRVJo5aYsOxVEqKFbZhXds0p/xXJD4YcnnOnzWrEtCP3cgBFGJOynn6lhsUs7X
         +UXqtXA/tiqDRVyw+bxh49+ecqnAFUCfACl9ofMkKYIGVmVd9NOfFCXbunDGq4FQ6F
         FNGCbbz0Q0MWFsCNsEFvqgtjmFR+g+U/rcvu23mQ=
Date:   Wed, 16 Jan 2019 18:14:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yang-Leo Li <leoyang.li@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        a.tropschug@ebs-systart.com, m.bittner@ebs-systart.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
Message-ID: <20190116101441.GH15808@dragon>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
 <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
 <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
 <20190116022100.GC15808@dragon>
 <CAL_Jsq+myeZ1n4X=KhHZjtPDHnGH=L65xxYbzMrt8Rq6Bur4Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+myeZ1n4X=KhHZjtPDHnGH=L65xxYbzMrt8Rq6Bur4Bg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:07:12PM -0600, Rob Herring wrote:
> On Tue, Jan 15, 2019 at 8:21 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Mon, Jan 14, 2019 at 12:02:47PM -0600, Rob Herring wrote:
> > > On Mon, Jan 14, 2019 at 4:21 AM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > Add devicetree binding for Oxalis board in JSON format. While adding
> > > > that, let's fix the description for LS1012A also.
> > > >
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/fsl.yaml | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > index d34fe0749199..0f30142fe316 100644
> > > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > @@ -173,12 +173,13 @@ properties:
> > > >                - fsl,vf610
> > > >                - fsl,vf610m4
> > > >
> > > > -      - description: LS1021A based Boards
> > > > +      - description: LS1012A based Boards
> > >
> > > Well, yes that was wrong...
> > >
> > > >          items:
> > > >            - enum:
> > > >                - fsl,ls1012a-rdb
> > > >                - fsl,ls1012a-frdm
> > > >                - fsl,ls1012a-qds
> > > > +              - ebs-systart,oxalis
> > >
> > > Sort alphabetically.
> > >
> > > >            - const: fsl,ls1021a
> > >
> > > And this is wrong too.
> > >
> > > I you just change it, then we will be missing an entry for LS1021A.
> > > What's the status of that SoC because there is no board dts file? We
> > > should not have .dtsi files in the kernel which don't get built.
> >
> > Hmm, I do not see any LS1021A SoC .dtsi in the tree.  I suspect it's
> > just a typo of LS1012A.
> >
> > @Leo, do we have a LS1021A SoC?
> 
> arch/arm/boot/dts/ls1021a.dtsi

Oops, I only searched arm64 folder.

So it seems the compatible of the boards below are missing there.

  ls1021a-moxa-uc-8410a.dts
  ls1021a-qds.dts
  ls1021a-twr.dts

Shawn
