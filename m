Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C5CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B4820849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544541684;
	bh=MN+FVvQINETTAzbt/6M6OzA7pw/8ygRELcMtNjRkSNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZPg04cEzP6ON1J8/Bx0fT+BDIQ6lAVBf2V/aoFNG8uX6aFJTqptzTNCKHTgH8T8hc
	 CMkB4JteVlsoEnkxW0txJkAPxsRMeo8YwSogeL58NhGBWIN0qwuXj7k3KLgV410E8R
	 jBHyTXf//beYYOxmXwCE3j+DyJSnIloharZ4IVwQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B4820849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeLKPVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:21:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbeLKPVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:21:22 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3E532086D;
        Tue, 11 Dec 2018 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544541682;
        bh=MN+FVvQINETTAzbt/6M6OzA7pw/8ygRELcMtNjRkSNE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OJesZVlS4er7UhlJCLUyoV9gIhNSFBtJ71flK1utj007ehBSezBa7tS3LBzE0p4ZL
         3h3hyjIehcxG2XLEFsI1PNoKlO95FVhQ5kg+ZlUmWKaFTYEfRAHsA/pY+FY62liViP
         X+E5YxM362nwmlnl97kE2y8gzgOcsmTCdikQKdW8=
Received: by mail-qt1-f181.google.com with SMTP id d19so16753789qtq.9;
        Tue, 11 Dec 2018 07:21:21 -0800 (PST)
X-Gm-Message-State: AA+aEWbSRn6+aR/0fD4Gg1g8zmn8BkVP/E9hfBVH+lgC6Y0duzNHt3ht
        9nZVaVwy5jszrL3a8DQv1hQTzLxJck+kIk5i3Q==
X-Google-Smtp-Source: AFSGD/XFaIYHDTZFTa8PfVID46pmbMMnOQVY1369UWTWxpKlWlUEEIGBsIS7bfvqXeFJzeuGgja/q0HJkT/ANyFJ4gc=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr15996574qtd.257.1544541681127;
 Tue, 11 Dec 2018 07:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <2386212.ILKoqq0Ivo@phil>
 <CAL_JsqL9PyD=0jy+GF5g8ee-FO_ijvArnzEohuvqK5Od3yr7fg@mail.gmail.com> <30286035.tdc4tAKEPf@phil>
In-Reply-To: <30286035.tdc4tAKEPf@phil>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Dec 2018 09:21:09 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+0+-yzB8mAodaK75Es6RPn=L5SCkFD7wgC-ZxaJtb3mg@mail.gmail.com>
Message-ID: <CAL_Jsq+0+-yzB8mAodaK75Es6RPn=L5SCkFD7wgC-ZxaJtb3mg@mail.gmail.com>
Subject: Re: [PATCH v2.2 24/34] dt-bindings: arm: Convert Rockchip board/soc
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

On Mon, Dec 10, 2018 at 4:45 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> From: Rob Herring <robh@kernel.org>
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
> thanks for the libyaml hint, now dtc does check my dts nicely and
> emits quite a number of little complaints ;-) .
>
> Also that suggestion to move the original firefly release+beta boards
> together was great and I just did that.
>
> Should look ok now, if so I'll apply it tomorrow.

LGTM
