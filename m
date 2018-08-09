Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E75AC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A852083E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAsFRlkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A852083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeHIJV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:21:58 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42343 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeHIJV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:21:58 -0400
Received: by mail-yw1-f66.google.com with SMTP id y203-v6so3514443ywd.9;
        Wed, 08 Aug 2018 23:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6JiQ96DaCJqrkS9rhpRrBs0v03hI9u7BYTi+nCO+XU4=;
        b=IAsFRlkU0FGCFbNIukZd+AVZ7nlBGJpClCh5SfeYU6qYS/0NzhmC+xRfoY4k6nuiUk
         LUxZc/GbVdfFyy+iQLfdBuvdBj1IDhu/kuFfmsxdRHQV/uOHaMdnSaAgN0d+ZY804khA
         9Ib7zHh3umUErYqqLdrpg67DM6hXxMMMM3lNSa2o4CH7hQdlVeEjuTAxvNGgeEtEn9fT
         k2RXbjqvwovuaGpEAnccnWaI22TVsGWB24Oeep+1BqWrs/3i72c2l8hpd0lhwfB6CX9W
         OhCsI2NP9xAnvsZKiJFDCk6zy8iowP0D3tvFQDXjPzGKWabNttbEBroHbmE2e3YPBCkf
         vLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6JiQ96DaCJqrkS9rhpRrBs0v03hI9u7BYTi+nCO+XU4=;
        b=EGmpMbhhHPMFfdooRR9rZVpmJOGEPAvGTo8ma+m75aP8LBZnwDArQaiJuUHKc0Raw7
         7leUdYfm786w7DzfQwNRu3cTKXN74kCN0A7QTyceJWxh0BV2BFLPKmMReuZi6a448ZJX
         nidxznPCxR3FEaEt18qu3UyoVRO7poLFVe4igYxTGT2kd6JBMTbhaosYuPhyRXpz+ySk
         GEDrfqZn/73B+ZdE8hhfK7+ffO4gBV4rNBMXUUZ/uf6Xfsf38cHPmL9BVeqX8ZQ26WmD
         pH0854MWfLuWD9FhuXI/24hclsJyQe6307YmphhWLenUQJJysS7b6B6vgyryVhMjq1o1
         0ryQ==
X-Gm-Message-State: AOUpUlHgpmwPAqmxjS0jy0XFHEASvhGA1kdBfG48T1IIHPtITU/pyzPd
        BykMIpNZiQezuNUiyslKJq50BQyA/q+IUe9ZjKg=
X-Google-Smtp-Source: AA+uWPxuvGqH1WRavnsgHqI989nBmSjuJrylZhclSjSwSXIlya1LYf3L0S1lebQ9dYhOlMFOvqdQKLR6Oz0uc1c5QTs=
X-Received: by 2002:a25:c844:: with SMTP id y65-v6mr395803ybf.278.1533797912701;
 Wed, 08 Aug 2018 23:58:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d44:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 23:58:31 -0700 (PDT)
In-Reply-To: <1533791971-27504-1-git-send-email-yamada.masahiro@socionext.com>
References: <1533791971-27504-1-git-send-email-yamada.masahiro@socionext.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 8 Aug 2018 23:58:31 -0700
Message-ID: <CAMo8BfJAkrVRqmTSEc1MFpm8gTwO7FS=80yTNy3_gHM-ckfY8w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: remove deprecated host-progs variable
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 10:19 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The host-progs has been supported as an alias of hostprogs-y at least
> since the beginning of Git era, with the clear prompt:
>   Usage of host-progs is deprecated. Please replace with hostprogs-y!
>
> Enough time for the migration has passed.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/xtensa/boot/Makefile | 3 +--
>  scripts/Makefile.build    | 7 -------
>  scripts/Makefile.clean    | 1 -
>  3 files changed, 1 insertion(+), 10 deletions(-)

For the xtensa part:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
