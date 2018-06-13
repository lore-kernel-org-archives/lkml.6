Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0AF95C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E8920891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OrdPZC6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E8920891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934961AbeFMQZR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:25:17 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37665 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754484AbeFMQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:25:15 -0400
Received: by mail-it0-f67.google.com with SMTP id l6-v6so4696684iti.2;
        Wed, 13 Jun 2018 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmFrQp7SobqL++B8/mDrELvha6BwVSdxkrrB+XkM80A=;
        b=OrdPZC6tv6SKzTB2fWRktS9nQ54JmY0E6VM3uGTTzM2EHkhsvt44OfeoHU6BQpiOx8
         xYLzsUX4/72h6luxp42MUjf6ruDnqNAZAcOAfWWdMbeqeW259FXINL4W6IBRX+BoFQ+q
         3t1U1xaOXTJiOw2Fq2upp9AoVkWvN7n+htpEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmFrQp7SobqL++B8/mDrELvha6BwVSdxkrrB+XkM80A=;
        b=pyMOosppDupQA30Nos9hjD7goMmKHsydkMyrWfwJYWrpH3JbhGIDruVsLeazCsgdMF
         Oa5lXWFj4A1Y109kUdcI+u0/RnzY/PyBtMs+M31Yl06mgsKuUGele1LDz3fzpsevrXdd
         xSYc/43BP2RZU9rLXXTojQNyjgIR3IQQOKyEn6XAzVBo6DyJrpidDxTJN3oPSV3a4KOY
         VmW3FBWU0CIVO0nqnVdWAM/PW2hVU6Sv7bTyNLB9OjVUkYLgIYxE7mZF5Alf3YTZ0PJP
         Mv4pNE1Yr/6r3K9I4jWJO3Czlg+IjRYsw88zX5T5lHwTCdQrHH0f9ZlAwwiig0LxBumm
         X+5w==
X-Gm-Message-State: APt69E1PcoPMqvhSgh3mKw3YvuMugrP5dcAac8MljhjIJ/WvUCnU/5iY
        CIrpLXpRWqzxCBG/H/cn8NqY7H2cGYNXoZnOxog=
X-Google-Smtp-Source: ADUXVKKNZs55ErEBn+37E8T7Kv78Mifp4rvD4P2k2QgL8BrTRC055Plavh8jGxgV/3D73IzYR3T4ctvlmfvnuXtvphA=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr5213903itd.16.1528907114446;
 Wed, 13 Jun 2018 09:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz> <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz> <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz> <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
 <20180613144606.nvbcyg2rdjpxhf7s@quack2.suse.cz> <7f4ae045-dfe4-6677-7418-f6f60b6c26f1@i-love.sakura.ne.jp>
In-Reply-To: <7f4ae045-dfe4-6677-7418-f6f60b6c26f1@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jun 2018 09:25:03 -0700
Message-ID: <CA+55aFx=CwNCg08HUeyYWc-WWuPkQBXVJDvHfrBjraTy-3MRWQ@mail.gmail.com>
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

On Wed, Jun 13, 2018 at 9:21 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since multiple addresses share bit_wait_table[256], isn't it possible that
> cgwb_start_shutdown() prematurely returns false due to wake_up_bit() by
> hash-conflicting addresses (i.e. not limited to clear_and_wake_up_bit() from
> wb_shutdown())? I think that we cannot be sure without confirming that
> test_bit(WB_shutting_down, &wb->state) == false after returning from schedule().

Right.

That's _always_ true, btw. Something else entirely could have woken
you up. TASK_UNINTERRUPTIBLE does not mean "nothing else wakes me", it
just means "_signals_ don't wake me".

So every single sleep always needs to be in a loop. Always.

              Linus
