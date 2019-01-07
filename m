Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FB3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDABF21736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jHOvL0HC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfAGLNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:13:08 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45880 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfAGLNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:13:05 -0500
Received: by mail-io1-f65.google.com with SMTP id c2so12366942iom.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 03:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YEXl1x9KpOBMBz/Mcro2sttBZKacHfsT+62DIcT6XxI=;
        b=jHOvL0HC5tw9iRHiGzuJNo+PJg2hcXjv+4+Y5OOVtKunPL7RkQh4hLSexqMUxeWdLi
         ozUs2Vl1neEPXEmAiD9XBadB5jDzTs0ppFC9Us4D5zcfxVu9qVqkI62w6wZpRtzTjg6B
         0rA6KR6Cbm14Nb91dkdVDj3Jid0/ZkqrCLvhZM+yxvm/0QsLURaIqxXXhxSvqOJ6OpzA
         1Rpx7yol2hLzgVX++h48UzkgNMT8FnTo7uOQ6ePKM2aJHjOgnuLPbJcEJg3FImOuoddd
         y5CL4R6WMAyPaMP+MGjdfztfGt1it66bU8xViaAiW2Q0UQAzG/RBGvGzNwTsfxftnLLW
         14eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEXl1x9KpOBMBz/Mcro2sttBZKacHfsT+62DIcT6XxI=;
        b=Qmtd8H+/4ykBi1FanvXO6Eq2RB/iiL6ftuBMVOhl/k7U8IIdie1i7NHcGmnrowOit/
         vy/3i4yBxK/HsM5COtOkirJrhNVgPzmtZ0MA15D5YhrzkKi31Q7iVC7Ld6kK8XqywJUO
         U5PB/wT9XtZONdQ6z8cQfMdhUjoiugI6aazI8sjqmIe2ebgDRvpJtWzbTFtB4RWzibVa
         7nFLULEuUQgShEoBIdv14yskGkJW2mkK3RophKbfoDv6Hq2q8ThEVt8b5HuqbLPQN4Er
         6JbEZbWQ2zGvdi3LC13AYs/B/E2ABPkkJVdC7qK9JdZk3ywbwHDLZFkeX1bL1uH8HRGZ
         71+w==
X-Gm-Message-State: AJcUukemWfjbbpQl5CyjcmkcXjndBaapNtA7p8P0v0OPcI9d66tEhWR8
        enJolVVOyv4/6FdoEBOSx96HMok1j0GiKoP+Py9P78MDw3Qpxg==
X-Google-Smtp-Source: ALg8bN4bWZnCL6g6U983BH4+/H9w3bVz56GfXr2rJC0l1ba5raWLVl+4L+8v0yBdktJI7sLvapvg8B4gQTklvsUMXmY=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr14869399ior.282.1546859584353;
 Mon, 07 Jan 2019 03:13:04 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007beca9057e4c8c14@google.com> <CACT4Y+Yx4BJw=F_PMx9a8AjPKzEwhzLnzt9K-dgkBoNkKQj2+g@mail.gmail.com>
 <ef2508c9-d069-2143-09a6-a90b9ef12568@I-love.SAKURA.ne.jp>
 <CACT4Y+YYwYDnqFmMwfSg6UNXnrbh46bo0jp7ijbej8nkDDmBXQ@mail.gmail.com>
 <eeb95c52-5bf8-d3ce-d32b-269aa86bcd93@i-love.sakura.ne.jp>
 <8cdbcb63-d2f7-cace-0eda-d73255fd47e7@i-love.sakura.ne.jp>
 <CACT4Y+Y5cdD=optF2k4a0W7vriVnzmzLU0SPGEJoOHRMi_bsZA@mail.gmail.com> <ea2bc542-38b2-8218-9eb7-4c4a05da36ea@i-love.sakura.ne.jp>
In-Reply-To: <ea2bc542-38b2-8218-9eb7-4c4a05da36ea@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Jan 2019 12:12:53 +0100
Message-ID: <CACT4Y+Yy-bF07F7F8DoFY8=4LtLURRn1WsZzNZ9LN+N=vn7Tpw@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in ndisc_alloc_skb
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+ea7d9cb314b4ab49a18a@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Linux-MM <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 6, 2019 at 2:47 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/01/06 22:24, Dmitry Vyukov wrote:
> >> A report at 2019/01/05 10:08 from "no output from test machine (2)"
> >> ( https://syzkaller.appspot.com/text?tag=CrashLog&x=1700726f400000 )
> >> says that there are flood of memory allocation failure messages.
> >> Since continuous memory allocation failure messages itself is not
> >> recognized as a crash, we might be misunderstanding that this problem
> >> is not occurring recently. It will be nice if we can run testcases
> >> which are executed on bpf-next tree.
> >
> > What exactly do you mean by running test cases on bpf-next tree?
> > syzbot tests bpf-next, so it executes lots of test cases on that tree.
> > One can also ask for patch testing on bpf-next tree to test a specific
> > test case.
>
> syzbot ran "some tests" before getting this report, but we can't find from
> this report what the "some tests" are. If we could record all tests executed
> in syzbot environments before getting this report, we could rerun the tests
> (with manually examining where the source of memory consumption is) in local
> environments.

Filed https://github.com/google/syzkaller/issues/917 for this.

> Since syzbot is now using memcg, maybe we can test with sysctl_panic_on_oom == 1.
> Any memory consumption that triggers global OOM killer could be considered as
> a problem (e.g. memory leak or uncontrolled memory allocation).

Interesting idea. This will also alleviate the previous problem as I
think only a stream of OOMs currently produces 1+MB of output.

+Shakeel who was interested in catching more memcg-escaping allocations.

To do this we need a buy-in from kernel community to consider this as
a bug/something to fix in kernel. Systematic testing can't work gray
checks requiring humans to look at each case and some cases left as
being working-as-intended.

There are also 2 interesting points:
 - testing of kernel without memcg-enabled (some kernel users
obviously do this); it's doable, but currently syzkaller have no
precedents/infrastructure to consider some output patterns as bugs or
not depending on kernel features
 - false positives for minimized C reproducers that have memcg code
stripped off (people complain that reproducers are too large/complex
otherwise)
