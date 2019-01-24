Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1336CC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54D4218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548356007;
	bh=ys+cZcN7C23K41TchXjNNZ3jRHLKQYUbYdM0495oLvg=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=EYkTCbt9/1pleSpNEGoSblS7AaXPXvsGyfo1lQTGBz9FrMfVuHWC6FfECbaOTSb9W
	 gcqiZptajuokB9XnilZq585/Zb4uHSV/U2Lbt7fFnUdT09T8iiYhq6zqdztIq98uYq
	 fKWGvVfwgdEglivXxc6ivjoTERBt2GLg3jzsAxq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfAXSxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:53:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfAXSxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:53:25 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A236218A6;
        Thu, 24 Jan 2019 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548356004;
        bh=ys+cZcN7C23K41TchXjNNZ3jRHLKQYUbYdM0495oLvg=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=awatSxVAnH2L/XlBIz6WimIrenvKl+ck7m9gY4aRk1xh5B9vf8kspWEkPiAWsJ9B6
         XKbhdJh1wk7eKDs8sGg5548nOK0rgsx8x2pe6pA+mr84CUQPLW2LH6sehIYPh+31vP
         nk1M3CByM5duEF3qNUO2AqQttmP15AzruZNxFRi4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] Revert "Input: olpc_apsp - enable the SP clock"
References: <20190121062255.551587-1-lkundrak@v3.sk> <20190121062255.551587-2-lkundrak@v3.sk> <20190123220545.GD179701@dtor-ws>
User-Agent: alot/0.8
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190123220545.GD179701@dtor-ws>
Message-ID: <154835600359.136743.8585628353385883771@swboyd.mtv.corp.google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Date:   Thu, 24 Jan 2019 10:53:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Torokhov (2019-01-23 14:05:45)
> On Mon, Jan 21, 2019 at 07:22:54AM +0100, Lubomir Rintel wrote:
> > Turns out this is not such a great idea. Once the SP clock is disabled,
> > it's not sufficient to just enable in order to bring the SP core back u=
p.
> >=20
> > It seems that the kernel has no business managing this clock. Just let
> > the firmware keep it enabled.
> >=20
> > This reverts commit ed22cee91a88c47e564478b012fdbcb079653499.
> >=20
> > Link: https://lore.kernel.org/lkml/154783267051.169631.3197836544646625=
747@swboyd.mtv.corp.google.com/
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> OK, as clock folks say it is a bad idea it must be so. Merge though clk
> tree?
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20

Ok sure. I'll merge them through clk tree. I'll fast track it through
clk-fixes too.

