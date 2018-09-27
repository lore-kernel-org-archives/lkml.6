Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F507C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F01216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VH7mTAPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F01216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeI1EiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:38:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35429 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeI1EiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:38:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id j9-v6so4181474otl.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OM7EeGrjcsh1y+yxDFXAt8/Qwyt+S6tQgPGaZOC3y/g=;
        b=VH7mTAPMcMX9kWfnpEdHxncbrfO1HRPALlQmBZQ5C2HJaPbDD4YZ8tt//mYk2qPe/7
         q/9wF3ZSM+3VN0jPSJYZgUH81/hctLFjLPTmREtGQ9ONzvvnia/X/73MT1aQ7muxrHL/
         QSI+5NpArI2n8w44x83oM7ql77CFlN5JcpgF9Yhhqam+9fv5w8PdQ6XOLnk+BSHruick
         BRZ6KuXH3vyQHEjSPuc1hbj7rPICSifwy3LCRztrIklgBZAyymYoCcPPu58xtFaCKuUC
         ujZ3fuyYnZ13SHgp/9Xv8u2awVNW+5VfgYZPULJrVKaV8EgNd/XT9y/jbEykMT9N7C29
         dAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OM7EeGrjcsh1y+yxDFXAt8/Qwyt+S6tQgPGaZOC3y/g=;
        b=Y8NGtqoE2FAZJnXS9Iz758+MqlidjUDPg7Qbe919gy0spuwMPYwG+yXP7KptIrd9jb
         xMYLIIBPBo1LTY2XK6cNGuGglM5dOmIK9Y3I1ciINj96EecjEK/ll2pc9/L1fmWWiUsf
         gF5xnyL+pVJa6SUSnH+X0FIt80umyemBngg87EuduW4IQ66mH67yltOFPLCTqkE9oj1/
         xo3MfVc1hW8U7zQNDc2N/0ohr0DE012PuB57w+hvaptKeNfocWS6YEkDCwoh3U4gVdzh
         L/ypvRnLwhI85RDlXpuTm92YLzjLFI6ODS9PBneqgzZFgU4tSeHa7i9NmockJBKA6IrC
         KDtQ==
X-Gm-Message-State: ABuFfojMG7QM96zDXOqZtfOiuUsTzll5FUm3Q1Cm85pAKzdbzQqLqtGw
        nMJdlA8HWK7fi/IysYAbrEOCSvDSpTxeX/x2oB+1cg==
X-Google-Smtp-Source: ACcGV62lzBQdbTO+0smjIUN+tWJ72SJZeWkNBWEwnJ43ksboMiCIULImnETl6px9juM+I9X5F5FsM314xU1wgdMmPMo=
X-Received: by 2002:a9d:2843:: with SMTP id h3-v6mr8717416otd.230.1538086654319;
 Thu, 27 Sep 2018 15:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-6-tycho@tycho.ws>
 <CAG48ez0JY=_fvgy+t92-08kBFgTAZ-3hgAp+OOAwmSd73MJ-QA@mail.gmail.com> <20180927221408.GD15491@cisco.cisco.com>
In-Reply-To: <20180927221408.GD15491@cisco.cisco.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 28 Sep 2018 00:17:07 +0200
Message-ID: <CAG48ez3LYZiEQJKf+6UxjeM0L7FXEq_qxZVb=O=sJeQ2DadbNg@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] seccomp: add a way to pass FDs via a notification fd
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 12:14 AM Tycho Andersen <tycho@tycho.ws> wrote:
> On Thu, Sep 27, 2018 at 09:28:07PM +0200, Jann Horn wrote:
> > On Thu, Sep 27, 2018 at 5:11 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > This patch adds a way to insert FDs into the tracee's process (also
> > > close/overwrite fds for the tracee). This functionality is necessary to
> > > mock things like socketpair() or dup2() or similar, but since it depends on
> > > external (vfs) patches, I've left it as a separate patch as before so the
> > > core functionality can still be merged while we argue about this. Except
> > > this time it doesn't add any ugliness to the API :)
> > [...]
> > > +static long seccomp_notify_put_fd(struct seccomp_filter *filter,
> > > +                                 unsigned long arg)
> > > +{
> > > +       struct seccomp_notif_put_fd req;
> > > +       void __user *buf = (void __user *)arg;
> > > +       struct seccomp_knotif *knotif = NULL;
> > > +       long ret;
> > > +
> > > +       if (copy_from_user(&req, buf, sizeof(req)))
> > > +               return -EFAULT;
> > > +
> > > +       if (req.fd < 0 && req.to_replace < 0)
> > > +               return -EINVAL;
> > > +
> > > +       ret = mutex_lock_interruptible(&filter->notify_lock);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       ret = -ENOENT;
> > > +       list_for_each_entry(knotif, &filter->notif->notifications, list) {
> > > +               struct file *file = NULL;
> > > +
> > > +               if (knotif->id != req.id)
> > > +                       continue;
> >
> > Are you intentionally permitting non-SENT states here? It shouldn't
> > make a big difference, but I think it'd be nice to at least block the
> > use of notifications in SECCOMP_NOTIFY_REPLIED state.
>
> Agreed, I'll block everything besides REPLIED.

Do you mean SENT? In REPLIED state, seccomp_notify_put_fd()
is racy because the target task is in the process of waking up, right?
