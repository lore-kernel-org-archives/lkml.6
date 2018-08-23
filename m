Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A922DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BCA21564
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRglYAMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BCA21564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeHWWJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbeHWWJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:09:30 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD0CC2150F;
        Thu, 23 Aug 2018 18:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535049511;
        bh=8AMFGtaRbCfQbD9zSe/O/47Ui1953WcuY449V4OwTiw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=lRglYAMAe42OokK12jnm8XPJv6GeLfTznHRjPeEAgNZBW8AdADWrFVRUqPKNN7t4e
         dtMFmVEP0QvJ4oIRiUyslRRVsxeuNTfmNJRdzABO4XYbVI50KyeqQgnOxJ87HU5rvG
         v2o6tKfMNDZdD7C6eEeWgQwS2ueyizpKVb53x1SU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Taniya Das <tdas@codeaurora.org>, skannan@codeaurora.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <c83e4248-aef2-bb40-8d8e-47d9b2918cc7@codeaurora.org>
Cc:     Evan Green <evgreen@google.com>, rjw@rjwysocki.net,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        anischal@codeaurora.org, devicetree@vger.kernel.org,
        robh@kernel.org, amit.kucheria@linaro.org
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
 <CAE=gft7_5SZKpU0i9Jbi6UV-eqW8=6Fm7rw4oKVXG6J9Q7_E+g@mail.gmail.com>
 <1ddda4b9e6dcd7ad415235f4d6af2dc7@codeaurora.org>
 <153333504360.10763.8964005567051510823@swboyd.mtv.corp.google.com>
 <4d37a1ee4f2d5b30da3f62cbfca756a8@codeaurora.org>
 <153370933225.220756.12056174025047430491@swboyd.mtv.corp.google.com>
 <c83e4248-aef2-bb40-8d8e-47d9b2918cc7@codeaurora.org>
Message-ID: <153504951102.28926.11593809590549791317@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Thu, 23 Aug 2018 11:38:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-08-08 03:15:26)
> =

> =

> On 8/8/2018 11:52 AM, Stephen Boyd wrote:
> >>
> >> Binding describes hardware controllable by the OS. That's the reality.
> >> Let's not add mandatory clock bindings for clocks that the OS can't do
> >> anything about.
> >>
> > =

> > It seems that you believe clks should only be used to turn on/off and
> > control rates. That is not the whole truth. Sometimes clks are there
> > just to express the clk frequencies that are present in the design so
> > that drivers can figure out what to do.
> > =

> =

> Stephen,
> =

> As this clock is not configurable by linux clock drivers and we really =

> do not care the parent src(as mentioned by Saravana) to generate the =

> 300MHz, would it be good to define a fixed rate clock so as to express =

> the HW connectivity & frequency?
> =


As a hack that works great, but why do we need to workaround problems by
adding a fixed rate clk to DT for this PLL? The PLL is provided by GCC
node so it should be connected to the GCC node.

