Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EFCC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4E320851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3HOsuHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4E320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbeLMQDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:03:22 -0500
Received: from mail-vs1-f49.google.com ([209.85.217.49]:32806 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbeLMQDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:03:21 -0500
Received: by mail-vs1-f49.google.com with SMTP id p74so1493819vsc.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 08:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGUL7YYer6QonzRjzphxpufukm4kdJxsjKJnGsT0LWE=;
        b=F3HOsuHF0rN4Db/DiPx1ASa2pnKCuuG08aI917Mm0HBnic9XunYSmsbuzkGvAhCApD
         yDKKziYXJbdd59joQAJJn24NxM4+TYSR5hboxGuYI301bm/kfMs0+gIeN1fSE/yuGxhQ
         yRtDIxIzZ7lD4W995hGUfdVgwVjIYXee71PKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGUL7YYer6QonzRjzphxpufukm4kdJxsjKJnGsT0LWE=;
        b=rC58f/6I8fgWpmXUcjLMLsERuJYUj1FXbQ3lmggOc19H3DTOhhUeBt2cGICopP7moZ
         9m522+n5hSgDeFT2WD35bbhbaAglWnLuZmNTM+SdlH+K4VhkDIBmOq3yzapJpqElnDlu
         NtsyJDmVH6i071bEWLMmxY8ctC5u4BQnXyB46UVCudG99Rf/Rey9KjQ1/hltQ+Ogk7ct
         8gw4nQx5Hjfy9nt8nsyXpU7G/6oAPizWGDzp8G8AQSTYaSIaRpClfMIjvQ3UXViV+WOG
         jdJc+GICrqwIBI9gdiA1G3QTgnd+m0RxOYqUkPbnZZhGfrLMN9HRO8UObQf8JUn+j0FI
         2krA==
X-Gm-Message-State: AA+aEWZ7jn0LR7yzmGAj0PcGrDLne6+1QMsw1z9VBeqWmRPvMRnzyDPF
        hecHve9ASsxSmDPXIRpYQUJWHkzq19mFkvO/ln72QQ==
X-Google-Smtp-Source: AFSGD/XEA4vUCcohb2JOhMNrm0fdLOh6TB91Z5MYL7FrT0KFWN+M6pyX1jWqz470b3wyUIYayQj/TLYqWglYBs8D4Io=
X-Received: by 2002:a67:b245:: with SMTP id s5mr11585246vsh.200.1544717000075;
 Thu, 13 Dec 2018 08:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20181211094938.25086-1-rnayak@codeaurora.org> <20181211094938.25086-11-rnayak@codeaurora.org>
 <CAPDyKFof-rkzmzibWOrAhDFysU=y+C8Bp0cK=_iht4=vmv-0vw@mail.gmail.com>
 <00d91f90-ccf1-3486-0d42-0c4105058e61@codeaurora.org> <154456502486.17204.11345601448030201032@swboyd.mtv.corp.google.com>
 <1c493bce-af67-2a4b-f903-8d39c39f7367@codeaurora.org> <154463956571.17204.13154447854211552369@swboyd.mtv.corp.google.com>
In-Reply-To: <154463956571.17204.13154447854211552369@swboyd.mtv.corp.google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Dec 2018 17:02:43 +0100
Message-ID: <CAPDyKFrY_9qHq_3NGHpOxCLRDV-D4RiaKm_Wckqxa5ukHcEt+Q@mail.gmail.com>
Subject: Re: [PATCH v6 10/10] soc: qcom: rpmhpd: Mark mx as a parent for cx
To:     swboyd@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>, Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 at 19:32, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rajendra Nayak (2018-12-11 20:13:13)
> >
> > >>> Just to make sure there are no conflicting hierarchical constraints
> > >>> between idle management and performance state management!?
> > >>>
> > >
> > > I'm not sure what idle states mean to the CX and MX domains. Would it be
> > > some sort of idle state governor attached at genpd creation time that
> > > would adjust the main SoC power rails when all devices attached are
> > > idle? Maybe I don't understand how idle states are different from
> > > performance states.
> > > My understanding is that devices using these domains would almost always
> > > expect their clk frequency and clk on/off state to decide what the
> > > performance state is, unless they need to ignore clk state because they
> > > aren't managing clks and bump up the voltage directly when the device is
> > > active. Either way, devices are actively managing the voltage they need
> > > these voltage domains to operate at by using the genpd performance
> > > states APIs.
> >
> > I am not quite sure whats the point that you are trying to make here,
> > but this is what I would expect the users of these genpds to do,
> > regardless of if they have a clk dependency or not.
> > When the device is active, vote for a performance state they need
> > then request for the genpd to be on. When they are idle, request for the
> > genpd to be turned off.
> >
>
> I believe Ulf is asking because he's proposing to make genpd idle states
> and genpd performance states orthogonal to each other. And to also make
> performance states unaffected by the on/off state of the genpd.

Yes, that's one of the reasons.

Anyway, I appreciate both of yours descriptive feedback, no further
worries from my side!

Kind regards
Uffe
