Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4A8C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D356222BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O6M+rOXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbfBLRQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:16:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38371 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731650AbfBLRP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:57 -0500
Received: by mail-ed1-f66.google.com with SMTP id h58so2863523edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9b6SDcWcNASqToIPGqXapMx5Mz7l/Dq+R+y7ygNEt7Q=;
        b=O6M+rOXHGCsFiSG6C4sVHS6ci6YD+AnYVsLTkzlJeykrDgaY6YP0Hl3EOnGcPzs/MK
         6NxDr5iVsJXqdFIvkp3heHwAnwUlIsqUa7BISotapag2KnoS5ehYsBqErP8wawpqV7Se
         XIxGYuBqP/aMJPUneDkR/RI2O0/gs1jI5dIlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9b6SDcWcNASqToIPGqXapMx5Mz7l/Dq+R+y7ygNEt7Q=;
        b=SgrVK0jE5c02j0FmKYHNrgNn0h6E9szX1KDau12TCr52fgLQuyw3rFiQDJLJ3HJzBm
         Qwg+CDI58D2IUEAc7koO6J6Wy8+ihS6KZ5PXSFpHDw+b+Al5E+VBCbVyq91ITGpNof8m
         VToFBHTbeGmYIOVnzUaRbSotTVmE8+S+xEtv29icsjwkoUifZrrzb+4SB9H4CosGnfnf
         pIioHRZ3EhzPoB16mKkN7rt7rrFaX7s+2v4yhOVRoZX7Fjk3M5ot9nJqYCmPAqnooPwG
         2P1Cd5lD9ViktJgmOtD62YsbjW7rqGTqfOx+Je71Yj6wmhQfDbj58T7zkUdCo0D96evH
         1MeQ==
X-Gm-Message-State: AHQUAuZVtOAXDGEKMsCBGSo2IWlejEBwQ8o2J6Thd/VOZ3rZPT5r4Q+5
        wYZBv2OxWxvDmKxK8a/kpjaXLBNWeZY=
X-Google-Smtp-Source: AHgI3IaFUDtTTiuu+Sb7ZFZRld/NTrKp0yH7kAJll/ts9gQv9g+quoM9f7XGwrGyvi+Mer5UDZ/r6g==
X-Received: by 2002:a17:906:d1c4:: with SMTP id bs4mr3486623ejb.205.1549991754769;
        Tue, 12 Feb 2019 09:15:54 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id f1sm2246279ejl.65.2019.02.12.09.15.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:15:53 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id v13so3569853wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:15:53 -0800 (PST)
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr3585818wro.255.1549991752805;
 Tue, 12 Feb 2019 09:15:52 -0800 (PST)
MIME-Version: 1.0
References: <20190212143003.48446-1-john.ogness@linutronix.de> <20190212143003.48446-8-john.ogness@linutronix.de>
In-Reply-To: <20190212143003.48446-8-john.ogness@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Feb 2019 09:15:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=whToBNHN_X_BQkO4zSyhSBaGqTH8XEtxg2_AxoBdDnEdg@mail.gmail.com>
Message-ID: <CAHk-=whToBNHN_X_BQkO4zSyhSBaGqTH8XEtxg2_AxoBdDnEdg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 07/25] printk-rb: add functionality required by printk
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 6:30 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> +                       while (atomic_long_read(&rb->lost)) {
> +                               atomic_long_dec(&rb->lost);
> +                               rb->seq++;
> +                       }

This looks like crazy garbage. It's neither atomic nor sane.

Why isn't it something like

    if (atomic_long_read(&rb->lost)) {
        long lost = atomic_xchg(&rb->lost, 0);
        rb->seq += lost;
    }

instead?

                Linus
