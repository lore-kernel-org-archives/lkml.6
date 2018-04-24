Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932872AbeDXIax (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:30:53 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35170 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932840AbeDXIau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:30:50 -0400
X-Google-Smtp-Source: AB8JxZqDRmhHeA/6Toik8sjOgnObwBZXOj5IyLvfZGEXgrzpoz4PtHK7QGWTiWv0UlhFTA0Dl+7/3T0RHorYjARRQQk=
MIME-Version: 1.0
In-Reply-To: <20180418093636.alasuzdjwjb2qovv@quack2.suse.cz>
References: <000000000000ba999f056a150015@google.com> <20180418093636.alasuzdjwjb2qovv@quack2.suse.cz>
From: Martijn Coenen <maco@android.com>
Date: Tue, 24 Apr 2018 10:30:49 +0200
Message-ID: <CAB0TPYGLW-bCRBTj--Y3xrgridzzR0V4Q+OCa6wv+yCi7RDaBA@mail.gmail.com>
Subject: Re: INFO: task hung in fsnotify_mark_destroy_workfn
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+e38306788a2e7102a3b6@syzkaller.appspotmail.com>,
        amir73il@gmail.com, Dan Carpenter <dan.carpenter@oracle.com>,
        dwindsor@gmail.com, elena.reshetova@intel.com,
        LKML <linux-kernel@vger.kernel.org>, mszeredi@redhat.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 11:36 AM, Jan Kara <jack@suse.cz> wrote:
> OK, so we are waiting for the grace period on fsnotify_mark_srcu. Seems
> like someone is holding fsnotify_mark_srcu too long or srcu period cannot
> finish for some other reason. However the reproducer basically contains
> only one binder ioctl and I have no idea how that's connected with fsnotify
> in any way.

Yeah, binder isn't involved with fsnotify at all.

> So either the reproducer is wrong, or binder is corrupting
> memory and fsnotify is just a victim, or something like that...

>From the dumped stacks I don't see how binder is involved in that task
getting hung up, so either it's not related to binder after all, or it
is indeed some form of corruption, but then I wouldn't expect it to
reproduce in the same way every time (or otherwise expect KASAN to
catch it). I'll try to see if I can repro it locally.

Martijn


>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
