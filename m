Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197A4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB9A222A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549892784;
	bh=dsx+q7cExN+ksmGLcEIG0Ck3AgA4YrIezx95HO3zG9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SkY2DfNE6ld1QQ2nlr8dX2cFAVZmKF0+D4s+eMUMlI4HflxU2ws8HV39TmU/Fcu5A
	 gk23qxfdzmKYA79OwU1yHixWRSGGqxprRdOIMmPSiEQMe5iJgZPYkzTQJnceQluPfM
	 KcIbd5f98ZkKskWFg+aZ6OG5HA5D1QfOrGGzgLAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfBKNqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:46:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbfBKNqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:46:20 -0500
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A70222AC;
        Mon, 11 Feb 2019 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549892779;
        bh=dsx+q7cExN+ksmGLcEIG0Ck3AgA4YrIezx95HO3zG9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M7NX0dj6FLM1Ql4+u8LGZN251/3GZ+5mzPx8cTMJKoigV3ylZYuzHiQ56sTbk5FrH
         ofjz+XepUaeJ86erX7ImMdjF3LWmNXjP09DtQGieZrgjteEfM4KyjBWKXVWl+huXIM
         emf1CSMFh+fYLg1sSrFA5MS1t7PvGUizK69d5nfA=
Received: by mail-lf1-f49.google.com with SMTP id u21so2330510lfu.1;
        Mon, 11 Feb 2019 05:46:19 -0800 (PST)
X-Gm-Message-State: AHQUAuYkjJSBrkAqjfiH8bs0dZFd86LuLpmZ40QaaCVE/yacu9a/zBfs
        R5HFlw52RUQmfwVkuvZNpJJ9R15kQsVJVxyh7Rw=
X-Google-Smtp-Source: AHgI3IZm/k8D64T9NQuXNN8XxpIEPfbWxnX7a9G/v9c/KZCPOd5MMyVQd9r6hCfgQaRw+w3W/bseGIknPSLko0ZpMfo=
X-Received: by 2002:ac2:4194:: with SMTP id z20mr10840382lfh.74.1549892777431;
 Mon, 11 Feb 2019 05:46:17 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170127epcas2p31da340c3f63e75e7bcb5c9c864a42173@epcas2p3.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-13-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-13-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:46:06 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf4H5MEWsBLe2R3ro3+Jsrzexeu9k9NK6eY5nWY_Lq8zw@mail.gmail.com>
Message-ID: <CAJKOXPf4H5MEWsBLe2R3ro3+Jsrzexeu9k9NK6eY5nWY_Lq8zw@mail.gmail.com>
Subject: Re: [PATCH 12/22] ASoC: samsung: i2s: Move SFR pointer to common
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
> The SFR region is common for both DAIs so move related data structure
> field from struct i2s_dai to the common driver data structure.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 105 ++++++++++++++++++++++------------------
>  1 file changed, 58 insertions(+), 47 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
