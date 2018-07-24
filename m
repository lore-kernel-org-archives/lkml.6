Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBED6C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656F8205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="cQSnkHhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656F8205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbeGXNfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:35:21 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34488 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388275AbeGXNfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:35:21 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so7132777ois.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Die7Pm1Eejhzj2M14zuz44DEuRaFLiy8VazLk5I90Oo=;
        b=cQSnkHhD0+g/4thn+PVE17YfCf2HOwxlvC5LKMsUJvkx5G3F65lHhxasDS4ZQ+U4oX
         ElDgtt17ha3Wi9WQ6R1VRij/dH7ew4ylHRt6hhhsoq8Vsr8OGxzdYq6QZm4Ya2QPn9UP
         mtnK4ZGLU7sO4o2/ml2Hk3FORzpp8xiQcUfYWpryT2HqO5fPjW/XP2rYDT7b55IaC36f
         TgIeImSbkz/6JMpIDMMbGRjdR3qBzHah07dAuxoOWyfnTOKs1JEzqX73/+ZOVt5SJpa0
         XO8kRe6dMSeeIiSpBqSfkLUaHwxvlglIuz4+xmcJIA/mKq1mrwv+Bw2mi2thIJzmZTQk
         YGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Die7Pm1Eejhzj2M14zuz44DEuRaFLiy8VazLk5I90Oo=;
        b=eemyCliM3K2+gjXdN3wUEGCPSeL4cqQ/otpBSzmFKSKXTXcmXcUdIsDI0KiFSFYnfT
         tyll6TkRPI0CuFvCrfNTabAElZGlQgaxniTRcuHck5B/G47XuvxTpyTNbmgASSkMSwn0
         e7YUnueUUIdsBuj5fR7sAtvLF32jYRB+XJ38q7sW9gDFB+gTJpzSEeRC9toYd81+b8gH
         C4I0xxTvCOOmPHvwaeriqn0FZg97kRsuU7T6cN59WR5Na1uuukpEoHauyTpLcIDxWWXD
         zgeGjOlT20DYQfxIP9vV94Mf/pj0BCr9k181ksLfSYBOrRY6m+dScPiws8jITAW7wYlm
         wPVg==
X-Gm-Message-State: AOUpUlExGSedEjwA+hbeCJAlPhBjbzS6i4XxzVys03+Ts0Pqd1O80L7v
        2UwRS977a6Qv3ySZJnoZ8hQsFqsUJ5J9JIrE5csIOA==
X-Google-Smtp-Source: AAOMgpcVaxDTPQJIXhsr3mmARiJo2uTVTgiu+9tWnBYP1E7irApmaTG9Kw3zv/EpEaewPl2ia4Zn4x93o40hUcSAhXA=
X-Received: by 2002:aca:bd8b:: with SMTP id n133-v6mr3048654oif.108.1532435345108;
 Tue, 24 Jul 2018 05:29:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3e18:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 05:29:04
 -0700 (PDT)
In-Reply-To: <CAGS+omDPkC=Tv7SJ91cLxrFnab_VPC3VZRAugkvAUokkkoYSTg@mail.gmail.com>
References: <20180717005719.258905-1-djkurtz@chromium.org> <20180717005719.258905-2-djkurtz@chromium.org>
 <CAD8Lp446Zu=EhdzRE9pEoskMWeOHOovoAJ8qtrovEuZ2E7Z5VQ@mail.gmail.com> <CAGS+omDPkC=Tv7SJ91cLxrFnab_VPC3VZRAugkvAUokkkoYSTg@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 24 Jul 2018 07:29:04 -0500
Message-ID: <CAD8Lp44Ty9x7UF0=QOpqG-Yeo4rg0ep0VfTuW5FaDuXE1VQO+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl/amd: use byte access to clear irq/wake status bits
To:     Daniel Kurtz <djkurtz@chromium.org>
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Ken Xue <Ken.Xue@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 6:38 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Sounds reasonable.  How about:
>
> -                       /* Clear interrupt.
> -                        * We must read the pin register again, in case the
> -                        * value was changed while executing
> -                        * generic_handle_irq() above.
> +                       /*
> +                        * Write-1-to-clear irq/wake status bits in MSByte.
> +                        * All other bits in this byte are read-only.
> +                        * This avoids modifying the lower 24-bits
> because they may have
> +                        *  changed while executing generic_handle_irq() above.
>                          */

That looks good. Thanks

Daniel
