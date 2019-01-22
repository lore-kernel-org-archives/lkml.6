Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DC7C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C933321726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KaSwu5U+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfAVSez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:34:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40188 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfAVSey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:34:54 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so21532689lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwhVzdBEJ3u2KOk+78DdfqIqDpxwPWSqhLf5NGniYSs=;
        b=KaSwu5U++KlZYJNLlqIwQQImW3uC6zStp7SaA9vQiDJQYvGeY6Bz51rp3ezecp5JIJ
         De4yvdHQS0KfRdXGlNK6ekq4ETYg6aOkrNaxrjOLFxV6s+VxrBMFSYl+VlGygs8luWbo
         mjg+J0ktBKtGGRsNk5vuesmiWPrtUM3lpyBEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwhVzdBEJ3u2KOk+78DdfqIqDpxwPWSqhLf5NGniYSs=;
        b=uYzGDLLPp7+RezSXIMGOLAlXXelFF3/vuwdi+wJ0jNlNjXxOldEd8exs64H/kxvOf/
         oILtttOFU5mcNfHZf98d4KoZKgd041iaext5I6bjouyhVIOpk0DUSLY2rQtU2FCOlq48
         x2LBJWOp+0T/qXfM3rs6t/XGsyNCgeMWLrD8B1ccOkbnIs1x+EBQ/p3soMx/Tt5GCJjO
         OhCJtl7K8AfwEALa4VxAiRHSacn2h+Jzk3sWONgQZchJSb4sujaAdKGjvbM/kdjVYzlI
         YhAlQ+SJprFiKFjSWU+nmEzOvvw284GRvP6U0KDqJYR08JmMBpHYzPXlKNgUxrRFtii9
         xM8w==
X-Gm-Message-State: AJcUukcn6nHfscrsom5ZDJIBCJ/D91nhfy/DzsP21Erg8stCTtcJGZJ3
        WsU1bNYy/SAfT/fpiKq7XNs1o4Ta+A0=
X-Google-Smtp-Source: ALg8bN4TbV/fTELX/zL6Wguke09ThWOvg65IZUzmbNWZpHv1jlkjaIzIsfFeZ8A7YHv11nIk7oX/jA==
X-Received: by 2002:a2e:3012:: with SMTP id w18-v6mr20547476ljw.75.1548182092382;
        Tue, 22 Jan 2019 10:34:52 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id s127sm125046lfe.8.2019.01.22.10.34.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:34:50 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id t18-v6so21568027ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:34:49 -0800 (PST)
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr22806530lji.60.1548182089278;
 Tue, 22 Jan 2019 10:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20190111230129.127037-1-evgreen@chromium.org> <20190111230129.127037-3-evgreen@chromium.org>
 <154767416474.169631.9323736638860679135@swboyd.mtv.corp.google.com>
In-Reply-To: <154767416474.169631.9323736638860679135@swboyd.mtv.corp.google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 22 Jan 2019 10:34:12 -0800
X-Gmail-Original-Message-ID: <CAE=gft6cPWjnA=A50Z5OC2b+heSmW_Z=vu-8ia+R=G7M5sSf5Q@mail.gmail.com>
Message-ID: <CAE=gft6cPWjnA=A50Z5OC2b+heSmW_Z=vu-8ia+R=G7M5sSf5Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] dt-bindings: phy: qcom-ufs: Add resets property
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 1:29 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Evan Green (2019-01-11 15:01:23)
> > diff --git a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt b/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
> > index 21d9a93db2e97..985f5e99ab332 100644
> > --- a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
> > +++ b/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
> > @@ -29,6 +29,7 @@ Optional properties:
> >  - vdda-pll-max-microamp : specifies max. load that can be drawn from pll supply
> >  - vddp-ref-clk-supply   : phandle to UFS device ref_clk pad power supply
> >  - vddp-ref-clk-max-microamp : specifies max. load that can be drawn from this supply
> > +- resets : specifies the PHY reset in the UFS controller
>
> Nitpick: Can you also add it to the example?
>

Sure, will do.
