Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C037CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90855222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549892868;
	bh=v5EPjsuzKTm49QfitWviH9ViqUGCji1VSww8+uZ5br4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nqo+YapOn2qiWK5Tmh090bn9A1a59A5UGjaGR6pH3X++1amcdS2mOkh/AV5Fgit4v
	 NaV84hxl+eWjWzTDeBRLmqLFBK4aCUpNi8ux/KRPV3wtx/CIMHXGDniuIvNz4wYKGG
	 rk2jg0GzcjlceOJNTCobwoiUGLJHj2vd/TZX7rao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfBKNrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:47:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbfBKNrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:47:46 -0500
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04F08222A5;
        Mon, 11 Feb 2019 13:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549892866;
        bh=v5EPjsuzKTm49QfitWviH9ViqUGCji1VSww8+uZ5br4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o05xEzpbR1/9Q+fxEQz34gD5O01dlSKvbFdrmPm8FNL56j6s7/WvguChy1CjnBRAW
         a8SJLp+GuIUPOZIRRp3YYcV400NXjiLFzWgi/8uj9Sae7u9CvhAeWneCUG0YkEwh5a
         G7AntANcsGVlA4EtvBaox1XSAGlyJG35uLr+/EKk=
Received: by mail-lf1-f51.google.com with SMTP id j1so7765323lfb.10;
        Mon, 11 Feb 2019 05:47:45 -0800 (PST)
X-Gm-Message-State: AHQUAuYAukio+U27ujxYCm8udQ6NwiRzNlpu1TQXLKnMdDjfEUf5dM++
        mxciXWEf6ZdsdvK84Lrts3EqO8MWh1m2cdzV280=
X-Google-Smtp-Source: AHgI3IZPizeOYx3ePfRbmSK3MhBmzNdifN+NUzkX6lyvseyTZwQzcl7Dl9bDaJixcmXbjUiMiByB3a9drc5KECfDbzQ=
X-Received: by 2002:ac2:4194:: with SMTP id z20mr10844479lfh.74.1549892864211;
 Mon, 11 Feb 2019 05:47:44 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170130epcas1p4809b7a8dc797ced2982dc3b305a0991b@epcas1p4.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-14-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-14-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:47:32 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd8_fA28owNtr6Rabq52dE_P3JF0NBLCrdVYcn_ftHJig@mail.gmail.com>
Message-ID: <CAJKOXPd8_fA28owNtr6Rabq52dE_P3JF0NBLCrdVYcn_ftHJig@mail.gmail.com>
Subject: Re: [PATCH 13/22] ASoC: samsung: i2s: Drop spinlock pointer from
 i2s_dai data structure
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
> As we now have the 'priv' pointer in most of the places we can use
> priv->lock directly, dropping extra indirection in the SFR region
> spinlock access.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 51 +++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 27 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
