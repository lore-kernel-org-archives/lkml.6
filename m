Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FAAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B8A206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547248852;
	bh=o2P8ttXrh+vvAaghmRZs97QsHcoinWVkF+uHKclR9J8=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=QuF0L2Mg3PO/cXAJCMTQNw9HsyYvZo/bJeQQJrtr6whNfGs/9ixZo6C3gendRVN5/
	 iObwQoTTOyJ/FZztd63nMK29LjPQhRx/R2+SHBKPq7k5J7skI3aMhsAUvbV5vSlOMN
	 LoMZ2x2V0dUunvp9TljQqIZdNxNJk7pjtkM9u3S0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfAKXUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:20:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfAKXUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:20:50 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9928D206B6;
        Fri, 11 Jan 2019 23:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547248849;
        bh=o2P8ttXrh+vvAaghmRZs97QsHcoinWVkF+uHKclR9J8=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=RRLDs1jhx7WxNmB7onUwxdPl2E+U/xNp/VTdtErKSnkOT81zD31vsq3wdfkIgkubk
         uERPxXwlAflhElksZVEPopZAWp0KuHi50syfn/y/A6uj4xDcBfV8qzAFSm1gYNxuiP
         9/3RobCsRVxL3cHCr4zrl7WzHV034LtlTyY4iELQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/7] dt-bindings: sdm845-pinctrl: add wakeup interrupt parent for GPIO
User-Agent: alot/0.8
In-Reply-To: <CAL_JsqL1z-iOewqBeE43n1cVSGiQyOPHBGbRmEm9zcVLJkoLEA@mail.gmail.com>
References: <20181219221105.3004-1-ilina@codeaurora.org> <20181219221105.3004-5-ilina@codeaurora.org> <20181229000714.GA3654@bogus> <20190107185113.GH14960@codeaurora.org> <CAL_Jsq+McuN5F9_a2bmECegR65vziNATpUqt4hysKL7FT=b9RA@mail.gmail.com> <20190109173111.GB22547@codeaurora.org> <CAL_JsqL1z-iOewqBeE43n1cVSGiQyOPHBGbRmEm9zcVLJkoLEA@mail.gmail.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org
To:     Lina Iyer <ilina@codeaurora.org>, Rob Herring <robh@kernel.org>
Message-ID: <154724884881.169631.9705938789464714812@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 15:20:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2019-01-09 11:36:56)
>=20
> > >However, my main concern is documenting something genericish in a
> > >device specific binding. It looks like Tegra is trying to add the same
> > >thing, so this needs to be documented in a common place. One question
> > >is whether wakeup is the only use or if this should be more generally
> > >a secondary interrupt parent?
> > >
> > Yes, wakeup is the only use of this interrupt parent.
>=20
> Maybe for you, but I was wondering about this more generally. Should
> we encode what the function (e.g. wakeup) is in the property name or
> have something like aux-interrupt-controller? Maybe some platforms
> have some need for a secondary interrupt-controller which is not
> wakeup. Routing interrupts to other cores perhaps?
>=20

I'd say it's not the interrupt-parent, but a secondary-interrupt-parent,
because it's another path that some GPIO interrupts will go through vs.
the "normal" summary irq line that uses the interrupt-parent. Maybe
that's similar to the interrupt partitioning that ARM is doing for PPIs
that only go to some CPUs?

We don't really specify that some GPIO is corresponding to the secondary
or primary interrupt controller for the GPIO controller in DT. If we
did, then we could do something like the interrupt-map binding and have
the index of that property be the gpio number and the interrupt parent
that it maps to (either summary from the GIC or MPM pin number).

 interrupt-map =3D <0 0 &gic GIC_SPI 208 0>,
                 <1 0 &pdc 3 0>;
 interrupt-map-mask =3D <0xfffffff 0>;

And then we would pass the 2-cell GPIO interrupt specifier (gpio# and
flags) through the table and remap it to arbitrary domain parents. We
could use this same design for the SSBI and SPMI gpio interrupt
controller where we're currently looking at hardcoding the base
interrupt number in the driver (0xc0) and then adding the GPIO number to
that to get the parent interrupt specifier.

It's sort of an abuse of interrupt-map, but I don't know if it really
matters because there isn't a child of the gpio controller that is going
to go through this table.

