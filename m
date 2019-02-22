Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B3DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0603920818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550822565;
	bh=rzNzALqErAPnwJRW0AzmQYlT0Gmt30ILBXGTVjpDzZk=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=J4PH8aDNZWG5lq0GYzVbYMXAciDdAxw7b4kD/WSqdUI/vgu+xaZyQID3QzKE3Bxm4
	 /EhbB2Umu7Z2c+N9enA31rE4ilaop6287RoYEmAf+iBjOcLyWsu8e8ZdFs6lxUK5Sq
	 cgfUT7nwbffMqJyul9h0dmbCzevhE91rknJbCzXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfBVICn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:02:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:42280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBVICn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:02:43 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A25C320818;
        Fri, 22 Feb 2019 08:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550822562;
        bh=rzNzALqErAPnwJRW0AzmQYlT0Gmt30ILBXGTVjpDzZk=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=UP6PL3RWo5BApPQR6Y3M/r/WvafosAMBTMXb1HdKSqRx3/gtEeziexx+ptydISF01
         P5FcKFB6tXD7uIURrCIcfV1a3kNZ57oxCiVEoBLnvzaQcngai+lbi8S0d0aJcklMcx
         W7ayvOjYT4/8z+WtvoGrbs4MuUHFZWirvKSMPOgw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/6] Add clock support for Actions Semi S500 SoC
Message-ID: <155082256184.77512.7380378442221286861@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org> <20190201035343.GB4283@Mani-XPS-13-9360> <20190216041541.GB3054@Mani-XPS-13-9360>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190216041541.GB3054@Mani-XPS-13-9360>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mturquette@baylibre.com, afaerber@suse.de, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Fri, 22 Feb 2019 00:02:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-02-15 20:15:41)
> Hi Stephen,
>=20
> On Fri, Feb 01, 2019 at 09:23:43AM +0530, Manivannan Sadhasivam wrote:
> > Hi Stephen,
> >=20
> > On Tue, Jan 15, 2019 at 09:03:34AM +0530, Manivannan Sadhasivam wrote:
> > > Hello,
> > >=20
> > > This patchset adds common clock support for Actions Semi S500 SoC of
> > > the Owl family SoCs. This series is based on the initial work done
> > > by Edgar Bernardi Righi. https://patchwork.kernel.org/cover/10587527/
> > >=20
> > > Since there isn't any update from him for long time, I took the liber=
ty
> > > to modify his patches, address review comments and send to list for r=
eview.
> > >=20
> > > This series has been tested on Allo Sparky SBC.
> > >=20
> >=20
> > Can you please merge the clk patches so that I can take the DT bits thr=
ough
> > Actions sub-tree?
> >=20
>=20
> Any update on this patchset?
>=20

Merged the three clk and binding patches into clk-next.

