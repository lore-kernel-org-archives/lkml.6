Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE9CC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3E820874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3E820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbeGXUtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:49:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44279 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388537AbeGXUtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:49:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id f23-v6so5098129edr.11;
        Tue, 24 Jul 2018 12:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u9YXqgy59EdlzthS/LNbR9o+P2/in5HjfYWgQ2CYqhU=;
        b=JHCPj3BuSIx4n+tvlp9Va4vWUrxQch1v1zIj9c+jrubIdWlFCxD7aYtW+94a3/PlXw
         UzpDvYeEP5gKEQFMcvv5b8PAZzmWlkGSYTvZ3HF3KqHC4eHAOeICdKCGFaQ8SSvVv633
         4AJ0yS0T7YpHwV+JZs6NV/kbA8T8uFw34CvH2vsrTcQK8PT4hswMMdTLn5DS1f5Fjb1c
         u3ZGqsD+GxhLR+Yv5+qyVeKpZcXqO3lyWhpZ2RbjoHHTWESCmv3U504jj5Iike6rx0fi
         q8ogO0ResBBndc/mCFn802pFESk8wYtm6eXDaW5C5JBlf1GU5KUCzTKfj8w0i8bRNkij
         4Juw==
X-Gm-Message-State: AOUpUlEvVXfLk7R3BZl3XBmkdPQBXTiQy43dbDjqeabyBfpyEJL9SxUY
        VRZOal3ouI+eQN+HlZ66OEM=
X-Google-Smtp-Source: AAOMgpd3PZvMcq6PR8vKJun0tTFOnsy9Y9pwSXc9fasoyMB5eOdot6MhrOL4SipahD0Q+4Lwrho+Nw==
X-Received: by 2002:a50:baae:: with SMTP id x43-v6mr19882262ede.65.1532461281301;
        Tue, 24 Jul 2018 12:41:21 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id a5-v6sm12234407edr.1.2018.07.24.12.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 12:41:20 -0700 (PDT)
Date:   Tue, 24 Jul 2018 21:41:09 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [RFT v2 01/10] pinctrl: samsung: Define suspend and resume
 callbacks for all banks and SoCs
Message-ID: <20180724194109.vbkahhcpi7avmj2m@kozik-lap>
References: <20180723175302.22535-1-krzk@kernel.org>
 <20180723175302.22535-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180723175302.22535-2-krzk@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 07:52:53PM +0200, Krzysztof Kozlowski wrote:
> Suspend and resume callbacks in Exynos/S5Pv210 pin controller drivers,
> save and restore state of registers.  This operations should be done for
> all banks which have external interrupts (as denoted by using
> EXYNOS_PIN_BANK_EINTG/EINTW macros).
> 
> Add all banks of Exynos5260 and Exynos5420.  This is necessary step for
> supporting suspend to RAM on these SoCs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos-arm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

