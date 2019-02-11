Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C64C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F391521B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P2U8JPxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfBKRL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:11:28 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33099 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBKRL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:11:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id q12so8389872lfm.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 09:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s0Ke2D+YQhyUTnHYmCz/UEaq2bJ6aXQCp0Q6/PcRnJc=;
        b=P2U8JPxpfd1ZC1nnCAC7878wfYW5iOSdJ7BZrPQlgP1hmfq9YCb/OQhCjqze+rZ25R
         +PReXxR/RT7BXDLgu2+qyY6oqvA9NK5NQuR/tac2OVjYDMDpiRlaiCuHmkHI6w4eSmQ9
         PXxuoLuXsBXuot/ECFNQF9pZdrrw+0zYXrtZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0Ke2D+YQhyUTnHYmCz/UEaq2bJ6aXQCp0Q6/PcRnJc=;
        b=iuEoCbuyNucHhuDJyQCK3zhx4Y6SfKYCOYZzxXyBmLPF3VGs0nS3PP9kgPN13y7eJu
         P8COLbj/cdKdfBTj5rarXk41tK+AH91/LaipLlf62ZpcW6kXz1zwmvDQyfN5DkeJUeH0
         dSZQqCrXWOp5jbfFVUQvm5Lqh6Uv1gLFq6nKxn8GeEV/fWheeotAdSm8iv/EzK0tFox4
         gYHxFyALJj3OC0oeMLdDClqeWw65KdPLXj0XFQMkblfymJT5294rF/Msz9DSd9eTpNRa
         61uQ3+difYZLYn8pA+NevhW8avIYKm067Nk6JT1b0fne2axJ70Si4mH9uXWoI2Kfc5Ly
         MQUw==
X-Gm-Message-State: AHQUAub13jvUyZIWpdOG1slfR3llzKWReDdrcOM8LtcMnioNzzYgvJAB
        eYm0JbyMa1xdsGppvPlHJ5/k/N+GNYs=
X-Google-Smtp-Source: AHgI3IYMb4HEnNWmq/pUBVFgnI2E6cbQp0WeZR6CuPmO0DQi/3sD3/km9VceSH4g3luHN0B5CYRhjA==
X-Received: by 2002:ac2:5230:: with SMTP id i16mr8984309lfl.63.1549905085349;
        Mon, 11 Feb 2019 09:11:25 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id g67-v6sm1623832lje.62.2019.02.11.09.11.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 09:11:24 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id n23so8362095lfl.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 09:11:24 -0800 (PST)
X-Received: by 2002:a19:9813:: with SMTP id a19mr22653642lfe.103.1549905083849;
 Mon, 11 Feb 2019 09:11:23 -0800 (PST)
MIME-Version: 1.0
References: <1549570542-2471-1-git-send-email-longman@redhat.com> <20190211083911.22f64578@lwn.net>
In-Reply-To: <20190211083911.22f64578@lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Feb 2019 09:11:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgvHhe+3HSpLSZEQm5ToJW4AFiynMvYBiqu=2zBVZnt-A@mail.gmail.com>
Message-ID: <CAHk-=wgvHhe+3HSpLSZEQm5ToJW4AFiynMvYBiqu=2zBVZnt-A@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: Fix grammatical error in sysctl/fs.txt
 & clarify negative dentry
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Waiman Long <longman@redhat.com>, linux-doc@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 7:39 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Linus, perhaps you'd like to take this one directly?

Done.

               Linus
