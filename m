Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E47C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A104D2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ac7DfttB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfASMQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 07:16:27 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35521 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfASMQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 07:16:26 -0500
Received: by mail-io1-f68.google.com with SMTP id f4so13046296ion.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 04:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FehSnhRcoGzYgkbOlV+6a3jQTpyj4YjPYsy8gPL/1Dk=;
        b=ac7DfttBovy+AIoFaHFGZX2ZzvPJXtM/oVwsSTuDktywKbLSh8T0EuVbvJxxSeJ+sa
         w6NPALC8dXy566sVdj7p3/Zj3ZE/PfqnfPAvFCdG6VE7Fj/NPSIT+KJ06GqC07iGXcKm
         i3+1HZ8G86KfCnKuLpAAdQnMM3/rJdSt1wGY3Wh+JdkuQVBOT21IS7MmzSxlosFoIqj/
         Qxl8mSpvAcUYaLKPUZdOfZNJRe5fBpU6cawVv7XccRCLMWqCd43/0DxxSybX5jXLyzqb
         PwQI8tJqsUHUynVyIM9Dn/n5jU02Cjbn6PiIZVIsJq+SsuF0g2QWuuVGCe5wF/H3QGgw
         uvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FehSnhRcoGzYgkbOlV+6a3jQTpyj4YjPYsy8gPL/1Dk=;
        b=HMfUCTYeGs11Crnpi0J1aB7wMGkg+/NskmS9ubQCt6zZ96KFl4J75Sx3i/4Yt+75bY
         atuWhpvqwAHV7N9h4eGZwqLr5IlxkA76yfLsefQWgNGHJ8zDo30Wdp6tzoJCipcDbIpV
         tIHsPOst4bXHPzMzGCGf2a3Q1s4Jx1iMAs339OxP6RIMXqAdTZpyowzBJelXMlmbdxXb
         foHpmuAf2x45DeKEaJqLvy8c5YQ7XD/tPPBQ6bDYbRY+dwlxuLmXu6k7t4NyIzHEz8m7
         oQKNVJVfs5410OG6DWSAYKmQbMgbjc3owcPrIq7e6wFg5r550NbAH+uUCVrYKchNa4bU
         hd4g==
X-Gm-Message-State: AJcUukdPfUtoP12rA9N/FnDs8GgIGpypO+ehU/VzHaRbhh65KoeH5Tg/
        wiFVoWeBkktrBUeKS1SXjfKJQqU6cYBxWhG6oCOCzA==
X-Google-Smtp-Source: ALg8bN73whMCEbc9WCZ+iapzHnbBXafy2GekP8bIeHtmJNp1swxJZUXRjkhv3uFmFbNafeGfsLcjibNIJf3JdYFooQ4=
X-Received: by 2002:a6b:fa01:: with SMTP id p1mr11714146ioh.271.1547900185316;
 Sat, 19 Jan 2019 04:16:25 -0800 (PST)
MIME-Version: 1.0
References: <ea2bc542-38b2-8218-9eb7-4c4a05da36ea@i-love.sakura.ne.jp>
 <CACT4Y+Yy-bF07F7F8DoFY8=4LtLURRn1WsZzNZ9LN+N=vn7Tpw@mail.gmail.com> <201901180520.x0I5KYTi096127@www262.sakura.ne.jp>
In-Reply-To: <201901180520.x0I5KYTi096127@www262.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 19 Jan 2019 13:16:13 +0100
Message-ID: <CACT4Y+acvQXPLHFSbNYAEma6Rqx6QCp_kqjsbAF8M9og4KA3CA@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in ndisc_alloc_skb
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+ea7d9cb314b4ab49a18a@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Linux-MM <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 6:20 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Dmitry Vyukov wrote:
> > On Sun, Jan 6, 2019 at 2:47 PM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > >
> > > On 2019/01/06 22:24, Dmitry Vyukov wrote:
> > > >> A report at 2019/01/05 10:08 from "no output from test machine (2)"
> > > >> ( https://syzkaller.appspot.com/text?tag=CrashLog&x=1700726f400000 )
> > > >> says that there are flood of memory allocation failure messages.
> > > >> Since continuous memory allocation failure messages itself is not
> > > >> recognized as a crash, we might be misunderstanding that this problem
> > > >> is not occurring recently. It will be nice if we can run testcases
> > > >> which are executed on bpf-next tree.
> > > >
> > > > What exactly do you mean by running test cases on bpf-next tree?
> > > > syzbot tests bpf-next, so it executes lots of test cases on that tree.
> > > > One can also ask for patch testing on bpf-next tree to test a specific
> > > > test case.
> > >
> > > syzbot ran "some tests" before getting this report, but we can't find from
> > > this report what the "some tests" are. If we could record all tests executed
> > > in syzbot environments before getting this report, we could rerun the tests
> > > (with manually examining where the source of memory consumption is) in local
> > > environments.
> >
> > Filed https://github.com/google/syzkaller/issues/917 for this.
>
> Thanks. Here is what I would suggest.
>
> Let syz-fuzzer write to /dev/kmsg . But don't directly write syz-program lines.
> Instead, just write the hash value of syz-program lines, and allow downloading
> syz-program lines from external URL. Also, use the first 12 characters of the
> hash value as comm name executing that syz-program lines. An example of console
> output would look something like below.
>
>
>   [$(uptime)][$(caller_info)] executing program #0123456789abcdef0123456789abcdef
>   [$(uptime)][$(caller_info)] $(kernel_messages_caused_by_0123456789abcdef0123456789abcdef_are_here)
>   [$(uptime)][$(caller_info)] executing program #456789abcdef0123456789abcdef0123
>   [$(uptime)][$(caller_info)] $(kernel_messages_caused_by_456789abcdef0123456789abcdef0123_and_0123456789abcdef0123456789abcdef_are_here)
>   [$(uptime)][$(caller_info)] executing program #89abcdef0123456789abcdef01234567
>   [$(uptime)][$(caller_info)] $(kernel_messages_caused_by_89abcdef0123456789abcdef01234567_456789abcdef0123456789abcdef0123_and_0123456789abcdef0123456789abcdef_are_here)
>   [$(uptime)][$(caller_info)] BUG: unable to handle kernel paging request at $(address)
>   [$(uptime)][$(caller_info)] CPU: $(cpu) PID: $(pid) Comm: syz#89abcdef0123 Not tainted $(version) #$(build)
>   [$(uptime)][$(caller_info)] $(backtrace_of_caller_info_is_here)
>   [$(uptime)][$(caller_info)] Kernel panic - not syncing: Fatal exception
>
> Then, we can build CrashLog by picking up all "executing program #" lines and
> "latest lines up to available space" from console output like below.
>
>   [$(uptime)][$(caller_info)] executing program #0123456789abcdef0123456789abcdef
>   [$(uptime)][$(caller_info)] executing program #456789abcdef0123456789abcdef0123
>   [$(uptime)][$(caller_info)] executing program #89abcdef0123456789abcdef01234567
>   [$(uptime)][$(caller_info)] $(kernel_messages_caused_by_89abcdef0123456789abcdef01234567_456789abcdef0123456789abcdef0123_and_0123456789abcdef0123456789abcdef_are_here)
>   [$(uptime)][$(caller_info)] BUG: unable to handle kernel paging request at $(address)
>   [$(uptime)][$(caller_info)] CPU: $(cpu) PID: $(pid) Comm: syz89abcdef0123 Not tainted $(version) #$(build)
>   [$(uptime)][$(caller_info)] $(backtrace_of_caller_info_is_here)
>   [$(uptime)][$(caller_info)] Kernel panic - not syncing: Fatal exception
>
> Then, we can understand that a crash happened when executing 89abcdef0123 and
> download 89abcdef0123456789abcdef01234567 for analysis. Also, we can download
> 0123456789abcdef0123456789abcdef and 456789abcdef0123456789abcdef0123 as needed.
>
> Honestly, since lines which follows "$(date) executing program $(num):" line can
> become so long, it is difficult to find where previous/next kernel messages are.
> If only one-liner "executing program #" output is used, it is easy to find
> previous/next kernel messages.
>
> The program referenced by "executing program #" would be made downloadable via
> Web server or git repository. Maybe "executing program https://$server/$hash"
> for the former case. But repeating "https://$server/" part would be redundant.
>
> The question for me is, whether sysbot can detect hash collision with different
> syz-program lines before writing the hash value to /dev/kmsg, and retry by modifying
> syz-program lines in order to get a new hash value until collision is avoided.
> If it is difficult, simpler choice like current Unix time and PID could be used
> instead...

Hummm, say, if you run syz-manager locally and report a bug, where
will the webserver and database that allows to download all satellite
info work? How long you need to keep this info and provide the web
service? You will also need to pay and maintain the server for... how
long? I don't see how this can work and how we can ask people to do
this. This frankly looks like overly complex solution to a problem
were simpler solutions will work. Keeping all info in a self-contained
file looks like the only option to make it work reliably.
It's also not possible to attribute kernel output to individual programs.
