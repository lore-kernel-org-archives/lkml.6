Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B76C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 13:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0713720855
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 13:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bvo6x1O8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfAZNVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 08:21:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40921 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfAZNVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 08:21:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so8821752lfe.7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 05:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MHoRCPgqdy7WTrXmYFbj8oWLth1COmjeVoUTO5GRIs=;
        b=Bvo6x1O8Fd6L54TFJtz4Km6KXgqA75t4Ylf8Si5Fxgl+9nAwftRXGBTEWUf2U4fxu7
         Ht1MwDOPwxFg26zNj2wayT3bhUdpIvmbFxiUzOCV3KdknXsaudcFqDe5drMvc9xRY92U
         e9wenupl6PEYYoIRkj1igv58xpvHoOJwOuYVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MHoRCPgqdy7WTrXmYFbj8oWLth1COmjeVoUTO5GRIs=;
        b=pd6Kzzl+JZ5UKRRibPqDHSVwAOStJI4w9oun9ERTBRp2r0/hX+UWsYLDWw69mYa2Cf
         lAkJ4OxrObH3mhxOumnlCBtMplVtI/xxu6/Yz0pgzmuHdL1b4QK17RV9nqkw3SIAQ+7a
         ERywOa9Dcnd29yHCy4Cnt/73nxjSU2RDnN9HpNjQwIb/N5MRC18xbjP5PNnjgeQ6+7Km
         hLHIhbKnPwvqA1X/DMpV9zwI3h8CXh3nQfoe5htYbQZTXgz8YuzvNks8osOuKkJKPVZC
         K7biqcL9mIDeyVOnnC7/RmwAH2DT3Qz32QWBbU81QVMWUi2RZE0Z6suaI7hj114RKKy2
         Kapw==
X-Gm-Message-State: AJcUukfTF1kc/k0gXQNrhXvw/neW4ucc0sA7yHoFgCdtUpLWdAtM2NAu
        Fod14DUjzD5KFq1ql1g+4wByO1LIyvIgpDJ0ZrXrlQ==
X-Google-Smtp-Source: ALg8bN4KSKAVP1qwGz6ri0mBZy9Tvil6J56uq66nWHdTVDuUJCEDyR1GyNpxynDTB7PhIwniYt4eBiGOzdfqwWe61pU=
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr11964632lfc.27.1548508868717;
 Sat, 26 Jan 2019 05:21:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548175934.git.gustavo@embeddedor.com>
In-Reply-To: <cover.1548175934.git.gustavo@embeddedor.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 26 Jan 2019 14:20:57 +0100
Message-ID: <CACRpkdZWg2pKkV8nxbnh6v55J58Hg1Crw=gmRge_1bLmABrE=w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix NULL pointer dereference and use struct_size()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 5:55 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> The first patch in this series fixes a potential NULL pointer
> dereference by adding a NULL check. A tag for stable has been
> added for this patch.
>
> The second patch promotes the use of struct_size() in devm_kzalloc().

Both patches:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
