Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9BC2BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C1E208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MBawlPYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C1E208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935760AbeFMOzr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:55:47 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36617 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935190AbeFMOzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:55:44 -0400
Received: by mail-it0-f67.google.com with SMTP id j135-v6so4280605itj.1;
        Wed, 13 Jun 2018 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ItRmEdnhylmdKeV4H7Os6lQn+0f7Cyy0O9X9R+PiIY=;
        b=MBawlPYAWkLzg5ZCx+QvRw78upEtrkWDrkBbUcI4yDlWKzAlrBV7+djiALCrww6sOc
         ZbZcvQj54ZsV//34Xyg3t/3OpHilfWgJipXxQukz4cTtzIiylvovyC4JIAywLmHnShPx
         +t1GoGletrDGKFBi45WP/RnNTEoj/dBnDZw1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ItRmEdnhylmdKeV4H7Os6lQn+0f7Cyy0O9X9R+PiIY=;
        b=gCx0I0lD4Ye7gWi4uekhFRKAMna52SapQOJs3i4/RVfp6qNttzpCX1ag3FCUfDO6IE
         l/vlaBuGtWa/eOZG02GnPIMtbZTbNZr8sSNbFY9BrrPfrQ1yjbTY3nVZf/SKNXjdzyWc
         BrAU0Ub7glujDCe6I+CK1Yh615orbTwJdJ1ZJPait8Nli84QV1sp/cIeWAxoE8fATqEq
         WyX8e+/rh9E75cbc7/wynzoCZ0WLCUyB7ypTrcU55sCQpjAmdqAvrFhesjOEEkHITpEp
         qpBFA3Ey18xVsxJcsL50ZoSXKid6k4H8ysJO2eRIdWwJTA5Luw54BcZ0oRaLmZ0PdLH6
         qvug==
X-Gm-Message-State: APt69E3AZcNzVYFKsng/wBgl/bPGxA9/UX2WPVbBs7JP2rVx9K6/cVoi
        W6SKRNlggBLRwG6lin60Ehn0iofb2SuMGdhX0Y4=
X-Google-Smtp-Source: ADUXVKJt603byvo3OMT7qnQuQiJxzp7/eXwcG1kWK8tPeYBC3lkQOE6lRWkJ6gB5xq1wrdXbXtGFyTTx2JpSHzJd/UI=
X-Received: by 2002:a24:5b81:: with SMTP id g123-v6mr4825865itb.1.1528901744036;
 Wed, 13 Jun 2018 07:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz> <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz> <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz> <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
 <20180613144606.nvbcyg2rdjpxhf7s@quack2.suse.cz>
In-Reply-To: <20180613144606.nvbcyg2rdjpxhf7s@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jun 2018 07:55:32 -0700
Message-ID: <CA+55aFzKrUdOV1RU+H4iOXkiCh+CoGmS1pvCP9Rybn8tTgWang@mail.gmail.com>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
To:     Jan Kara <jack@suse.cz>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
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

On Wed, Jun 13, 2018 at 7:46 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 13-06-18 19:43:47, Tetsuo Handa wrote:
> > Can't we utilize RCU grace period (like shown below) ?
>
> Honestly, the variant 1 looks too ugly to me. However variant 2 looks
> mostly OK.

The versions that don't have that conditional locking look fine to me, yes.

> Also I'd avoid the addition argument to wb_writeback() and split the function instead. The
> patch resulting from your and mine ideas is attached. Thoughts?

Is there a reason for this model:

+               if (cgwb_start_shutdown(wb))
+                       __wb_shutdown(wb);

when there is just one call site of this? Why not just make the
function void, and make it do that __wb_shutdown() itself in the true
case?

IOW, just make it be

+               cgwb_shutdown(wb);

instead?

That's what "wb_shutdown()" does - it does the "wb_start_shutdown()"
test internally, and does __wb_shutdown() all inside itself, instead
of expecting the caller to do it.

I dunno.

              Linus

              Linus
