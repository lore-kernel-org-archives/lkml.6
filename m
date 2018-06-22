Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7F6C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DA12413F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cII8q+v7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DA12413F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeFVLeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:34:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51156 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeFVLeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:34:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id e16-v6so1939828wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vsEMOwdamfEmX0SXqZBDhoxfkK6Dn0HXhBblkHeMg0=;
        b=cII8q+v7tcrxRYGsh6fFATMjKsulAY4M6UHpGKAOtTFPTjoWcJcmCL/8ryRO7i4lJQ
         cANkD90ux4f2c6TvTdhxrLmeUiFCC8TyYolYnVLE3LEivgBJ1Q6gxYCR0VinoDQbCyyT
         cBZCq5j8FFkT2Z56MfQ0mqqnT5TO4YthE5Nj5iHjctxxTvczNKBg1/FdRWqAQc2OHBdh
         DPYdv3p/oMGLbon4P9EDBBuJgtQhvTIuXbqmOSgg/GguY+IilhF75loWAZk3uHMy+GAo
         d4Ydply0RhRsp2n2OTJ5eAwH3FYOH6ctdQsmgaT9hM2Q7CR1Vhp4fuxau+RwtGs9UF+s
         q8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vsEMOwdamfEmX0SXqZBDhoxfkK6Dn0HXhBblkHeMg0=;
        b=dKVY/W5k47N/3mkjfvfYFdKun3mNYTKoHiPDDdMyxPLLUCyN2pGh6aqjvR6pkOayRR
         fLz+y0CUm2L6gmKIApFjJHIv4kKe7lbHrJ+hyK42FbIbUafEr2LnVm0Hgo99atqv55tx
         GpDneauDlD2nW8vnEdjNC7VaEJOg/rjPV6peQzZr/2YiS+mHk/flYzfzsp6ya+4NxdxV
         3+Cq9n65AdfgMudHVeWvOUO5Vuy0zK4tY7QdnoybqP9mCzpFKTFuFJrhnbwhwwA5JaUn
         kpaVP1ZOnQx7qTawdGEfm8NHQaGTjOGelNNjEEqdI6EtiwMm8nrDJ4/2e0JfSHAQPyQS
         jrJw==
X-Gm-Message-State: APt69E1U+hxnlIFVdZBtaHtyWmCBY5WbSO8OtGXhDGTov93mEf+Pl7kd
        +D83zvEYKphy5IqkFIhiZvSd/A==
X-Google-Smtp-Source: ADUXVKIm2kMDEn+2Q8PzvZM2/ybL2GQyecyMyMv6UdcpoFuDa+8QFbVuWoLYHjYuddnD8zCLXjcemA==
X-Received: by 2002:a1c:f114:: with SMTP id p20-v6mr1455419wmh.10.1529667248732;
        Fri, 22 Jun 2018 04:34:08 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k17-v6sm2086986wmc.23.2018.06.22.04.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 04:34:07 -0700 (PDT)
Message-ID: <1529667246.2900.6.camel@baylibre.com>
Subject: Re: [PATCH v2 0/6] clk: meson: axg: add audio clock controller
 support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Jun 2018 13:34:06 +0200
In-Reply-To: <20180522163457.13834-1-jbrunet@baylibre.com>
References: <20180522163457.13834-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-22 at 18:34 +0200, Jerome Brunet wrote:
> The purpose of this patchset is to add support for the clock controller
> dedicated to the audio subsystem found on A113 based SoCs
> 
> The series depends on the CLK_MUX_ROUND_CLOSEST fixes [merged in clk-next]
> and the duty cycle support [1] making their way into CCF.
> 
> First patch is a clean-up of the meson clk Kconfig.
> Then, there is 3 clock provider drivers for clocks found in the audio
> The last 3 are for the clock controller itself.
> 
> Changes since v1: [2]
>  * Rebase clk-meson's next/drivers
>  * Correct typo in documentation and squash DT patches
> 
> [1]: https://lkml.kernel.org/r/20180420211141.28929-1-jbrunet@baylibre.com
> [2]: https://lkml.kernel.org/r/20180425163304.10852-1-jbrunet@baylibre.com
> 
> Jerome Brunet (6):
>   clk: meson: clean-up meson clock configuration
>   clk: meson: add clk-phase clock driver
>   clk: meson: add triple phase clock driver
>   clk: meson: add axg audio sclk divider driver
>   dt-bindings: clock: add meson axg audio clock controller bindings
>   clk: meson: axg: add the audio clock controller driver

Applied for next on top of mike's clk-core-duty-cycle branch.

