Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeDHWqQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 18:46:16 -0400
Received: from imap.thunk.org ([74.207.234.97]:44970 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752285AbeDHWqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 18:46:14 -0400
Date: Sun, 8 Apr 2018 18:46:03 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        Eric Biggers <ebiggers3@gmail.com>,
        syzbot <syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] crypto: DRBG - guard uninstantion by lock
Message-ID: <20180408224603.GA32004@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        Eric Biggers <ebiggers3@gmail.com>,
        syzbot <syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
References: <001a114467482dbc4b05692df8f9@google.com>
 <4564679.HlOejCIXXz@positron.chronox.de>
 <CACT4Y+Y7hdm6LX5-PZu9zXFSmAKMP_jCYY7Z7g6a0xd_XCEYhA@mail.gmail.com>
 <6541596.TtyMCBNA0Q@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6541596.TtyMCBNA0Q@positron.chronox.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2018 at 09:07:03PM +0200, Stephan Müller wrote:
> Can you please check whether the attached patch fixes the issue?
> 

Stephan,

FYI, if you incude in your e-mail "#syz test <GIT URL> <BRANCH>" as
the first line of your patch and the syzbot e-mail is cc'ed, the
syzbot will automatically apply the patch in the e-mail against the
git tree/branch specified in the "#syz test" line, and then try to see
if the problem it discovered still reproduces --- and then send you
e-mail one way or another.

So the syzbot will run while the patch goes through the normal e-mail
review process, which is kind of neat.  :-)

Cheers,

					- Ted
