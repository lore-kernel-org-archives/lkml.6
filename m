Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A1AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0772D205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IKw92NBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394026AbfAPPT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:19:29 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42754 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394014AbfAPPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:19:29 -0500
Received: by mail-vk1-f196.google.com with SMTP id y14so1488111vky.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 07:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xj6wTrVlVV59Th7wm7ALLQYi/URMHFEqKb+Qs5aFWQg=;
        b=IKw92NBB+tbW9hf1Mm0ESbUd/C1Xzwfg/oNugQb4HG6HebgM3sua+zA+OTFVxuGA5U
         FYzh4d20T9Rr/Q9Lh0IHtdpwJRAkuRj0wvSsTNsYmHlU4L1XelSoVwYZkkuhK+/Sj/8g
         6p+7CcLFsUkVAuva+n8QvYcLi1jpUFoQAmlE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xj6wTrVlVV59Th7wm7ALLQYi/URMHFEqKb+Qs5aFWQg=;
        b=YZrFPfU3yeOg1qAZK/jBCaGD7KWTk6S62gCwheEQMkb/+YVkKrW2c1IcZILyQBzqfv
         YX77XA1piUvWB7ruT8lbZK4dauSoAGIYcdqglZl5sFSnCDbsfEA3hDK3Z6rFRpCV8kRk
         jIBiYjoq+TCLzxU0LcJdq+qtT1rqou8PFJ+5K86PvuJuMT5MtYe7M/XeHEXzTzyVJtqD
         HWbBW0kF9EJHUDi0XRYSmcHT++C83GC1kYS+794gMKp2ELFgh+qir/0fHZwWWi5gBTgg
         DOMZkhfG1ZqHf9cjkChGTp6LOihClR2U+plcrwUnfGucnil1QBVV4ny4OzVXV1QkMdc8
         Gs2w==
X-Gm-Message-State: AJcUukcEeppjJHIXV0bnThJ+enRzRdhF2XsvbGkVBXv/sBFw4jwS/08e
        k9HhjVThUIptcPKSdHZV9abcqbdY1Q4K65Z/hiyzXw==
X-Google-Smtp-Source: ALg8bN6RtiYGPiWpFafxJ1fapQIBWJJ52lOpbNSwnAaxA4V6hx5wXmUi4J9ZuTpGIbEHf54V4SX7h0/pbWJ0S9sj+jk=
X-Received: by 2002:a1f:9042:: with SMTP id s63mr3576300vkd.17.1547651966804;
 Wed, 16 Jan 2019 07:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20190110040209.6028-1-rnayak@codeaurora.org> <20190110063323.ltmqkl2xl4nhccvq@vireshk-i7>
 <20190116055238.GD25927@tuxbook-pro>
In-Reply-To: <20190116055238.GD25927@tuxbook-pro>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Jan 2019 16:18:50 +0100
Message-ID: <CAPDyKFqyviQ5aF6EO1Ww8Xegsoe-Jj=UGsU9ZwJkaJ_wPVRViA@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] Add power domain driver for corners on msm8996/sdm845
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        henryc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 at 06:52, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 09 Jan 22:33 PST 2019, Viresh Kumar wrote:
>
> > +Rafael
> >
> > On 10-01-19, 09:32, Rajendra Nayak wrote:
> > > Changes in v11:
> > > * Updated opp-level binding description based on feedback
> > > from Viresh
> > > * Other minor fixups in 'PATCH 2/9'
> >
> > >  Documentation/devicetree/bindings/opp/opp.txt |   3 +
> > >  .../devicetree/bindings/power/qcom,rpmpd.txt  | 145 +++++++
> > >  arch/arm64/boot/dts/qcom/msm8996.dtsi         |  34 ++
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi          |  51 +++
> > >  drivers/opp/core.c                            |  18 +
> > >  drivers/opp/of.c                              |   2 +
> > >  drivers/opp/opp.h                             |   2 +
> > >  drivers/soc/qcom/Kconfig                      |  18 +
> > >  drivers/soc/qcom/Makefile                     |   2 +
> > >  drivers/soc/qcom/rpmhpd.c                     | 402 ++++++++++++++++++
> > >  drivers/soc/qcom/rpmpd.c                      | 317 ++++++++++++++
> > >  include/dt-bindings/power/qcom-rpmpd.h        |  39 ++
> > >  include/linux/pm_opp.h                        |   7 +
> > >  13 files changed, 1040 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> > >  create mode 100644 drivers/soc/qcom/rpmhpd.c
> > >  create mode 100644 drivers/soc/qcom/rpmpd.c
> > >  create mode 100644 include/dt-bindings/power/qcom-rpmpd.h
> >
> > Rafael/Ulf: Who should pick this series ? Should I take this via OPP
> > tree ?
> >
>
> Given that the weight of the patches lies in arm-soc area it could be
> favourable to just take them that way, with the one opp-patch carrying
> your (Rafael's?) ack.
>
> If you prefer otherwise, I suggest that we take patch 6 and 8 (the two
> dts patches) through arm-soc and you merge the rest in your tree.

It sure sounds easiest to funnel this though the soc maintainer tree,
unless Viresh think there are lots of additional changes to the OPP
core going in this cycle, which thus may conflict.

However, it's not my call.

Kind regards
Uffe
