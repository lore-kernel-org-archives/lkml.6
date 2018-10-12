Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8C6C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C35A2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQzYjQps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C35A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbeJLXjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbeJLXjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:39:53 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24D9220835;
        Fri, 12 Oct 2018 16:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539360403;
        bh=nftVJ122uyq0S1+wltIQ+0goo2IYIgoTKJbD0UISEu4=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=kQzYjQpsxNsOmxxUsunkoULE4XasQYfFlkMEL6tv6wwewzwxay9VMD6bZPsxb2/nR
         kHyhDzDjl9u3LSGySPyQrrnE6OWUJ/uF0QzyraIMZOFmFruoRRMeQ4UUZ4sU91xORY
         q1jOAMAQsr9M7jc9g+KrAmsChuzsn8VHNjJB6nxU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <87woqoaty1.wl-kuninori.morimoto.gx@renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87efcy1rm4.wl-kuninori.morimoto.gx@renesas.com>
 <87bm821rkf.wl-kuninori.morimoto.gx@renesas.com>
 <153923999820.207691.114282732524143268@swboyd.mtv.corp.google.com>
 <87woqoaty1.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <153936040246.5275.14492857755273657122@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: add 74aup1g157gw 2-input multiplexer as clock driver
Date:   Fri, 12 Oct 2018 09:06:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuninori Morimoto (2018-10-11 17:37:30)
> > > +       .recalc_rate    =3D clk74_recalc_rate,
> > > +       .get_parent     =3D clk74_get_parent,
> > > +};
> > =

> > Can this all be handled by the 'gpio-mux-clock' compatible/driver? I
> > suppose it may need an update to add the rounding policy that you want
> > via some sort of DT property, but otherwise it would be fine?
> =

> Hmm.. not sure.
> If we can add new feature (=3D .round_rate ?) on gpio-mux-clock,
> I can consider it.

Yes that would be the idea. Extend gpio-mux-clock driver to have what
you want with rounding. I'm not really sure why there is a rounding
policy needed though. Is it a static configuration at boot, or does the
code using this gpio clk need to search the parent rate space somehow
and mux it over?

