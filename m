Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D11C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7244420872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547195637;
	bh=lYLZ1fsbLS8KYAm5cE4Qbzw1iabheBnVOksYYx2cEt8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SdaOoAjNznW4+5JzQ3ypyERYxEy16oOUQvrg9PsxeFZECGkR1JBvkAhQ60S+vtxE2
	 Be6W79CHxdjGnd/RI2oBuB/q1d37LSG6/SbbU5dnXlcVyYFA6b9CIjNsOFaRS4fIA9
	 SlzIKvM7IDV9BqmCvZZEtYWluhOq3zhYcxjOQpVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbfAKId4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:33:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbfAKIdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:33:55 -0500
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1239B214C6;
        Fri, 11 Jan 2019 08:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547195634;
        bh=lYLZ1fsbLS8KYAm5cE4Qbzw1iabheBnVOksYYx2cEt8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d4SQGBeeBHWrwJWcT7yQsyOAUPUtl4xHwuFCgiog2A8xHeTGOAZ2ReObQhFFiLjhC
         wwbQkHD6RvUjNhcsQPW6NVMG6DUXpCYVZoRzy6LzbjMePtakmT/5ayEcUX5M5L4hgf
         jM5qDs+dA70KtlehkgqQx4z0I6IrwA46Asue67oo=
Received: by mail-lj1-f176.google.com with SMTP id q2-v6so12160665lji.10;
        Fri, 11 Jan 2019 00:33:53 -0800 (PST)
X-Gm-Message-State: AJcUukcKW4ar7iQTWPMNn6kMfUqSAc3cFkDYdpCaSSG9CmfIucsVET5r
        XT7pWLzWFW1B5f8prSapN0lOaFffTWif41FxeGI=
X-Google-Smtp-Source: ALg8bN4idQMnzlcuSVedLIDuqNpTFTh1SZJsuMqGXJfGMLxlNexMV53bkJp/fAhAHSNfmwkePvxO3I0YOPRheSYeYAs=
X-Received: by 2002:a2e:5d12:: with SMTP id r18-v6mr8884448ljb.89.1547195632259;
 Fri, 11 Jan 2019 00:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com> <20190108165601.25708-3-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20190108165601.25708-3-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 11 Jan 2019 09:33:41 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdZPTP1c1GN-274G0jBMCHZiXk1C3Q+JnergehkuExPXg@mail.gmail.com>
Message-ID: <CAJKOXPdZPTP1c1GN-274G0jBMCHZiXk1C3Q+JnergehkuExPXg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ARM: dts: s5pv210: aries: Support for more devices
 present on Aries
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, xc-racer2@live.ca,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 at 17:56, Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
>
> From: Jonathan Bakker <xc-racer2@live.ca>
>
> This commit enables following devices present on Aries based phones:
> - pwm-vibrator attached to PWM 1
> - poweroff support
> - Atmel maXTouch touchscreen, connected to i2c2
> - Broadcom BCM4329 bluetooth over uart0
>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v1:
>    - Touchscreen irq pin should have PULL_NONE, since it's already
>      pulled up with 2.8v
>    - Touchscreen irq should be edge failing (like in vendor sources)
> ---
>  arch/arm/boot/dts/s5pv210-aries.dtsi | 68 ++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)

Thanks, applied.

Best regards,
Krzysztof
