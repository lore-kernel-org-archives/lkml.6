Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8680C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69A7217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550521354;
	bh=9oq1OAvlr12zSi0zM6neHAQdoA75u3uYQ6TK9gKmYNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YE9luHEZD8/p2lSNe+y5dNiWGrnQHIJTA3iAve7//EHsptfhoySTpCFYRHaKFCuQI
	 OHB1FA30tFwzYza0TaS3Capi3CTEFaXAYTCvIxeu0qRxjyyJW9C3vp8JDaYda8x/DQ
	 U/9nLQ3yU8NsVENpjUaplMT2HJDxoe76DPiynJmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfBRUWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:22:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42214 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbfBRUWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:22:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id j89so5480211edb.9;
        Mon, 18 Feb 2019 12:22:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yUZOEWYVHVWGHaCEqHMLRk5Z8RqncHPDNyBu3buZeGE=;
        b=llkWU6ac/Vo5n7DL+7n6olOxKI35x98l72RXHSNfwQMY2PY0swvNn7dpndGneOzhfV
         FP3HRm++EPzCGSrcX5PKGwB/05tBtwW/aSgaAM3mOAyPNzbiA50NR7jTz15fouEwvgin
         Phq500mo2xyMzogcM3lT94oUi038NdHs4nZWEhb2s8AJsWr5T9AJuZmoGDz4M6abln4X
         VWeJZyVu7aBAhwx+BP2318H8gjwRpBonJpGLxogvYbVJmuzBP/ttX6NT4sF5WTvkKaZS
         715ukL5DW54yQtljsr+5Ce4KuWv6P454wk+58U08479lfymhP1SWcKg4eDmv/MhFEHM+
         JXlg==
X-Gm-Message-State: AHQUAuYvewP8q2CQ41ayWvyr9mpI7bz6AYsVuQaog3PXyjFW6PdbRcGk
        NLf92AzP5Pt48b271g5QY8c=
X-Google-Smtp-Source: AHgI3IZa6kTFAD/YC7G2bnk3Odgb/DjltecffQOtGCXi6T7xqRIxb4Bzh2/SDYgQQTha8X2Spm6QHA==
X-Received: by 2002:a17:906:5048:: with SMTP id e8mr17909599ejk.214.1550521350545;
        Mon, 18 Feb 2019 12:22:30 -0800 (PST)
Received: from kozik-lap ([194.230.155.153])
        by smtp.googlemail.com with ESMTPSA id g20sm1237247ejk.72.2019.02.18.12.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:22:29 -0800 (PST)
Date:   Mon, 18 Feb 2019 21:22:27 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 20/21] ARM: dts: exynos5422-odroidxu3: Add support for
 secondary DAI
Message-ID: <20190218202227.GA24814@kozik-lap>
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
 <CGME20190212180549epcas1p20b5cc51ba13fb934056196d1b89d67ab@epcas1p2.samsung.com>
 <20190212180342.32040-21-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190212180342.32040-21-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 07:03:41PM +0100, Sylwester Nawrocki wrote:
> This patch extends DAPM routing and adds secondary CPU DAI entry
> to support the secondary audio PCM interface on Odroid XU3.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 6 ++++--

Thanks, applied.

Best regards,
Krzysztof

