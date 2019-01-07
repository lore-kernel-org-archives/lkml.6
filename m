Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C0FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052262147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546892960;
	bh=PSYzZGwsIKxDAd0hEW3WVjrSic8PfPmA2bfYTvD7d5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vb+TT5IPxljY4GZ4/X1klRUjDNqKhG3DE40JPvfnQ2v7YuaA6P+HqLmAXsUapQBtX
	 zP8nssiz57Wcp2Faw4NS6Z4+WK8lnISX0+NXhRwHWHxa13kMby1ydwczSZIM6Yvm95
	 h0pnaYWOrU1Fb3L2RGjLhFV3EtcbNyASZky6/2Ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfAGU3T convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:29:19 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40775 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfAGU3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:29:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so2133429edr.7;
        Mon, 07 Jan 2019 12:29:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NLh9TviOHL95KaLbs99nNqTK8EJIAJzILq5WanPkzlA=;
        b=odsHdT9P/VPIx18JZ65iDbFA7U6/TDNS8ijE4qwu4RBjBDFG2UplIstEFbjHPs2vih
         fN3dZHJzLNSBOgxipXkaBxAxOGzMNx+Ui5A81Ja3DyJIKGya1lTIGuS5mNDq936pAufj
         C6TGt3tb8J2B4rdD43sHaDDyKlCsCX6XfTPlR2FJi9CHEczrF8oS92/YIZ4Pr6RWCbYY
         R0RQZYqemQV6TXWuBKHZiVFm8dOWgidthpa3jvZN+HPxNe9FVS5NqXuhFX+TqKK4NiII
         3FSRGY3nIKFhaTXI22IFDMMRkFI+V09RlL11QKcUeKDgAvsirz71a3x/PDfQb43g29DW
         /3ow==
X-Gm-Message-State: AA+aEWaUcKk5dS9t2xvKLla7+258J2I0KfmPR/U3c7F+XqaTXIeWXowm
        y5l8+wPjRpu50GlMc7Oad0o=
X-Google-Smtp-Source: AFSGD/VkPfTwc73TNzvTWivUfKtcLdLV9NeBpvpnKj/APJW+eu4Vj+t+n7uckkcgOOyrO2Y4/P3YuA==
X-Received: by 2002:a50:b623:: with SMTP id b32mr55094679ede.55.1546892956823;
        Mon, 07 Jan 2019 12:29:16 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
        by smtp.googlemail.com with ESMTPSA id m14sm38643638edc.27.2019.01.07.12.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 12:29:16 -0800 (PST)
Date:   Mon, 7 Jan 2019 21:29:13 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     inki.dae@samsung.com, airlied@linux.ie, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        kgene@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ARM: dts: s5pv210: Add node for exynos-rotator
Message-ID: <20190107202913.GB21920@kozik-lap>
References: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228151904.12079-4-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181228151904.12079-4-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 04:19:04PM +0100, Paweł Chmiel wrote:
> This commit adds node for Exynos Rorator device,
> so it can be used on all s5pv210 based devices.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/boot/dts/s5pv210.dtsi | 9 +++++++++

Thanks, applied.

Best regards,
Krzysztof

