Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A378C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3822083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="UHG4oHIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3822083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeJVSAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:00:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43586 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbeJVSAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:00:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id t10-v6so2598805wrn.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 02:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KWKmse8a4tt4dj9gO+OCYFTgYGfwesV1BTfj6SJjFBc=;
        b=UHG4oHIoiAOS7ywsNzXbgzOKhA15XUX4qm7whkiX/wsrGBubLK5eRA/AB9DWcddRQj
         JGlhgNsAzHtfdb6QhyQLH4wQVPBnLmm1k31X3XwEAEH4hNuGUcWCcfBzrVRvXS9CCDlq
         IarInq/gxumNZoGQXRRy+nqKg1yz+VPQ6Kw4l/k3nOUmMK8XlaxGhLZHm7SGAmWpVT7O
         B8D13s3Vnda1/1ePf9U2KKfLEhh1uPIV+HVqiREEVqqrySaagmM07kIuthl8jWN7IJ+V
         FYedsg3q0MHEcQMcyeNl01qzEcjPGPZ5iBKwLrkXlqV29k0v0Oiki5uSyfYKFXKxzdfT
         Tcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KWKmse8a4tt4dj9gO+OCYFTgYGfwesV1BTfj6SJjFBc=;
        b=sVQFkHRcTFy/H4Cm3xYRvVJfXD56Zq9aFnK7YBwxjIzAeHlVEkD26qktzhEvtoUc7+
         EIWLjYfLuyZ9QQPRqn+mDZulZutTAeXZBOD/6WLBMDo2/udnyhAppGmQfBxI0SNLSlPM
         EMpveP4S3NUpGUswRvBmdjXL/wwYHZUtJkFCu6s7TrUaFgTPURyvE4huXn4ZTljZPaNd
         j22btopmJ1CN9sYedhp5TSRQ7hxRJO8z7jU7TDuyJkvy1qQSvsgMp+4qaZSoSb79z2w6
         vsy7iy1nb6Ll4WMq58YApkwZF4coQdOzyV24fiQ3mFDLyQ8qTXOkMu6iYUyrtnoCteQA
         1Rjw==
X-Gm-Message-State: ABuFfog9nIsB/JW60qxg0xKyZzUAZ8k84fGTj3056OAeig84Imir1TgV
        GlBTJgA9nVpZSb8v6WoICZw2eA==
X-Google-Smtp-Source: ACcGV60L2zfSr+eg+ycnikrDQutZEXEnwbVwtfktTBQQ32WhwDuTqF9sqFnc5YqhwYnYpJNfF/qYUw==
X-Received: by 2002:adf:b211:: with SMTP id u17-v6mr42714249wra.180.1540201371789;
        Mon, 22 Oct 2018 02:42:51 -0700 (PDT)
Received: from brauner.io ([185.7.230.214])
        by smtp.gmail.com with ESMTPSA id g186-v6sm11550570wmf.19.2018.10.22.02.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 02:42:48 -0700 (PDT)
Date:   Mon, 22 Oct 2018 11:42:41 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v7 1/6] seccomp: add a return code to trap to userspace
Message-ID: <20181022094240.mp7pd2m2abyttrfb@brauner.io>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-2-tycho@tycho.ws>
 <CAGXu5jJr3JWLYGrJ+knu3sj4wwJ_irVvs+JRrY5MuYT3voLegg@mail.gmail.com>
 <20181017202933.GB14047@cisco>
 <CAGXu5jK5yN7zcPUMzFYnUbRrVkLNE0YDCioYdNC3P6mF437+5g@mail.gmail.com>
 <20181021160437.GB25202@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181021160437.GB25202@cisco>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 05:04:37PM +0100, Tycho Andersen wrote:
> On Wed, Oct 17, 2018 at 03:21:02PM -0700, Kees Cook wrote:
> > On Wed, Oct 17, 2018 at 1:29 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > > On Thu, Sep 27, 2018 at 02:31:24PM -0700, Kees Cook wrote:
> > >> On Thu, Sep 27, 2018 at 8:11 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> > >> > @@ -60,4 +62,29 @@ struct seccomp_data {
> > >> >         __u64 args[6];
> > >> >  };
> > >> >
> > >> > +struct seccomp_notif {
> > >> > +       __u16 len;
> > >> > +       __u64 id;
> > >> > +       __u32 pid;
> > >> > +       __u8 signaled;
> > >> > +       struct seccomp_data data;
> > >> > +};
> > >> > +
> > >> > +struct seccomp_notif_resp {
> > >> > +       __u16 len;
> > >> > +       __u64 id;
> > >> > +       __s32 error;
> > >> > +       __s64 val;
> > >> > +};
> > >>
> > >> So, len has to come first, for versioning. However, since it's ahead
> > >> of a u64, this leaves a struct padding hole. pahole output:
> > >>
> > >> struct seccomp_notif {
> > >>         __u16                      len;                  /*     0     2 */
> > >>
> > >>         /* XXX 6 bytes hole, try to pack */
> > >>
> > >>         __u64                      id;                   /*     8     8 */
> > >>         __u32                      pid;                  /*    16     4 */
> > >>         __u8                       signaled;             /*    20     1 */
> > >>
> > >>         /* XXX 3 bytes hole, try to pack */
> > >>
> > >>         struct seccomp_data        data;                 /*    24    64 */
> > >>         /* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
> > >>
> > >>         /* size: 88, cachelines: 2, members: 5 */
> > >>         /* sum members: 79, holes: 2, sum holes: 9 */
> > >>         /* last cacheline: 24 bytes */
> > >> };
> > >> struct seccomp_notif_resp {
> > >>         __u16                      len;                  /*     0     2 */
> > >>
> > >>         /* XXX 6 bytes hole, try to pack */
> > >>
> > >>         __u64                      id;                   /*     8     8 */
> > >>         __s32                      error;                /*    16     4 */
> > >>
> > >>         /* XXX 4 bytes hole, try to pack */
> > >>
> > >>         __s64                      val;                  /*    24     8 */
> > >>
> > >>         /* size: 32, cachelines: 1, members: 4 */
> > >>         /* sum members: 22, holes: 2, sum holes: 10 */
> > >>         /* last cacheline: 32 bytes */
> > >> };
> > >>
> > >> How about making len u32, and moving pid and error above "id"? This
> > >> leaves a hole after signaled, so changing "len" won't be sufficient
> > >> for versioning here. Perhaps move it after data?
> > >
> > > Just to confirm my understanding; I've got these as:
> > >
> > > struct seccomp_notif {
> > >         __u32                      len;                  /*     0     4 */
> > >         __u32                      pid;                  /*     4     4 */
> > >         __u64                      id;                   /*     8     8 */
> > >         __u8                       signaled;             /*    16     1 */
> > >
> > >         /* XXX 7 bytes hole, try to pack */
> > >
> > >         struct seccomp_data        data;                 /*    24    64 */
> > >         /* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
> > >
> > >         /* size: 88, cachelines: 2, members: 5 */
> > >         /* sum members: 81, holes: 1, sum holes: 7 */
> > >         /* last cacheline: 24 bytes */
> > > };
> > > struct seccomp_notif_resp {
> > >         __u32                      len;                  /*     0     4 */
> > >         __s32                      error;                /*     4     4 */
> > >         __u64                      id;                   /*     8     8 */
> > >         __s64                      val;                  /*    16     8 */
> > >
> > >         /* size: 24, cachelines: 1, members: 4 */
> > >         /* last cacheline: 24 bytes */
> > > };
> > >
> > > in the next version. Since the structure has no padding at the end of
> > > it, I think the Right Thing will happen. Note that this is slightly
> > > different than what Kees suggested, if I add signaled after data, then
> > > I end up with:
> > >
> > > struct seccomp_notif {
> > >         __u32                      len;                  /*     0     4 */
> > >         __u32                      pid;                  /*     4     4 */
> > >         __u64                      id;                   /*     8     8 */
> > >         struct seccomp_data        data;                 /*    16    64 */
> > >         /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
> > >         __u8                       signaled;             /*    80     1 */
> > >
> > >         /* size: 88, cachelines: 2, members: 5 */
> > >         /* padding: 7 */
> > >         /* last cacheline: 24 bytes */
> > > };
> > >
> > > which I think will have the versioning problem if the next member
> > > introduces is < 7 bytes.
> > 
> > It'll be a problem in either place. What I was thinking was that
> > specific versioning is required instead of just length.
> 
> Euh, so I implemented this, and it sucks :). It's ugly, and generally
> feels bad.
> 
> What if instead we just get rid of versioning all together, and
> instead introduce a u32 flags? We could have one flag right now
> (SECCOMP_NOTIF_FLAG_SIGNALED), and use introduce others as we add more
> information to the response. Then we can add
> SECCOMP_NOTIF_FLAG_EXTRA_FOO, and add another SECCOMP_IOCTL_GET_FOO to
> grab the info?
> 
> FWIW, it's not really clear to me that we'll ever add anything to the
> response since hopefully we'll land PUT_FD, so maybe this is all moot
> anyway.

I guess the only argument against a flag would be that you run out of
bits quickly if your interface grows (cf. mount, netlink etc.). But this
is likely not a concern here.
I actually think that the way vfs capabilities are done is pretty
nice. By accident or design they allow transparent translation between
old and new formats in-kernel. So would be cool if we can have the same
guarantee for this interface.

Christian
