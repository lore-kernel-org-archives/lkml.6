Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85E4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D89420844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU4pDVaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D89420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbeHAWjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:39:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41896 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeHAWjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:39:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so18044617ljy.8;
        Wed, 01 Aug 2018 13:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y92YWSAQ6DJ8cACRNi2JxD32qSbT1XMauYYZ8kJ0yIs=;
        b=IU4pDVaKMRh3mCO/ImiUFOp24EDGuvOAvOu4qokdcUtHwo5Jelcr3TxEpcGomYesy4
         xzFw/8Qg4h98M64jqUbi5t4eAQiHDHwBcisMc+HbTx2ZmezwKtbx9/rexuJH0HAPouEO
         uCrtiJnrBCVBGNY6wCVwZluIQ6+PtZ/4EdwrgGidTAvxanA92nRGc9MKb5d/8mivO8Td
         1UMrVCr2Vzq8ib64HDbE6wAsgePohNhpENGm0bNavY813yhGeQHKIVa2LPkhhToieaJG
         wG2GcMXYLJc+J8pZ2miSikzK2DMUs4qR0deE535xZRR7nHs1zo0H2hxx9Oe+UYmhzmdY
         LlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y92YWSAQ6DJ8cACRNi2JxD32qSbT1XMauYYZ8kJ0yIs=;
        b=GX3M6MVgrOcucMfWMO2mqfwqRiD9oeybN+9SWlJ8plT/bXJr1t5T3bpXNg2nvk9ITM
         8HY9o5g1uOJeOLflLIfALlUiTnTzblBvn9uwmhkmdMMOz+AwofqMKKFqI6mThBLz3NNr
         5BDewavo7I1ecAPifQHQmgI6dS2hhfhhJFpdliraaScZRRcsLgJ6t/W65aGiYmCHSoT/
         OsaCXrzBOyM+6LbZUDxUCLo21yxuwayFK2EbRpjTBPF+gb22WpZ/IfZ+/4IH9nDnWcPV
         qDzRLUX2awIlm5oVbtCCbIDCrRigElEI+m1HMFwKAB3FfJMtyYnAiw/rXGq714OmrwYc
         7qLg==
X-Gm-Message-State: AOUpUlFpMcFNam0oz4bsefbwh2MXtxDdvvGtXrIGkAGePT2ZAR0sLt82
        iWow0BKLHGs2naF8tu5cVG4=
X-Google-Smtp-Source: AAOMgpc/P5GbbW6prSu4DfvvMaBihnBKRFpa0budCLOF3XYS2CJpSAa2SKoUUEdNAiJ4ShePScfsSg==
X-Received: by 2002:a2e:2114:: with SMTP id h20-v6mr21936024ljh.135.1533156691874;
        Wed, 01 Aug 2018 13:51:31 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id r22-v6sm3312396ljh.22.2018.08.01.13.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 13:51:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Stefan Agner <stefan@agner.ch>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linus.walleij@linaro.org,
        pdeschrijver@nvidia.co, marcel.ziswiler@toradex.com
Cc:     keescook@chromium.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: tegra: readd gpio-ranges properties
Date:   Wed, 01 Aug 2018 23:51:29 +0300
Message-ID: <2326493.bQHeyqsldt@dimapc>
In-Reply-To: <20180726154025.13173-2-stefan@agner.ch>
References: <20180726154025.13173-1-stefan@agner.ch> <20180726154025.13173-2-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 26 July 2018 18:40:25 MSK Stefan Agner wrote:
> The properties have been commented out to prevent a regression a
> while ago. The first regression should be resolved by
> commit 44af7927316e ("spi: Map SPI OF client IRQ at probe time").
> 
> The second regression is probably addressed by
> commit 494fd7b7ad10 ("PM / core: fix deferred probe breaking suspend resume
> order") and/or maybe others. Readd the gpio-ranges properties to see
> whether regressions still get reported.
> 
> This reverts commit 4f1d841475e1f6e9e32496dda11215db56f4ea73
> ("ARM: tegra: Comment out gpio-ranges properties").
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---

Unfortunately the second regression hasn't been addressed yet, this patch 
still breaks wake-up using GPIO key. BTW, better to spell "readd" as "re-add".



