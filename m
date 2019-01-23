Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE1AC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A18421872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NkFT4v/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfAWUwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:52:12 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:33359 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfAWUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:52:12 -0500
Received: by mail-pl1-f179.google.com with SMTP id z23so1770018plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:references
         :user-agent:cc:from:in-reply-to:message-id:to:date;
        bh=bXeu6E3QeLuaGp+qjeiDmBsnCZgMz+VXt93+l0l/4+s=;
        b=NkFT4v/5dG1GqD4cfER2tKz0Kka14obhhviwu3Z97gFffOhK2fxJcOEW9cwP0T/FMd
         7gkASifh8pGw+r1TMz7wdmO3sRNU3K0O4pR9U+1OOCT+069X3hunH6nWXJqEM349MxlI
         5cMgHVwOcDMqqtCpQGUZf9ZR5R7M09F4P+KbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :references:user-agent:cc:from:in-reply-to:message-id:to:date;
        bh=bXeu6E3QeLuaGp+qjeiDmBsnCZgMz+VXt93+l0l/4+s=;
        b=MpGDLFswvdZWGGB5CqXfl7rtGX1iS1sn9a+q/J9QUL/e95m8JZEgQ+qNf/l/3dTXsC
         87NCVr/VFNhtcT3/Q6VTAb72u+Bl/II04rjaBvxnm4yZdzC5FlzU2kP1kIRg+UEzpkj9
         GxPiI7He7rwsqTVKhJa9aTCZ5PS4t1hnX1YCgr7BJ7/Bwcznr8ypCfSmF+JdtoqzDPp4
         7KJniXJXbv9iyJ00WzuKjCIm+fmZz0GCMynQZnLm1W+SVMGhw566krYiHFp6Z64nFoR1
         ru8BSufZa4xi/vK6PpOc8WmNFjAzlDPk17h2+muGfofNUZgaFlEEQDduF7F/sErQMtsU
         mLMQ==
X-Gm-Message-State: AJcUukcY/bzjSPwgzQzgRGh+lKUD0i7IFotllKn/MXtrXOPSNRk1UiTQ
        8L2eHobN1auAvmO7biWtga41GQ==
X-Google-Smtp-Source: ALg8bN7VaMT+ZwhHUb0VVp3i5/LhD6m+o/2KE60dXm9Ghy47Me3ctm1qj0yhAMJnbIAx2uXidsSTSg==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr3789052pla.136.1548276731494;
        Wed, 23 Jan 2019 12:52:11 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d21sm27893569pfo.162.2019.01.23.12.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 12:52:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/7] dt-bindings: sdm845-pinctrl: add wakeup interrupt parent for GPIO
References: <20181219221105.3004-1-ilina@codeaurora.org> <20181219221105.3004-5-ilina@codeaurora.org> <20181229000714.GA3654@bogus> <20190107185113.GH14960@codeaurora.org> <CAL_Jsq+McuN5F9_a2bmECegR65vziNATpUqt4hysKL7FT=b9RA@mail.gmail.com> <20190109173111.GB22547@codeaurora.org> <CAL_JsqL1z-iOewqBeE43n1cVSGiQyOPHBGbRmEm9zcVLJkoLEA@mail.gmail.com> <154724884881.169631.9705938789464714812@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Cc:     Evan Green <evgreen@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <154724884881.169631.9705938789464714812@swboyd.mtv.corp.google.com>
Message-ID: <154827672955.136743.8509585166504871320@swboyd.mtv.corp.google.com>
To:     Lina Iyer <ilina@codeaurora.org>, Rob Herring <robh@kernel.org>
Date:   Wed, 23 Jan 2019 12:52:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-01-11 15:20:48)
> Quoting Rob Herring (2019-01-09 11:36:56)
> >=20
> > > >However, my main concern is documenting something genericish in a
> > > >device specific binding. It looks like Tegra is trying to add the sa=
me
> > > >thing, so this needs to be documented in a common place. One question
> > > >is whether wakeup is the only use or if this should be more generally
> > > >a secondary interrupt parent?
> > > >
> > > Yes, wakeup is the only use of this interrupt parent.
> >=20
> > Maybe for you, but I was wondering about this more generally. Should
> > we encode what the function (e.g. wakeup) is in the property name or
> > have something like aux-interrupt-controller? Maybe some platforms
> > have some need for a secondary interrupt-controller which is not
> > wakeup. Routing interrupts to other cores perhaps?
> >=20
>=20
> I'd say it's not the interrupt-parent, but a secondary-interrupt-parent,
> because it's another path that some GPIO interrupts will go through vs.
> the "normal" summary irq line that uses the interrupt-parent. Maybe
> that's similar to the interrupt partitioning that ARM is doing for PPIs
> that only go to some CPUs?
>=20
> We don't really specify that some GPIO is corresponding to the secondary
> or primary interrupt controller for the GPIO controller in DT. If we
> did, then we could do something like the interrupt-map binding and have
> the index of that property be the gpio number and the interrupt parent
> that it maps to (either summary from the GIC or MPM pin number).
>=20
>  interrupt-map =3D <0 0 &gic GIC_SPI 208 0>,
>                  <1 0 &pdc 3 0>;
>  interrupt-map-mask =3D <0xfffffff 0>;
>=20
> And then we would pass the 2-cell GPIO interrupt specifier (gpio# and
> flags) through the table and remap it to arbitrary domain parents. We
> could use this same design for the SSBI and SPMI gpio interrupt
> controller where we're currently looking at hardcoding the base
> interrupt number in the driver (0xc0) and then adding the GPIO number to
> that to get the parent interrupt specifier.
>=20
> It's sort of an abuse of interrupt-map, but I don't know if it really
> matters because there isn't a child of the gpio controller that is going
> to go through this table.
>=20

Rob, can you please respond?

