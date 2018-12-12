Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D71EC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C7F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ej/wWOvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C7F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeLLSct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:32:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38020 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbeLLScs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:32:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so8724425pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=jEdJMWVAU5LEwaritAJ+QZPVTm4Dl4mvsSuDOgl5tRw=;
        b=ej/wWOvIQLcHxWQQL/uSsCkHdqjbhRFmm0QbQGTm3l/+Kimg7MLhvLSsf32CtWu+7X
         LAD7YF3GEyOwqLi1CJZ6E9p9SFSuDa2KrzO9g+KcB1Gi0ZbxwnaipVEmd59OwilfK1tY
         7gde5s+RzLUSZNg7k3TZkZy/4Bbzwz3E7irW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=jEdJMWVAU5LEwaritAJ+QZPVTm4Dl4mvsSuDOgl5tRw=;
        b=ui3JrcL/BNiCDzq39HdU0EFnQKSGSJNr1UCD+gxB5Ripbke8+52l8auB6nKmtGgul9
         8t2nCv2Qp712AJNZrB27Pt6wJ35XQ28RVS0k1Wb32SrOLJTi2Dgx5r3ESDlur3tythqz
         OhztaoMqWoTVmnnwTXC/HKNQdqeHootL3wjVH8ExrhmjeurMDh1yliq1Tw1tonBe9Isn
         YuhOQLMJ8K5UXhFwRwVYt29yhNF+ldBk3T84VyDpknf4c/6/C4n57tLVAgceJLQ/tCmh
         /BAl6Ukf2jiBIM06pxzNSHQ3O9x+7POFLtlWBINMwVA7knZE/kAoNc0sTzeO/3Dh0tVb
         YUGQ==
X-Gm-Message-State: AA+aEWZB1k8lO8AZr+SowK9d50tF8JC+FYsMuKUWBysEEiJ+udNwXiWG
        IG+x1coGkBfckQsJ4MXCnFQEOA==
X-Google-Smtp-Source: AFSGD/XWO1QaEYYQYLOa+pLsWUserVFvdPJh7VBA3cjOjJCQewtxotFp7PEz1MS34zWKH/BypMVjhA==
X-Received: by 2002:a62:44d8:: with SMTP id m85mr21448313pfi.164.1544639567058;
        Wed, 12 Dec 2018 10:32:47 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v14sm30737240pgf.3.2018.12.12.10.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 10:32:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1c493bce-af67-2a4b-f903-8d39c39f7367@codeaurora.org>
Message-ID: <154463956571.17204.13154447854211552369@swboyd.mtv.corp.google.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 10/10] soc: qcom: rpmhpd: Mark mx as a parent for cx
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181211094938.25086-1-rnayak@codeaurora.org> <20181211094938.25086-11-rnayak@codeaurora.org> <CAPDyKFof-rkzmzibWOrAhDFysU=y+C8Bp0cK=_iht4=vmv-0vw@mail.gmail.com> <00d91f90-ccf1-3486-0d42-0c4105058e61@codeaurora.org> <154456502486.17204.11345601448030201032@swboyd.mtv.corp.google.com> <1c493bce-af67-2a4b-f903-8d39c39f7367@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>, Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Dec 2018 10:32:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-11 20:13:13)
>=20
> >>> Just to make sure there are no conflicting hierarchical constraints
> >>> between idle management and performance state management!?
> >>>
> >=20
> > I'm not sure what idle states mean to the CX and MX domains. Would it be
> > some sort of idle state governor attached at genpd creation time that
> > would adjust the main SoC power rails when all devices attached are
> > idle? Maybe I don't understand how idle states are different from
> > performance states.
> > My understanding is that devices using these domains would almost always
> > expect their clk frequency and clk on/off state to decide what the
> > performance state is, unless they need to ignore clk state because they
> > aren't managing clks and bump up the voltage directly when the device is
> > active. Either way, devices are actively managing the voltage they need
> > these voltage domains to operate at by using the genpd performance
> > states APIs.
>=20
> I am not quite sure whats the point that you are trying to make here,
> but this is what I would expect the users of these genpds to do,
> regardless of if they have a clk dependency or not.
> When the device is active, vote for a performance state they need
> then request for the genpd to be on. When they are idle, request for the
> genpd to be turned off.
>  =20

I believe Ulf is asking because he's proposing to make genpd idle states
and genpd performance states orthogonal to each other. And to also make
performance states unaffected by the on/off state of the genpd.

