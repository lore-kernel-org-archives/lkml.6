Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A33C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E339217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWkwfFOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfAWBJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:09:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33421 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfAWBJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 20:09:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so263535plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 17:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yAdYEfI7vGNlahuqZhtfFtAmzXo9ftqOW3CPVmj07Lk=;
        b=eWkwfFOQvjmi3nwPvoAEcjeZ0P3nubev1DEOdnAS9qDIP6Nq69UC8T4z+FuZvN7Dib
         PawjpH1d3A1ObWRJVzWHbslWxoCdkkzT2V3hiGVfNqRen0SF3nqzCjNFEAJQs4wSdzlw
         IkgD4fm+9dBhJwIUK4L1sSAY8Vix9UdLpU3kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yAdYEfI7vGNlahuqZhtfFtAmzXo9ftqOW3CPVmj07Lk=;
        b=NLUxWUwYdvl0blS4v4CMDleYe+rtJAABRsWZGb01S2MAhw8Xlq4dF4hrORNt9MBLe0
         F2R/nmuXwDK0s6Xl9o/k9oofx9sjNiyjjKs1mWWCHW1hWFbOCJ7QcGzooKt2814oeGza
         jGZFR75N80YLNo5fja7s84v4c+V59Tci0jBFymB1430Gk4EsWItQ1sKPgkwNv1zFB58i
         pmaQgpKu4ECTDCtvrW4AlKW5lbEhFivgURFrHkTohLoiWnbUX6YkD4+bB3oratlly3p0
         kNKmANfk+L3qH/Z1vLvS6Hhgw5hFcPl1TIvmVuCiD5gf4jtXrnL3r7bUExQVZux+Jsar
         KQ6A==
X-Gm-Message-State: AJcUukerorduykkeL2Ug/6Domy/xsTEkGNNew2NTTCe5Acgn95rFfhlF
        tb3gtdza4agBUUSg+5uuzjYfoQ==
X-Google-Smtp-Source: ALg8bN69hJ+5OuFs3mrxDMJqEj5gPJ1NZsiKl65LBRk+lFY+PcsoyS40gFuc4PBgqAgZ3grWGTOxBQ==
X-Received: by 2002:a17:902:850c:: with SMTP id bj12mr218341plb.46.1548205773088;
        Tue, 22 Jan 2019 17:09:33 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n68sm26543831pfb.62.2019.01.22.17.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 17:09:32 -0800 (PST)
Date:   Tue, 22 Jan 2019 17:09:30 -0800
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
Message-ID: <20190123010930.GI31919@minitux>
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
 <20190122055112.30943-4-bjorn.andersson@linaro.org>
 <CAD=FV=WXind-uk7V_XTDgM83LZbmtKb2Ln6pQjmUkaZMz8SFsA@mail.gmail.com>
 <20190123002610.GE31919@minitux>
 <CAD=FV=Wsk3s2NbX4pR6v9-kK41edLF4hd7B_BanoFkAXyLBwyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Wsk3s2NbX4pR6v9-kK41edLF4hd7B_BanoFkAXyLBwyA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Jan 16:40 PST 2019, Doug Anderson wrote:

> Hi,
> 
> On Tue, Jan 22, 2019 at 4:26 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > > > +               clocks = <&xo_board>;
> > > > +               clock-names = "xo";
> > >
> > > I've found that nearly all the places that refer to xo_board are wrong
> > > and should actually point to '<&rpmhcc RPMH_CXO_CLK>'.  Maybe yours
> > > should too?
> > >
> >
> > Yes, xo_board is a fake clock representing the 19.2MHz clock feeding the
> > cxo (or cxo2) pad of the SoC. So you're definitely right in that this
> > should be referencing the actual 19.2MHz clock.
> >
> > We've kept referring to this as xo_board, as we don't handle probe
> > deferral when gcc will probe earlier than rpmcc in the boot and for
> > other non-clock drivers the fear of actually hitting 0 on the refcounter
> > for this (you don't want to disable the cxo while running the system).
> 
> Note that, as defined in the device tree, "xo_board" is actually 38.4.
> IIUC that is not actually a fake/bogus clock but represents the actual
> crystal on the board.  There's a divide by 2 in the CPU though so most
> peripherals consider "xo" as 19.2.
> 

There's the 38.4MHz XO connected to the PMIC, but the signal going into
the CXO_IN pad of the SoC is supposed to come from LNBBCLK1 and be
19.2MHz.

> ...OK, confirmed.  The actual RF_XO_CLK pin on the board is truly
> connected to 38.4.
> 

And the three RF clocks from the PMIC are all ticking at 38.4MHz.


The "xo" I need here is the LNBBCLK1 (RPMH_CXO_CLK in clk-rpmh), for the
purpose of preventing the root clock to be turned off if apps goes to
suspend while the modem is booting, before it has had a chance to tell
RPM(h) that it needs it to be on.

Regards,
Bjorn
