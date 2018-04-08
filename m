Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeDHGBo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 02:01:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbeDHGBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 02:01:42 -0400
Date: Sat, 7 Apr 2018 23:01:40 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: WARNING in kmem_cache_free
Message-ID: <20180408060140.GB16007@bombadil.infradead.org>
References: <001a114467482dbc4b05692df8f9@google.com>
 <CACT4Y+adiXih0-jfNGHgf1kEQ2=KLY5NdX-87BTDbrQgEAHc9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+adiXih0-jfNGHgf1kEQ2=KLY5NdX-87BTDbrQgEAHc9g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 03:33:36PM +0200, Dmitry Vyukov wrote:
> On Fri, Apr 6, 2018 at 3:24 PM, syzbot
> <syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com> wrote:
> > Unfortunately, I don't have any reproducer for this crash yet.
> 
> Interesting type of bug, I think we see this for the first time.

Can you focus syzbot to try to find a reproducer?  This seems to be
produced by calling mount() with a pathname that's somewhere between,
say, 3950 & 4100 bytes long from a compat 32-bit task.
