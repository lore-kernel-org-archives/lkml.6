Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE727C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8406A20862
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eoXXeEth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8406A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeH2Pof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:44:35 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37159 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbeH2Pof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:44:35 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so6823050itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqY42sz4DDaInW18SddTORscIK2ZF+ExZt6qoBOc16Q=;
        b=eoXXeEthhN17NuA4sg8qQ943LchNKeiQgTKycXrDB96AtUsamU0lAR97ALed1s7LLQ
         6U/UHLEq1sqQIEStRlcuYZBOY6t8Ij94nVFA6pLfO6U4LKlYSryCYa3N5zpqcgg+Pq5v
         eK0a4N/cp6ZpGaUeHrwbAZkv5GnwfjmvhSLxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqY42sz4DDaInW18SddTORscIK2ZF+ExZt6qoBOc16Q=;
        b=fSnKiYrTBkW6DKESzv2HIlUWyPaft3QoSlKRiqJbfSrsKAK7WdLAbo/H8U2Mqc0aAW
         BzbUPKrJ2AJ13X9mlPuRWiv4OOdWduQOuR6mNVvZJ5ZKLzb6Onb5UVhXtCCvM3K/2adg
         9e2eGnTbF6buXCfvmX/cvYduKgwZ0GD048hn34RTnNQjFjBjyEnzTqMCcWywCdUf7NCK
         1S/bYbk+dj+Fa+WGBNcLC6GeG3S+wZlGPSVO42pN3Arc770l5u6ErzGhG2ZrMd97zF1u
         yplmuCyB3CWP5F5qCJlAMjcEismEyPc/bsMxTOd4jfSz6gLM3EbIe0PsWmsMtZyhcOFE
         VDgg==
X-Gm-Message-State: APzg51CZJp7S/5zt9RP19t6bhtxvEhVeGYI0LBA6Hix5w42CEOYmvYGe
        /f9NObZSB3OGqbpqV7SO0W/6fSyDeJixV6hDALJqwQ==
X-Google-Smtp-Source: ANB0VdYPJbkXs1JVqKbPriYvzfsTMDKa5tes0B1+6xwaPAjk6gK3Kxtu1G1lqbrS8hitUFfzcdn+T5uYpb98AypFz8w=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr4608552itk.62.1535543283195;
 Wed, 29 Aug 2018 04:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180815171035.GA17360@embeddedor.com>
In-Reply-To: <20180815171035.GA17360@embeddedor.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 13:47:51 +0200
Message-ID: <CACRpkdYLWLhw-O00=Gc3FeVWt9dKFURNO2m5ic4MyjbJrGtGdA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: lpc18xx: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Joachim Eastwood <manabian@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 7:10 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Addresses-Coverity-ID: 1292308 ("Missing break in switch")
> Addresses-Coverity-ID: 1292309 ("Missing break in switch")
> Addresses-Coverity-ID: 1309546 ("Missing break in switch")
> Addresses-Coverity-ID: 1357369 ("Missing break in switch")
> Addresses-Coverity-ID: 1357389 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied.

Yours,
Linus Walleij
