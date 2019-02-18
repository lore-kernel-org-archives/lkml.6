Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A6AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3960A21900
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550521365;
	bh=I+BYq/mxJaH0ibkJ1FtRRwNGSLHD4IXU06URxoT6GMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wIB/n2a42v1orL8aDOMDT8rAL8WbgcpIBIzCKuLNAGJBe6HHxmRp7K2nUtRl7bWut
	 rjG2EYwwnA2BXVqX2PGcFNMl0tkGbdf3+OzmmEqlCzrSIch+sKJSpH5Iwkt9w92ENP
	 KiZuZDYSvrcv6nbFkS6isMmUkjx1wEB2UsmB7rHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfBRUWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:22:43 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42227 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbfBRUWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:22:42 -0500
Received: by mail-ed1-f65.google.com with SMTP id j89so5480615edb.9;
        Mon, 18 Feb 2019 12:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MhF5ILnI6/WQmtarx57lZJWu0njEcLuEc6xrTnml1js=;
        b=DIQ13EEl4JbD5wRIwIxwSkfxmPlKshXAPRFQdAW120o9mL4SwLuUsk8PgMyD4Ghlnk
         xwZIA1ApOEIBGcMso3qItvlc1xfXWKftKbYVn+Wr/S4DxtifiU9vqacbA2TEqN/nyyZ9
         vM5aTydwarqoosfH34jyFhR7+/US0hbcVCS3te7hIZMrjsGSBrkfeYCZR0SgYcbNSdwb
         /JwKDl3fnJwVGmcUwumiOH2vQRucaAItRUgtRIhhOoAzLrg9PHFF1T9u4m7Qq9EiJ8Gw
         AYshitHNtDCK6eabcPt1WPgHMTY1LcbQU0lCqwaAcOzluaIsPDXqL45L4fPx/wt/5Jqe
         GdiA==
X-Gm-Message-State: AHQUAuaQ2KYNMXKKknf2D3/23nrwV7ZJ05+96P0Kf0YeQTkz5aaWofDZ
        si4+8RFcWwar9KxgiV9dCoc=
X-Google-Smtp-Source: AHgI3Iag+wIwd4tERVU3IznZFJsDBy4kNk0lhAesVBNDW3F4c1AaEviU0VkTUHhtws30lJp/EdV74Q==
X-Received: by 2002:a17:906:2643:: with SMTP id i3mr17913868ejc.157.1550521360210;
        Mon, 18 Feb 2019 12:22:40 -0800 (PST)
Received: from kozik-lap ([194.230.155.153])
        by smtp.googlemail.com with ESMTPSA id m3sm3274222eja.11.2019.02.18.12.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:22:39 -0800 (PST)
Date:   Mon, 18 Feb 2019 21:22:37 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 21/21] ARM: dts: exynos5422-odroidxu4: Add support for
 secondary DAI
Message-ID: <20190218202237.GB24814@kozik-lap>
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
 <CGME20190212180553epcas2p10fb4f2f465392de8609c127ed3f33ab4@epcas2p1.samsung.com>
 <20190212180342.32040-22-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190212180342.32040-22-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 07:03:42PM +0100, Sylwester Nawrocki wrote:
> This patch extends DAPM routing and adds secondary CPU DAI entry
> to support the secondary audio PCM interface on Odroid XU4.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu4.dts | 4 +++-

Thanks, applied.

Best regards,
Krzysztof

