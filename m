Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F01EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A4D2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kbb/rxS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A4D2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeKOJ3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:29:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41278 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeKOJ3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:29:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id e22-v6so8672777pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=0Uv3L6IXpdg0jSHMsiwZaUN+U0h+C/Nw1Eag7oiR388=;
        b=kbb/rxS3L5KdYfbHFbW99nCSqTumdLHxQ11mJpPbXBFHZjYNKUPeAEGayA51nxqg5I
         1iGWxvu0hwMlp0HaamyUjybZUMuihHRIKbyEYOLop4rUfs9d4+qLie5QiMG28FKq6kRE
         OIC+zPU+rEl4OZSXD+oP6ueZIkSa3Id6Mhn3JLDwrkY9qljisdeTmgZGEHmUzTqoyER0
         Sxuzen1doaD1t9c6c7QYF4CfaRgSpNKLovh19P98KYZ1PGYQVdDjs8pVU4IrHr1enaRP
         AaLIkdOojyHxJ1QZ99dy3OYawQhbzdIiP4tKlLi/v2pcWDnrANtSKbsNm9gn7JpbgtJn
         4mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0Uv3L6IXpdg0jSHMsiwZaUN+U0h+C/Nw1Eag7oiR388=;
        b=iRtUElxADtViBP0gHVAPXHKyrPYoog90N/Hjs9LaCYRAQJA7UYRbHdmYN5oF6iBYf9
         kuNerpO8Lo4ArvCfuILaY0posuDOAI8QSv18iC5gzAVIQiYSRfuX5lDP6rITD5aD7Oyn
         sNB7YsavapoQnEiqNTjYVsNPZ7MFgIV0wgpaSol7RyDE8h1GRq9c/c4/uEDmv3YdEUVy
         1VwSla1HXD4uuVz4v03XshS/kh0RGXqqwUUP0OTlZzxP2YkG3CEAR+A+XIvVlTw2K/0D
         QziwSLATIGd2RdmTeI+WLoq58elKXUNNU4puubAoMUFvEa1duU+b3IQAgbA2+GObyYQX
         Y7Jg==
X-Gm-Message-State: AGRZ1gK1rdkWhgxD3D6g1oZ2SPAdOyLe9zfx6gptuhHcVWis885BV4dU
        dRdqbrrgeQj4txIbkan7bJP1Mutx9E3NMg==
X-Google-Smtp-Source: AJdET5clE8tQlgjHFhXXPLRCGgZ+2ugHkT0McO5Um3zM0phGHzBsY9qxNw07j1lEXkpOZLWPBpMpsQ==
X-Received: by 2002:a63:1d10:: with SMTP id d16-v6mr3496036pgd.228.1542237830399;
        Wed, 14 Nov 2018 15:23:50 -0800 (PST)
Received: from localhost ([64.114.255.114])
        by smtp.googlemail.com with ESMTPSA id n87-v6sm31419026pfb.62.2018.11.14.15.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 15:23:49 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     christianshewitt@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: meson-gxl-s905x-khadas-vim enable Bluetooth
In-Reply-To: <1539432427-11779-1-git-send-email-christianshewitt@gmail.com>
References: <1539432427-11779-1-git-send-email-christianshewitt@gmail.com>
Date:   Wed, 14 Nov 2018 15:23:48 -0800
Message-ID: <7hpnv7gs57.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> This enables Bluetooth support for the following models:
>
> - Khadas VIM basic (AP6212) using firmware BCM43438A1.hcd
> - Khadas VIM pro (AP6255) using firmware BCM4345C0.hcd
>
> The AP6212 module used on the VIM basic has an ID clash with another
> device. To get Bluetooth working you either need to apply a kernel
> patch to drivers/bluetooth/btbcm.c so 0x2209 loads BCM43438A1 or the
> BCM43438A1.hcd firmware must be renamed to BCM43430A1.hcd.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Queued for v4.21 (applied to v4.21/dt64 branch),

Kevin
