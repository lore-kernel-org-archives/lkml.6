Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE140C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4D2222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550044738;
	bh=hDVJkJQCmtsGGjhiE0aWgXA8oGY3zK+mp3t2DTTl3gE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HapZMFDSRTOrHzGSD+RzGHZ8HScheAYSg10FC59VKNnStTmXrS+p4IKeBYSOV6Z3k
	 t7wNPMTwniu3uK6/vR1AlPf3ZhmyZHWsmCGFy4O0E2ploXpSBH2hC79LE9nrQl6dQq
	 p5aqGUTINDIEEyzYWhOgWx37UXphOhnAkndAwKjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389706AbfBMH65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:58:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731829AbfBMH64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:58:56 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39860222C7;
        Wed, 13 Feb 2019 07:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550044735;
        bh=hDVJkJQCmtsGGjhiE0aWgXA8oGY3zK+mp3t2DTTl3gE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m1nWmM/c0Bbi1GibIek8bLDYbMG1h3pnjzZlFC547sO6Al3xDC0/mlWLYJJ/qu6/n
         PjYZPDp9+va6tOWz8PZdahgiTNThv2FjC9jqtFaN/Z+2L4WivGbpEROi99zsJC6dFJ
         jn29kzr/VrS5Ag9wRf4mfF1aq3DDX7XkcVg2xH48=
Received: by mail-lj1-f175.google.com with SMTP id e17-v6so1162854lja.8;
        Tue, 12 Feb 2019 23:58:55 -0800 (PST)
X-Gm-Message-State: AHQUAuYNy9i3IeQ1PnfbtfrgDtciHmyHhK+IGi/yBAjKKTKb4Hbm/vKW
        m0NIj0qYkZr13l5lI49EU8L6W/lK+iQRvLOF85o=
X-Google-Smtp-Source: AHgI3IYuiezkauhSRJ83PC+tR4+Q1BK+VHgZ9j6cNBAcImI5FQkpTzTVdS3Cyh2eTxdumiORCtbtiiedVQfhZW1x70E=
X-Received: by 2002:a2e:999a:: with SMTP id w26-v6mr4739683lji.169.1550044733312;
 Tue, 12 Feb 2019 23:58:53 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190212180535epcas2p3aaa1c3d8fd9fcfb5a30bc6d132aba70a@epcas2p3.samsung.com>
 <20190212180342.32040-1-s.nawrocki@samsung.com> <20190212180342.32040-17-s.nawrocki@samsung.com>
In-Reply-To: <20190212180342.32040-17-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 13 Feb 2019 08:58:41 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe8wpP8ky8P4CPq4t51P+fjZ+7kecg2Vsq_9s=4Xa0VrA@mail.gmail.com>
Message-ID: <CAJKOXPe8wpP8ky8P4CPq4t51P+fjZ+7kecg2Vsq_9s=4Xa0VrA@mail.gmail.com>
Subject: Re: [PATCH v2 16/21] ASoC: samsung: i2s: Simplify pri_dai, sec_dai
 pointers usage
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

On Tue, 12 Feb 2019 at 19:05, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> If the probe call is on the primary DAI we can use 'other' in place of
> i2s->sec_dai, if the probe call is on the secondary DAI we can use 'i2s'
> in place of other->sec_dai.
>
> While at it fix one whitespace issue.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
