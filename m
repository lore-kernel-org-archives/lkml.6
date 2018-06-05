Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeFEQER (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:04:17 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37246 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeFEQEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:04:13 -0400
X-Google-Smtp-Source: ADUXVKKgP05PyF874DXsV3HCY0Trl9jIuGmEX9S9MXhaijK+eGTLCPw32ptBBapCk33ufHWcGALYjeOB708PtRQmN5k=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 5 Jun 2018 18:04:10 +0200
X-Google-Sender-Auth: SFuStefRwrpWZC_LI--iR3yqcH0
Message-ID: <CAK8P3a2M9RBKMXikFW2jZYwQnWXDjOJ6mzD6Jt85SVOnZkbXnQ@mail.gmail.com>
Subject: vfs_timespec64 merge into v4.18?
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

As I discussed with Thomas on IRC, I'd still like to try to get Deepa's series
merged to have 64-bit inode timestamps in VFS, as a prerequisite to fixing
the individual file systems for y2038 as the next step.

The orignal tree that I've been testing with is in
https://github.com/deepa-hub/vfs vfs_timespec64 (see description at [1]
Unfortunately this was never in linux-next so far, so it's definitely
against our
normal rules, and if there are any objections (or new issues getting found),
then we should defer it another merge window.

Until very recently, the branch worked fine with both linux-next and 4.17-rc,
but with some last minute changes to the NFS and Overlayfs trees, it
gained some nasty conflicts.

I've merged Trond's NFS branch and Miklos' Overlayfs branches into
it, fixed up those conflicts and now uploaded it to my tree at
git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
Obviously this will break if either of them rebases their trees once
more, in which case I assume Stephen will drop my branch from
linux-next.

Once those two are merged into mainline and nothing unexpected
has come up from linux-next testing, we could either send a pull request
to Linus for the merged branch, or regenerate the flag-day patch in it
using coccinelle, which should result in identical contents.

        Arnd

[1] https://lkml.org/lkml/2018/5/25/828
