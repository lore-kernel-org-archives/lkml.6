Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CA6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BBC218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550478718;
	bh=wmH5xtrgzA6vrA5s9kCPo+qLnTfqVMbr6qZ+lWy+EM4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ol3VFNsMXMFj1zUvEGHsdeI8r1ENBjAKukeH94uDgfsAuz1GWayNj428jW8LpSLbT
	 A3IZ+LwtltRG9uZElqbqpd/VlChduqiIceZz4z8agRKlyhSzW1tGUzF7uH9k6N4jv5
	 dDCmu63+ZPkltOQKcy5Cq9RR5Kmi6mqxBvWbLexw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfBRIb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:31:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbfBRIb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:31:56 -0500
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F2F218C3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 08:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550478715;
        bh=wmH5xtrgzA6vrA5s9kCPo+qLnTfqVMbr6qZ+lWy+EM4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pD6cFgu9rQIBsdvsW3SekMfzUj6fRazCGoqLUXEWqvZEyNpaeFA+M5VPt94f5Ld1U
         ijXWJ2kOsKhUniOiazelRKlDF16vvccnJGKd1ykhPMy1JQpEJBNhVSDz1ZcHlskofc
         vZ+1TJN4S2CHcgqpdoOOcFcuia6UA8f2V1yyjS0A=
Received: by mail-lf1-f50.google.com with SMTP id n15so11632699lfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 00:31:55 -0800 (PST)
X-Gm-Message-State: AHQUAuYZhT6skpnRxBCocwp6CMgBu3Xc4XWLh/5qIPNJyI++obX5NZDj
        l3IDMVZEs2tqnXjLsFXqF3Ym0DzICj2+PP4bGUk=
X-Google-Smtp-Source: AHgI3IZoFcJL28ctPEYUCpGrFnIwO2+Z/GGca1/qGaJRZdLKm5M9Xwo5aAW/zr7opiASot7/ykth+xaA7ebzpqhVxBU=
X-Received: by 2002:a19:d83:: with SMTP id 125mr12665670lfn.159.1550478713232;
 Mon, 18 Feb 2019 00:31:53 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190215144822epcas2p4a6187a4e4d45c7ac3ea067ac428b3678@epcas2p4.samsung.com>
 <20190215144809.28007-1-s.nawrocki@samsung.com>
In-Reply-To: <20190215144809.28007-1-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 18 Feb 2019 09:31:42 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdViVjS9ZzbBy94+UPK6-DEbCdPx-vsAa-SvrntyNunAA@mail.gmail.com>
Message-ID: <CAJKOXPdViVjS9ZzbBy94+UPK6-DEbCdPx-vsAa-SvrntyNunAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: samsung: i2s: Fix the secondary platform device registration
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 at 15:48, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> This fixes unregistration of the secondary platform device so all
> resources are properly released. The test for NULL priv->pdev_sec
> is not necessary and it is removed.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> This patch is based off of ASoC for-next and patches:
>  ASoC: samsung: odroid: Ensure proper sample rate on pri/sec PCM
>  ASoC: samsung: i2s: Prevent potential NULL platform data dereference
>  ASoC: samsung: odroid: Add missing DAPM routes
>
>  sound/soc/samsung/i2s.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index 6bf0f55d1e51..e36c44e2f1bb 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -1359,11 +1359,10 @@ static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
>
>  static void i2s_delete_secondary_device(struct samsung_i2s_priv *priv)
>  {
> -       if (priv->pdev_sec) {
> -               platform_device_del(priv->pdev_sec);
> -               priv->pdev_sec = NULL;
> -       }
> +       platform_device_unregister(priv->pdev_sec);
> +       priv->pdev_sec = NULL;

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Although I think that you might need to re-order calls in
samsung_i2s_remove(). In general they should be in exact reverse order
of probe(). In this case, clk_disable_unprepare(priv->clk) should be
after unregistering secondary device. If order has to be different
because of some reasons - could you document them in comment?

Best regards,
Krzysztof
