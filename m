Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38FCC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB15A20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GkpopHof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB15A20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeKIWT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:19:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42074 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeKIWTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:19:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id f3-v6so1444262ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 04:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nk21tnnoDwhuNvj9FAuE4Ry3v2AXcRImK4QnDNjlSDo=;
        b=GkpopHofFpkkvXOfW33KoxZJH4V+9vuEQXZY42rgTi444qJW/a22UCcCY2I1qiVV5f
         fXCq+ahasxhwa9rOypcYAIIOMP8EaK04zijsRYRno1B5Q/8IbLOgaLKSlGWNHBE/am0/
         6WGIsPPWnfb1JoY8WiuWyRBqCwzERybAp9d7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nk21tnnoDwhuNvj9FAuE4Ry3v2AXcRImK4QnDNjlSDo=;
        b=VZFZHEX/u2w2XBEbbjwp/aR0Sx3p3nuLFtCewmmmIWISskyRIaGv+2uYKNi+aQM2J8
         xPq6xGFSmtandErA4K8Aj3IU4CLRzodzBUZMOFxnsFkGGvManXFxEeamS5QI7jXYMgmq
         3qQELnttjgsmLfdufdtCpQzFRhJ/pMc/vuHZHpxiuIQqDXMcv3O6T8vWP+hOoAE0xaTK
         Ibyrw8wyPf3PQAafXi/IHKWsyKEwhEv65RSec/7kPMTklhPoO7v0ewgKU6ks5spN5AXd
         VNIGOuYMUuq5Xhj+GJwLXGH+NK8/BV+TMaKMyatKHelcceYarEk6ZMdd6yUJkjURENqP
         pG3w==
X-Gm-Message-State: AGRZ1gKPT7EfeC8AxUxaXCkUBoQicOSi2yuBPNQ/rKCkJnRM4NUSUr2w
        hLb80kqmUTsFA7tBUnljrqGLimVwD2k=
X-Google-Smtp-Source: AJdET5cgkINTaBSp9fO3L/rKcD7rgQHtwkvx0bWep7iKnDMDgv9t5nximmvKZjP1ttd8YBUefcU64A==
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr5899131lji.60.1541767166123;
        Fri, 09 Nov 2018 04:39:26 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id v5-v6sm1370329lje.78.2018.11.09.04.39.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 04:39:25 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id p86so1221399lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 04:39:25 -0800 (PST)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr5421215lfg.117.1541767164362;
 Fri, 09 Nov 2018 04:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20181109081402.777716d1@mschwideX1>
In-Reply-To: <20181109081402.777716d1@mschwideX1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Nov 2018 06:39:07 -0600
X-Gmail-Original-Message-ID: <CAHk-=wj+HK7htwua62MnT9e_vsfgboiACR08MQDsXj9+4WQEBg@mail.gmail.com>
Message-ID: <CAHk-=wj+HK7htwua62MnT9e_vsfgboiACR08MQDsXj9+4WQEBg@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for 4.20 #2
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 1:14 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> s390 updates for 4.20-rc2

Pulled.

>  - A fix for the pgtable_bytes misaccounting on s390. The patch changes
>    common code part in regard to page table folding and adds extra
>    checks to mm_[inc|dec]_nr_[pmds|puds].

Ugh. This is somewhat invasive, I worry  that some header include or
architecture doesn't pick up on the subtle __PAGETABLE_XYZ_FOLDED
things (if you don't get the includes, the mm_xyz_folded() maros will
be mis-defined.

Has this been in linux-next or any other wide testing? The changes
aren't _new_, but...

             Linus
