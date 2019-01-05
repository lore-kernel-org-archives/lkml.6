Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2D6C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BFF222C9
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q+5cDkxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfAEVfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 16:35:53 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37858 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfAEVfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 16:35:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id t18-v6so35174889ljd.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 13:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxbn7OZizY4endTBK+hV62HfKgJuHeH+yi957ApGI7Y=;
        b=Q+5cDkxGHwSomySBmZDsKmSHGDlxgEDl11bY0f4iCpBFmMN/2h+t1PrE980iHl9hbM
         BQo9f+tO7IlIkDhwdj2UXseMVWBVfkXrNCvGFQQUUORQ3jo08qtjxIZ/a+gWWS3nP7P2
         t/wTjLQmtGFM8ZjrP55sUfmfeP8uaL7AxH7Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxbn7OZizY4endTBK+hV62HfKgJuHeH+yi957ApGI7Y=;
        b=FrEwHiOY7qtRymZvK//6ItFL0+asxlF4TWhqYVHChSS9gMPbd0tlgs0M8Zg3PyEXJP
         GXPEbFiqVr+tYVLLkzbjppA9Y9InB97DqE1FNSaKU1L2NWDSolW0CzsRvMLm/kXsrmzG
         ywus1KyE8n01AhmgeVotFiY0LrKZNPmbl0rHIiWsrEJVEHc9NqGRFAZQPcXKKAE2Pn+Z
         RJzq3fEJKs+hm2C5hmFPHn9waVbmbOolQ7a443JCt3GVPNb8J7uiONS/0xAJGtsTvoBb
         n5Rn3rQDOKpYUnZFwWR2mscUMjGqADjIuMJ9aCfDG8jXU18iK09d2sC1ikEYIVubSAFr
         gosQ==
X-Gm-Message-State: AJcUukck7TW61wIwjmbmO49OrfZ9Gvr+VvJhqqM/seIYIVR/lpBUiL50
        HtJDwA9BvRDRA9h/j/BzVzS6FiUC5fk=
X-Google-Smtp-Source: ALg8bN5Z+kTXxG3oW8l45WiUXXtqLjaMBxcoIe/JNkrp+3t5L6Rkcz1fZuw7wu0WRKTehamj53a9KQ==
X-Received: by 2002:a2e:3218:: with SMTP id y24-v6mr34491533ljy.157.1546724151131;
        Sat, 05 Jan 2019 13:35:51 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id h22-v6sm10047772lji.45.2019.01.05.13.35.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 13:35:50 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id s5-v6so35141846ljd.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 13:35:50 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr8257272ljk.80.1546724149804;
 Sat, 05 Jan 2019 13:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20190105212118.61022-1-olof@lixom.net>
In-Reply-To: <20190105212118.61022-1-olof@lixom.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 13:35:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiwLK8uPuzh3OABUHHi9D4PO5+fPaizRnviGno5oGevbA@mail.gmail.com>
Message-ID: <CAHk-=wiwLK8uPuzh3OABUHHi9D4PO5+fPaizRnviGno5oGevbA@mail.gmail.com>
Subject: Re: [PATCH] lib/genalloc.c: include vmalloc.h
To:     Olof Johansson <olof@lixom.net>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Skidanov <alexey.skidanov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 1:21 PM Olof Johansson <olof@lixom.net> wrote:
>
> Fixes build break on most ARM/ARM64 defconfigs:

Interesting.

Andrew, I thought ARM was one of the platforms that your tree compiled
against? Or was some other change just hiding this?

Anyway, I'll apply as soon as the previous build test finishes.

                   Linus
