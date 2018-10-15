Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B81C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2022064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNc26Rmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2022064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJOWHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:07:06 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:45128 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeJOWHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:07:05 -0400
Received: by mail-oi1-f170.google.com with SMTP id e17-v6so15169936oig.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1KylTzXWMdQCYANC2rMK995/mAYZbkA7n6qE4dnzfM=;
        b=uNc26Rmc+nIg+ZwBHc0N8O7RgKt2t3b0fkKRz+kt+CiaCo5qrQGGseDT/W/+pF6MIF
         hTw8Hkjy3cjRkhphI6oq4EDhfo+ooYL+jStsj3GDfrITRkOrTDTVMs1Fk17QNtUl69gw
         VdhJRIUesOPFwxYRMiijeohIsXMT5gG+60yPAdCc9sVi8XqzaRMuSmhI9r6u3vHe5BUr
         /ZiRUEuZR4cW5HbadA6cPcqS8aMypznZS80h6W/o2O4uCs5HKGmy4Vvkc7/79HPxbcYx
         rzTyiHphNXbMLjCxW5lZEuEdK+HPNBZCL1mnBCupNivMukFvrR47fqDXx6WXtjIUYI0R
         WatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1KylTzXWMdQCYANC2rMK995/mAYZbkA7n6qE4dnzfM=;
        b=DE5UXyl1dfXLtg8j0elRN6RFdPVo5TCuuZGu7tk66otcovic4YyWVsQKX8Zh2zIQ0u
         4jbnno8LBBdfzCIg+ELWmsIZq2RQEQZq8Mxvk2hrOJXpFnON8A2UgLYSGCfArzu7LFCB
         xhk7L0XiuYUdrn7DyU7xqlT4bi/5n41kZ0CMz1cXe5CHa2ntC1HCbrxG/KdnF4aOGGde
         Kl5mO3PSqGrqfZlCuhgBWDhbV3JHsj/Q/Nl28wl8MroIdPpwzROrWhoBGtMakqA0ekzm
         eal68zWe+XkGHJnzX7MEHGwmKBm27+0YWCHoI8rrZAW2AjB94tNFgsmGNDT9hA3Zq5m8
         KhgA==
X-Gm-Message-State: ABuFfoi1JkNiQlD8vmvLpPOGT3OKanDFvP+PaQ4Mdm2lR4YfwB/LFvgS
        H5ztfO/hM9jf5JHee0+WMYUi4G9ZQSgyWYHMTddlug==
X-Google-Smtp-Source: ACcGV60sC3ibGofPmI8y4mHZH25G6Pd/anUQLk6rzjgQXn+wwQ9ciWG+bmJ+Iajw6L1c63RHHI0AH2jKNSuRFHyp/Bc=
X-Received: by 2002:aca:490b:: with SMTP id w11-v6mr8861748oia.126.1539613295557;
 Mon, 15 Oct 2018 07:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1wN=oC_uWkHHhboDvfVt8p9O98ZMFZyh=AK6D=eHU7MA@mail.gmail.com>
In-Reply-To: <CAG48ez1wN=oC_uWkHHhboDvfVt8p9O98ZMFZyh=AK6D=eHU7MA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 15 Oct 2018 16:21:09 +0200
Message-ID: <CAG48ez09LXvVv_u+uSBR+hYqmQAGO1iFf9gGvcOKGGMKXKvnvg@mail.gmail.com>
Subject: Re: sys_tee() bug: after tee() of partial page, both pipes can merge,
 clobbering each other's data
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 4:13 AM Jann Horn <jannh@google.com> wrote:
> I noticed the following behavior; basically, after copying part of a
> normal pipe buffer (anon_pipe_buf_ops) from pipe A to pipe B, both
> pipe A and pipe B can merge new writes into the existing page,
> clobbering each other's data:
>
> ============
> $ cat tee_test.c
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <unistd.h>
> #include <err.h>
> #include <stdio.h>
>
> int main(void) {
>   int pipe_a[2];
>   if (pipe(pipe_a)) err(1, "pipe");
>   int pipe_b[2];
>   if (pipe(pipe_b)) err(1, "pipe");
>   if (write(pipe_a[1], "abcd", 4) != 4) err(1, "write");
>   if (tee(pipe_a[0], pipe_b[1], 2, 0) != 2) err(1, "tee");
>   if (write(pipe_b[1], "xx", 2) != 2) err(1, "write");
>
>   char buf[5];
>   if (read(pipe_a[0], buf, 4) != 4) err(1, "read");
>   buf[4] = 0;
>   printf("got back: '%s'\n", buf);
> }
> $ gcc -o tee_test tee_test.c
> $ ./tee_test
> got back: 'abxx'
> $
> ============
>
> splice_pipe_to_pipe() probably has the same problem?
>
> I'm not sure what the cleanest way to fix this would be. Replace
> anon_pipe_buf_ops with packet_pipe_buf_ops when copying a buffer? Or
> add a new buffer flag for marking a buffer as mergeable, and get rid
> of buf->ops->can_merge?

Actually, I'll just cook up a simple patch myself.
