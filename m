Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C829AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A0F21924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550215498;
	bh=gCMvMJB8jyS5NVoL6Bpbbi0W9NYjiZmOLDG06SjhFJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vLdl0g5ozfTbZe/2fmOi1+No/2h3bFGItGRg6MxicOUnTRZzYcWqP+MwSHlOq2q+H
	 xlluqbWe4FCNG3jKJ9jIZGnCsUfCQUlIMLiXZ8HfUVXpcz1UK6qF1UUY/+fTiuFYYQ
	 U9LzOFSBSbi1oV4FZ96323J6WojAbs9UK73tRkNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389675AbfBOHYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:24:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfBOHYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:24:48 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D78F21920
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550215484;
        bh=gCMvMJB8jyS5NVoL6Bpbbi0W9NYjiZmOLDG06SjhFJo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=elUxCBq9+hoeWcTe7EJljJhmFxCwbIjW8R+qSwWDjcUQuJSAjzr0hEvuFgWbY3bAO
         SGfJvi3dN4oYubvh6sYttAtJFkWWxTZSHRsPRz4Lvky+bGy8OGSJQ4PgvOwvsvGWE5
         jusdq3g88SDbwSn+6m/5tu+PntrnZdohlX1wdhdY=
Received: by mail-lj1-f178.google.com with SMTP id e17-v6so7477324lja.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 23:24:43 -0800 (PST)
X-Gm-Message-State: AHQUAuaRSqStQ43IMKY9ivG2o7uxUVoXBILVWiVIxtZl8AqoyOD0vw9g
        4eRvb5/gW+qIjlaPzUnBGwvVQ4grHvQxGdIwJxE=
X-Google-Smtp-Source: AHgI3IYrD6/FF6hobnvbge7h1TRGNYtf/3xPgUP2DGPCY4dWydPmXDhXmqV6nukzwcW/euc+XI5Wqmq9j2ytDgnyAoc=
X-Received: by 2002:a2e:3a10:: with SMTP id h16-v6mr4865196lja.184.1550215469733;
 Thu, 14 Feb 2019 23:24:29 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190214160039epcas2p34b9e3b3ca5f9b0aa1fb5ed59403a6fe1@epcas2p3.samsung.com>
 <20190214160011.3940-1-s.nawrocki@samsung.com>
In-Reply-To: <20190214160011.3940-1-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 15 Feb 2019 08:24:17 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd20QPjvEV_TzKi8fcJM-Ws4Te6W0ZRvzNVt2c-60VKAQ@mail.gmail.com>
Message-ID: <CAJKOXPd20QPjvEV_TzKi8fcJM-Ws4Te6W0ZRvzNVt2c-60VKAQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: samsung: odroid: Ensure proper sample rate on
 pri/sec PCM
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 at 17:00, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> Currently when playing sound with different sample rates actual
> sample rate will be determined by audio stream which starts first
> on either primary or secondary PCM. The audio root clock will be
> configured appropriately only for the first stream. As the hardware
> is limited to same sample rate on both interfaces we need to disallow
> streams with different sample rates. It is done by this patch by
> returning error in FE hw_params if there is already active stream
> running with different sample rate.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/odroid.c | 56 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)

Is this the fix for
"aplay: set_params:1403: Unable to install hw params:"
which appeared in today's next (so after your last round of patches get merged)?
https://krzk.eu/#/builders/1/builds/3093/steps/24/logs/stdio

Also, since yesterday (so with previous rounds of patches) the audss
rebind freezes entire kernel:
https://krzk.eu/#/builders/1/builds/3093/steps/25/logs/stdio
https://krzk.eu/#/builders/1/builds/3093/steps/25/logs/serial0

It is not important test but it was always passing in my suite.

Best regards,
Krzysztof
