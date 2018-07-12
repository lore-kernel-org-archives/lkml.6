Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8838EECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0771B2124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uqjp3vMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0771B2124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbeGLTwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbeGLTwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:52:38 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 868062124D;
        Thu, 12 Jul 2018 19:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531424497;
        bh=zw7Wf1MRYU3yWh3N3KpfhaIw9aQcelIrq10eM7LE4r8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Uqjp3vMAwEJebGlgG8OM+DHX9i7p8yA9No/MwzktgAILMLxHYsEUhfRRZfll5XOy6
         45CdTSi0JThh3B/QjMGYNaw/1m7U9JDxAvjltlU2coXPO+BU5jZThkUNIUtTUKcW98
         m+ayNLiQjHE/KnbwqQ4YdkBQIUX9Ps8vjkIII26Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, ryadav@codeaurora.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <e0203471-85ef-456a-d7f3-85c66a82b8c1@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1529763567-13131-1-git-send-email-tdas@codeaurora.org>
 <1529763567-13131-4-git-send-email-tdas@codeaurora.org>
 <153109408562.143105.15954380130353645468@swboyd.mtv.corp.google.com>
 <10f87216-caa2-d523-e134-6cf3acd268a7@codeaurora.org>
 <153111701079.143105.13387458941681113476@swboyd.mtv.corp.google.com>
 <436cc6a3-7406-c695-7879-3b9d042262cc@codeaurora.org>
 <153112184177.143105.15452587215679149679@swboyd.mtv.corp.google.com>
 <288770be-a763-b287-f62a-72ab7616efdb@codeaurora.org>
 <153114876561.143105.465317097490450694@swboyd.mtv.corp.google.com>
 <e0203471-85ef-456a-d7f3-85c66a82b8c1@codeaurora.org>
Message-ID: <153142449680.48062.13809855257701591509@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/3] clk: qcom: Add display clock controller driver for SDM845
Date:   Thu, 12 Jul 2018 12:41:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-07-12 10:21:33)
> ++ Display driver team,
> =

> On 7/9/2018 8:36 PM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-07-09 02:34:07)
> >>
> >>
> >> On 7/9/2018 1:07 PM, Stephen Boyd wrote:
> >>> Quoting Taniya Das (2018-07-09 00:07:21)
> >>>>
> >>>>
> >>>> On 7/9/2018 11:46 AM, Stephen Boyd wrote:
> >>>>>>
> >>>>>>     > Why is the nocache flag needed? Applies to all clks in this =
file.
> >>>>>>     >
> >>>>>>
> >>>>>> This flag is required for all RCGs whose PLLs are controlled outsi=
de the
> >>>>>> clock controller. The display code would require the recalculated =
rate
> >>>>>> always.
> >>>>>
> >>>>> Right. Why is the PLL controlled outside of the clock controller? T=
he
> >>>>> rate should propagate upward to the PLL from here, so who's going
> >>>>> outside of that?
> >>>>>
> >>>> The DSI0/1 PLL are not part of the display clock controller, but in =
the
> >>>> display subsystem which are managed by the DRM drivers. When DRM dri=
vers
> >>>> query for the rate clock driver should always return the non cached =
rates.
> >>>
> >>> Why? Is the DSI PLL changing rate all the time, randomly, without goi=
ng
> >>> through the clk APIs to do so?
> >>>
> >>
> >> Hmm, I am afraid I do not have an answer for this, but this was the
> >> requirement to always return the non cached rates from the clock drive=
r.
> >>
> > =

> > Ok. Who knows about this requirement? Can we add someone from the
> > display driver to understand more?
> > =

> As per my discussions offline with the display teams,
> =

> There is a use-case where the clock framework is unaware of the PLL VCO =

> frequency change and thus the drivers would query to get the actual HW =

> frequency rather than the cached one.
> =

> Do you think keeping these flags would have any impact other than always =

> getting the non-cached rates?
> =


The flag will make it so clk_get_rate() works in spite of something
changing the frequency behind the framework's back, but I want to
understand what and why it's changing without framework involvement. We
shouldn't need the flag here, because this flag is typically for clks
that are controlled by some other entity that the kernel doesn't have
control over. In this case, it seems like we have full control of the
clk tree for the display PLL down to this clk, so it should be perfectly
fine to not have this flag. The presence of the flag means that the
display driver is doing something wrong.

