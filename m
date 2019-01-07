Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4D9C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDC921783
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dv+6YeVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfAGCXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:23:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46540 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfAGCXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:23:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so36811607ljh.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 18:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3tj7pm4UmZnLxfKcpU9mdtYQNswus22y6Jt9pfqfs8=;
        b=Dv+6YeVCqmAWDcOcQoTcRSr4KqtN+vIbOsuP95RSEr5qpokiJy83Ikb5qwWlPmLyaK
         eWQeakc90JCyVotmrDxvOShX3VB+7kMZcISjkcYS6L6XUdAL/wn7bLvRuLnR/REQCc+Y
         79vJ+7Rb1Jcy/ZOn6okROrrdDld5mkt3dgsHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3tj7pm4UmZnLxfKcpU9mdtYQNswus22y6Jt9pfqfs8=;
        b=bU89e0/UW8r5gicw6il4KnMNsdMF79kaGGFqCFe2GrkPRo3otazxhbgfL4t8r9PXAD
         XHn2pUNLNMG876IPaX1oEoFAMWc1ixCWTTmhBD39c1KB8YO/iqIfSWv0SIxxHmaxv78z
         KzpAr5aVFzCL2ps/gzg6Xc0QaQlQMLqGSZx4tGMTg4Q4chv9ew5jYKE3FTS42FQHxzCW
         3jdkAkbbehjiqTivF1+GHOslozOTp5wrulFdIAner9+hfthCjvHaoYuNrm0TsDlcylwp
         b5amnZZS7mFMPJU9MlBhODQdtnJCQ20UqZoufTHtU6WTCfp+9bZIForwgugdbv4quPVF
         2LCw==
X-Gm-Message-State: AJcUuke/VybO0Fin6oCMx4SEIrRc6oMBUoR1WTb88m0cBnxE7KQj3EoC
        Rde3bU4CDkeADnnNeehf7IXbXAb3ovc=
X-Google-Smtp-Source: ALg8bN4Ukg6wKuA335go7SiYnjOOkMplyT0bAudGUzU6mIVeb6V6V2xJ0tn1FvEDOkKHKJxhUpaTrQ==
X-Received: by 2002:a2e:5703:: with SMTP id l3-v6mr35634107ljb.106.1546827789940;
        Sun, 06 Jan 2019 18:23:09 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 11sm12539022lfq.89.2019.01.06.18.23.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 18:23:09 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id u89-v6so36888105lje.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 18:23:09 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr32903976ljs.118.1546827346766;
 Sun, 06 Jan 2019 18:15:46 -0800 (PST)
MIME-Version: 1.0
References: <1546826888-29197-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1546826888-29197-1-git-send-email-yamada.masahiro@socionext.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jan 2019 18:15:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiHNj59B9BJww2u-4mPERp5=EKCWtn4ZQC0TSiX47gYiw@mail.gmail.com>
Message-ID: <CAHk-=wiHNj59B9BJww2u-4mPERp5=EKCWtn4ZQC0TSiX47gYiw@mail.gmail.com>
Subject: Re: [URGENT FIX PATCH] arch: restore generic-y += shmparam.h for some architectures
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Michal Simek <monstr@monstr.eu>,
        Stafford Horne <shorne@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Guan Xuetao <gxt@pku.edu.cn>, linux-c6x-dev@linux-c6x.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 6, 2019 at 6:08 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Could you pick up this directly?
> Apology for breakage.

Oops. I just made rc1.

But sure, I'll pick it up. Everybody is likely using the git tree
anyway, rather than some random release patches and tarballs.

             Linus
