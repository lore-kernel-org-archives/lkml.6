Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id QIbDLot1GVu3CwAAmS7hNA
	; Thu, 07 Jun 2018 18:12:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B02F06089E; Thu,  7 Jun 2018 18:12:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 23D8F6074D;
	Thu,  7 Jun 2018 18:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23D8F6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933617AbeFGSMZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:12:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:49841 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932568AbeFGSMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:12:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B155BAE59;
        Thu,  7 Jun 2018 18:12:22 +0000 (UTC)
Date: Thu, 7 Jun 2018 20:12:22 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, mcgrof@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: bpf-next boot error: KASAN: use-after-free Write in
 call_usermodehelper_exec_work
Message-ID: <20180607181222.GD5527@wotan.suse.de>
References: <000000000000271c83056dd6acc6@google.com>
 <CACT4Y+ZO9pbQ+5gyZPW4DZFKtJbciwmx=gWGxzx2sp2fy8+d6Q@mail.gmail.com>
 <20180607160659.g3x2pwdbxcsx5yxs@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607160659.g3x2pwdbxcsx5yxs@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 09:07:01AM -0700, Alexei Starovoitov wrote:
> On Thu, Jun 07, 2018 at 02:19:16PM +0200, Dmitry Vyukov wrote:
> > On Mon, Jun 4, 2018 at 10:21 PM, syzbot
> > <syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com> wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    69b450789136 Merge branch 'misc-BPF-improvements'
> > > git tree:       bpf-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1080d1d7800000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=e4078980b886800c
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=2c73319c406f1987d156
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com
> > 
> > 
> > This crash now happens on every other boot of mainline tree. This
> > prevents syzbot testing of new code, and just boots machine with
> > corrupted memory. Were there any recent changes in umh? +Alexei, you
> > seem to touch it last. Could your change cause this?
> 
> looking into it. I think I see the issue. Trying to reproduce.

And this is why a test driver would be useful ;)

  Luis
