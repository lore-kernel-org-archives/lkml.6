Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ED7C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E6A27CED
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFVjrxww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E6A27CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936330AbeF2Mgm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:36:42 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35536 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932676AbeF2Mgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:36:39 -0400
Received: by mail-it0-f68.google.com with SMTP id l16-v6so2657424ita.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 05:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBG7mXx2IxpRnogZ1FpdbDkhc+onC7si3N5eMJNpvmY=;
        b=TFVjrxwwbI+D8PXRgqV710Bc4s4q65h6JYRyq+s4KFmUdD0Tjb7PaqAql8Nn93XO/4
         GBf4ZiDFxSn/zY1tu5XNDDgai72vuFDS/YpwCE4WUUiFg3nl8x6xKAu8B9kERyzZBh4p
         qfOq2Ec5EereTMpbnkZm+tS6KyFPPQr+9+Pfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBG7mXx2IxpRnogZ1FpdbDkhc+onC7si3N5eMJNpvmY=;
        b=DA644tHVcjp9/4+ZP3YWiiN08qQ1SDlw2qXivsEfHVgl1FfY1JuugV7mWvKhnD6omf
         J9vr4AXdUGqeWTjt6ZlEU6ptKbUdQYgaUYfoojV9zquBEDxipATfqeUo1mdGir/C+e2Y
         RybgimGrld6KIn0UZMM7JCWm5/2BK4RiRrYQ0BFqXb0cFSy9cyE6auBFGT4cJqgm4YyW
         RuXCx3k2qHxzxMv6s/b7Ah+bsFWaf2BxIiXng0QiSqjkkJsxh2zyGHKQzfMJ8YZrA13f
         xpcCYtmhVb5Rp9H7ehQ8aGYmY5xXAFh6Hd5r4n4EiwTRoDFZKPKa6ZVcWNkaqpR2SRce
         OYfg==
X-Gm-Message-State: APt69E3/zYMOtYWcpqEwW32cactVYSJa4uO64CAyqLJwmdi56RldqezN
        79Jn3QouNujkPOEMwAxVUezhjKCSaE2Q9lSqTLztBC+S
X-Google-Smtp-Source: AAOMgpcLP+7K8pwUSuQVf7CME2zc8KPAPLFcHsBfSCUDCoL6uMkn/GRyW/2c4oTp+MkKg8aZLtI/wv/+90xSPc9Zixg=
X-Received: by 2002:a02:597:: with SMTP id 23-v6mr11398982jal.112.1530275799017;
 Fri, 29 Jun 2018 05:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530005114.git.mchehab+samsung@kernel.org> <60e0372bb4d96f7795404e28d776a4600e38efe2.1530005114.git.mchehab+samsung@kernel.org>
In-Reply-To: <60e0372bb4d96f7795404e28d776a4600e38efe2.1530005114.git.mchehab+samsung@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Jun 2018 14:36:28 +0200
Message-ID: <CACRpkdbiWoZ0HjYw37MyN_23mdijDNEJhdJ=voqVTKAqbgAqXw@mail.gmail.com>
Subject: Re: [PATCH 6/9] gpio.h: fix location of gpio legacy documentation
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:49 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:

> The location of this doc file was moved. Change its reference
> accordingly.
>
> Fixes: 7ee2c13080c9 ("Documentation: gpio: Move legacy documentation to driver-api")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Should I apply this to the GPIO tree?

Yours,
Linus Walleij
