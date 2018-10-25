Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAE0C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684F320834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7rtxyJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684F320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeJYTs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:48:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45397 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeJYTs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:48:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so7801567ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 04:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D6SD6/jujQg1CursZ8OklcDodhHHy6xFN5ju3b8fGxQ=;
        b=F7rtxyJm2llV4fY39L0oVln4ufKXn5x6jwgjwDbjAsWsTZotRr5S0P6O/i407SSIi+
         xZLqN4vC8iuBwS/cyffVsgX/YviEi/wrxsKC67J7qcNa4ER7FmDIQFRd4pblxvAeYLWd
         7dQJOqDdP/qd9dJlwURQtcvr94DCDDSj/1Ueo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D6SD6/jujQg1CursZ8OklcDodhHHy6xFN5ju3b8fGxQ=;
        b=N/43CxXeF87SV2zlOGpHjSY8dMoxs9rHKsod8fC9UVLM5zSE4XynkWgu0Mr3wesz61
         iQlyb+opmCQGja0juxwVuAvHoiCvCWCrz4iILlaBdnWC8DVnhy6AQEWrCLtkWLBS2g8d
         YhkWvusE1CF3VB4EeO6SdC96l2LLvNyUpa1OAc0ZdxbcIPj59vLQqksYWkKeqplMXFDQ
         p80PZAiJMllS5suoncAx3CKci8+Db/O19c2rfpU6SphijsxJOYitMRTa30g6yJ7akQTk
         JkUh6UUY6FShKG/w2HorQrC8H47y8zzot/iMyxM96ERuBh57f/5R+owyH2wTXLx0y9Zj
         mrEQ==
X-Gm-Message-State: AGRZ1gK/jGHDXavQP+YYBzZ0kfWpRJCiB97KXzopPQGW1sj747vzIAtW
        ZdNyAj0aEuDstigxkChSsrtJJ+pkUE+32HOFfKA78psTEsY=
X-Google-Smtp-Source: AJdET5fbstZrfrwfVhap+wFQJfGr038Fb0sErhWKW4VlaIXEwCYC3QkszPfrUnKaLcEtTYDdO0CYRNpVetQaefV4Ejs=
X-Received: by 2002:a2e:90d8:: with SMTP id o24-v6mr940750ljg.97.1540466165170;
 Thu, 25 Oct 2018 04:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181024153843.16021-1-brgl@bgdev.pl>
In-Reply-To: <20181024153843.16021-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Oct 2018 13:15:52 +0200
Message-ID: <CACRpkdbzQ1chqGPWj2wSrsOBc75ZKPfFGu0hqvMeo+x=s9S1BA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as co-maintainer of gpiolib
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 5:39 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> As discussed with Linus Walleij - I'm adding myself as
> the co-maintainer.
>
> Cc: Beno=C3=AEt Cousson <bcousson@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Excellent, patch applied for fixes. Welcome aboard! :D

Yours,
Linus Walleij
