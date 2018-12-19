Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11B7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA80218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545236700;
	bh=ToLZrp4f+MWoAKXWfE3u0PBIjE7fElyAJL+tuW+N2fg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aFCY2HqYlIxbHQPOdx1e0b5HZJXO/aQmlFFfhQAUfpnzAn2sivWdAexgft2nS+xBO
	 T8/3QRcO3ELVkbvtXbZN7U/36bGhdUOtXixO16mk+QX4olAc96ElIN7nLcjIQYc9uv
	 ZWNIeUZoiUuuxMiY+8Kve5tu3dQ62seZWveFRXvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbeLSQY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:24:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbeLSQY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:24:59 -0500
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2013A218D4;
        Wed, 19 Dec 2018 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545236698;
        bh=ToLZrp4f+MWoAKXWfE3u0PBIjE7fElyAJL+tuW+N2fg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IfFb5K1mTnvg9fcl7xkP9cB01SU4QJEOzEBSy44yF2dOltjWYoiYNM8FuMLAZ7dbn
         TI9RtMK9XHVT9b6sgr3l7rRrdbfSlgUNDT6rQaLRS9RiClT1B8RTZEpxyBuyfyY36y
         manRr9YDXEC3bn6fYjRVOEQS/Hvy0tRK+A7WmOic=
Received: by mail-lf1-f45.google.com with SMTP id b20so15467863lfa.12;
        Wed, 19 Dec 2018 08:24:58 -0800 (PST)
X-Gm-Message-State: AA+aEWb/0rC2UJhB+VoeHKNdcDevj285tht/OZnZaOuToWAJ54fAI2U9
        qOeN6q7e5QZq/wqYo7enFcSzFwXFqvedGrZGVqU=
X-Google-Smtp-Source: AFSGD/WbBkY6fbbtvOcginDxp+XpGUfEBoNEfzCOOju8eiMWJnsrHpMaO3zwGkpkxieOFartugGT3UIgFFZk5pYF1ak=
X-Received: by 2002:a19:660a:: with SMTP id a10mr14085124lfc.146.1545236696261;
 Wed, 19 Dec 2018 08:24:56 -0800 (PST)
MIME-Version: 1.0
References: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com> <20181219155704.15264-4-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20181219155704.15264-4-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 19 Dec 2018 17:24:45 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdFSqsKswPHUFCRZ436yWX9evFzyAo75DNkU=fznppCAQ@mail.gmail.com>
Message-ID: <CAJKOXPdFSqsKswPHUFCRZ436yWX9evFzyAo75DNkU=fznppCAQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: s5pv210: Add node for exynos-rotator
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
> This commit adds node for Exynos Rorator device,
> so it can be used on all s5pv210 based devices.
>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/boot/dts/s5pv210.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)

Patch looks good but it is too close to merge window so I won't be
able to send it further. I'll pick it up for next cycle, after this
merge window.

Best regards,
Krzysztof
