Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbeAaBlm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 20:41:42 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:37307 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbeAaBlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 20:41:40 -0500
X-Google-Smtp-Source: AH8x227Ic8mJargX5Ybpo9O5yJBH4T7rqm2isyt4mLRnTvlmGZq03MCFC5jOHnQgMESRhr85gIh5RQ==
Date: Tue, 30 Jan 2018 17:41:36 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+32b24f3e7c9000c48490@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: unable to handle kernel paging request in
 check_memory_region
Message-ID: <20180131014136.ulrq64mhcwd7fhqw@gmail.com>
References: <001a113feecc4fa53a05629c32a5@google.com>
 <CACT4Y+bKv7q4U1ah2Z-jcK4gVnjtTxxnXZgBw1bnWK4wLEv_CA@mail.gmail.com>
 <8bf5e24e-1bce-81dc-4e92-80ce20c5d152@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bf5e24e-1bce-81dc-4e92-80ce20c5d152@iogearbox.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2018 at 01:22:13AM +0100, Daniel Borkmann wrote:
> On 01/13/2018 08:29 AM, Dmitry Vyukov wrote:
> > On Fri, Jan 12, 2018 at 11:58 PM, syzbot
> > <syzbot+32b24f3e7c9000c48490@syzkaller.appspotmail.com> wrote:
> >> Hello,
> >>
> >> syzkaller hit the following crash on
> >> c92a9a461dff6140c539c61e457aa97df29517d6
> >> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> >> compiler: gcc (GCC) 7.1.1 20170620
> >> .config is attached
> >> Raw console output is attached.
> >> C reproducer is attached
> >> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> >> for information about syzkaller reproducers
> >>
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+32b24f3e7c9000c48490@syzkaller.appspotmail.com
> >> It will help syzbot understand when the bug is fixed. See footer for
> >> details.
> >> If you forward the report, please keep this part and the footer.
> > 
> > 
> > Daniel, is it the same bug that was fixed by "bpf, array: fix overflow
> > in max_entries and undefined behavior in index_mask"?
> 
> And also here, fixed by:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=bbeb6e4323dad9b5e0ee9f60c223dd532e2403b1
> 

Thanks Daniel, this crash is no longer occurring and I verified that commit
bbeb6e4323da fixed it, so let's allow syzbot to close this report too:

#syz fix: bpf, array: fix overflow in max_entries and undefined behavior in index_mask

- Eric
