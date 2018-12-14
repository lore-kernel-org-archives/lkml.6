Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDD4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E1A206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbpQPcF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbeLNPDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:03:46 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44431 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbeLNPDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:03:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so5141877lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 07:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u/qGRSrhkslRfRZkCOSZnGtEVWI+I6J5PC6Xl0kVfQ8=;
        b=AbpQPcF1RdcDXZRWJoX/EauVBx+LTUdwfG2YHOniVGj5EvV38YIB21Bh0Hd5ncW7Ne
         xKjFsRDAmL+71LSUUspZC+jfp60xt6WzwC3XqL8qTaEiVLeC1YownsCOxULMviXYvxbq
         9ByJXg5lyOYZm1vzyxgrG1NoQ5CvYem5alYRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u/qGRSrhkslRfRZkCOSZnGtEVWI+I6J5PC6Xl0kVfQ8=;
        b=ekSY3fNjAMItiQ6/kRiNI5GT5OMtte2qzWWrxg4gw3eEIKZ+VqcHLJ3SbgBDiiSwTa
         tUvuPxOGiY+Kgvvpd9LHAGsLrxIHRVJZwme05KRwvYGUf5+6nrz9YwooFOy5yQ58fyih
         2nimaiIdHppqaGJD7JqmsZi229iV5pHv2nrPDa1ljZVMoj1imwqy4ImJdkZFgv+v7BeW
         b+k4WyJFZs6gQfg/r2A4qkuFd+H0r/zlGvk/Kj/i/R1i0cwQ+jTj5oVhcZgUoQwqPN0W
         XmQIPZpBLeYq7cSf7goSJ8AErPoYLeTD9VNo5lMU7avJNe8eGQXClb5UXnN82adeO0t3
         tm/A==
X-Gm-Message-State: AA+aEWatu48neXi3TURuMWDXa9dtziLnX5BmNDQdMZDWBjHhggxfxFLN
        ZHIP7edpuKxATkp1EKjUx73t4QFofGcsUZh4KHMbcA==
X-Google-Smtp-Source: AFSGD/UNcTZ6znxZsSFExRyVIZFvjBO6lvO1MpJWcsFs2NIOJvNhMoCgY6G6Z9YNMbcugl9AbzR4YB4Wja/7+NSKRT4=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr2082817ljk.4.1544799823976;
 Fri, 14 Dec 2018 07:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-20-robh@kernel.org>
In-Reply-To: <20181205195050.4759-20-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Dec 2018 16:03:31 +0100
Message-ID: <CACRpkda2qA4AQG3sT+7LEvuGV=8EtnLFnAn8WCPbnoD75X7EbQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Use of_node_name_eq for node name comparisons
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 8:51 PM Rob Herring <robh@kernel.org> wrote:

> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied!

Yours,
Linus Walleij
