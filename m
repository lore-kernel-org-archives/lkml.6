Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED80C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C02E218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gleOli4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfABQJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:09:28 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39836 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbfABQJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:09:27 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so39257347itl.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 08:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQSAGLLXfYKROR0kF5dNfmSWj+QgQJTtLLJc0aY8VzQ=;
        b=gleOli4f+OHWBLj9w5q5JkAFdQcEYq5x5Xah6xJRaWM7dyp+8W0SyU40zdhgx1hon4
         8atJLGSfNOx2YuVJ6b0I+GkkXznMGGMeS9K7abG3QrT+CUHY6P6yHN73l9uh2lHv/LDo
         y72/nQ79P2qnyh+mtmGgQHnnXsmV5vp+jXQ3NpY8bCWHzMcWbFC8w616W9g8kGuSyDYi
         LrQFrDcK6BLWhQZPe/gK2GAksfIGM4PNohW+eSaQFkgufYS0wOSA+tDwj5RWX8BRdpq1
         yxbyugYJCCh7KC3PokRStglNY51iboKNzmwygbRVNX8bwk9Rr4qmpjUux/rcGPoF8OMy
         OHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQSAGLLXfYKROR0kF5dNfmSWj+QgQJTtLLJc0aY8VzQ=;
        b=fbkFerBIy/BkIOsojGwIvVoaoYjew9Byf9pI+Sp3xKHtXjpG0vJo6dQQd1XLNj2pH9
         mF7woPoEsmKa+m9BlCaigePk2rzhaUPKmQTGNQP+f4yYAa2QVGcNZpYxLdUKXjA3oWxw
         DpyAO7OAC9pwg175Ci0jzLCDKO4TJXCsbQ58kCCsX7YJFBdL9kv2gD/NFnKSVe8IVcj9
         EoKIufRm1Ui0iohvnk804Mj6ByROXMA0flymFOnmQ8o2mBSXNMDVqrEBx+xLH5o6YItV
         RVa1O+KDLgmM5Z/KCP0cTEpwJ0ESYUnpRNmTMn42gOW/fJyVG1FPGQMAOvIL/eftOBsg
         Ea+A==
X-Gm-Message-State: AJcUukf+WI6kchlJCQJ4aJlFlsLxAI5B1t0hUVIuosjaCGNYHlFaRDGQ
        GWBXSZ8+nShAyjRZFmQs7ADL2AoIXaCPrJ/G6P07aw==
X-Google-Smtp-Source: ALg8bN5JmG7mzeUxsOuBf32/x3sRcThek+Xzyf+8Tcdl9tb7bAb64DSX1QCq6nU4H0nPtC9NVCAYEIH9OtIclyrBYzQ=
X-Received: by 2002:a24:6511:: with SMTP id u17mr6190552itb.12.1546445366770;
 Wed, 02 Jan 2019 08:09:26 -0800 (PST)
MIME-Version: 1.0
References: <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
 <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
 <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz> <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp>
 <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp>
 <20181213121847.mwlr2vyv6qzclhk6@pathway.suse.cz> <20181213124255.GB3053@tigerII.localdomain>
 <20181217145452.3kev4rmo2l5lt2qy@pathway.suse.cz> <93f19e57-5051-c67d-9af4-b17624062d44@i-love.sakura.ne.jp>
 <20181218083911.qxvlqlwlb4eye72x@pathway.suse.cz> <20181218085833.GA460@jagdpanzerIV>
In-Reply-To: <20181218085833.GA460@jagdpanzerIV>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 2 Jan 2019 17:09:15 +0100
Message-ID: <CACT4Y+ahbDb7F2B1-z5QxroZcqP+AEUfUi6Sa1ZHRpaCeVmZ=w@mail.gmail.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 9:58 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (12/18/18 09:39), Petr Mladek wrote:
> >
> > Sergey, are you okay with this squashed patch, please?
> >
>
> Yeah. There are several minor nitpicks, but here is my
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>
>
> One final question - can syzbot folks confirm that the patch
> helps? Just curious.

This slip through the cracks. Tetsuo pinged me and I am testing now.
Need to create a set of tests and update parsing code to handle this.
