Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeDCDJ4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 23:09:56 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:41013 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbeDCDJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 23:09:54 -0400
X-Google-Smtp-Source: AIpwx4+0KCYJeHHj6hxRTnkJAa0JL4PKU81B/R0FE3liJ4juL41MuNN18EWEcL7OGnH2oq91W2G6Ag==
Date: Mon, 2 Apr 2018 20:10:21 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: syzbot <syzbot+7a1cff37dbbef9e7ba4c@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, dhowells@redhat.com, gs051095@gmail.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        pasha.tatashin@oracle.com, riel@redhat.com, rppt@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, wangkefeng.wang@huawei.com
Subject: Re: KASAN: use-after-free Read in alloc_pid
Message-ID: <20180403031021.GB685@sol.localdomain>
References: <94eb2c06406c59cccc0568c527c2@google.com>
 <878ta5z00m.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878ta5z00m.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 06:00:57PM -0500, Eric W. Biederman wrote:
> syzbot <syzbot+7a1cff37dbbef9e7ba4c@syzkaller.appspotmail.com> writes:
> 
> > Hello,
> >
> > syzbot hit the following crash on upstream commit
> > 9dd2326890d89a5179967c947dab2bab34d7ddee (Fri Mar 30 17:29:47 2018 +0000)
> > Merge tag 'ceph-for-4.16-rc8' of git://github.com/ceph/ceph-client
> > syzbot dashboard link:
> > https://syzkaller.appspot.com/bug?extid=7a1cff37dbbef9e7ba4c
> >
> > So far this crash happened 4 times on upstream.
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> 
> Do you have any of the other traces?  This looks like a something is
> calling put_pid_ns more than it is calling get_pid_ns causing a
> reference count mismatch.
> 
> If this is not: 9ee332d99e4d5a97548943b81c54668450ce641b
> 
> I could use a few more hints to help narrow down what is going wrong.
> 
> It would be nice to know what the other 3 crashes looked like and
> exactly which upstream they were on.
> 

The other crashes are shown on the syzbot dashboard (link was given in the
original email).

Eric
