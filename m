Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9596C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A730C218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550092070;
	bh=84OSiL10Ix1gX46qwLRQYNp4IPyjpj7yo62J9jRk54c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LU2IpqpwLfrUUYH9gscFKbzhG/ij0Yzfli08OYpAJaTFCGiO2WGFx0AdjIhz+OxCS
	 qDqFKNMVbbQ3t2IGqtJY2+DkY14qFoAlSUYdqHcUNc25/SmE0+oP9yDmU9oZu63T2I
	 pzh88Pne6WQOluIVwN2EjaWQOrtHL0PAtnFPRhIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394705AbfBMVHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:07:49 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45788 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfBMVHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:07:49 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so6737338ota.12;
        Wed, 13 Feb 2019 13:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yVq6qd0CDAm/lBJzXv+lqJKV0+gBxOcHBTedAUe3rvI=;
        b=RZBA5ipui/HnqwlANTdAMghhESKCpJnecl3kb8hYTrc+xOZ0QO6cF2ttsbMwqAQr9R
         0F0sQEWP7gmAT+iylrQ+H1fikjf2yhhMIXYiunbLm8dYInjbORPtmsJil1xOO10KXskT
         zdQYMDdpYeAqdnWn11XlTs4wNQLA+mAkLb+Xfh0IZdYU/49rqqpdIkZK4gNyF8rtP5KF
         z7CvFsYPCa3/YycoujtC1feBPewLu/df3WeMsTbCfcrKr646OWBhFMku3U4SfEFqSAek
         M7h+AB8nfclrY0SAOuIDaH8w0avBKPx6qFwsgvDKI33EAjTC4xvvbtadcojEPWLP/J6b
         86xA==
X-Gm-Message-State: AHQUAuYbYTPZytHSq4MXosRrOIBZYUooWv7PdT0S3/aSzZtmqTCGGkZd
        IVE+tOR9pE2A++mx016HXA==
X-Google-Smtp-Source: AHgI3IbgR2jM34wgdgRHvoHSBF9qY7OqQ10nfGKLD3iRPAtE/E03+APfYxrIV5QPSnpH81C9vYfFOQ==
X-Received: by 2002:aca:c443:: with SMTP id u64mr116265oif.136.1550092068287;
        Wed, 13 Feb 2019 13:07:48 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m26sm168372otl.32.2019.02.13.13.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:07:47 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:07:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Message-ID: <20190213210746.GA2989@bogus>
References: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190201164718eucas1p1bca3a199d60e109e1da654d8afff2a47@eucas1p1.samsung.com>
 <1549039612-28905-2-git-send-email-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549039612-28905-2-git-send-email-l.luba@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 05:46:45PM +0100, Lukasz Luba wrote:
> Define new IDs for clocks used by Dynamic Memory Controller in
> Exynos5422 SoC.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  include/dt-bindings/clock/exynos5420.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
