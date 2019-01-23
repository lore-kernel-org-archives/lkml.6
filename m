Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C069C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B05E21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UxwszPnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfAWXYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:24:53 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33599 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfAWXYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:24:52 -0500
Received: by mail-vs1-f68.google.com with SMTP id p74so2444395vsc.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sKWuVUxL+3nJfhLjliOc9hwx62Duqm6fu5tODyqT6dQ=;
        b=UxwszPnwJc1oCQiQ0HV1xOKgaPF5lg88UHBh1GQyrdidlMjCx1kJ2rzmItXK6qKfUN
         DOEeUKeOyPlqUqQu9qUDYJEyC8k7liYk1iUjr9OyFmc8DezYOy1FMT2aVVPTnLBrS5qO
         Hlx+AeWiotmwTSeK+WVnAfcy3nA4LY2WhqTxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKWuVUxL+3nJfhLjliOc9hwx62Duqm6fu5tODyqT6dQ=;
        b=SWPiFMSULpGz8CEYd1Ug3iTsuyAYPSCsEIuVVE3WQivVLrcD1x7qH0LKzfIojO6MvH
         IZIt5sWF+/jTpjW6XNQd3kQG8rJxxiEQ+f9vxFCl6O7t4cDoF+ASV17FtupdKwB2bnSO
         d0VaRLnChKtJ28ODPUc0uZII5YENkmY0kJzIa8gn5xcKBtIGCIeJZk5U+sgNTBh8vM1h
         H/fsUVgsNQC2wtC/k/9U5PffYuzSKMN3roei8+FC1PKr8cRoqjswQJSLfkr0MlMGfsAm
         wbA8I+cxKNRnQvqlBnlwwx0uPqzE8oEPrPv9m2gCMt8NfNUTdiUGgpIkSHMVxF9dfK+d
         8Ggw==
X-Gm-Message-State: AJcUukeqqUspZn53n/ulqSPX6+Z+qO6Gma2HgfHl2I7Q+k+UhciCO4OK
        VPVszywQaPWm9tNcR52Gv3Se3It63gM=
X-Google-Smtp-Source: ALg8bN7LVZnvvWSU3X3i87U1bgU4DfG+b1IUZaQey1ChqvjkSI1ma0sqzWre0zYR7GHrX7wUJygkMQ==
X-Received: by 2002:a67:2584:: with SMTP id l126mr1752088vsl.153.1548285891289;
        Wed, 23 Jan 2019 15:24:51 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id e67sm29660744vsd.32.2019.01.23.15.24.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 15:24:49 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id p74so2444364vsc.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:24:49 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr1796197vsj.144.1548285888818;
 Wed, 23 Jan 2019 15:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
 <20190122055112.30943-4-bjorn.andersson@linaro.org> <CAD=FV=WXind-uk7V_XTDgM83LZbmtKb2Ln6pQjmUkaZMz8SFsA@mail.gmail.com>
 <20190123002610.GE31919@minitux> <CAD=FV=Wsk3s2NbX4pR6v9-kK41edLF4hd7B_BanoFkAXyLBwyA@mail.gmail.com>
 <20190123010930.GI31919@minitux>
In-Reply-To: <20190123010930.GI31919@minitux>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 23 Jan 2019 15:24:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vf+3dAo9pZ=AJ6mrMuYL0f=dBNdk3XLV+tORG0c8hbDg@mail.gmail.com>
Message-ID: <CAD=FV=Vf+3dAo9pZ=AJ6mrMuYL0f=dBNdk3XLV+tORG0c8hbDg@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] arm64: dts: sdm845: Introduce ADSP and CDSP PAS nodes
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 22, 2019 at 5:09 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 22 Jan 16:40 PST 2019, Doug Anderson wrote:
>
> > Hi,
> >
> > On Tue, Jan 22, 2019 at 4:26 PM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > > > > +               clocks = <&xo_board>;
> > > > > +               clock-names = "xo";
> > > >
> > > > I've found that nearly all the places that refer to xo_board are wrong
> > > > and should actually point to '<&rpmhcc RPMH_CXO_CLK>'.  Maybe yours
> > > > should too?
> > > >
> > >
> > > Yes, xo_board is a fake clock representing the 19.2MHz clock feeding the
> > > cxo (or cxo2) pad of the SoC. So you're definitely right in that this
> > > should be referencing the actual 19.2MHz clock.
> > >
> > > We've kept referring to this as xo_board, as we don't handle probe
> > > deferral when gcc will probe earlier than rpmcc in the boot and for
> > > other non-clock drivers the fear of actually hitting 0 on the refcounter
> > > for this (you don't want to disable the cxo while running the system).
> >
> > Note that, as defined in the device tree, "xo_board" is actually 38.4.
> > IIUC that is not actually a fake/bogus clock but represents the actual
> > crystal on the board.  There's a divide by 2 in the CPU though so most
> > peripherals consider "xo" as 19.2.
> >
>
> There's the 38.4MHz XO connected to the PMIC, but the signal going into
> the CXO_IN pad of the SoC is supposed to come from LNBBCLK1 and be
> 19.2MHz.

Ah, thanks for pointing me to the right clock!  :-)

OK, so something is definitely wonky then.  "xo_board" is definitely
38.4 currently in the device tree.  That's my fault due to commit
5ea3939cf51f ("arm64: dts: sdm845: Fix xo_board clock name and
speed").  ...but, in my defense:

A) The hardcoded "divide by 2" for "bi_tcxo" in "clk-rpmh.c" came from Qualcomm.

B) The parent of "bi_tcxo" has always been "xo_board"

C) Children of "bi_tcxo" have always been only correct if "bi_tcxo" was 19.2


...so if "cxo" is really 19.2 then we need to update clk-rpmh to get
rid of the hardcoded divide by 2 I think?


-Doug
