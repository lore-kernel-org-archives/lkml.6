Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38955C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F0E20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F0E20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388338AbeGXHrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:47:25 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34584 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388279AbeGXHrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:47:25 -0400
Received: by mail-vk0-f66.google.com with SMTP id l143-v6so1534807vke.1;
        Mon, 23 Jul 2018 23:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kzYJdxRtl2zoJLT8tysuqz/tFUEsxxbAqwg1HaSJvKQ=;
        b=q72Pr6gE2kkzTr9cLPctH3fGa81ISnRKMq/uS/QYUWJ4WmxWgrOIE777PWy6Ily7g9
         PxC3La6EicdG3pTGvjHw/Uzy9KCi+jfh5OcusszPzi3rAgu0qjhyJ2Lw3lERKK8P327f
         NNZ0vDmBcmD4ExITyfU+kAjc3t3XB5YA2IHBmzXE70EpORBHeym455PuiryykAIT+uUk
         TfYiZ3+TSXBtf+or7tCc4OJJ5eq8TIfWWjRsBCM1GWdz20BuJWOMyDwHosr9HnFOmMYs
         tVBFLP6C8Nn/tX4/csWWv/QssCdIGU28uGEmd1uh4IIA4qFkAK3zEe0PduQmWkHyY3Qj
         JmlQ==
X-Gm-Message-State: AOUpUlHR04n7NWawYLRwAGInpqz1Pk/RSwlRN45xjN2sBa/JG3tFPhBj
        J+t7Gj0PZ+wilyi7TCMBn5Q0t4/jnWPK5Wkcatg=
X-Google-Smtp-Source: AAOMgpdD+arhnlxfO14T/057h6tKjPok2t5HLE7gPam8qMMEP3PTns3hJ4mcUjQfdB45ULcQG9v94L97Z4//U5q3ky8=
X-Received: by 2002:a1f:dd47:: with SMTP id u68-v6mr9341679vkg.137.1532414550267;
 Mon, 23 Jul 2018 23:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <1532413979-187684-1-git-send-email-weiyongjun1@huawei.com>
In-Reply-To: <1532413979-187684-1-git-send-email-weiyongjun1@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Jul 2018 08:42:17 +0200
Message-ID: <CAMuHMdXUAyn-SF5j3EeA5xvm-BhYAmK4eegEyCEf9vdPhejaUA@mail.gmail.com>
Subject: Re: [PATCH -next] regulator: bd9571mwv: Make symbol
 'dev_attr_backup_mode' static
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 8:24 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> Fixes the following sparse warning:
>
> drivers/regulator/bd9571mwv-regulator.c:220:1: warning:
>  symbol 'dev_attr_backup_mode' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
