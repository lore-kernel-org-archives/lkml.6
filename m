Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dwVgFAJSHFuoMAAAmS7hNA
	; Sat, 09 Jun 2018 22:17:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1A6EC607E4; Sat,  9 Jun 2018 22:17:38 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WAuy4Jjn"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6FBDC6074D;
	Sat,  9 Jun 2018 22:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FBDC6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbeFIWRe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 18:17:34 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52998 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753408AbeFIWRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 18:17:33 -0400
Received: by mail-it0-f66.google.com with SMTP id m194-v6so6381704itg.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 15:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EH+S2aO2joJdw7kHwHtakM3W5r3IVpyT0L2ElCqfKP0=;
        b=WAuy4JjnZhZfypI+yeFtNGNVTduxiA2enxhU/skf/+X55PHg2jRiObVuFpWVQiztAn
         a6a92sZFV2UuHmzx9nTpR8RZykfp/GRFqiw9QnBQeP8txZxNw9OtsWupaKWAx2ZjIl5Q
         qLPKakyY0g99rumRZyN/Iz+9pYukWmA8UcngA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EH+S2aO2joJdw7kHwHtakM3W5r3IVpyT0L2ElCqfKP0=;
        b=HY3jfjqQd+uuShnLS0c/IKYS2hyA5HDp2nAd911K5a/egziNvHj8M7WvMjocqTrzk4
         CHHNKyHrjRlZ2evWCIJ1I5uNFynYYIcpCUTrTgXOiE67PYZ5X9XBqM2/wzYRz5e58LVS
         Onk8Oqtal3j6LNz8bQcbrGRKMetz1Ux1TL2o3ufus6exEA8Uz8fvtm2C4ICivLcAShCj
         xfvsp2y0fAtU5eZUe2pXtg/T9ShfqVSlNw9gNOBBrtbZZl4i+BYbDOLv7575f+4fb3dT
         gh3T66RZD1MvqnyotMoC3i4iXjJUkF/rMoEF5UguyHfdE4TGf9UhoSnTIereLbWvPi+q
         oBWg==
X-Gm-Message-State: APt69E2N2fqfp754Zigz2onun6UUyZmf6i/e1Fdn5/4Ce4wKTzSAElrE
        /iCjT6Pf3+bES1mX6Uldnf4doyi5vV71tu0hkgI=
X-Google-Smtp-Source: ADUXVKLU7aIMLTZqxrFz3jQVFiZFzcE1vPnF08DwzmuTEOwictSs1k+tsSyj+IqNk0B2MSKvlxmEbDTu8xREMtvnYcs=
X-Received: by 2002:a24:3cd7:: with SMTP id m206-v6mr5950447ita.113.1528582652593;
 Sat, 09 Jun 2018 15:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+bvA6hrVT5u-Cy_zJLNTM5SYf9kt+sXYmfq13rPGfiqFQ@mail.gmail.com>
 <CABXOdTf+CoB6EkhG1yPtB4NNtohbex=ebHLX7YW5TyQQGn9byw@mail.gmail.com>
 <CACT4Y+aGMoobn069+Lq1BT2YGqi9qYY9vHFtiXT2DLsJ5ZUh9Q@mail.gmail.com>
 <873735n3dy.fsf@xmission.com> <20180116173440.GA15893@kroah.com>
 <CACT4Y+Yy4YZG54xXfR1QNM0i8aS66BZyCnaD2YuooYo2sGuSLg@mail.gmail.com> <81a0eb59-c204-9e36-13b7-88c2ea99ceab@I-love.SAKURA.ne.jp>
In-Reply-To: <81a0eb59-c204-9e36-13b7-88c2ea99ceab@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 Jun 2018 15:17:21 -0700
Message-ID: <CA+55aFzJaHyKBg_PTS85Y5RxUsQEerJ_Lc5HY1dd1YNztf==Wg@mail.gmail.com>
Subject: Re: what trees/branches to test on syzbot
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Guenter Roeck <groeck@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Wu Fengguang <fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 11:36 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/01/22 22:32, Dmitry Vyukov wrote:
> >
> > FTR I've just dropped linux-next and mmots from syzbot.
>
> I hope that we can test linux-next on syzbot, as a tree for testing debug
> printk() patches.

I think it would be lovely to get linux-next back eventually, but it
sounds like it's just too noisy right now, and yes, we should have a
baseline for the standard tree first.

But once there's a "this is known for the baseline", I think adding
linux-next back in and then maybe even have linux-next simply just
kick out trees that cause problems would be a good idea.

Right now linux-next only kicks things out based on build issues (or
extreme merge issues), afaik. But it *would* be good to also have
things like syzbot do quality control on linux-next.

Because the more things get found and fixed before they even hit my
tree, the better.

                Linus
