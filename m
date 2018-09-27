Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769CEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E8321722
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="d1ySdirD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E8321722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeI1FKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:10:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35860 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbeI1FKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:10:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id c18-v6so4234673otm.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/zJfM9GE6AKjvgquwPQ/0ceLGlSpIPHhNQftyRiruSY=;
        b=d1ySdirD0UIEDejUae0JedohfvjFTLcWz8PSf3ojtmutnqL9V1sZztbn8EbIEmlx0g
         TsP1CCbs6QVe8F4JjHZtKfuQEWo9JlaMd/kGimTU2a7AVBCMUzBSqX19u3wWx5XKtoaw
         rGBH7DsDgEB9apYDtygmMcSOSxifcz0X9QXZdBaCxsM9dBoIVUSODMmXg25bLEaOGgVq
         Sn1R5KOdDyqQgWYswnsDTkjLLyJ3eyUnpE6CxiMXMmKqfQkNdSVxkfxHJnGI1fCmw6kf
         6i4EXzQvlBQnH1uq8OMkra7KJeYg59Luf+IMaSQsWNpXW4ZvKhAqzHr6nOsKXgGfF9lK
         VtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/zJfM9GE6AKjvgquwPQ/0ceLGlSpIPHhNQftyRiruSY=;
        b=rs4sDw1SfH0/8pITfoBY2Kn9ZGgKsgKwa3B8KWEnX9kNPCM8q65ksKXHThOzv1gQFS
         +5i1427PCqhqoKJTo4qXXCSACCLbhaGjX5uiHrROSmpFcX6b/GAj2RF53fNIz41i83Ju
         X2FQRZ7SwEpoinZP+MC/HBTSjSMsFlSuQyJ+3OzH8R1VyfVX84ShbB/M5zSJw21g+k/G
         opZEg2sgwJIEIzBEh8oxRuZBWyx2fWQ+T2aggiED9D4A39YdwxOspTbjRtIHo/jjeD4L
         MFcbOf+Qz98FE9k3P+GlttSVecMEE1HxFaBXR3CeWd/4qYg8P5N+2eNkcL12RvNmfPA5
         VPQA==
X-Gm-Message-State: ABuFfoj24iKpnZ6BdE2tcAw85fIFqeQiNMxti5BXydmWwMyty/kkkz3f
        5I+/tttwMsAr+teeD1F6BQat0g==
X-Google-Smtp-Source: ACcGV61Z7eqb3DXrF4G4fdurBLXNnoik4YijAh5Yh+Fjy2/KCM3zNsRZ/5rK6VHnCmsTfNKQWQr50Q==
X-Received: by 2002:a9d:7:: with SMTP id 7-v6mr7825517ota.312.1538088600311;
        Thu, 27 Sep 2018 15:50:00 -0700 (PDT)
Received: from cisco.cisco.com ([128.107.241.175])
        by smtp.gmail.com with ESMTPSA id n2-v6sm1064743otl.15.2018.09.27.15.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 15:49:59 -0700 (PDT)
Date:   Thu, 27 Sep 2018 16:49:51 -0600
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
Message-ID: <20180927224951.GG15491@cisco.cisco.com>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-6-tycho@tycho.ws>
 <CAG48ez0JY=_fvgy+t92-08kBFgTAZ-3hgAp+OOAwmSd73MJ-QA@mail.gmail.com>
 <20180927221408.GD15491@cisco.cisco.com>
 <CAG48ez3LYZiEQJKf+6UxjeM0L7FXEq_qxZVb=O=sJeQ2DadbNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3LYZiEQJKf+6UxjeM0L7FXEq_qxZVb=O=sJeQ2DadbNg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 12:17:07AM +0200, Jann Horn wrote:
> On Fri, Sep 28, 2018 at 12:14 AM Tycho Andersen <tycho@tycho.ws> wrote:
> > On Thu, Sep 27, 2018 at 09:28:07PM +0200, Jann Horn wrote:
> > > On Thu, Sep 27, 2018 at 5:11 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > > This patch adds a way to insert FDs into the tracee's process (also
> > > > close/overwrite fds for the tracee). This functionality is necessary to
> > > > mock things like socketpair() or dup2() or similar, but since it depends on
> > > > external (vfs) patches, I've left it as a separate patch as before so the
> > > > core functionality can still be merged while we argue about this. Except
> > > > this time it doesn't add any ugliness to the API :)
> > > [...]
> > > > +static long seccomp_notify_put_fd(struct seccomp_filter *filter,
> > > > +                                 unsigned long arg)
> > > > +{
> > > > +       struct seccomp_notif_put_fd req;
> > > > +       void __user *buf = (void __user *)arg;
> > > > +       struct seccomp_knotif *knotif = NULL;
> > > > +       long ret;
> > > > +
> > > > +       if (copy_from_user(&req, buf, sizeof(req)))
> > > > +               return -EFAULT;
> > > > +
> > > > +       if (req.fd < 0 && req.to_replace < 0)
> > > > +               return -EINVAL;
> > > > +
> > > > +       ret = mutex_lock_interruptible(&filter->notify_lock);
> > > > +       if (ret < 0)
> > > > +               return ret;
> > > > +
> > > > +       ret = -ENOENT;
> > > > +       list_for_each_entry(knotif, &filter->notif->notifications, list) {
> > > > +               struct file *file = NULL;
> > > > +
> > > > +               if (knotif->id != req.id)
> > > > +                       continue;
> > >
> > > Are you intentionally permitting non-SENT states here? It shouldn't
> > > make a big difference, but I think it'd be nice to at least block the
> > > use of notifications in SECCOMP_NOTIFY_REPLIED state.
> >
> > Agreed, I'll block everything besides REPLIED.
> 
> Do you mean SENT? In REPLIED state, seccomp_notify_put_fd()
> is racy because the target task is in the process of waking up, right?

Yes, sorry, I mean SENT.

Tycho
