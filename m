Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0B3FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2D820882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4QEImVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2D820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeINN5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:57:06 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51704 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbeINN5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:57:05 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so1568804itf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 01:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdnROInqa8fgM6Zwqsu54AYpV92t4kezTWLkwiUlX5E=;
        b=Y4QEImVVpdTJ+93YRu2utkMcUC8g+VPVhSyqoxIegc63GLfcKLP6K7mQYljhVuBS8o
         KmuretaHEQtC1OTbskhACWru6UHJdfk+GB4AhtG7fC1gdAbEwVkmxGogFi/dB9gN9MVK
         IbM53xn/vId9/cD+F61E9W+kefbT0bvvJxwK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdnROInqa8fgM6Zwqsu54AYpV92t4kezTWLkwiUlX5E=;
        b=l7imdzYi43r1DKk6omObyw30c6apV8Vr0I//4kXjdHLTD09WHIRNy2X2+RKsBuJhcm
         4j15wzDjv0I+rmMp3TGO9XexiI8bbYqBADt3LHsiK/XJjxJ6t8D8E0j43pL5Bm90nYE6
         xr1OrGuNKkpjgjUHUEqsnt0lQ59/T97NotvO/6pcKnuhALQJd9DNacGugoMmdJSaQw7U
         zGbcdQcVWKoNYwKKDzlup1qHHbg4ywtZ5Gi65KBTa0GjrsTDMda88qFh9DErzOQOYoDf
         AeNqMwfvjIEpf4PPoSiUU9zNOpv8PFkIISj2L1Hizm+5+Fb1WLD33b4YYb6lw5VGjBtp
         Y53A==
X-Gm-Message-State: APzg51CSddivrmB4b6s8mCjB+JNhebNcCPHe54wxttwThKdSB7bz+wNE
        x/KMCsdqPnTKwXNPnVstNkJ8x8sDtCy97bfiUC9+Pw==
X-Google-Smtp-Source: ANB0VdZbukmqAmAFwQo6guO3A/XDRAk6WkjiesOUuKKcuWN3GTp+51bLdX2jCrY5WemwRac7S+dlokPLwcgKUK2E3Lg=
X-Received: by 2002:a24:7044:: with SMTP id f65-v6mr480465itc.62.1536914617571;
 Fri, 14 Sep 2018 01:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180912135352.19722-1-suzuki.poulose@arm.com> <20180912135352.19722-12-suzuki.poulose@arm.com>
In-Reply-To: <20180912135352.19722-12-suzuki.poulose@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Sep 2018 10:43:24 +0200
Message-ID: <CACRpkdanfg5s6_cAHdr3Sgc1NodNk+ECK8w0DoLvMvw9dxuWwA@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] arm: dts: ste-dbx5x0: Update coresight bindings
 for hardware port
To:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mathieu poirier <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        coresight@lists.linaro.org, Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 3:54 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> Switch to the new coresight bindings
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess you will merge this with the rest of the patches so I do
not need to queue it?

Yours,
Linus Walleij
