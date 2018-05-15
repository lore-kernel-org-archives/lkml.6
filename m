Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeEOUtr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:49:47 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42194 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbeEOUtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:49:45 -0400
X-Google-Smtp-Source: AB8JxZoR1w0e0qvTl8kndLZSSlArllFTMcUSFUp8HA/vaiQk1g+HD2GEnxoyiJxVZhvMe2vp//0ZWc53EhBl9YjPL6M=
MIME-Version: 1.0
In-Reply-To: <20180513230237.GG677@sol.localdomain>
References: <089e0825fc78410eaa056845781e@google.com> <20180513230237.GG677@sol.localdomain>
From: Roland Dreier <roland@purestorage.com>
Date: Tue, 15 May 2018 13:49:23 -0700
Message-ID: <CAL1RGDVNaJ8OG+4ajmCZN1GnvsZUAqY3LXMRPv57mGSPJyhwAQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __list_add_valid (5)
To: Eric Biggers <ebiggers3@gmail.com>
Cc: linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, rds-devel@oss.oracle.com,
        syzbot <syzbot+db1c219466daac1083df@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Still reproducible on Linus' tree (commit 66e1c94db3cd4e) and on linux-next
> (next-20180511).  Here's a simplified reproducer:

Thanks!  That's a fantastic test case.

The issue is a race where rdma_listen() sees invalid state in the
middle of an rdma_bind_addr() call that will ultimately fail.  I'll
send a proposed patch shortly.

 - R.
