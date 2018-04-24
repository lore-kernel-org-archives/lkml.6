Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933219AbeDXMzz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:55:55 -0400
Received: from imap.thunk.org ([74.207.234.97]:50586 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757866AbeDXMzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:55:46 -0400
Date: Tue, 24 Apr 2018 08:55:41 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: syzbot <syzbot+e1670f554caa60fb147b@syzkaller.appspotmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
Message-ID: <20180424125541.GB4189@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        syzbot <syzbot+e1670f554caa60fb147b@syzkaller.appspotmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs@googlegroups.com
References: <0000000000008bce26056a7a6c23@google.com>
 <CAKdAkRRyRPEnghR6YqE++-H=HJbFL0ejK73Z_vMp_TMyNTT4ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKdAkRRyRPEnghR6YqE++-H=HJbFL0ejK73Z_vMp_TMyNTT4ew@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 10:49:12AM -0700, Dmitry Torokhov wrote:
> On Sun, Apr 22, 2018 at 7:02 PM, syzbot
> <syzbot+e1670f554caa60fb147b@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot hit the following crash on upstream commit
> > 285848b0f4074f04ab606f1e5dca296482033d54 (Sun Apr 22 04:20:48 2018 +0000)
> > Merge tag 'random_for_linus_stable' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random
> > syzbot dashboard link: https://syzkaller.appspot.com/bug?extid=e1670f554caa60fb147b
> 
> Ted,
> 
> input_add_randomness() (that ends up calling crng_reseed() and the new
> numa_crng_init()) is called (and has been called ever since inception)
> from an interrupt context and thus may not sleep. The following commit
> breaks this:

Fixed by: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1672186.html

Will be pushed to Linux shortly.

						- Ted
