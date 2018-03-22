Return-Path: <dja@axtens.net>
ARC-Seal: i=1; a=rsa-sha256; t=1521726489; cv=none;
        d=google.com; s=arc-20160816;
        b=x++MAAcROmZBURr2ZGIoYt169XmsgI59yzEsFa5I9TO+Pz415EJfIBZDiSz24+lhoK
         liCtRz+GX+q2BLpHH0HPZSjDkZwNBv8CU/zt7ZvteKg6shTmTmziYKF0E0dxsvxYuu2q
         K2qXYtDqqSLVD/MBmyDD/iZq60gZU/liRmmS3FA7OcNEZ0uqpEkybBeGnHRD6UGFssop
         aOrGQ78TcneqeI1QUwQNg0G9iv3nhiM5MAGpKAejYBpsGOFjGGR24ijnXcXWVsZK2F/r
         PSgFs7By6wR0WQDWcgJRvad55xhkPYLuCwQ9i3OlJq6R14NhvPFuUEjpYNft2s28vV0z
         xmXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=5wyhMzRgBNiEWeS3YtPAYuINyRBl7sq5+gIK2NiCPno=;
        b=uABAF2pfP/+ngLhg0ZN+ajoUDYc7QKoeqCI76fmp7mQFb9xmXGY2nVPHOl0qvS4BtT
         OUaULaxBXkz+Pf6+Pc/dsY0zxYBZa2M+MYSsEzS4Ta4IX+6cQpgY0HYpAIT5KopTK0D/
         7ORamafdg3dSIf9eJGfeQ27eFb4nGVFpOlHUyUsdIdbjmitLmLtameYBtlJz0scM8DME
         oNGpMk9i+1BhG844wkY/C4cDmgU2zoH76+//jomJYMCAspnNBCmWBlGnI+cbxuiGb5qJ
         +7vWcKDA/fevJslZq2TLM2rGZ2dMR2QgFR0sATHm3FJ7BUKtN/SnCEDancg3XIOxr+Tr
         T8mA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axtens.net header.s=google header.b=B9Ql1N5g;
       spf=pass (google.com: domain of dja@axtens.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=dja@axtens.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axtens.net header.s=google header.b=B9Ql1N5g;
       spf=pass (google.com: domain of dja@axtens.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=dja@axtens.net
X-Google-Smtp-Source: AG47ELtkb96qfQo6XCSsi/XhAnc1Pb0Oz5sGwAt1jEBdVTLiYRfafcKiK6ktZbD8J6uCllA1B1hGuw==
From: Daniel Axtens <dja@axtens.net>
To: Michael Neuling <mikey@neuling.org>, Mikulas Patocka <mpatocka@redhat.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Neuling <mikey@neuling.org>
Subject: Re: tty crash in Linux 4.6
In-Reply-To: <CAEjGV6zRghiCCMC1+-n+YPeA0Lrq=-vcvdoYpbwE4G=TXWzY3Q@mail.gmail.com>
References: <alpine.LRH.2.02.1605161555430.8188@file01.intranet.prod.int.rdu2.redhat.com> <573A5996.3080305@hurleysoftware.com> <573B3F84.5050201@hurleysoftware.com> <573B5E4C.8030808@hurleysoftware.com> <alpine.LRH.2.02.1607071855150.19053@file01.intranet.prod.int.rdu2.redhat.com> <CAEjGV6zRghiCCMC1+-n+YPeA0Lrq=-vcvdoYpbwE4G=TXWzY3Q@mail.gmail.com>
Date: Fri, 23 Mar 2018 00:48:06 +1100
Message-ID: <87po3wusq1.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1534517131154419915?=
X-GMAIL-MSGID: =?utf-8?q?1595645875637561122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

>> This patch works, I've had no tty crashes since applying it.
>>
>> I've seen that you haven't sent this patch yet to Linux-4.7-rc and
>> Linux-4.6-stable. Will you? Or did you create a different patch?
>
> We are hitting this now on powerpc.  This patch never seemed to make
> it upstream (drivers/tty/tty_ldisc.c hasn't been touched in 1 year).

I seem to be hitting this too on a kernel that has the 4.6 changes
backported to 4.4.

Has there been any further progress on getting this accepted?

Regards,
Daniel

>
> Peter, can we take this patch as is, or do you have an updated version?
>
> Mikey
>
>> Mikulas
>>
>>
>> On Tue, 17 May 2016, Peter Hurley wrote:
>>
>> > On 05/17/2016 08:57 AM, Peter Hurley wrote:
>> > > On 05/16/2016 04:36 PM, Peter Hurley wrote:
>> > >> > Hi Mikulas,
>> > >> >
>> > >> > On 05/16/2016 01:12 PM, Mikulas Patocka wrote:
>> > >>> >> Hi
>> > >>> >>
>> > >>> >> In the kernel 4.6 I get crashes in the tty layer. I can reproduce the
>> > >>> >> crash by logging into the machine with ssh and typing before the prompt
>> > >>> >> appears.
>> > >> >
>> > >> > Thanks for the report.
>> > >> > I tried to reproduce this a number of times on different machines
>> > >> > with no luck.
>> > >
>> > > I was able to reproduce this crash with a test jig.
>> > > The patch below fixed it, but I'm testing a better patch now, which
>> > > I'll get to you asap.
>> >
>> > --- >% ---
>> > Subject: [PATCH] tty: Fix ldisc crash on reopened tty
>> >
>> > If the tty has been hungup, the ldisc instance may have been destroyed.
>> > Continued input to the tty will be ignored as long as the ldisc instance
>> > is not visible to the flush_to_ldisc kworker. However, when the tty
>> > is reopened and a new ldisc instance is created, the flush_to_ldisc
>> > kworker can obtain an ldisc reference before the new ldisc is
>> > completely initialized. This will likely crash:
>> >
>> >  BUG: unable to handle kernel paging request at 0000000000002260
>> >  IP: [<ffffffff8152dc5d>] n_tty_receive_buf_common+0x6d/0xb80
>> >  PGD 2ab581067 PUD 290c11067 PMD 0
>> >  Oops: 0000 [#1] PREEMPT SMP
>> >  Modules linked in: nls_iso8859_1 ip6table_filter [.....]
>> >  CPU: 2 PID: 103 Comm: kworker/u16:1 Not tainted 4.6.0-rc7+wip-xeon+debug #rc7+wip
>> >  Hardware name: Dell Inc. Precision WorkStation T5400  /0RW203, BIOS A11 04/30/2012
>> >  Workqueue: events_unbound flush_to_ldisc
>> >  task: ffff8802ad16d100 ti: ffff8802ad31c000 task.ti: ffff8802ad31c000
>> >  RIP: 0010:[<ffffffff8152dc5d>]  [<ffffffff8152dc5d>] n_tty_receive_buf_common+0x6d/0xb80
>> >  RSP: 0018:ffff8802ad31fc70  EFLAGS: 00010296
>> >  RAX: 0000000000000000 RBX: ffff8802aaddd800 RCX: 0000000000000001
>> >  RDX: 00000000ffffffff RSI: ffffffff810db48f RDI: 0000000000000246
>> >  RBP: ffff8802ad31fd08 R08: 0000000000000000 R09: 0000000000000001
>> >  R10: ffff8802aadddb28 R11: 0000000000000001 R12: ffff8800ba6da808
>> >  R13: ffff8802ad18be80 R14: ffff8800ba6da858 R15: ffff8800ba6da800
>> >  FS:  0000000000000000(0000) GS:ffff8802b0a00000(0000) knlGS:0000000000000000
>> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> >  CR2: 0000000000002260 CR3: 000000028ee5d000 CR4: 00000000000006e0
>> >  Stack:
>> >   ffffffff81531219 ffff8802aadddab8 ffff8802aadddde0 ffff8802aadddd78
>> >   ffffffff00000001 ffff8800ba6da858 ffff8800ba6da860 ffff8802ad31fd30
>> >   ffffffff81885f78 ffffffff81531219 0000000000000000 0000000200000000
>> >  Call Trace:
>> >   [<ffffffff81531219>] ? flush_to_ldisc+0x49/0xd0
>> >   [<ffffffff81885f78>] ? mutex_lock_nested+0x2c8/0x430
>> >   [<ffffffff81531219>] ? flush_to_ldisc+0x49/0xd0
>> >   [<ffffffff8152e784>] n_tty_receive_buf2+0x14/0x20
>> >   [<ffffffff81530cb2>] tty_ldisc_receive_buf+0x22/0x50
>> >   [<ffffffff8153128e>] flush_to_ldisc+0xbe/0xd0
>> >   [<ffffffff810a0ebd>] process_one_work+0x1ed/0x6e0
>> >   [<ffffffff810a0e3f>] ? process_one_work+0x16f/0x6e0
>> >   [<ffffffff810a13fe>] worker_thread+0x4e/0x490
>> >   [<ffffffff810a13b0>] ? process_one_work+0x6e0/0x6e0
>> >   [<ffffffff810a7ef2>] kthread+0xf2/0x110
>> >   [<ffffffff810ae68c>] ? preempt_count_sub+0x4c/0x80
>> >   [<ffffffff8188ab52>] ret_from_fork+0x22/0x50
>> >   [<ffffffff810a7e00>] ? kthread_create_on_node+0x220/0x220
>> >  Code: ff ff e8 27 a0 35 00 48 8d 83 78 05 00 00 c7 45 c0 00 00 00 00 48 89 45 80 48
>> >        8d 83 e0 05 00 00 48 89 85 78 ff ff ff 48 8b 45 b8 <48> 8b b8 60 22 00 00 48
>> >        8b 30 89 f8 8b 8b 88 04 00 00 29 f0 8d
>> >  RIP  [<ffffffff8152dc5d>] n_tty_receive_buf_common+0x6d/0xb80
>> >   RSP <ffff8802ad31fc70>
>> >  CR2: 0000000000002260
>> >
>> > Ensure the kworker cannot obtain the ldisc reference until the new ldisc
>> > is completely initialized.
>> >
>> > Fixes: 892d1fa7eaae ("tty: Destroy ldisc instance on hangup")
>> > Reported-by: Mikulas Patocka <mpatocka@redhat.com>
>> > Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>> > ---
>> >  drivers/tty/tty_ldisc.c | 11 ++++++-----
>> >  1 file changed, 6 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
>> > index cdd063f..bda0c85 100644
>> > --- a/drivers/tty/tty_ldisc.c
>> > +++ b/drivers/tty/tty_ldisc.c
>> > @@ -669,16 +669,17 @@ int tty_ldisc_reinit(struct tty_struct *tty, int disc)
>> >               tty_ldisc_put(tty->ldisc);
>> >       }
>> >
>> > -     /* switch the line discipline */
>> > -     tty->ldisc = ld;
>> >       tty_set_termios_ldisc(tty, disc);
>> > -     retval = tty_ldisc_open(tty, tty->ldisc);
>> > +     retval = tty_ldisc_open(tty, ld);
>> >       if (retval) {
>> >               if (!WARN_ON(disc == N_TTY)) {
>> > -                     tty_ldisc_put(tty->ldisc);
>> > -                     tty->ldisc = NULL;
>> > +                     tty_ldisc_put(ld);
>> > +                     ld = NULL;
>> >               }
>> >       }
>> > +
>> > +     /* switch the line discipline */
>> > +     smp_store_release(&tty->ldisc, ld);
>> >       return retval;
>> >  }
>> >
>> > --
>> > 2.8.2
>> >
>>
