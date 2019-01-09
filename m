Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A5BC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E236B214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547060355;
	bh=9wQSqXTXQITGVaGZVT+TVz3KKCITj1WWQqUmA7iw9DI=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=DWtDe0NTa1HUKfRVuHm+X5UHwvxceITWkxVQMX7thkv/xUZJU5s4b52NXgr/nxvsx
	 pIn2U2tS7NT05xI+IrnlP8TsJ6PKaOM1uZazHXNwEP1npbOmzrIjvspk3sO3K3gI6u
	 g+zKyJ27Sq5wKMjhKvd3Lzz3+pH+RNqNZW5ueGhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfAIS7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:59:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfAIS7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:59:13 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5D2420859;
        Wed,  9 Jan 2019 18:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547060352;
        bh=9wQSqXTXQITGVaGZVT+TVz3KKCITj1WWQqUmA7iw9DI=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=D6IFDTP0BA9yUwoIyGJd0b2I/Cd//pEKhkuA3BaEbeXFt+EaLn3bSz0C4zeGUgn6x
         JVuLFgTF/R0mqNIshqk3NIZbxxpeik1a2takdMGWX5OpHch6LZyNFb4xYhg3Y+dWz4
         rC20HSU66H1Ayoi4OQ7VTh5CE5mCmuDv7m+MUO5w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: qcom: Add CLK_SET_RATE_PARENT for 8998 branch clocks
Cc:     bjorn.andersson@linaro.org, marc.w.gonzalez@free.fr,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org
In-Reply-To: <1545099134-26471-1-git-send-email-jhugo@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <1545099134-26471-1-git-send-email-jhugo@codeaurora.org>
Message-ID: <154706035216.15366.40165828357929779@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 10:59:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2018-12-17 18:12:14)
> A branch clock is basically a clock that can be gated for power savings,
> but is also what devices/drivers consume.  Configuring a branch clock's
> rate needs to be done at the source, so for all branch clocks which have
> a defined parent, set CLK_SET_RATE_PARENT so that clk_set_rate() calls on
> branch clocks can do what is expected.  This is important as most drivers
> do not check the resulting clock rate after a successful clk_set_rate()
> call, thus the driver may get out of sync with the actual hardware state
> and weird issues might crop up.  This has been observed with issues
> getting SDHCI to reliably support "fast" cards such as SDR104.
>=20
> Fixes: 4807c71cc688 (arm64: dts: Add msm8998 SoC and MTP board support)
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---

Applied to clk-next

