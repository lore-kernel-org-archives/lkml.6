Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589F3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB72216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="gHJlrtn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB72216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeI1Eek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:34:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32990 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeI1Eek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:34:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id m23-v6so4174817otf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HQlKN50WM+JsabHzn7SoqTNDtIQjbrBcqRFw4MRzbUs=;
        b=gHJlrtn1QnDzhLXqtuhUqeCLNaHdxtWSqXb+Fc+qlaNSOrPv71buxujhZ9Y/ZPfVNa
         KD8y+vz6c8a63YR5uHObZmARgtOnvkrjYWwx4PULqaZNCxrNvPs9LvkUsZmuGKog7cSw
         uZB3+7TaXO/XvWtjc4n1wKgmgXjf6rtuOJe5BTtdzKUkyIJTU91AwgIK6CXu3yvdQCaj
         bT6PLQnYv11juGov9/FkTIThkZ3IC2w20LZ0mr1IRBe9i/40UFC5mqr8YrFJnKxNmAQ0
         rSbi2AGuerOZFVSwgQ6LreuRkJZ4GagpGJwAzguNsdismlaeg+FVq/sV/kYs4cpltnHM
         03HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HQlKN50WM+JsabHzn7SoqTNDtIQjbrBcqRFw4MRzbUs=;
        b=KpYUv1hj8J82DkpUKxOCGixTP9+B/ltX4vnf+dI5pViy7DiL5AtlXiJ95fqYFDumVl
         CVzKzK1wi8PcekFn9a5YXZs3kkT6UJ4GGdmav7JjqkwYHffG6yoM3JheVE6HDJyKyMGa
         Ol9Zv+s/sHnlirS9+q5coQBNrBbGRbnRnElkNOtnJrlIQcYnIs/8kHQH3MXNVWtJHUg4
         mKc0NqX9mfYGU/QQcWE1y1UuoMsezeTPfBgDK89N1n7QrmtONGXY5EDTo1kOloMh4rn7
         0j2KUSNAHmkhmMSXMJ7iAlDZBL5yemvQYlMnBlxPhxfgZDDqDmVC1tsOJot2GRHbxtSB
         EIdQ==
X-Gm-Message-State: ABuFfoiZi0MlYzfUjzuyrzyuuUv7sqfj7SSttA7uh3aHT3TEWydhDmv8
        pGelq/hcnXd58B1P/mImwcUI8Q==
X-Google-Smtp-Source: ACcGV60DNxPBOa2ibDuiKec433NfWeDakOOO50wDjCoIY76kDC3yXiHEoSz2KnGp3fF3A0MSvNeD2Q==
X-Received: by 2002:a9d:7185:: with SMTP id o5-v6mr8657920otj.60.1538086452138;
        Thu, 27 Sep 2018 15:14:12 -0700 (PDT)
Received: from cisco.cisco.com ([128.107.241.175])
        by smtp.gmail.com with ESMTPSA id e7-v6sm953076oii.26.2018.09.27.15.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 15:14:11 -0700 (PDT)
Date:   Thu, 27 Sep 2018 16:14:08 -0600
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
        suda.akihiro@lab.ntt.co.jp, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 5/6] seccomp: add a way to pass FDs via a notification
 fd
Message-ID: <20180927221408.GD15491@cisco.cisco.com>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-6-tycho@tycho.ws>
 <CAG48ez0JY=_fvgy+t92-08kBFgTAZ-3hgAp+OOAwmSd73MJ-QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0JY=_fvgy+t92-08kBFgTAZ-3hgAp+OOAwmSd73MJ-QA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:28:07PM +0200, Jann Horn wrote:
> On Thu, Sep 27, 2018 at 5:11 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > This patch adds a way to insert FDs into the tracee's process (also
> > close/overwrite fds for the tracee). This functionality is necessary to
> > mock things like socketpair() or dup2() or similar, but since it depends on
> > external (vfs) patches, I've left it as a separate patch as before so the
> > core functionality can still be merged while we argue about this. Except
> > this time it doesn't add any ugliness to the API :)
> [...]
> > +static long seccomp_notify_put_fd(struct seccomp_filter *filter,
> > +                                 unsigned long arg)
> > +{
> > +       struct seccomp_notif_put_fd req;
> > +       void __user *buf = (void __user *)arg;
> > +       struct seccomp_knotif *knotif = NULL;
> > +       long ret;
> > +
> > +       if (copy_from_user(&req, buf, sizeof(req)))
> > +               return -EFAULT;
> > +
> > +       if (req.fd < 0 && req.to_replace < 0)
> > +               return -EINVAL;
> > +
> > +       ret = mutex_lock_interruptible(&filter->notify_lock);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = -ENOENT;
> > +       list_for_each_entry(knotif, &filter->notif->notifications, list) {
> > +               struct file *file = NULL;
> > +
> > +               if (knotif->id != req.id)
> > +                       continue;
> 
> Are you intentionally permitting non-SENT states here? It shouldn't
> make a big difference, but I think it'd be nice to at least block the
> use of notifications in SECCOMP_NOTIFY_REPLIED state.

Agreed, I'll block everything besides REPLIED.

Tycho
