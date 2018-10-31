Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CD2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617E4205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bsLmE5z7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617E4205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbeJaXVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:21:02 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40669 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbeJaXVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:21:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id n3-v6so11784923lfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xO7Vcf4fzZKA49GPvzmTfY8AJ3F+PgyS0WuNXnwAAPQ=;
        b=bsLmE5z74cfEZ7yLJZZmvSUQpjVeYVPSKyN3ekwg4IS8Hz+PxvYixYEO0WHKeHJofv
         AVldRhol6vtgNaATvybeHaytiQIsZ8YaXRg3mUOPyrpTz0yqhplrOVuVHu4Vnf2I5z3g
         NknCmvkL1Am4hFXLsOheiWmFaFBG4d93olG8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xO7Vcf4fzZKA49GPvzmTfY8AJ3F+PgyS0WuNXnwAAPQ=;
        b=UFJ1jI5jfd4ppIy7rwFB2IFexuL+p+pRkfXHvF7FKWo3z59RAB/a2ZNx1I/2zDDg5A
         N0oPOMH2U5ZHRzTbZ3sFYSWCWUkR0Itc15xUHors83NqjKyftGWpR7mB9+I4ySwGGJU+
         IY0pmKTcEJrKB5zWFPVKAUZ9pjFWUcQkHa/iLR/aIP6Th1CjR6pA6bxf55zp3NMHT8Ix
         F3Z+pFZLHD3ErXmgj0eCDG7czDGxqfLv2t0+Gv9RYgaMy8GdUtMm/RAmWeRrVwI8MFji
         +m/jY2OzWyB5wvQhBNFYFIAq7VeafRxRHX7pA/HYXS0fv50wGOikq/a0um9NiaSprejs
         JPdg==
X-Gm-Message-State: AGRZ1gK2ZFt2pyloMYNHhRcWZtQ9B1tw7camHjfAOXobGIjSobFiSym1
        HtJK8dLi+nvzWacmDOpaVvfU97UGQ/ajblpvSMurtw==
X-Google-Smtp-Source: AJdET5ewvNfn+8PeaVY/seEmUBYuxnYX+gEVCG2JXMjA8MF3hQwgdv+R1vWK9RrQbupjElzCtmcgWsKpfgvsDkXzzQQ=
X-Received: by 2002:a19:5154:: with SMTP id f81mr2111030lfb.96.1540995766366;
 Wed, 31 Oct 2018 07:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181030140722.2853-1-colin.king@canonical.com>
In-Reply-To: <20181030140722.2853-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Oct 2018 15:22:34 +0100
Message-ID: <CACRpkdavUp0Yjcj8MwxA9pfhp-3MpdJbnfuCzGetSHBkxvXZAw@mail.gmail.com>
Subject: Re: [PATCH] gpio: sch311x: clean an indentation issue, remove
 extraneous space
To:     Colin King <colin.king@canonical.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 3:07 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to clean up an indentation issue, remove space
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.

Yours,
Linus Walleij
