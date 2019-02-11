Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9142C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8401F2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549892674;
	bh=LhPunQKnFzPArevg/Zqs99DsanjNR2sLG88+ce284Yw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oaxGA9+kDtyt/DKNooDtefEVQS5EdZ9WrYnSOpSVG+j1zjC3qN/lL8yC1kNWjzgi+
	 Gx1wDKrM/dWTzT86YY/XB+YUcw598FoLgtigvanCwQxT11v42P4V1N+3idEc64mCbt
	 L/FgSh5MA3ktgwc2/sw/63flLVSw/LHu1YhnPRV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfBKNod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:44:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfBKNoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:44:32 -0500
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC1F9222A6;
        Mon, 11 Feb 2019 13:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549892672;
        bh=LhPunQKnFzPArevg/Zqs99DsanjNR2sLG88+ce284Yw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BH0qNFglB3BOOjnP5kmM9+yQIxWagk8L83kSqHB8abc4hqUG4r2dLt3WsmFC0+L1Q
         Ag+J4Pk2XxEQsiPNIn8kf5xPIX5hSC1qP4wKQZEzVUn7vy/feF292w7wf1GLOIrl/h
         SxLp37XHLXMEi9Ywn4BtUZLcO305snCi0AUiE9ZE=
Received: by mail-lf1-f46.google.com with SMTP id b20so7751847lfa.12;
        Mon, 11 Feb 2019 05:44:31 -0800 (PST)
X-Gm-Message-State: AHQUAuYqq8XObHZZiUim73QD7fWwxRFF0i4i/29ElUgwAYcTxbMNjh8w
        cm08P10u+FD1QRLcHZKsV41eL7zHyuVKQutrTF4=
X-Google-Smtp-Source: AHgI3IauRUDjOCfXMPdcxMijCEYlegAtAnNNTAnZjjmjq3rDhKfI6adCDCFgpTdO8NA1IkQRW1a/JJkffJiumK4wszM=
X-Received: by 2002:a19:c48e:: with SMTP id u136mr15429450lff.167.1549892670118;
 Mon, 11 Feb 2019 05:44:30 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170116epcas2p1e0768a74062c8af83842ddb59309850f@epcas2p1.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-10-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-10-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:44:18 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdjH8W6O+DyMQYU_aTcj2yTouabcsxh2yViumkYu0XC8A@mail.gmail.com>
Message-ID: <CAJKOXPdjH8W6O+DyMQYU_aTcj2yTouabcsxh2yViumkYu0XC8A@mail.gmail.com>
Subject: Re: [PATCH 09/22] ASoC: samsung: i2s: Move core clk to the driver
 common data structure
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
> The core clock is also common for both CPU DAIs so move it to
> the driver's private data structure.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
