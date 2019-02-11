Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0E6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C612229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549892545;
	bh=as6+ZGJm2y+vWEaA73phHL2yDc9uYkzeuj0NuifwlsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B7Sr7iAhIX+HgmTaNeRVVGTnOBw3wLPPuJdndHkCwEa0pT+nK0zC6YUxnOzzSfp6l
	 37/wv6o71w2Mn6y79L7codldK857IOVUvJSzOzS5JhSWtEL3k1etlDIM9QZa6JkqKt
	 6byXnB6bHrfOMWcN3wA81g4yigFlEmqZfN7mQq6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfBKNmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:42:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfBKNmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:42:23 -0500
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 898192229E;
        Mon, 11 Feb 2019 13:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549892542;
        bh=as6+ZGJm2y+vWEaA73phHL2yDc9uYkzeuj0NuifwlsI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mGYP9GaSK25ZbcDVtFmPVIw+8uRZ8p8FybBpsvY+TvgnaRPRv08pV9qmJMICdyoQE
         oweYKzboMXa+tYtG7Gk0o6kfi1cUod1wCuEsbpdfu3TIscO9N18vqtTnSnlBae/yas
         rFK9r1O+IoW/7mxPPBDmWkpalVzrR5oJYC7tuLjI=
Received: by mail-lj1-f173.google.com with SMTP id j13-v6so8797346ljc.2;
        Mon, 11 Feb 2019 05:42:22 -0800 (PST)
X-Gm-Message-State: AHQUAuYLsj9cRE8JQfvRaHDwFIQ7Mc9q9innckmxRrqcEnhmomoxsrHi
        pFPU4q+2akBTwTfoLbwz1vmHhXvyWMEHpWEjAf4=
X-Google-Smtp-Source: AHgI3IYfN/lm4EUjPyBuFhetVXpzLeIidzPBPpmSwoyG+8HO9oJE0YPSbnSGALURUNQBLfaArU5oSOvri3X1SsC9DA0=
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr18829134lja.19.1549892540758;
 Mon, 11 Feb 2019 05:42:20 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170112epcas1p31ed740ef43d8a3eb71ca7245fba1bc3d@epcas1p3.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-9-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-9-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:42:09 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcaQHttvBzzrBnX41+5RrBgrxkDuLxTy1ao9kmC33AYwA@mail.gmail.com>
Message-ID: <CAJKOXPcaQHttvBzzrBnX41+5RrBgrxkDuLxTy1ao9kmC33AYwA@mail.gmail.com>
Subject: Re: [PATCH 08/22] ASoC: samsung: i2s: Add widgets and routes for DPCM support
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
> This patch adds DAPM widgets required to model the internal mixer
> of the I2S controller merging audio streams from the primary and
> from the secondary PCM interface.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
