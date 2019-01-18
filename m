Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADFFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AF620652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfARFUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:20:37 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:41017 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfARFUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:20:36 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0I5KYZN096133;
        Fri, 18 Jan 2019 14:20:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Fri, 18 Jan 2019 14:20:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0I5KYqv096128;
        Fri, 18 Jan 2019 14:20:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x0I5KYTi096127;
        Fri, 18 Jan 2019 14:20:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201901180520.x0I5KYTi096127@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: INFO: rcu detected stall in =?ISO-2022-JP?B?bmRpc2NfYWxsb2Nfc2ti?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+ea7d9cb314b4ab49a18a@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Linux-MM <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>
MIME-Version: 1.0
Date:   Fri, 18 Jan 2019 14:20:34 +0900
References: <ea2bc542-38b2-8218-9eb7-4c4a05da36ea@i-love.sakura.ne.jp> <CACT4Y+Yy-bF07F7F8DoFY8=4LtLURRn1WsZzNZ9LN+N=vn7Tpw@mail.gmail.com>
In-Reply-To: <CACT4Y+Yy-bF07F7F8DoFY8=4LtLURRn1WsZzNZ9LN+N=vn7Tpw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote:
> On Sun, Jan 6, 2019 at 2:47 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > On 2019/01/06 22:24, Dmitry Vyukov wrote:
> > >> A report at 2019/01/05 10:08 from "no output from test machine (2)"
> > >> ( https://syzkaller.appspot.com/text?tag=CrashLog&x=1700726f400000 )
> > >> says that there are flood of memory allocation failure messages.
> > >> Since continuous memory allocation failure messages itself is not
> > >> recognized as a crash, we might be misunderstanding that this problem
> > >> is not occurring recently. It will be nice if we can run testcases
> > >> which are executed on bpf-next tree.
> > >
> > > What exactly do you mean by running test cases on bpf-next tree?
> > > syzbot tests bpf-next, so it executes lots of test cases on that tree.
> > > One can also ask for patch testing on bpf-next tree to test a specific
> > > test case.
> >
> > syzbot ran "some tests" before getting this report, but we can't find from
> > this report what the "some tests" are. If we could record all tests executed
> > in syzbot environments before getting this report, we could rerun the tests
> > (with manually examining where the source of memory consumption is) in local
> > environments.
> 
> Filed https://github.com/google/syzkaller/issues/917 for this.

Thanks. Here is what I would suggest.

Let syz-fuzzer write to /dev/kmsg . But don't directly write syz-program lines.
Instead, just write the hash value of syz-program lines, and allow downloading
syz-program lines from external URL. Also, use the first 12 characters of the
hash value as comm name executing that syz-program lines. An example of console
output would look something like below.


  [$(uptime)][$(caller_info)] executing program #0123456789abcdef0123456789abcdef
  [$(uptime)][$(caller_info)] $(kernel_messages_caused_by_0123456789abcdef0123456789abcdef_are_here)
  [$(uptime)][$(caller_info)] executing program #456789abcdef0123456789abcdef0123
  [$(uptime)][$(caller_info)] $(kernel_messages_caused_by_456789abcdef0123456789abcdef0123_and_0123456789abcdef0123456789abcdef_are_here)
  [$(uptime)][$(caller_info)] executing program #89abcdef0123456789abcdef01234567
  [$(uptime)][$(caller_info)] $(kernel_messages_caused_by_89abcdef0123456789abcdef01234567_456789abcdef0123456789abcdef0123_and_0123456789abcdef0123456789abcdef_are_here)
  [$(uptime)][$(caller_info)] BUG: unable to handle kernel paging request at $(address)
  [$(uptime)][$(caller_info)] CPU: $(cpu) PID: $(pid) Comm: syz#89abcdef0123 Not tainted $(version) #$(build)
  [$(uptime)][$(caller_info)] $(backtrace_of_caller_info_is_here)
  [$(uptime)][$(caller_info)] Kernel panic - not syncing: Fatal exception

Then, we can build CrashLog by picking up all "executing program #" lines and
"latest lines up to available space" from console output like below.

  [$(uptime)][$(caller_info)] executing program #0123456789abcdef0123456789abcdef
  [$(uptime)][$(caller_info)] executing program #456789abcdef0123456789abcdef0123
  [$(uptime)][$(caller_info)] executing program #89abcdef0123456789abcdef01234567
  [$(uptime)][$(caller_info)] $(kernel_messages_caused_by_89abcdef0123456789abcdef01234567_456789abcdef0123456789abcdef0123_and_0123456789abcdef0123456789abcdef_are_here)
  [$(uptime)][$(caller_info)] BUG: unable to handle kernel paging request at $(address)
  [$(uptime)][$(caller_info)] CPU: $(cpu) PID: $(pid) Comm: syz89abcdef0123 Not tainted $(version) #$(build)
  [$(uptime)][$(caller_info)] $(backtrace_of_caller_info_is_here)
  [$(uptime)][$(caller_info)] Kernel panic - not syncing: Fatal exception

Then, we can understand that a crash happened when executing 89abcdef0123 and
download 89abcdef0123456789abcdef01234567 for analysis. Also, we can download
0123456789abcdef0123456789abcdef and 456789abcdef0123456789abcdef0123 as needed.

Honestly, since lines which follows "$(date) executing program $(num):" line can
become so long, it is difficult to find where previous/next kernel messages are.
If only one-liner "executing program #" output is used, it is easy to find
previous/next kernel messages.

The program referenced by "executing program #" would be made downloadable via
Web server or git repository. Maybe "executing program https://$server/$hash"
for the former case. But repeating "https://$server/" part would be redundant.

The question for me is, whether sysbot can detect hash collision with different
syz-program lines before writing the hash value to /dev/kmsg, and retry by modifying
syz-program lines in order to get a new hash value until collision is avoided.
If it is difficult, simpler choice like current Unix time and PID could be used
instead...
