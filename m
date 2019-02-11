Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62ADC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA6E222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549892739;
	bh=E6coOdyHY5fGJ9aYr3HY2kzJGWR8GXZ4UjupezIYE94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=adknG2Ka+ZEbctSmoh+p5d6jX3rC5EGLHvleDF41TnkMdFmwws/QSwEuMyN0P/ccW
	 y/PENoGoECWptoaPTgE1MCTV41MOSkZOrF6SbuAFqMGVZ9HO9PiD5QCMyRVwIvNHdg
	 Lqh+C353rWJnIfvCq2JznmrsaRnLEIvenEVojBG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfBKNpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:45:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbfBKNph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:45:37 -0500
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0CBF222A5;
        Mon, 11 Feb 2019 13:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549892736;
        bh=E6coOdyHY5fGJ9aYr3HY2kzJGWR8GXZ4UjupezIYE94=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dr5xJKz0B8/ukktC8Hw7Wf2ZeEj+hADvyvrgdyoTbtw+3YWFuSIWBexlkoIL5S4Ws
         8p6PaDINoiolkK1fZ3y9cQI/w3YMDWHlnx8DT8kubJ9GnnBqPX8Pqxc2tEQgB9ICB6
         yR5feYCkCYW40E7Uzc81NHImWeS+6quPTvKQXhHI=
Received: by mail-lj1-f173.google.com with SMTP id c19-v6so8787548lja.5;
        Mon, 11 Feb 2019 05:45:35 -0800 (PST)
X-Gm-Message-State: AHQUAuZqAcP6CzqoyV92Ctz9WeOZENGQEbOp8eeKU1PUjj9g7Ioyth5g
        9akZm1uEWHFtOZkJma0uANuJt8TTgqbedR67aBQ=
X-Google-Smtp-Source: AHgI3IYsG/bbzvjva/BXs5SS1s9mfMAVlzxUjIkkIReIL3VCYCeXh4KGwyMeVWvbNRjEa3orDHDDOSvbNBBkM145pGg=
X-Received: by 2002:a2e:3a10:: with SMTP id h16-v6mr21908495lja.184.1549892734231;
 Mon, 11 Feb 2019 05:45:34 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170123epcas1p2fae464ba7f102d841548c5a523cc6660@epcas1p2.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-12-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-12-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:45:23 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdtUi_n_-zmznziMz41SXr9mMDb+QNoz2Kj1hjTfxcLdA@mail.gmail.com>
Message-ID: <CAJKOXPdtUi_n_-zmznziMz41SXr9mMDb+QNoz2Kj1hjTfxcLdA@mail.gmail.com>
Subject: Re: [PATCH 11/22] ASoC: samsung: i2s: Move registers cache to common
 driver data structure
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 at 18:01, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> There is no need to keep the PM suspend/resume register cache separate
> for each DAI as those registers are common, move related i2s_dai data
> structure to the driver's common data structure.  This will allow us
> to simplify the code a little eventually and to make it easier to follow.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
