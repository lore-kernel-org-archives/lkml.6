Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3FEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB9421874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546037416;
	bh=uVI3otFRq0tFWPeVcKd+mDKORvyqnzzM4+2NNrOZpvY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wzCU1WuGB8QdNp79GTAYIM+Q62YRryAmbNtz8qVMkIQ9v0ZsB4ZulnFEruhmAumKX
	 cB8ENbNCLEg/DjRin0aUsjHvCC2yiOwDmVNUEfKI6xIdVyKR3ztv/SDzZLm8jV8Twg
	 C+mMU/liSRsHV/RFaL/dZyB9odB+BYIgwKe84sw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeL1WuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:50:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbeL1WuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:50:15 -0500
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4288E21903;
        Fri, 28 Dec 2018 22:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546037414;
        bh=uVI3otFRq0tFWPeVcKd+mDKORvyqnzzM4+2NNrOZpvY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nLqDJKWJDHGNnXtb3MmAOHUpn0gw76A0gFmLKFDoFWqC0ezsKuUsXX2E7TJEOkh00
         xeezhDzpoAsSmOuG+RTcWQBPIOZva+DwMWMha+nbb5eaThU6oDGk4KBF3WoH1Mbu+o
         wWv62WYIxbezyH1IfwjtAkqKqpCgrMk7tay3SO34=
Received: by mail-lf1-f49.google.com with SMTP id z13so15347158lfe.11;
        Fri, 28 Dec 2018 14:50:14 -0800 (PST)
X-Gm-Message-State: AA+aEWbnDfQDE+FqdNKn4UxGQGLKIJwWxGFlQ3g2IWR1e/jJWs1EJ2Xn
        i6aY6U4Xh4ATQAlXVdCcAgPMPlewpuAFFghlu/k=
X-Google-Smtp-Source: AFSGD/V15kW1pbsIywPYvAVgrXECvr7WoEuIfoP9uIPHnRVftI4INopYcTh9/6YEDYpmMKF9BXc2hFU4DtXOqbEAPi4=
X-Received: by 2002:a19:a28e:: with SMTP id l136mr15895055lfe.87.1546037412298;
 Fri, 28 Dec 2018 14:50:12 -0800 (PST)
MIME-Version: 1.0
References: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com> <20181228151904.12079-3-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20181228151904.12079-3-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 28 Dec 2018 23:50:01 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcdKG4rkRh=AQ+zQPYRDbQo=eaOAMe5A6hvGDta796mTA@mail.gmail.com>
Message-ID: <CAJKOXPcdKG4rkRh=AQ+zQPYRDbQo=eaOAMe5A6hvGDta796mTA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: gpu: samsung-rotator: Document
 s5pv210 support
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

On Fri, 28 Dec 2018 at 16:19, Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
>
> This commit documents new compatible for s5pv210 soc,
> which will be also supported by this driver.
>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v1:
>   - Removed list enumeration
>   - Placed s5pv210 at beginning of list (it's the oldest chipset)
> ---
>  Documentation/devicetree/bindings/gpu/samsung-rotator.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
