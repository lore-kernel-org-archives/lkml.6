Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327FFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA15620672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcGK7U9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbeLQHj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:39:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44518 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeLQHj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:39:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so11147095wrt.11;
        Sun, 16 Dec 2018 23:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g1JxZQg+zDQ3RAd4cmu0CH6qXDipWJuyunzbnB9nuIk=;
        b=bcGK7U9p7mwDNnXmL4yzQOLDwDc0EbGtZhr5UdbwvSXq15lfTTIttcrHhQFkWNa8xN
         H3U+Aa676djTRk+w8Xprd8eeUiBquHEkKp/CG4V9cSdOu3FRfMp/ubFQ1yIZJyjHHkcM
         qpnmLXxNiyfA7iqTxR+R4ZA303AutwGXnI+vT5kyz702mTx3j7UFuq1cJMqJ4mBc/9sz
         QtIGtDaVjvQQg9QKmXaWTY+owpM5sSsSfb9UTqoSZDt7q6t/Z5LW+jyO2umLEfOpxfe4
         A0g4BD8N5uygG+LCOQOuU8Shn/UsrPX3QPRXlSqUf3IRuBPoG1iDXV7+zPZ5OjiLH80I
         KEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1JxZQg+zDQ3RAd4cmu0CH6qXDipWJuyunzbnB9nuIk=;
        b=LQbBvphFqkpUaC7HoIYYtsMpVTBMW4rvretbAN7h/XEJT29bn7FW62aNIfkSwzmnrL
         Q4ue8J5VWh3nnmC33v/Qm/akNlWVUlj7d5UgTcX1I+Ga6+Spd7w16NT8bk8vKdaYUpUH
         ICE0QcZ9u6PJhIRAS3+i1D79XphosCdDEdeVbRIB5ip415gAQZLtykmluzD9KugQZT1O
         qfYE2vbbZIBvQN6Qbx18C7Ey0xKQQPwxTKz+1jWwFLixJCdCbSQ9UBPDkHFeiVTB4roh
         17Ffv1rXgHb6+G3u1HLc40TPsp1Eaq69n39yY1Gk9PXIAtc3nF+rGp3PP1ScikRu/lqM
         p6Mw==
X-Gm-Message-State: AA+aEWaVxLhvsWPH4IUykxvxdgPFe3pxDyD7hDTgog1sYjS/qnZiJE4e
        zj/YblaaJ4w4wW8A5D4v/DhhHcPrmyKFRd/poyc=
X-Google-Smtp-Source: AFSGD/Vbhh1hBt6KIQSgBwWCQJSHTVIFVysQ2lpnc8gKRYwDGAlE2Og6ESZsTg9/OPWcMUlu0Dx0rmULs5QzOaCLBQQ=
X-Received: by 2002:adf:93e2:: with SMTP id 89mr9945808wrp.129.1545032395385;
 Sun, 16 Dec 2018 23:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20181217023827.7947-1-andrew.smirnov@gmail.com>
 <20181217023827.7947-3-andrew.smirnov@gmail.com> <871s6gahvh.fsf@tkos.co.il>
In-Reply-To: <871s6gahvh.fsf@tkos.co.il>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sun, 16 Dec 2018 23:39:44 -0800
Message-ID: <CAHQ1cqEx=jh86AkOhqiOmEcu51x-FMujFAsMiGgq5=6atvUXZw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: reset: imx7: Document usage on
 i.MX8MQ SoCs
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-imx@nxp.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 9:03 PM Baruch Siach <baruch@tkos.co.il> wrote:
>
> Hi Andrey,
>
> Andrey Smirnov writes:
> > The driver now supports i.MX8MQ, so update bindings accordingly.
> >
> > Cc: p.zabel@pengutronix.de
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: cphealy@gmail.com
> > Cc: l.stach@pengutronix.de
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  .../bindings/reset/fsl,imx7-src.txt           |  7 +-
> >  include/dt-bindings/reset/imx8mq-reset.h      | 64 +++++++++++++++++++
>
> This header file belongs at the next patch in this series, right?
>

I was asked to move it here, see lkml.kernel.org/r/20181211224349.GA30397@bogus

Thanks,
Andrey Smirnov
