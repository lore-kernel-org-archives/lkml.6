Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9150FECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 16:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365052083C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 16:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="Tz6+2vzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365052083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeJVAT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 20:19:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42767 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbeJVAT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 20:19:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id f8-v6so2753190wro.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=21P02KsXQVVmg3Huv2uEG5HLR0+58fRmI+DDclHAhIw=;
        b=Tz6+2vzlhYatUQZLbtl9qPc2F9pv1R1bSMqmJ2f/fFFt5lEl5oj0wqcFkgTVnhF/XA
         zDAHUshEQu8jNuOCNCgwPG/JT01wbqZ6FDbPtjCjOTThNaSqLAP0Q/nPaltvjeRsZXm3
         yDYzqbCzcsajzf6u03vCqgCRVuC7P5IE7/thyKxxsgirTIHPVtQBeH4ebSWNOxq376Pf
         1SZi+DW+ZOva+A51eAvp+f2gpYhHQeCz10Yl2S3oK0L2QDcnq+cnMucYP6mWQHtyx3R9
         9NhwYd+KCtMM0TUGRfCou8j6ZctZ7H4CaqDdcyvrUmeiDCU+4DWWGBwYnCWbiyQqCmqY
         +ZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=21P02KsXQVVmg3Huv2uEG5HLR0+58fRmI+DDclHAhIw=;
        b=f4suKSnqwEBkpHV7utYXz6AIc+6YmBvNqLjCsivZJ9y80jLb5/USrFR61DWVYY1UrR
         VHX3lQJGL67d+wEnHYtUzFApT4A+Mct2XG19SUah4oX3mVvecedpH0VleyhWmTS3NO7Q
         2po7r0fShmd+c3mzL8hKYFrjjmv3TeAqpPz58AkAMo+4j9YK622RGwt1h7qaCRq0KEls
         B5yND0rd9KM6MUQJ522pJkfmRaLCqIepcf615KAwqaBcQSQLWrMW5JFxea5UVGRQD088
         n+eXBJ2jIKQ/dtlZJk+JnR2c/ZJcZP/XiaU+8iRfDWVbFt0v2sl3dFWsQA2YXAdF3anv
         tL3A==
X-Gm-Message-State: ABuFfohaxY86s4ae9Iop1/HqJHtREeXmIkGfYljyucLhY0aUi1Ujs76g
        r8pywA/GJ4uQeqDAL0MBq9KKf2gsk8hF70mm
X-Google-Smtp-Source: ACcGV63koRRAhAN79IJols9FxYMh9bYBaUq9je/tRhcenH1LHF4PpAlYPq4wBej3VEOAghvQk8I/pw==
X-Received: by 2002:adf:b313:: with SMTP id j19-v6mr21495679wrd.207.1540137879902;
        Sun, 21 Oct 2018 09:04:39 -0700 (PDT)
Received: from cisco ([109.144.219.53])
        by smtp.gmail.com with ESMTPSA id l10-v6sm673406wrv.29.2018.10.21.09.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 09:04:38 -0700 (PDT)
Date:   Sun, 21 Oct 2018 17:04:37 +0100
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] seccomp: add a return code to trap to userspace
Message-ID: <20181021160437.GB25202@cisco>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-2-tycho@tycho.ws>
 <CAGXu5jJr3JWLYGrJ+knu3sj4wwJ_irVvs+JRrY5MuYT3voLegg@mail.gmail.com>
 <20181017202933.GB14047@cisco>
 <CAGXu5jK5yN7zcPUMzFYnUbRrVkLNE0YDCioYdNC3P6mF437+5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jK5yN7zcPUMzFYnUbRrVkLNE0YDCioYdNC3P6mF437+5g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 03:21:02PM -0700, Kees Cook wrote:
> On Wed, Oct 17, 2018 at 1:29 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > On Thu, Sep 27, 2018 at 02:31:24PM -0700, Kees Cook wrote:
> >> On Thu, Sep 27, 2018 at 8:11 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> >> > @@ -60,4 +62,29 @@ struct seccomp_data {
> >> >         __u64 args[6];
> >> >  };
> >> >
> >> > +struct seccomp_notif {
> >> > +       __u16 len;
> >> > +       __u64 id;
> >> > +       __u32 pid;
> >> > +       __u8 signaled;
> >> > +       struct seccomp_data data;
> >> > +};
> >> > +
> >> > +struct seccomp_notif_resp {
> >> > +       __u16 len;
> >> > +       __u64 id;
> >> > +       __s32 error;
> >> > +       __s64 val;
> >> > +};
> >>
> >> So, len has to come first, for versioning. However, since it's ahead
> >> of a u64, this leaves a struct padding hole. pahole output:
> >>
> >> struct seccomp_notif {
> >>         __u16                      len;                  /*     0     2 */
> >>
> >>         /* XXX 6 bytes hole, try to pack */
> >>
> >>         __u64                      id;                   /*     8     8 */
> >>         __u32                      pid;                  /*    16     4 */
> >>         __u8                       signaled;             /*    20     1 */
> >>
> >>         /* XXX 3 bytes hole, try to pack */
> >>
> >>         struct seccomp_data        data;                 /*    24    64 */
> >>         /* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
> >>
> >>         /* size: 88, cachelines: 2, members: 5 */
> >>         /* sum members: 79, holes: 2, sum holes: 9 */
> >>         /* last cacheline: 24 bytes */
> >> };
> >> struct seccomp_notif_resp {
> >>         __u16                      len;                  /*     0     2 */
> >>
> >>         /* XXX 6 bytes hole, try to pack */
> >>
> >>         __u64                      id;                   /*     8     8 */
> >>         __s32                      error;                /*    16     4 */
> >>
> >>         /* XXX 4 bytes hole, try to pack */
> >>
> >>         __s64                      val;                  /*    24     8 */
> >>
> >>         /* size: 32, cachelines: 1, members: 4 */
> >>         /* sum members: 22, holes: 2, sum holes: 10 */
> >>         /* last cacheline: 32 bytes */
> >> };
> >>
> >> How about making len u32, and moving pid and error above "id"? This
> >> leaves a hole after signaled, so changing "len" won't be sufficient
> >> for versioning here. Perhaps move it after data?
> >
> > Just to confirm my understanding; I've got these as:
> >
> > struct seccomp_notif {
> >         __u32                      len;                  /*     0     4 */
> >         __u32                      pid;                  /*     4     4 */
> >         __u64                      id;                   /*     8     8 */
> >         __u8                       signaled;             /*    16     1 */
> >
> >         /* XXX 7 bytes hole, try to pack */
> >
> >         struct seccomp_data        data;                 /*    24    64 */
> >         /* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
> >
> >         /* size: 88, cachelines: 2, members: 5 */
> >         /* sum members: 81, holes: 1, sum holes: 7 */
> >         /* last cacheline: 24 bytes */
> > };
> > struct seccomp_notif_resp {
> >         __u32                      len;                  /*     0     4 */
> >         __s32                      error;                /*     4     4 */
> >         __u64                      id;                   /*     8     8 */
> >         __s64                      val;                  /*    16     8 */
> >
> >         /* size: 24, cachelines: 1, members: 4 */
> >         /* last cacheline: 24 bytes */
> > };
> >
> > in the next version. Since the structure has no padding at the end of
> > it, I think the Right Thing will happen. Note that this is slightly
> > different than what Kees suggested, if I add signaled after data, then
> > I end up with:
> >
> > struct seccomp_notif {
> >         __u32                      len;                  /*     0     4 */
> >         __u32                      pid;                  /*     4     4 */
> >         __u64                      id;                   /*     8     8 */
> >         struct seccomp_data        data;                 /*    16    64 */
> >         /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
> >         __u8                       signaled;             /*    80     1 */
> >
> >         /* size: 88, cachelines: 2, members: 5 */
> >         /* padding: 7 */
> >         /* last cacheline: 24 bytes */
> > };
> >
> > which I think will have the versioning problem if the next member
> > introduces is < 7 bytes.
> 
> It'll be a problem in either place. What I was thinking was that
> specific versioning is required instead of just length.

Euh, so I implemented this, and it sucks :). It's ugly, and generally
feels bad.

What if instead we just get rid of versioning all together, and
instead introduce a u32 flags? We could have one flag right now
(SECCOMP_NOTIF_FLAG_SIGNALED), and use introduce others as we add more
information to the response. Then we can add
SECCOMP_NOTIF_FLAG_EXTRA_FOO, and add another SECCOMP_IOCTL_GET_FOO to
grab the info?

FWIW, it's not really clear to me that we'll ever add anything to the
response since hopefully we'll land PUT_FD, so maybe this is all moot
anyway.

Tycho
