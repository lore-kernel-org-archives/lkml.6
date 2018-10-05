Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46221C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F072420645
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F072420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeJEOlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:41:07 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:41033 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbeJEOlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:41:06 -0400
Received: by mail-qk1-f173.google.com with SMTP id 23-v6so4985234qkh.8;
        Fri, 05 Oct 2018 00:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZ+wYD3bYHt8StmegEBv1TQYx0JeTgu/DAt9TrcIc1E=;
        b=R/8QG6v/n2S05qpJz4EdGmzh3S6TMqhnKvcjQpk6DozspiGuIYDq9Bk0/C6Ww12bHV
         n+SscFnGERv+WqYJllaExmP/alsVTFqd/atKOqJe1uIc0eNewVI46GgHKmGDmYPPYpjO
         T4+KKWrcr5/hEyR/+aQMDOPa44/h7fuDdm2uKxB8WiA80sm6ORBRgdRpM1VtOOe9AJzh
         cMWLZ6masGF0tE78joYLUOgRtEaFeVP/1s89smPxo5zXg5tAi+7wIPy6x/kmkgVqnEbO
         kpTGuLTC7PHaINCmbYULwvUjJsGV5q0K9IbDsHuCEGQHlzryJC5Zt9A4U58dRxr2/q+g
         LwrQ==
X-Gm-Message-State: ABuFfojdqdlGU9bD4B6lUWNhm4B+kVN9SbN7NYydN9wBa16HehtVcnay
        BAA2DAlCki+2+jvsf/KIlOFM67t20Cv/UMghvfw=
X-Google-Smtp-Source: ACcGV63IYn6LOnzmEpL5o3lrY+mM65Xhie0YIpOihhEgwv42DgOJ0tkyRpZDwDa5iBOlw6DywWRKvoC61esZAL6sEpw=
X-Received: by 2002:a37:2b12:: with SMTP id r18-v6mr7723120qkh.343.1538725416626;
 Fri, 05 Oct 2018 00:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <1538720352-85691-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1538720352-85691-1-git-send-email-yuehaibing@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 5 Oct 2018 09:43:20 +0200
Message-ID: <CAK8P3a2Yzv1ThTZLp5boydi1_poi_V7RbSF3JZ4KG41GEjF6RA@mail.gmail.com>
Subject: Re: [PATCH -next] eeprom: at25: remove unneeded 'at25_remove'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        devang.panchal@softnautics.com,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 8:08 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/misc/eeprom/at25.c: In function 'at25_remove':
> drivers/misc/eeprom/at25.c:384:20: warning:
>  variable 'at25' set but not used [-Wunused-but-set-variable]
>
> Since commit 96d08fb43e30 ("eeprom: at25: use devm_nvmem_register()"),
> at25_remove is do nothing, so can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

I had to double-check that removing the remove callback doesn't
result in a device that you cannot remove, but it is in fact supported, so

Acked-by: Arnd Bergmann <arnd@arndb.de>
