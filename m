Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D61DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C1A218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545236587;
	bh=QSkckDURgj+9WLccl7aLFxkVXmwA0nrKp4CtTj2gmo4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wzHEPkP8Zh1gvnzDJ0Mp3Jzbgi80qFSa35AJFr+ss9/ZV/8y4EDlRQtUEQZEvOUCS
	 bbO3b3RyNtXGLJlOXkBRKUXgwRw8C+FHGRnJKpsBcnk7plMEKq26MT/LDDLg9MhI+u
	 ZGVA2Yw1QM0pMc1sLHCJ/TJpUMGG4h7W9hm6ftfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbeLSQXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:23:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbeLSQXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:23:05 -0500
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F60B218D3;
        Wed, 19 Dec 2018 16:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545236585;
        bh=QSkckDURgj+9WLccl7aLFxkVXmwA0nrKp4CtTj2gmo4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nI2cMWd0QX4dAHKNVNISHLNv49/oWnuroLg7eNNixiNtZihlNJVM2TZ18w2PADQS7
         rQLrQdP4X7AGBQxa6P6KyiB2tYoxLz+x1ZmS/DgBlby/jhYccuNqkr5rN9XRfqH7kA
         t78sVpJmCA7Jx0u7m1bnV14nsXkxOxZ80NnRqvyI=
Received: by mail-lf1-f47.google.com with SMTP id e26so15500547lfc.2;
        Wed, 19 Dec 2018 08:23:04 -0800 (PST)
X-Gm-Message-State: AA+aEWYxG4ehTwpRG8WUzObFh9fUZsYfJ3Tgjsr/t47MUSI99NxzVY0r
        fVifM2cHh3XfIhwoBlwTUk7SCZwGyptGu0NCtUc=
X-Google-Smtp-Source: AFSGD/VO2kVSDgr7J8iQDZ0WsAGHEdvNG6Nk8qU4kQVGNZk3zhBgl1ex+2zT9Eb9YWL4arFoXrAPXSVSHpTYjYsQn6A=
X-Received: by 2002:a19:d8d8:: with SMTP id r85mr12753915lfi.92.1545236582750;
 Wed, 19 Dec 2018 08:23:02 -0800 (PST)
MIME-Version: 1.0
References: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com> <20181219155704.15264-3-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20181219155704.15264-3-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 19 Dec 2018 17:22:51 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfHHNUzQZu62btspC+6SwgoGPdAzusfSixXM7U9u3QP7A@mail.gmail.com>
Message-ID: <CAJKOXPfHHNUzQZu62btspC+6SwgoGPdAzusfSixXM7U9u3QP7A@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: gpu: samsung-rotator: Document s5pv210 support
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     Inki Dae <inki.dae@samsung.com>, airlied@linux.ie,
        jy0922.shim@samsung.com, Seung Woo Kim <sw0312.kim@samsung.com>,
        kyungmin.park@samsung.com, kgene@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 17:04, Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
>
> This commit documents new compatible for s5pv210 soc,
> which will be also supported by this driver.
>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  Documentation/devicetree/bindings/gpu/samsung-rotator.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.txt b/=
Documentation/devicetree/bindings/gpu/samsung-rotator.txt
> index 82cd1ed0be93..78658dec6941 100644
> --- a/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
> +++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
> @@ -5,6 +5,7 @@ Required properties:
>         (a) "samsung,exynos4210-rotator" for Rotator IP in Exynos4210
>         (b) "samsung,exynos4212-rotator" for Rotator IP in Exynos4212/441=
2
>         (c) "samsung,exynos5250-rotator" for Rotator IP in Exynos5250
> +       (d) "samsung,s5pv210-rotator" for Rotator IP in S5PV210

How about putting it at beginning as the oldest chipset? This would
require reordering the list so maybe let's remove the a/b/c list
enumerations? They are kind of useless.

Best regards,
Krzysztof
