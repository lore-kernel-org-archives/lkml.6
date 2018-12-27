Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DF5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10776208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fKRiAQ2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeL0Sl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 13:41:26 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38047 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeL0SlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 13:41:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so16944466lja.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 10:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyDe1p+tkmFcikYp8QyhHWP9919PccCLPbnmFGBAZW4=;
        b=fKRiAQ2yHSIOaqa5IeeIkPeQdbdevbxKsoNfBuAZ8IRcOlsHCNq55qQ/ccgxYg/IQ7
         ixhvS8rUkijJtUz7qCkfCxcmFa7yfUi0EMZY4BCVwk7LyB9xtzDr9cnw91Nno6Nj6T0f
         oK2KeCPZUKqDHJKrYqG+KhXc4MJQkwb+cBmkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyDe1p+tkmFcikYp8QyhHWP9919PccCLPbnmFGBAZW4=;
        b=DNwQYrXVdYOKQM6ABlgvqpqqEJGRLLG1nH4E4h6COF/rMJhMo4w2w+Rcti5r1oyhj3
         lByQLvANyOXEi+1kKSqV6FYuVZpq2A0sllRd51XlWVBUHdwgzjaKhuUyhctGLAAeSjtX
         CcHrIZgmP0yBEqg5uxfq6WpZe9Y2C2Bzwokjcu3OOvkk8IwGyXNrAB+txPgRQVUUhayu
         TZjHFwftcCG7yWFkvp4Di5bOveh/7bz2liZHEcZ+BjTdokG67cKZSoLJrF9vX3OuIxHT
         WNzdeDgaMobdVEwwyYXhGR9yipKjXp8wOFygx7nPV+ZaqmaitvdGkyULhemQVkdFUI3H
         0aKQ==
X-Gm-Message-State: AJcUukfs4DiNFaLarDY83CBtzV29WWgs9GfM+UUTJvpSxJowz0YbQMM/
        uMY0f7SOwCFndRuXvUsTnlqAhhpelcU=
X-Google-Smtp-Source: ALg8bN5OSIVjEC17VLfHsZFockewHRHtFmI17oEayzNy9Pwv8k60VBEWtuTUJ5b9JvvTywj7lXGLww==
X-Received: by 2002:a2e:3012:: with SMTP id w18-v6mr14217283ljw.75.1545936083268;
        Thu, 27 Dec 2018 10:41:23 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id f16-v6sm8249962lji.88.2018.12.27.10.41.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 10:41:22 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id u89-v6so16969684lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 10:41:22 -0800 (PST)
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr13695081lja.148.1545936081926;
 Thu, 27 Dec 2018 10:41:21 -0800 (PST)
MIME-Version: 1.0
References: <20181224224509.GA67077@gmail.com> <CAOesGMjQg2vo2-fbjppumttN1Mz9Ce6VqvK0SkfhdkHPxhP=DQ@mail.gmail.com>
In-Reply-To: <CAOesGMjQg2vo2-fbjppumttN1Mz9Ce6VqvK0SkfhdkHPxhP=DQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Dec 2018 10:41:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjo=hdU9iQf+DdQ6pq4GOrPm+ydf6CkJJvft82EHrKGzA@mail.gmail.com>
Message-ID: <CAHk-=wjo=hdU9iQf+DdQ6pq4GOrPm+ydf6CkJJvft82EHrKGzA@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler changes for v4.21
To:     Olof Johansson <olof@lixom.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 8:17 PM Olof Johansson <olof@lixom.net> wrote:
>
> Linus, can you apply directly?

Done.

              Linus
