Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EA131C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAF7204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fTIe89hO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAF7204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935780AbeFMOG7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:06:59 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55808 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935606AbeFMOG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:06:56 -0400
Received: by mail-it0-f65.google.com with SMTP id 16-v6so3836544itl.5;
        Wed, 13 Jun 2018 07:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xhzc51CG8vqY/oVZ7zvfqJRft5omwKXpAj+EyltjQlo=;
        b=fTIe89hOSVpzwTFfjfqpR3ymPqHXtCpyp5oNAbT7kdVslahscRoWg5y3RS5htZfdsh
         0AyZTBU9bu+zUTxShTCS3t64uFQ5RWd7D3jSTcVUDcX/kSK3ZSCZoVaPQHkCVaEKj7Jk
         D6LxQjS+R2uijrTnUB4sYJYdW4iAqYmK1PLvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xhzc51CG8vqY/oVZ7zvfqJRft5omwKXpAj+EyltjQlo=;
        b=IJDPkpxg4VzDPOcZAH71kD5qKkUTFmOdlEM9dUzWV5uBol0s8ibTw8+BFbuSt5RtOn
         PIZCtwR2nIik40Oyzpt0qkHx7fzNIW3ZthIGAqgQkz8YwJYxTWALaJocLVwlYvWkHlp1
         gwYOvv3F+JuldthgxU47uzZ9N7GxWyXub0UZIhK/tOD2ChkHMA64NcRFxxVrdNUTxcAg
         ty4BL+8SkY4tf4NStXB3Y0ETlvAsksKOjjD1frkwiPdijx0MLyIQhvTuTKQjLH7NPxux
         hJGilzycwa+3topsZ1AzHT2UqgFIx0Q3dVbIkZ2r2GhLzG1oZgapdcegnWrKseWxy4v8
         HhQg==
X-Gm-Message-State: APt69E0eAfC8LvmzViyCc418khdlvwMMvtMhffQej7zQtqSraA41LIIU
        NbFlnDXumxllrtSxoVwW/sxujJkOK7n48uf5dsg=
X-Google-Smtp-Source: ADUXVKJxZ+r2KKOvabp1qvfkjChEkzZ6mIJ3kfkHfr3BOget7WIANqieDXL6Zi+/A/FdvCfjOFGQjkz6uhEnb8HeZbU=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr4706145itd.16.1528898815889;
 Wed, 13 Jun 2018 07:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
 <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
 <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz> <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz> <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz> <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
In-Reply-To: <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jun 2018 07:06:44 -0700
Message-ID: <CA+55aFz0tL4c5wrCcjukph95qQ+97Dmxpq4Ct7raqkiEJX-8xQ@mail.gmail.com>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 3:44 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Can't we utilize RCU grace period (like shown below) ?

_Please_ don't do conditional locking. Particularly not the kind where
then a function drops the lock that was taken in another function -
and only does it based on some parameter.

Yes, we have cases where we do it, but it's seldom a great idea, and
it _really_ makes for subtle code (and subtle bugs).

                  Linus
