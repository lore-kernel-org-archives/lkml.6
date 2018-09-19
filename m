Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C5FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5552150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPWwi2fJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5552150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbeISTzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:55:25 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35563 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731815AbeISTzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:55:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id j9-v6so5932396otl.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y35MgMLwNQ+mpjAvYkUjCt2sywHROKOTrs1klOT26xY=;
        b=hPWwi2fJlNVIMlOK5+jFsc266ffzvyI3CisyGiNDZHxbQBQ9/jYAu3ExXZhVqgWYtJ
         RhjIRaRO4KMCqdXma+FRDqttQwCF4uZBGwlY+vc7yQzug5N5EHn8S5PZCFfQaSWvzCxR
         IFbE5FsdDgm22MXSSldo2sd9M6ixFAKwgmpGP6HtnipqeAkJ6kXwKtwVczxprm00TXF8
         w//ZKHInPBQkuIuau3xxlfP6v2dog4szdxPT8VsduKYWc5mriS6gmhkGQd25ywc7nQSo
         /EW1foQ4cIUwZEfbEo/ghEjfoIMIWmRUqqJ+VqE0P3nl0Q6tnNUt3mQRfVQ13YGrfDYk
         KORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y35MgMLwNQ+mpjAvYkUjCt2sywHROKOTrs1klOT26xY=;
        b=EvKN+hHGkkZISDTzn4kuDy1SZ4J/bMIxni8JPamfSkN0rYgAr0CMOeblJK7vr0whT8
         uz3ICR5qRsANsyx05mthE8LxgafNq+1pUaZ3WcpF2QqpO4j+wX+JQpyabocGeY4GUBiX
         QszuwQk0nphXuTLs07+tv+rDydAeukwE0YuHQXj9XcBMNbS8EJflvYhTZQSaWQ/jlpXz
         prku/M1N5yAEzjVidZjvYXjl0vuka7BErzktJH7ptq4nwn3o5IHH77hzBFSOZKFV/0og
         QEGwfv4+tCtRGA69AxA+h03SWb4Zg06cjnzJo/Ag/KmA3Gl4As+TiCxDeVlUso7jqgAl
         TeKQ==
X-Gm-Message-State: APzg51CW6C5k7Mvs/CrM5M3a/bgAIkQZEkMa8u8bhP36Vo1KrFeR5ObO
        NTIujZVNzQV4TLrUXNCQu0EXil0fI8Ebb8eGvt2vXw==
X-Google-Smtp-Source: ANB0VdZwXDcTufyd/AJmlCQ7b4RkNiqHs8ZdRtb7wAiaI3Bh2WDj/52Q+w/zQ7mSuMqzQBexkNjm5A3dTR+nvrKzJkk=
X-Received: by 2002:a9d:3224:: with SMTP id t36-v6mr17886618otc.284.1537366636921;
 Wed, 19 Sep 2018 07:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180919070737.GB17524@uranus.lan> <20180919071056.GC17524@uranus.lan>
In-Reply-To: <20180919071056.GC17524@uranus.lan>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 19 Sep 2018 16:16:50 +0200
Message-ID: <CAG48ez0d0mO3yN10ApgJuwt9DTDj6x+j_wtjz6qM35nGtxnUdw@mail.gmail.com>
Subject: Re: [linux-next] BUG triggered in ptraceme
To:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, avagin@virtuozzo.com,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding FS people to figure out whether GFP_KERNEL allocations with
i_rwsem's held for writing are okay.

On Wed, Sep 19, 2018 at 9:10 AM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> On Wed, Sep 19, 2018 at 10:07:37AM +0300, Cyrill Gorcunov wrote:
> > Hi Oleg! While been testing criu with linux-next we've triggered a BUG.
> > https://api.travis-ci.org/v3/job/430308998/log.txt
> >
> > [    2.461618] BUG: sleeping function called from invalid context at security/apparmor/include/cred.h:154
> > [    2.461794] in_atomic(): 1, irqs_disabled(): 1, pid: 152, name: init
> > [    2.461890] 1 lock held by init/152:
> > [    2.461981]  #0: 00000000f30c3fda (tasklist_lock){.+.+}, at: ptrace_traceme+0x1c/0x70
> > [    2.462114] irq event stamp: 2524
> > [    2.462242] hardirqs last  enabled at (2523): [<ffffffff98002922>] do_syscall_64+0x12/0x190
> > [    2.462363] hardirqs last disabled at (2524): [<ffffffff98b8b02f>] _raw_write_lock_irq+0xf/0x40
> > [    2.462476] softirqs last  enabled at (1904): [<ffffffff98ac79ef>] unix_sock_destructor+0x4f/0xc0
> > [    2.462586] softirqs last disabled at (1902): [<ffffffff98ac79ef>] unix_sock_destructor+0x4f/0xc0
> > [    2.462697] CPU: 1 PID: 152 Comm: init Not tainted 4.19.0-rc4-next-20180918+ #1
> >
> > Which is due to commit
> >
> > commit 4b105cbbaf7c06e01c27391957dc3c446328d087
> > Author: Oleg Nesterov <oleg@redhat.com>
> > Date:   Wed Jun 17 16:27:33 2009 -0700
> >
> >     ptrace: do not use task_lock() for attach
> >
> > because now after write_lock_irq(&tasklist_lock); apparmor calls for
> > traceme and
> >
> > static inline struct aa_label *begin_current_label_crit_section(void)
> > {
> >       struct aa_label *label = aa_current_raw_label();
> >
> > -->   might_sleep();
> >
> > Take a look please, once time permit.
>
> Heh, actually not :) It is due to commit
>
> commit 1f8266ff58840d698a1e96d2274189de1bdf7969
> Author: Jann Horn <jannh@google.com>
> Date:   Thu Sep 13 18:12:09 2018 +0200
>
> which introduced might_sleep. Seems it is bad idea to send bug report
> without having a cup of coffee at the morning :)

Yeah, I fixed one sleep-in-atomic bug and figured I'd throw a
might_sleep() in there for good measure... sigh.
I guess now I have to go through all the callers of
begin_current_label_crit_section() to see what else looks wrong...

apparmor_ptrace_traceme() is wrong, as reported...

apparmor_path_link() looks icky, but I'm not sure - from what I can
tell, it's called with an i_rwsem held for writing, and that probably
makes calling back into filesystem context from there a bad idea?
OTOH, it's just the i_rwsem of a newly-created path, so I don't know
whether that's actually an issue...

security_path_rename() is called with two i_rwsem's held, but again,
I'm not sure whether that's a problem.
