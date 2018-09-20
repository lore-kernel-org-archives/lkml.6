Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6917AECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0643E21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmOzOYKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0643E21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbeITU7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:59:53 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40033 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732577AbeITU7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:59:52 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so12796424ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vS9jgLrGH0ZG39BWwdu+BdiMbxugTaf430O/dvG5JEc=;
        b=VmOzOYKdtPDFWA0ONxUeVG7LsqrQtiYYkv259HDkfY/wWbMsOkeqiDbQtxNbJCKqQL
         i5Mdo9pYACPjoDwvWnkZ3Til6CFhVZt1f/kH7tkt/6kRHzr8eATMsOnO8gkirJQmiu/i
         3s1CXGpjGgh/elTkYqWPX1o2eaMfPfDNi/qtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vS9jgLrGH0ZG39BWwdu+BdiMbxugTaf430O/dvG5JEc=;
        b=lW+7G7io4bjn0qmsQ1MsrCBXho28LEa1gYupn8ITnlLWTGbasqKPZ6iPcPF1fibz2x
         VJr1+TplyKP9VcPpa1/eN1ug8FtkFwZFhz3tGM09TR14cA3MhQe5ZtGdTbY8834f7ODr
         iiEZcwg6O7BkvJJovvyhge3U64bKvgjZI2wUrBAx/rr9fPprLOtCRTMT8cZYJzsh+tIw
         kFA2FLmqfBix9IlTWiGXiIWaT/8Y7U3o3X9UiBVg9cE18Mo682qRJSaGUdUKFrDEtabk
         MzH7a+bgcOypGFMreLnBWvI25isJrEbJvdCiJJy/kvHfdKj7I72VtC+uPBBc3hXfMzYC
         MGwQ==
X-Gm-Message-State: APzg51BS6uR/2k0yA1Oevsdb3Q430ohZLASUl/et4c3RzlrwjuHxD1cG
        S8tWf4js3Qk9RL7yLohTMrsNHJd0nQox9Ihs8ZjgbkhN
X-Google-Smtp-Source: ANB0VdYPQXNLrWNPRsAT3TNIk5rieI4zg/LEwP8u2HSQrZGgAJjbPAaYeCiZVvGcYNKMlzredLcREDf3bZB9/uhTukc=
X-Received: by 2002:a24:6b0d:: with SMTP id v13-v6mr2647935itc.16.1537456555729;
 Thu, 20 Sep 2018 08:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180919012427.12439-1-stefan@agner.ch>
In-Reply-To: <20180919012427.12439-1-stefan@agner.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Sep 2018 08:15:43 -0700
Message-ID: <CACRpkdbbp2p68A37Lgfj28QGga7-iEqod_QX8biBxdznkc4r9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: tegra: do not export tegra_pinctrl_probe
To:     Stefan Agner <stefan@agner.ch>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 6:24 PM Stefan Agner <stefan@agner.ch> wrote:

> No user of tegra_pinctrl_probe can be built as a module, hence
> exporting the symbol is not necessary. Drop EXPORT_SYMBOL_GPL.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Patch applied.

Yours,
Linus Walleij
