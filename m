Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB2CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687262083E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJZMu45C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfBNBMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:12:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36367 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfBNBMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:12:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id q11so3285256lfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 17:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+CK3h06JP2ePbDgZuFb8l81NzBDGF8oHvDHMG3VvcSo=;
        b=KJZMu45CbWlgc/Fix7vFAWlVi2Q2cuTp6l2pd+U0LnfRAB6SMraL1EmXY1kb30Thud
         K5q0rGaDaETNgxPtzDPx1R3FQH2XoEoraiI6S7HC+apQNv5DiIhhNEIZ8Wu1dqrpuu8J
         rMQ+iMrqZgvnULkGHcjOFWKsqqZBd52aT4OoqIA7d8K9X9UUwQZaTVOV+EXtnVlCq99s
         pgR5Bcc6bWyPoEFzrgdBlkxntUIeu2Py28MaRfLrDW0953IdnRNweFlCfYWsEBuF95ky
         k3a5OlYLv/c+7aZxlsAClwkd4pJaW2ZrCFE6ZGHifE1Jzw85TQAI9n2CJewQFspQe5c2
         bldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+CK3h06JP2ePbDgZuFb8l81NzBDGF8oHvDHMG3VvcSo=;
        b=aqNZg5OXUdD45LIaxdVnexlKRjUNwg+Eba0PxrNYPwSx+xuD0vE53h5HSO8vessjae
         QO039jG+i/Dq8bF02IVCThb5vY4E2k8K24vzB7tFcU1mH3mjXx6vzomnWKSWLkRHw1ce
         IUv+cqNurybz7q9d8zgBYTJ8qddkF8NBk3XGjEi/KdC8nXq0ewFMWg1o9T33ZGKUKkoJ
         0PPZYOUrVoEuARzVZrY8hfq1zbRlJr4KD+WGvIPfPPflRE3n4rPw9sRZ/qBxhTDZReOo
         8FuETpuRx35hkoH1uj9+dVniKotI0WMb4SN7wJQYppTyfBXKJCFeSszBnHegFFmPClvp
         WsiQ==
X-Gm-Message-State: AHQUAubbG4lhIWcvVG3utPzQmUvvEJugKbmbVE3oYwLmmnunYFxe5ZQR
        RHSDcj9AvGx8CbW1V8pdqJW21pAGysiSgimopSGTt9M4ykM=
X-Google-Smtp-Source: AHgI3IZrU8MqW/NuuHs1ZB+hM39vyTospuySSFoNqy+aojaiA0X/Q3lXlvezcD9M3qr2lb0uA8oklZTCTf3Dg7eC3h4=
X-Received: by 2002:a19:a84e:: with SMTP id r75mr516753lfe.45.1550106738559;
 Wed, 13 Feb 2019 17:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20190209001522.GA11769@gmail.com> <20190211082619.14d3f6f1@erd987>
In-Reply-To: <20190211082619.14d3f6f1@erd987>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 14 Feb 2019 02:12:07 +0100
Message-ID: <CANiq72m31+2bHDs2mt1iY8C1S5ARoG-QeSeDeofCW7uPFWiXtA@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: ht16k33: fix potential user-after-free on
 module unload
To:     Robin van der Gracht <robin@protonic.nl>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 8:26 AM Robin van der Gracht <robin@protonic.nl> wrote:
>
> Looks good
>
> Acked-by: Robin van der Gracht <robin@protonic.nl>

Thanks all! I will send this for -rc7.

Cheers,
Miguel
