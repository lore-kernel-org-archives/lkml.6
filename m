Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0759C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9918F20868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJWVMQVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfAWA0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:26:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37946 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfAWA0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:26:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so224111pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zHQqa/+X9U/i+PXpqlIOsr5wN9zoDfeCi2jk94VmOSQ=;
        b=dJWVMQVV2NA1MWu+6qhO0JjMBJO4RFj2eiTMMeIU54h3jrjnRuWfC7R1cGCKu1ptRr
         A3bChCqNWAE7JT2Ru0n9pXvoJzOk+UKorAu7UawAs/Pmed4vKTJUEVX8mu2zVFZNGb3T
         nn06mciNdy5t/Dt2eAUgFRYC9w9qUnHit8bPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zHQqa/+X9U/i+PXpqlIOsr5wN9zoDfeCi2jk94VmOSQ=;
        b=cSuDDLSHifDHwx8h6MMhQ/5d1jJPsPNuUNSkLQjBmIa/B8T1ecHWeRPl6d3Cw0Anf/
         t4K2PdsNHQkk1VbuEs6AA5iaHC18W2b6lUJHLESx3DcBoAHanaP5onFtf+Z8PXYAEH/x
         8nVxQ0jpgyQVQ8Q7btNxIM+QmO8rtXh2AJdWGwTmI2Z5Cx5SmQnggiNvYYZBZn0Yp+NW
         1s7xHnqYqx6nPmKhAtRotROGInkuWyuVIL2WO2TOBeJlesyB540BHbB07zhv9pQQ61lZ
         7sA6hh5BuARvnxxf2Cg54eaYhjXnR/gdHRbNiQxkGgqFiqXLZdImM2h7sEk4PIvQpLAt
         gLig==
X-Gm-Message-State: AJcUuken1pX6aw9J22hWZJroBt2ZK6pLK/k7TL2ipJbqX/Yy2srI5wLL
        vbdP+FljSWzi401LkeNbIZdCiw==
X-Google-Smtp-Source: ALg8bN5PQH1DpatsoIWctrInt3PJqRpY8YE1l4awjPHALvvMtbFCfbPJ609PANMk2tiYUOIwcuyh7w==
X-Received: by 2002:a63:d208:: with SMTP id a8mr72012pgg.77.1548203173153;
        Tue, 22 Jan 2019 16:26:13 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r8sm22033869pgu.38.2019.01.22.16.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 16:26:12 -0800 (PST)
Date:   Tue, 22 Jan 2019 16:26:10 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] arm64: dts: sdm845: Introduce ADSP and CDSP PAS
 nodes
Message-ID: <20190123002610.GE31919@minitux>
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
 <20190122055112.30943-4-bjorn.andersson@linaro.org>
 <CAD=FV=WXind-uk7V_XTDgM83LZbmtKb2Ln6pQjmUkaZMz8SFsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WXind-uk7V_XTDgM83LZbmtKb2Ln6pQjmUkaZMz8SFsA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Jan 15:46 PST 2019, Doug Anderson wrote:

> Hi,
> 
> On Mon, Jan 21, 2019 at 9:52 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > Add the ADSP and CDSP nodes for PAS-based remoteproc, supporting booting
> > these cores on e.g. the MTP, and enable the same for the MTP.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > Changes since v2:
> > - New patch
> >
> >  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  8 ++++
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 58 +++++++++++++++++++++++++
> >  2 files changed, 66 insertions(+)
> 
> It's a bit of a nit of mine that if it's not totally obvious what
> acronyms mean that they should be spelled out in places that use them.
> 
> In this case I believe ADSP is the Audio DSP.  Is CDSP the Camera DSP?  ...or ?
> 

C as in Compute. I'll spell these out as I respin the series.

> 
> > +       adsp_pas: remoteproc-adsp {
> > +               compatible = "qcom,sdm845-adsp-pas";
> > +
> > +               interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
> > +                                     <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> > +                                     <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> > +                                     <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> > +                                     <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> > +               interrupt-names = "wdog", "fatal", "ready",
> > +                                 "handover", "stop-ack";
> > +
> > +               clocks = <&xo_board>;
> > +               clock-names = "xo";
> 
> I've found that nearly all the places that refer to xo_board are wrong
> and should actually point to '<&rpmhcc RPMH_CXO_CLK>'.  Maybe yours
> should too?
> 

Yes, xo_board is a fake clock representing the 19.2MHz clock feeding the
cxo (or cxo2) pad of the SoC. So you're definitely right in that this
should be referencing the actual 19.2MHz clock.

We've kept referring to this as xo_board, as we don't handle probe
deferral when gcc will probe earlier than rpmcc in the boot and for
other non-clock drivers the fear of actually hitting 0 on the refcounter
for this (you don't want to disable the cxo while running the system).

I'll give it a spin with appropriate reference and see what happens, I
think this should either be changed or documented in the commit message.

Thanks,
Bjorn
