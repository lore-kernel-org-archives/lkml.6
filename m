Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68C3C5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A49920883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547838102;
	bh=Bgcjvd5HPLqNMwpcnJaTaHEC9lLIohbdbCPfKxN4rfQ=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=kAQdXLuoWdX8DOZ35+l3DEkT1MPXPNcfx1iYoOjhe/vRGBoRg/zsI0B5HfiUGs/OM
	 jP0NZFRsVMiLw3NKBkmcrfOTAtJgkv5dPI9cryPJbuxm9n4ZLy5C6GvlhvayD1KUY6
	 RxgTHkc+bNsmXYOGw6yX2gDcPR6W3qe66RmUHxjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfARTBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728583AbfARTBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:01:40 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD4392086D;
        Fri, 18 Jan 2019 19:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547838099;
        bh=Bgcjvd5HPLqNMwpcnJaTaHEC9lLIohbdbCPfKxN4rfQ=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=kbmCV9YMaL6BdWM0kT3X43ubRcXpK885yRkFO3+k+IrYlMYFc9LrS6OukCZv8EaAh
         vCkOnz0p/Dp+ruGo1gEE2wUKiE3akxgnj0knFe6f1qh3asshEit6SjozfAsJFASGhA
         2v/3gNFSUSYYpyRftsNm3Spg3hZ1Ajjszy2uaFs4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] clk: qcom: lpass: Add CLK_IGNORE_UNUSED for lpass clocks
User-Agent: alot/0.8
In-Reply-To: <6ad2f27c-0afc-af6a-8198-679a88dcc2f9@codeaurora.org>
References: <1545306385-31240-1-git-send-email-tdas@codeaurora.org> <154533989563.79149.10213938035592547726@swboyd.mtv.corp.google.com> <b6397ef1-a6df-0040-9dcc-c491b76a2f8f@codeaurora.org> <154689507747.15366.6553307032295093169@swboyd.mtv.corp.google.com> <adc9235a-3700-7730-a473-8a6baf47a1e0@codeaurora.org> <154750471090.169631.5712250327468594228@swboyd.mtv.corp.google.com> <6ad2f27c-0afc-af6a-8198-679a88dcc2f9@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Message-ID: <154783809872.169631.3437337484694848807@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 18 Jan 2019 11:01:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2019-01-17 03:19:22)
>=20
>=20
> On 1/15/2019 3:55 AM, Stephen Boyd wrote:
> > Quoting Taniya Das (2019-01-13 22:12:39)
> >>
> >>
> >> On 1/8/2019 2:34 AM, Stephen Boyd wrote:
> >>>
> >>> As far as I know, I'm not suggesting the use of CLK_IS_CRITICAL here.
> >>> But removing CLK_IS_CRITICAL and relying on some random bootloader
> >>> behavior also looks wrong. Can you clarify what's going on?
> >>>
> >>
> >> To enable LPASS clocks the requirement is to enable the GCC_LPASS_SWAY
> >> clock.
> >> 1) If the LPASS drivers are enabled/probed before the clock late init
> >> the client would take care to maintain the dependency to enable the
> >> GCC_LPASS_SWAY clock before enabling the LPASS clocks.
> >>
> >> 2) There could be a condition where the LPASS drivers would probe/init
> >> later the clock late_init. When the clock_late_init would try to access
> >> the LPASS clocks, since we cannot maintain the dependency this access
> >> would fail. To avoid this the earlier patch has made the GCC_LPASS_SWAY
> >> clock as CRITICAL.
> >>
> >> 3) Marking the GCC_LPASS_SWAY clock as CRITICAL has a issue, in the ca=
se
> >> where the LPASS subsystem would be restarted due to some critical
> >> failure on LPASS. Toggling the restart register of LPASS would clear t=
he
> >> hardware state of this clock and thus the next access of the LPASS
> >> clocks would result in failure of the system.
> >>
> >> 4) To avoid issues happening in (2) and (3) all the LPASS clocks chould
> >> be safely marked as CLK_IGNORE_UNUSED. And lpass drivers would take ca=
re
> >> of the dependency to enable the required clocks.
> >>
> >=20
> > Ok, so why can't we enable/disable the lpass sway clk in the
> > prepare/unprepare phase of the lpass clk driver paths? Or why can't we
> > forcibly enable this lpass sway clk after the reset is deasserted? Which
> > clk controller is the reset part of? GCC or LPASS?
>=20
> It is part of Always On Subsystem.

Ok. Is this merged upstream?

>=20
> >=20
> > It still sounds like the LPASS clk driver isn't handling dependencies it
> > has on accessing registers, but maybe we can get away with not handling
> > the dependency still if we make the reset "do the right thing" and turn
> > the clk back on so it stays "critical".
> >
>=20
> This is a reset from hardware and it does not bring back the clock to=20
> the previous state and so we can not mark it "critical". I would submit=20
> the next series with comments updated. Please let me know in case you=20
> have any comments.
>=20
>=20

Can we have the always on subsystem reset code go hit this clk enable
bit back on? And also have the LPASS clk driver get this GCC sway clk
and enable it during probe? Maybe we need to get some sort of API in the
clk provider layer that can tell us that the clk state has changed now
and it needs to be restored. I haven't thought about it deeply but that
may be the best solution here.

