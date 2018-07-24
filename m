Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1362BC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD68B2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD68B2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbeGYAiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:38:08 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40220 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388438AbeGYAiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:38:08 -0400
Received: by mail-io0-f194.google.com with SMTP id l14-v6so4844307iob.7;
        Tue, 24 Jul 2018 16:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cffg0zKFwY6a2w8PlWQ+92x2BOUt7wGbBHB5bDOIhrs=;
        b=k3vbRdeZ/c1iON7x8bjG4Ju0ousoZG0cLSAuzvyXu5ZCxQ6dBtFg0WAMPSAK8Rg0HH
         3alRMojMoXyCtgAYQO/wCWQnPxdoYFfeOOVNRyS1SdOjjV8PZQJPqRoY/4YdmBUYy06A
         86hpiSpaEVTUGDr4BBeYBnChm8DMzwKbH0uoO53XsuxXVOvfGY4vsOGUA+Gf950g4L7S
         peo1lyFJXq0YupKEkMLMXMJtgE5QIVrY5OD2UGY9Tgvz8V7PRMcwj2H3r7GOhFwDATvV
         bcBi3arZQs0kGZwVJ+R5HPYQZfU9SmYWmGf688yWsU9P20b2q/51hlXLDgTCVdRhJ6r5
         ltjg==
X-Gm-Message-State: AOUpUlE9D88JENuoFrGejT9TMjCSOvNQ3YC0Pgs6Ppr66T+OktGeTEPL
        tUIHVzr1dy9Z+ZwhRBE7cQ==
X-Google-Smtp-Source: AAOMgpeGl8RL7IzIN70Po8GQix3e9lZt8tFgMiqqmQ8kf6TT77IhqRwkrU5LcynmCZoAzoGEZHrhkQ==
X-Received: by 2002:a6b:9711:: with SMTP id z17-v6mr14678319iod.205.1532474958529;
        Tue, 24 Jul 2018 16:29:18 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id f195-v6sm1601451itf.41.2018.07.24.16.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 16:29:18 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:29:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yixun Lan <yixun.lan@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] clk: meson: add DT documentation for emmc clock
 controller
Message-ID: <20180724232917.GA27041@rob-hp-laptop>
References: <20180712211244.11428-1-yixun.lan@amlogic.com>
 <20180712211244.11428-2-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712211244.11428-2-yixun.lan@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 09:12:43PM +0000, Yixun Lan wrote:
> Document the MMC sub clock controller driver, the potential consumer
> of this driver is MMC or NAND. Also add three clock bindings IDs which
> provided by this driver.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../bindings/clock/amlogic,mmc-clkc.txt       | 31 +++++++++++++++++++
>  .../clock/amlogic,meson-mmc-clkc.h            | 16 ++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>  create mode 100644 include/dt-bindings/clock/amlogic,meson-mmc-clkc.h

Reviewed-by: Rob Herring <robh@kernel.org>
