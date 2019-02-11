Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2033C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979AD222A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549892704;
	bh=ImfN+vmUn20H836hEVFAFzTx8ntD8FTdqyP2Dg5Q6Bk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Zd9pqMfjdDf2VQiNWaYpf+R9Gpo6CAOHbKJCDE1G0ZjhWjb23QBIHprYJApYMBptc
	 z+HxilIwHrkG/2x7OxHjLtFFdWhWja4Yr0iZ95VqrjruTV8sqSxYv6LMDNV7f4ivvx
	 hYJYSMvHDTUY8tBwUjzBldaBof3opOfaTt0PMbuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfBKNpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbfBKNpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:45:00 -0500
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 956EA222A6;
        Mon, 11 Feb 2019 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549892699;
        bh=ImfN+vmUn20H836hEVFAFzTx8ntD8FTdqyP2Dg5Q6Bk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eawjigs+IYJnJOInZZ9HdWTBDuFjXZtlsOZvf5sVSO8nO2oOJMBbdFx67qfON3MHe
         gseV6XY8ZGEDAc0iVK3R8Rw0LK+xHITDIU4rHX3kY3Mr18jCCJWAus45w8vW+nvrUa
         ooMhR11UDMczgR4zSapM3rrPAitpzvgAaKdpYSrU=
Received: by mail-lf1-f43.google.com with SMTP id b20so7753034lfa.12;
        Mon, 11 Feb 2019 05:44:59 -0800 (PST)
X-Gm-Message-State: AHQUAuZrdewVtLiAF3AC9A4hXz74bXeUHbolmhEXp9gM/YZd7+z+b8W4
        gKBPJm8nxyBy1KddO0M4txvAxcyy5DKhS1HpFB4=
X-Google-Smtp-Source: AHgI3IZJyOPJ4BwJcLlcEkxUaCYQBQpNb/lhBr6x/eGYnOGRC+J+oMYp0DQgWKN50vrO2s7HGzSE8Kqt+KOdIzyksCY=
X-Received: by 2002:a19:f013:: with SMTP id p19mr3595979lfc.154.1549892697800;
 Mon, 11 Feb 2019 05:44:57 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170120epcas1p211e1582a6124d6b7d0e33db6c0017480@epcas1p2.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-11-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-11-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:44:46 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcZhHyh6Lob8tFMdUdP5mmutA2g2bysF766a9+6ucpEww@mail.gmail.com>
Message-ID: <CAJKOXPcZhHyh6Lob8tFMdUdP5mmutA2g2bysF766a9+6ucpEww@mail.gmail.com>
Subject: Re: [PATCH 10/22] ASoC: samsung: i2s: Move opclk data to common
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
> The clock for generating I2S signals is also common for both CPU DAIs
> so move it to the driver's common data structure.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 70 +++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 37 deletions(-)
>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
