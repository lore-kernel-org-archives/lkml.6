Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74D9C43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4CD20815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546556533;
	bh=kJ2Hunfp569kJV49JwV3xKdKpOapLl4fXgttjC8EGQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DzPMK6F+z6NH7xvpaXpvDHoqMOjLrnanfLUIKzqfQvOGiDJwlVWwZELg/IW3JR/sm
	 NJaQhAHvrFb3p5KhLt2gAcYZsDubEH3qj47FWRiTep434lgGrCmC0VKxUcR+RBBE4N
	 8F3HCtQKKy42KpW6trelaWTvNXdzhb7vxU2PfLNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfACXCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:02:12 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55887 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfACXCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:02:12 -0500
Received: by mail-it1-f194.google.com with SMTP id m62so47538812ith.5;
        Thu, 03 Jan 2019 15:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+yAuDYqw26SUmzh667+nR4C2OZufSpiblcwZrq/i1zA=;
        b=d8Uwr65fFxfPqB9dAWlBDbTXThqQckbPjAPAgTeqQBKlwOtSIiGlLJftlnV8gx4NK6
         mw91ElYeGSfxvxFE3tuedMJeursId6n30/YxsH+8Gkdd4DiQI1TdPRp8AuvJibB6C19L
         h7gyxh3664G7cFyIeuURcck2DHo9zV0yOl2pzD794/P82+VjrfRQzbIWM5zye4JHSUeC
         G3i6aE7UblRkFxrbmxW9xjjOAya/MZnumYU+Itib77BX93b378BVo8sJF2VihM3vzrHb
         odwOP98KbkPQONItWOzKpzpp+PsJ6i26HbYc2ieMynkHq0I4e8KoRR5ijNS5ID3/hbHQ
         8MUA==
X-Gm-Message-State: AJcUukd2J9ggd8yHk16wn5P9OlliNYYi2+FBwJGUt2Ps/7DjGGOCy/lW
        VkaaKJTPfnNlXkRzNFj2dw==
X-Google-Smtp-Source: ALg8bN5Ij/GIIondPWfkSo9lM06JUFqag+j9dPGudwxneaKXEAKPgiAfTIBMWYgwJkNtMpTdCbUQdA==
X-Received: by 2002:a24:6115:: with SMTP id s21mr31253483itc.62.1546556531148;
        Thu, 03 Jan 2019 15:02:11 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id e10sm24924755ioa.65.2019.01.03.15.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 15:02:10 -0800 (PST)
Date:   Thu, 3 Jan 2019 17:02:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        balbes-150@yandex.ru, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: meson-saradc: update
 temperature sensor support
Message-ID: <20190103230209.GA21801@bogus>
References: <20181227215020.9803-1-martin.blumenstingl@googlemail.com>
 <20181227215020.9803-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227215020.9803-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2018 22:50:19 +0100, Martin Blumenstingl wrote:
> Meson8b and Meson8m2 use a 5-bit wide TSC (temperature sensor
> coefficient). The SAR ADC registers however can only store (the lower)
> 4 bits. The fifth (upper-most) bit is stored inside the
> MESON_HHI_DPLL_TOP_0[9] register from the HHI register area.
> This adds a syscon property to the HHI register area so a driver can
> fetch the HHI register map and store the fifth TSC bit in there.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/iio/adc/amlogic,meson-saradc.txt      | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
