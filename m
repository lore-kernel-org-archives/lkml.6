Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbeBBWSo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:18:44 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:35102 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeBBWSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:18:33 -0500
X-Google-Smtp-Source: AH8x224iiJln+q65FXRRnWohiOWY7R6XaK8RA9+wfHbHxWe8nZAJyqyMEsZ//RonWMb6oLDuoRGFmA==
Date: Fri, 2 Feb 2018 14:18:29 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+ffa3a158337bbc01ff09@syzkaller.appspotmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: kernel stack regs has bad 'bp' value (3)
Message-ID: <20180202221829.tdiji2332t7orcxj@gmail.com>
References: <001a11449aa2faf11805643af581@google.com>
 <CACT4Y+YOmbZGdBbFpmjRJXABGe1tD=F+3na77DwoPCEaROADyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YOmbZGdBbFpmjRJXABGe1tD=F+3na77DwoPCEaROADyw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 02:57:32PM +0100, Dmitry Vyukov wrote:
> On Fri, Feb 2, 2018 at 2:48 PM, syzbot
> <syzbot+ffa3a158337bbc01ff09@syzkaller.appspotmail.com> wrote:
> > Hello,
> >
> > syzbot hit the following crash on upstream commit
> > 7109a04eae81c41ed529da9f3c48c3655ccea741 (Thu Feb 1 17:37:30 2018 +0000)
> > Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide
> >
> > So far this crash happened 4 times on net-next, upstream.
> > C reproducer is attached.
> > syzkaller reproducer is attached.
> > Raw console output is attached.
> > compiler: gcc (GCC) 7.1.1 20170620
> > .config is attached.
> 
> 
> From suspicious frames I see salsa20_asm_crypt there, so +crypto maintainers.
> 

Looks like the x86 implementations of Salsa20 (both i586 and x86_64) need to be
updated to not use %ebp/%rbp.

- Eric
