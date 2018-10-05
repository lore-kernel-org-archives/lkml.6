Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7A3C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BDE20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BDE20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeJENwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:52:53 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44525 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeJENwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:52:53 -0400
Received: by mail-vs1-f66.google.com with SMTP id v18-v6so6878805vsl.11;
        Thu, 04 Oct 2018 23:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhQVmu5PsbA8KglWsfK7J5RGjTcmlwjRRtpr35bR3Jk=;
        b=WRmByDx0mBrKLG2sljSBi8ShfpQWLUPw3vzxfBcxYtvkPEb8W5hHcyiKjNHn+mnW90
         glbTMqSobr+KGD2Ka6VWwK/A5HcD/+HYHo5eepY/mtCYmAJukcG8DboLU2eGYbVqyZLn
         EP9boRrVO9hwtuSBg545RmvYlcEw9g1p2xMXU9qSbbUux8CNBS03QmLHWT/7Q+YSwIV0
         avKJtJbcIfwGOK6eaxaqzbUH22d205VPzlWqqCnAEtMJaE4g2cf/HzJxVchCutCA/ZyP
         /OtmXZQZ8nraQUb5/uMEwvErvvGZpKeLzzMHgIBa9QpniXMNJcrz9Q0evfsWa78cgkni
         Sfcw==
X-Gm-Message-State: ABuFfojxUHGxSHh+9xCqG1DEshMTdnvorvI62ucJ/2D46IbKMkiRRXan
        +2TV2IjxZYEtUeU3zGXQF7jZR/YYG24dl4DnaWM=
X-Google-Smtp-Source: ACcGV63zxVwtAoU7YsLfAlUlb3HaOAL1c/Ue8W6wYTcjl1t2v9iuAVRxyk430xltlHJp2rZEWnKzzyjTfDiRf2Xi+bk=
X-Received: by 2002:a67:f3cc:: with SMTP id j12mr3027025vsn.96.1538722534839;
 Thu, 04 Oct 2018 23:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <1538720352-85691-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1538720352-85691-1-git-send-email-yuehaibing@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 5 Oct 2018 08:55:23 +0200
Message-ID: <CAMuHMdU1U7izR23KYdP6W912ZKLtb=UuyRu4hZv0OWkxithuEQ@mail.gmail.com>
Subject: Re: [PATCH -next] eeprom: at25: remove unneeded 'at25_remove'
To:     yuehaibing@huawei.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        devang.panchal@softnautics.com,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        gustavo@embeddedor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 8:08 AM YueHaibing <yuehaibing@huawei.com> wrote:
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
