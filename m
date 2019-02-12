Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616AFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD672083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pSl3zbne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbfBLOnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:43:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51053 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbfBLOnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:43:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id x7so3223753wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 06:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZUy0VCT1WuGXUG1KTNtWcsxFWdFXTWKSDbOTngrZcLA=;
        b=pSl3zbne4W+iYHTH/1UEv8dQigHTIrlQKSWlB+wcwUo1j7DDzFS4nHlCbmqPMSgUhq
         Lpt+B6jdgBlgyz2bXqcnse+XbxYmBSWdV039c5Kt+6KJcGCduiccf9vrtmHD3hDbGOJd
         fBPShB9QVyu18wD7dQW0pCRlsS+5ZWTDU+jc7E4ixXpLicp3+BN66cET0P32RIlEIUzn
         HJfDZnpl2qz+VSo7zLm5LvdVhTjLdI1BxYYHzekOAmKRdu9DVZf6VyA6ILuxJ/d8KD/5
         kOqc94+TY8oVn1ovW+8exY9572Ju6As+CWegMag95Ws9akJ3B++j4OjzB3fGqsnJk+um
         HCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZUy0VCT1WuGXUG1KTNtWcsxFWdFXTWKSDbOTngrZcLA=;
        b=QQUVhW2BQwrnI6mYHGFEjNb9BWfzNF/jizcS4H4IuucDSNR7V2vRYAKKcgvB2loHta
         kAuds87kg0iDtFipA0Kk9OUqq4xGNSZT0rSj+GFuPJf+F/pZ0CBqlgUXwpb0LBAojGUi
         ZyVggkKY6iFbAGi5GWtgqsIlEA10xMycPHPtsuSh8GhHwXVsoacL8ZjY6evUKdHfUc4b
         FL2oFzOl4yNns2SkrlQJrG+t4BRguhpIzlmpt7QDPj7ufMFOajdymuDOn1jYkzSKUgAc
         l/73u/CUYvcIo2C5pLaI7eKiHGqLlzEgoVTJYyMxjwxQXvgPUy9INUlATgMwXJLIZtpa
         FimQ==
X-Gm-Message-State: AHQUAubJZ84FsI5qUxkpGs89TuKcvVz3wK3pZJKyjcF1jYuRApSxJzvb
        +phaAVmc6UgPX8nPI2jh5qmXXg==
X-Google-Smtp-Source: AHgI3IbuPmVopWs3+dKFaWZNzP7k1eAL4Y4UJqGV0lgkEf5b9kk8sUNznwx/d7GxtOfT8shboocq0g==
X-Received: by 2002:a1c:2358:: with SMTP id j85mr2972336wmj.130.1549982583020;
        Tue, 12 Feb 2019 06:43:03 -0800 (PST)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e9sm25037122wrc.56.2019.02.12.06.43.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 12 Feb 2019 06:43:02 -0800 (PST)
Message-ID: <a2475cc2b0de8a13bc103ef6f4157a4a569c4a6c.camel@baylibre.com>
Subject: Re: [PATCH 2/3] soc: amlogic: gx-socinfo: Add new SoC IDs and
 Packages IDs
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Feb 2019 15:43:01 +0100
In-Reply-To: <20190212142344.13634-3-narmstrong@baylibre.com>
References: <20190212142344.13634-1-narmstrong@baylibre.com>
         <20190212142344.13634-3-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-12 at 15:23 +0100, Neil Armstrong wrote:
> This adds the G12A and G12B SoC ids and the S90X2 package ID.
                                                ^   
Small typo here --------------------------------|

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/soc/amlogic/meson-gx-socinfo.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c
> b/drivers/soc/amlogic/meson-gx-socinfo.c
> index 1ae339f5eadb..c1a9c34d861b 100644
> --- a/drivers/soc/amlogic/meson-gx-socinfo.c
> +++ b/drivers/soc/amlogic/meson-gx-socinfo.c
> @@ -37,6 +37,8 @@ static const struct meson_gx_soc_id {
>  	{ "AXG", 0x25 },
>  	{ "GXLX", 0x26 },
>  	{ "TXHD", 0x27 },
> +	{ "G12A", 0x28 },
> +	{ "G12B", 0x29 },
>  };
>  
>  static const struct meson_gx_package_id {
> @@ -53,11 +55,14 @@ static const struct meson_gx_package_id {
>  	{ "S905W", 0x21, 0xa0, 0xf0 },
>  	{ "S905L", 0x21, 0xc0, 0xf0 },
>  	{ "S905M2", 0x21, 0xe0, 0xf0 },
> +	{ "S805X", 0x21, 0x30, 0xf0 },
> +	{ "S805Y", 0x21, 0xb0, 0xf0 },
>  	{ "S912", 0x22, 0, 0x0 }, /* Only S912 is known for GXM */
>  	{ "962X", 0x24, 0x10, 0xf0 },
>  	{ "962E", 0x24, 0x20, 0xf0 },
>  	{ "A113X", 0x25, 0x37, 0xff },
>  	{ "A113D", 0x25, 0x22, 0xff },
> +	{ "S905X2", 0x28, 0x40, 0xf0 },
>  };
>  
>  static inline unsigned int socinfo_to_major(u32 socinfo)


