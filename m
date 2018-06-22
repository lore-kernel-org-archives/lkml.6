Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC9CC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA8F208B3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="iCWkTOU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA8F208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934107AbeFVA6g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:58:36 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34123 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933948AbeFVA6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:58:34 -0400
Received: by mail-qk0-f193.google.com with SMTP id q70-v6so2878082qke.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 17:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DKLW2PmdP5k00k88E1K5FGHFbTfbMsr2JKjdH+kgTKQ=;
        b=iCWkTOU23am8xuZAqZb7KdD9NMH7R6MqHsiUGjgua6f8LmOcDepNAK2ALfuOeEeChf
         0ggwsl1He6zCu/ZJk3mFNGtu2HRBtS6cefeKOudaAjv8B0+R9R78x8S6x5HPQe5hmG/2
         aebtQXHCxy7rMrp2w4vXbiltcxghHFThjGxFkkHJOo1/CTrR/Q304negRNNWfmXfsZNQ
         b+igQtMiXffY0uf3MzGZn7G1DLq7x8lHdsjoJ6n33rL0BDnPUPyXdU7AeAIszB2qX+kW
         c+EH+m8f5Zqk8y0rkHcH24P38aiqg0Y2fwciNyBzU72bkKIJPCkMNVfmzu9ySs5ftJiN
         tsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DKLW2PmdP5k00k88E1K5FGHFbTfbMsr2JKjdH+kgTKQ=;
        b=dEp5n7esJCC8GZlEp544SdWR5ULt3sEfeO1DceBBBfqwW5TfeBeDXPaY6q4P/YwBu3
         zce6ykzjGTBxyQp/2IF0xkMsqMKMkp6yabXYhZYASJdQTjqhznZSFxULp0NBgaHoCSiR
         OS6Wfg4oxzRa/mv5O7ueuHNy+evUa8ZpdfT4JH2L2FlA/27HUXrcDQ4rI75k62+T3lOc
         Y8URAYPVmvpvLjh70mdHYtu4MKA/kbuyIFQVKYkiLh/osIFPeSMagi0JmHYj4E8Mly90
         eTwbl2NvlCToEY4onKVeTDYyU5h7R91ag8u1UbN/Zw36V5hPl66T3h7nY83ceCaLAjk2
         FBAw==
X-Gm-Message-State: APt69E0ZS4eD1Z5ykKzIBG3qCcwwWFkEjZwPqX6og5asMAU36IQAO5l7
        NrrDX6d4tUCjsiQBTyOG/YwHlg==
X-Google-Smtp-Source: ADUXVKIuYfK0SW7wv06vrNYALYePVpXSHzOMvS7y5tbH7LwL8X5RYI7N0tiubkicQewGjoswC+FrnA==
X-Received: by 2002:a37:424a:: with SMTP id p71-v6mr24327742qka.209.1529629113329;
        Thu, 21 Jun 2018 17:58:33 -0700 (PDT)
Received: from cisco ([173.38.117.67])
        by smtp.gmail.com with ESMTPSA id h57-v6sm5903751qtc.68.2018.06.21.17.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 17:58:32 -0700 (PDT)
Date:   Thu, 21 Jun 2018 18:58:29 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Jann Horn <jannh@google.com>
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
        suda.akihiro@lab.ntt.co.jp, "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH v4 1/4] seccomp: add a return code to trap to userspace
Message-ID: <20180622005829.GK3992@cisco>
References: <20180621220416.5412-1-tycho@tycho.ws>
 <20180621220416.5412-2-tycho@tycho.ws>
 <CAG48ez2-vK57HfbRs94YLiz3SVJ7u4tTrxtAmbRepDqk6m-c_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2-vK57HfbRs94YLiz3SVJ7u4tTrxtAmbRepDqk6m-c_A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:21:47AM +0200, Jann Horn wrote:
> On Fri, Jun 22, 2018 at 12:05 AM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > This patch introduces a means for syscalls matched in seccomp to notify
> > some other task that a particular filter has been triggered.
> [...]
> > +Userspace Notification
> > +======================
> > +
> > +The ``SECCOMP_RET_USER_NOTIF`` return code lets seccomp filters pass a
> > +particular syscall to userspace to be handled. This may be useful for
> > +applications like container managers, which whish to intercept particular
> 
> typo: "wish"
> 
> [...]
> > +passed around via ``SCM_RIGHTS`` or similar. Alternativley, a filter fd can be
> 
> typo: "Alternatively"
> 
> [...]
> > +It is worth noting that ``struct seccomp_data`` contains the values of register
> > +arguments to the syscall, but does not contain pointers to memory. The task's
> > +memory is accessiable to suitably privileged traces via via ``ptrace()`` or
> 
> Typo: "accessible"

Thanks!

> [...]
> > +
> > +static void seccomp_do_user_notification(int this_syscall,
> > +                                        struct seccomp_filter *match,
> > +                                        const struct seccomp_data *sd)
> > +{
> > +       int err;
> > +       long ret = 0;
> > +       struct seccomp_knotif n = {};
> > +
> > +       mutex_lock(&match->notify_lock);
> > +       err = -ENOSYS;
> > +       if (!match->has_listener)
> > +               goto out;
> > +
> > +       n.pid = task_pid(current);
> > +       n.state = SECCOMP_NOTIFY_INIT;
> > +       n.data = sd;
> > +       n.id = seccomp_next_notify_id(match);
> > +       init_completion(&n.ready);
> > +
> > +       list_add(&n.list, &match->notifications);
> > +       wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
> > +
> > +       mutex_unlock(&match->notify_lock);
> > +       up(&match->request);
> > +
> > +       err = wait_for_completion_interruptible(&n.ready);
> > +       mutex_lock(&match->notify_lock);
> > +
> > +       /*
> > +        * Here it's possible we got a signal and then had to wait on the mutex
> > +        * while the reply was sent, so let's be sure there wasn't a response
> > +        * in the meantime.
> > +        */
> > +       if (err < 0 && n.state != SECCOMP_NOTIFY_REPLIED) {
> > +               /*
> > +                * We got a signal. Let's tell userspace about it (potentially
> > +                * again, if we had already notified them about the first one).
> > +                */
> > +               if (n.state == SECCOMP_NOTIFY_SENT) {
> > +                       n.state = SECCOMP_NOTIFY_INIT;
> > +                       up(&match->request);
> > +               }
> > +               mutex_unlock(&match->notify_lock);
> > +               err = wait_for_completion_killable(&n.ready);
> 
> Does this mean that when you get a signal that isn't SIGKILL,
> wait_for_completion_interruptible() will bail out with -ERESTARTSYS,
> but then you hang on this wait_for_completion_killable()? I don't
> understand what's going on here. What's the point of using
> wait_for_completion_interruptible() when you'll just hang on another
> wait on the same "struct completion"?

This is the implementation of this suggestion by Andy:
https://lkml.org/lkml/2018/3/15/1122

The idea is to alert the listener that there was a signal exactly
once, in case it's in the middle of processing a request it could bail
out and do something else. So the killable wait is intended to ignore
other (non-fatal) signals after the first one and wait for whatever
the handler decides to do with the signal it received.

Tycho
