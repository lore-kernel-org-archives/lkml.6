Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A4316256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCD520894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="niJ9A2X+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCD520894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbeG3SB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbeG3SB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:01:58 -0400
Received: from localhost (unknown [104.132.0.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F163C20870;
        Mon, 30 Jul 2018 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532967974;
        bh=Z0bbgSW9XilYmBig0cf/W2OghYPpfgrXhZQJouMUuEA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=niJ9A2X+sIdt+J+lJFErYW54zMmQig8YdK26nEVhP0qXYjB0QgSqSlL8yqIR3opaA
         HkhRKK5/eyKNW2oop+mCmVz8xwk4tUTXQZw+OnLSnDW6XA/xOvddndjwWS2S5twWC8
         GpcIW5zzAa1NIxQLJes8PbzgN8Oww0Nr+FBHBJSc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180730114056.GA17362@e107155-lin>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        linux-clk@vger.kernel.org,
        LAK <linux-arm-kernel@lists.infradead.org>
References: <1532700112-11852-1-git-send-email-amit.kachhap@arm.com>
 <153270946725.48062.11195853363758024681@swboyd.mtv.corp.google.com>
 <CADGdYn5T2-B2UE9DX3wFHdvqfF85n0NAbKDBf2KHOQreRi=H+g@mail.gmail.com>
 <20180730114056.GA17362@e107155-lin>
Message-ID: <153296797329.17365.14490424418553594815@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: scmi: Fix the rounding of clock rate
Date:   Mon, 30 Jul 2018 09:26:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sudeep Holla (2018-07-30 04:40:56)
> On Mon, Jul 30, 2018 at 11:03:51AM +0530, Amit Daniel Kachhap wrote:
> > Hi,
> > =

> > On Fri, Jul 27, 2018 at 10:07 PM, Stephen Boyd <sboyd@kernel.org> wrote:
> > > Quoting Amit Daniel Kachhap (2018-07-27 07:01:52)
> > >> This fix rounds the clock rate properly by using quotient and not
> > >> remainder in the calculation. This issue was found while testing HDMI
> > >> in the Juno platform.
> > >>
> > >> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> > >
> > > Any Fixes: tag here?
> > Yes, This patch is tested with Linux v4.18-rc6 tag.
> >
> =

> No Stephen meant the commit that this fixes, something like below:
> =

> Fixes: 6d6a1d82eaef ("clk: add support for clocks provided by SCMI")
> =

> so that it can get backported if required.
> =


Yep! Thanks!

