Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2257C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649BD2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVTvFcMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649BD2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeK3MeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:34:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34036 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3MeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 07:34:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id p6so2932029lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 17:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=imTXz5sZlu1Kh8pfeNdiHOOHYdQh1mhRs+8hfeMyx/0=;
        b=YVTvFcMVFW4d6Qtv3Gks1YZGGyVCSefK5irFL+CjNcGCDo7iI+YfcYrh4TOEntWcCP
         B8JLC+l0UdUpI03kiKWKiTS0hQXm35qCSaFVL2fFNr4TIL4Jvco9+AuXlUZO4Ul+zJtD
         /WuRE7+3V/FpE+G1bTiX9/epsPNiOBDdBouQzb36Wm8cUADJnMV6hJpokbUnhaIN1v8/
         WUuqdLvo6JXL2XlIWuV3s5yxd+EG/Kv458HIOHlgd96gemRkTdPryKV6lMe00zvwHvI+
         FpmdYPXpmPQONQr0jL9vwuvd9vfbc2+5cC1pVbww/k1Njwm7Qq4YsDneEqSz0KJFBJJQ
         YyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=imTXz5sZlu1Kh8pfeNdiHOOHYdQh1mhRs+8hfeMyx/0=;
        b=JpLU5EG9UwfmzVS/Py5e1K9iKcrTguyKing4bJCbzLilKrHcH8l3tsAgVI9lG//rcx
         ZtYjJlZ/chu3jMYSNdG3S9CtGSu7C5ZmRf+pU6GYkVt+RBYU8yl66P/0qvMTEZNznE1F
         LsqDNw/sI3rhsRWVG0Epp9GlsBbbX7jLobtkVpHHEPaN1xv0uUoIhnGPMKZwlbiEyw+O
         GpiUQNbVfh9hoI/rs7d/TO3G1k8ElmoXmtuxD8ea1mQRRKGzlQVYs7JypoMJDNPhQAp8
         kuP0tTDwCof593mTcD9eEzMLb4rLIQib4IRJNFd67/Nc6LzXo92X7c7pmxRG8zLLm61q
         ui4g==
X-Gm-Message-State: AA+aEWb7od509CFtUQEqilFXvQRTVslTkUtD20duqnzV++5SoCooAQ8x
        bJy+3NGNIdFZByk3bXNvi04=
X-Google-Smtp-Source: AFSGD/VnATtqBLw0BdwFAvAmEpDlT6x+WaXVlEwoxi5zttbfvR/rd6c5cCTJJLwaOcsg6bZpEY9IOA==
X-Received: by 2002:a19:6f0a:: with SMTP id k10mr2281069lfc.119.1543541194530;
        Thu, 29 Nov 2018 17:26:34 -0800 (PST)
Received: from z50.localnet (apn-31-0-32-254.dynamic.gprs.plus.pl. [31.0.32.254])
        by smtp.gmail.com with ESMTPSA id e13-v6sm535382ljk.53.2018.11.29.17.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 17:26:33 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Petr Cvek <petr.cvek@tul.cz>,
        Paul Parsons <lost.distance@yahoo.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 2/5 v7] regulator: fixed/gpio: Pull inversion/OD into gpiolib
Date:   Fri, 30 Nov 2018 02:28:36 +0100
Message-ID: <3345160.3ImKfB1b4q@z50>
In-Reply-To: <20181119071126.8889-2-linus.walleij@linaro.org>
References: <20181119071126.8889-1-linus.walleij@linaro.org> <20181119071126.8889-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Monday, November 19, 2018 8:11:23 AM CET Linus Walleij wrote:
> This pushes the handling of inversion semantics and open drain
> settings to the GPIO descriptor and gpiolib. All affected board
> files are also augmented.
> 
> This is especially nice since we don't have to have any
> confusing flags passed around to the left and right littering
> the fixed and GPIO regulator drivers and the regulator core.
> It is all just very straight-forward: the core asks the GPIO
> line to be asserted or deasserted and gpiolib deals with the
> rest depending on how the platform is configured: if the line
> is active low, it deals with that, if the line is open drain,
> it deals with that too.
> 
> Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com> # OMAP1

Tested-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>	#OMAP1 Amstrad Delta

Thanks,
Janusz


