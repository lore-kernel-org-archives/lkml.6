Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555F6C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1882820880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544454797;
	bh=dDdcSD7bp88X/qUQ7li/kWdFcWPzomLjZ2LS0nIncr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f9fVBQUHIP6sbesJ1Xjbe85Vt76pI0NItzI+MFljQAOL3xCjUcMb5o7+5DgVE11eW
	 3k7JJ+c98F7Z6X7gw4jaKP9+bYk1XDNCxwOsxnzUV0H41I8BpC03Fxgpv3U1ceY8ad
	 R8FT+ZoFk7Jpd0KR/cRxr0UHzR6rcLJfeRwQpZx0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1882820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbeLJPNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:13:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbeLJPNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:13:15 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28F6820880;
        Mon, 10 Dec 2018 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544454794;
        bh=dDdcSD7bp88X/qUQ7li/kWdFcWPzomLjZ2LS0nIncr8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c9o0Iybl72eNWTMT+2cl59R8cWmnK8rbuggLVw+zX2Jm6XhhHZc3sCL9uerXFypsj
         oHoXNUgyqhzUSGql/3wG8n8BnoZgyFZ5S2A7s+lHP32MIq9imbSzu3/gvmZoOsoHrF
         CXQvyhVZwbzuwLs8pajnFvxWpl5FEo0EiVBKROOM=
Received: by mail-qt1-f173.google.com with SMTP id y20so12578380qtm.13;
        Mon, 10 Dec 2018 07:13:14 -0800 (PST)
X-Gm-Message-State: AA+aEWay2NKQzQZKQhz4hclXHGtqTiCpFPRdtY7wgxF84lOn4s7IxDmZ
        nL+VIXnIUOVgnBL+Ky9ViaeVlkGr2BIYyqB46g==
X-Google-Smtp-Source: AFSGD/UiArMNFA82E9QwxjiY0qfhpCbk+7rMiWiC+7FVOKqgbNQMOEyhls+PoQniOcLqNQkSqw079lkOVCqQCfwGZlY=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr12028373qtd.257.1544454793279;
 Mon, 10 Dec 2018 07:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <3170130.k0DT9deCHj@phil>
 <CAL_JsqLwSg=CWQYzvfCq9WVexU5donsF6ugib2ONNN3vvjzZXw@mail.gmail.com> <2386212.ILKoqq0Ivo@phil>
In-Reply-To: <2386212.ILKoqq0Ivo@phil>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 10 Dec 2018 09:13:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL9PyD=0jy+GF5g8ee-FO_ijvArnzEohuvqK5Od3yr7fg@mail.gmail.com>
Message-ID: <CAL_JsqL9PyD=0jy+GF5g8ee-FO_ijvArnzEohuvqK5Od3yr7fg@mail.gmail.com>
Subject: Re: [PATCH v2.1 24/34] dt-bindings: arm: Convert Rockchip board/soc
 bindings to json-schema
To:     "heiko@sntech.de" <heiko@sntech.de>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 9, 2018 at 4:14 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Convert Rockchip SoC bindings to DT schema format using json-schema.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> [move to per-board entries and added recently added boards]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Hi Rob,
>
> there are boards where the description adds much value and on others
> it is maybe less, but personally I'd like to keep things uniform,
> as that makes reading these things easier if the format stays the
> same all the time, so I've gone forward and just did the conversion
>
> make dtbs_check did not complain about the schema it seems but I
> did end up with an error later on:
>
> FATAL ERROR: Unknown output format "yaml"
> make[2]: *** [scripts/Makefile.lib:313: arch/arm/boot/dts/rk3036-evb.dt.yaml] Fehler 1

You need libyaml and its headers installed so dtc can output yaml, but
that's not needed for checking the schema against the meta-schema.

> But I guess I did not mess up the schema yet.
>
> So does it look ok that way?

Yes, but one comment...

> +      - description: Firefly Firefly-RK3288
> +        items:
> +          - const: firefly,firefly-rk3288
> +          - const: rockchip,rk3288
> +
> +      - description: Firefly Firefly-RK3288 (beta board)
> +        items:
> +          - const: firefly,firefly-rk3288-beta
> +          - const: rockchip,rk3288
> +
> +      - description: Firefly Firefly-RK3288 Reload

Seems like combining these 3 (or first 2?) would make sense if this is
just revs of the same board.

But either way is fine.

> +        items:
> +          - const: firefly,firefly-rk3288-reload
> +          - const: rockchip,rk3288
