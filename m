Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB63AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A8821783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547247067;
	bh=Z1lCTTPpnhTR+sgeALta1GhiVWo3H7WodAW1f8zhS2k=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=GgFoyfz2/ToyPPT4TjHQ7H13tbmIMt3H+UpSfyvYBnPwHtylhNF9AoXAIDpm7H+li
	 P52eOGffldt3/mJfOv2eyJl2lQWTFw0SU2FFgu6T4vnC75SoYorih5j+Qr5qVI+wAt
	 AACHLcyEae+hWFWKTG+T9qpwn8sxrjMDNi+5liKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfAKWvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAKWvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:51:06 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 613F220878;
        Fri, 11 Jan 2019 22:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547247065;
        bh=Z1lCTTPpnhTR+sgeALta1GhiVWo3H7WodAW1f8zhS2k=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=a3lAodn1vtqMQjapK779eJy4pbWsfNGb8HMUdR2LMTOgdg8fNyiSTjMyr0pCYqYsj
         xrlqqUc8emJL/elboDmH3LwHOELKXBdgZlRLpSNCm9J/LV9863LyDjvZqFZme0HbkE
         /nALD28Q3qbZ7pcbz5m4C5K0ypAbwKJPQgTGeGrM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/6] Add clock support for Actions Semi S500 SoC
User-Agent: alot/0.8
In-Reply-To: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        afaerber@suse.de, mturquette@baylibre.com, robh+dt@kernel.org
Message-ID: <154724706468.169631.2903523518830581075@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 14:51:04 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2018-12-31 10:55:11)
> Hello,
>=20
> This patchset adds common clock support for Actions Semi S500 SoC of
> the Owl family SoCs. This series is based on the initial work done
> by Edgar Bernardi Righi. https://patchwork.kernel.org/cover/10587527/
>=20
> Since there isn't any update from him for long time, I took the liberty
> to modify his patches, address review comments and send to list for revie=
w.
>=20
> This series has been tested on Allo Sparky SBC.
>=20
> Thanks,
> Mani
>=20
> Edgar Bernardi Righi (1):
>   dt-bindings: clock: Add DT bindings for Actions Semi S500 CMU
>=20
> Manivannan Sadhasivam (5):
>   clk: actions: Add configurable PLL delay
>   ARM: dts: Add CMU support for Actions Semi Owl S500 SoC
>   ARM: dts: Remove fake UART clock for S500 based SBCs
>   clk: actions: Add clock driver for S500 SoC
>   MAINTAINERS: Add linux-actions mailing list for Actions Semi

What's the merge strategy for these patches? Some are for clk, others
are for arm-soc, etc. I see a sandwich of patches too so it sounds like
I can't even take just the clk ones for fear of breaking something that
the dts bits in the middle clear out of the way.

