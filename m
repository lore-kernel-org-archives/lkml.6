Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E5313F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D86D20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D86D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeG3M0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:26:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39314 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbeG3M0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:26:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so10057360lji.6;
        Mon, 30 Jul 2018 03:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=McujzIHhL7O5/JRcLWU+sKuH5pQnJhAGv73MCXix4pA=;
        b=rH4fc5O3obn5rC6ZiYf4m50j7BnDV7vgjMdZYlXXxQO8Aon1Z3LnxwGeVQ40OElf5o
         705AnFAqUB3yO1bp5gj4hCG94DiGATcyGvVxDQ/C+OjYP8YQp5HWXxSUJ7KARlPQrHwo
         5/erXm2LHvCMmY3C6CZb45Y/G9/3EyVl+tySx35k4QEJXW995KTLXaSAk4FJijONrEEZ
         VY4ZI3bDl0pjAZm6pF+b4OxC02uza7n+lMchFlbfztmhjY9E1426ShMq3D011UOYWdEO
         ykxjD9D/HPrm5djLzKQ7EpiGUmEDEMutWOyR+Uv7WDiBcFEuL1daGPsuGXOEI6hZwmd8
         9eaA==
X-Gm-Message-State: AOUpUlFom/9nxOe0oDdPHYFTruy1wOJ0GfDVpQxcgm6ZULDHGlxRu5Og
        +Ji0kRI7Ym1lhL2Pf8fqzNQ=
X-Google-Smtp-Source: AAOMgpcltoNShne1BW6jVvHbJv86W+o52DpKcSblsRvZJNspLp5+2s4f5Cl8N/rFfWF0a5LqUX9Onw==
X-Received: by 2002:a2e:9941:: with SMTP id r1-v6mr12000683ljj.53.1532947914912;
        Mon, 30 Jul 2018 03:51:54 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id o74-v6sm1506002lfg.31.2018.07.30.03.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 03:51:54 -0700 (PDT)
Date:   Mon, 30 Jul 2018 13:51:52 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        eballetbo@gmail.com, linus.walleij@linaro.org,
        mazziesaccount@gmail.com, dmitry.torokhov@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, broonie@kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v11 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180730105152.GC8862@localhost.localdomain>
References: <cover.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
 <77184f651e5cefb112f1061bc682b759f88144c6.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77184f651e5cefb112f1061bc682b759f88144c6.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 01:43:34PM +0300, Matti Vaittinen wrote:
> ROHM BD71837 PMIC MFD driver providing interrupts and support
> for three subsystems:
> - clk
> - Regulators
> - input/power-key
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Please note that I maintained the acked-by line from Enric because the
patch version 11 mostly contains only trivial changes - and is not
touching the points Enric was originally concerned. Enric, please
let us know if this is not Ok for you.

Br,
	Matti Vaittinen

