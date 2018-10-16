Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1067AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2752089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="IkVfl3e6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2752089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeJPVG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:06:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34804 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPVG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:06:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id l6-v6so25060851wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 06:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pPGtFXkvrGdsjxo/nkHWDL/y8sCSjoPsZkt/g4hCQwo=;
        b=IkVfl3e6gB9/gtTFngOtKR33y/4tvLwBOKxD3wayYG8hbzZLBXspgRvfuIj79YYexL
         HphsHkS857H/iKjAG+nTMxeS9LRZNlEHJWAVvw1JhbgFyNtksKBhsKuTMY+RcSTL2nm9
         /Y5rVtyl/wYZqPn7uZ7h/Q5C7Ppx74dDI5A/xOFf0agiH0rmLAZzlLHfpxJE+/zObjtT
         GIFaF28mecY2ZkS64dJ09r3eJdvSxkOQNQDHs0CUFTk4hwL1yr8ghfBh3Lv1LgLXFZ4F
         HvX9qkyHpHpnxquYhTfNcmzo7I7VgDEyj07vet/ealJ6OrsG+RwxKjjXw9dRniRLJqUh
         IZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pPGtFXkvrGdsjxo/nkHWDL/y8sCSjoPsZkt/g4hCQwo=;
        b=U3PQf2cWcBkKXpys+NgdY4AigETjeOwV0m0LXCE0EbougzqtIl1Vjic6y0tQWu6PVO
         KTmAB4d09cj5yP9qtK2Nd7nuSg3RFTIUs6rZMCiYUL0Ib1FEG2w2mubT0hWC6KY7t8x6
         LVO2DKOkNRegHwhOGS4yquxpNy2R1a5K7qnjDad52FplPd7Ctr9wlvlYw3soKCW3Ihcx
         eLHSYRGDHAr/rKMWLx6TNAaRRhv+qIcoTuW+4Ky3+Tq3x6I9nNUzTK9oY3k1a0KN3s1R
         kRYKiLNJiouR6+7u/qqTqCxMzSw88wCnhhh+jo78ZGjdL+/jzS1eHHdap8FGMqfbtnWm
         RDzg==
X-Gm-Message-State: ABuFfojW45hYZL6RurdH1o9iAhrDOvSyaWksCLajncnp9jWUpTpiXNFi
        XMaki65qvjT6WsbFYhb6a+yPTw==
X-Google-Smtp-Source: ACcGV63xaYkjPDKJoHMaaRImM4FZRN+YjYplIlZAsTh/ijxa8YbsHji61Abn6PCNKK3Py3aA6kmzBw==
X-Received: by 2002:adf:e784:: with SMTP id n4-v6mr20009447wrm.187.1539695789459;
        Tue, 16 Oct 2018 06:16:29 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id 90-v6sm17726059wrg.86.2018.10.16.06.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 06:16:28 -0700 (PDT)
Date:   Tue, 16 Oct 2018 15:16:22 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v1 2/2] sysctl: handle overflow for file-max
Message-ID: <20181016131621.ebtkabyzvfqkh3s6@brauner.io>
References: <20181015105544.4395-1-christian@brauner.io>
 <20181015105544.4395-3-christian@brauner.io>
 <CAGXu5jL2j+9ey4732XmTrU4ZJQwJvxmkHMCzwgar9FnVNZhjwg@mail.gmail.com>
 <20181015162817.a7egfo4hutzi3cah@brauner.io>
 <CAGXu5jKSnmcrmOCcuNKX39tx6_p0EY4GBtvpeK=g7PxUg1LJTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGXu5jKSnmcrmOCcuNKX39tx6_p0EY4GBtvpeK=g7PxUg1LJTA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 02:20:15PM -0700, Kees Cook wrote:
> On Mon, Oct 15, 2018 at 9:28 AM, Christian Brauner <christian@brauner.io> wrote:
> > On Mon, Oct 15, 2018 at 09:11:51AM -0700, Kees Cook wrote:
> >> On Mon, Oct 15, 2018 at 3:55 AM, Christian Brauner <christian@brauner.io> wrote:
> >> > Currently, when writing
> >> >
> >> > echo 18446744073709551616 > /proc/sys/fs/file-max
> >> >
> >> > /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> >> > crashes the system.
> >> > This commit explicitly caps the value for file-max to ULONG_MAX.
> >> >
> >> > Note, this isn't technically necessary since proc_get_long() will already
> >> > return ULONG_MAX. However, two reason why we still should do this:
> >> > 1. it makes it explicit what the upper bound of file-max is instead of
> >> >    making readers of the code infer it from proc_get_long() themselves
> >> > 2. other tunebles than file-max may want to set a lower max value than
> >> >    ULONG_MAX and we need to enable __do_proc_doulongvec_minmax() to handle
> >> >    such cases too
> >> >
> >> > Cc: Kees Cook <keescook@chromium.org>
> >> > Signed-off-by: Christian Brauner <christian@brauner.io>
> >> > ---
> >> > v0->v1:
> >> > - if max value is < than ULONG_MAX use max as upper bound
> >> > - (Dominik) remove double "the" from commit message
> >> > ---
> >> >  kernel/sysctl.c | 4 ++++
> >> >  1 file changed, 4 insertions(+)
> >> >
> >> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> >> > index 97551eb42946..226d4eaf4b0e 100644
> >> > --- a/kernel/sysctl.c
> >> > +++ b/kernel/sysctl.c
> >> > @@ -127,6 +127,7 @@ static int __maybe_unused one = 1;
> >> >  static int __maybe_unused two = 2;
> >> >  static int __maybe_unused four = 4;
> >> >  static unsigned long one_ul = 1;
> >> > +static unsigned long ulong_max = ULONG_MAX;
> >> >  static int one_hundred = 100;
> >> >  static int one_thousand = 1000;
> >> >  #ifdef CONFIG_PRINTK
> >> > @@ -1696,6 +1697,7 @@ static struct ctl_table fs_table[] = {
> >> >                 .maxlen         = sizeof(files_stat.max_files),
> >> >                 .mode           = 0644,
> >> >                 .proc_handler   = proc_doulongvec_minmax,
> >> > +               .extra2         = &ulong_max,
> >>
> >> Don't we want this capped lower? The percpu comparisons, for example,
> >> are all signed long. And there is at least this test, which could
> >> overflow:
> >>
> >>         if (atomic_long_read(&unix_nr_socks) > 2 * get_max_files())
> >>                 goto out;
> >
> > Does that check even make sense?
> > Commit 518de9b39e854542de59bfb8b9f61c8f7ecf808b made get_max_files()
> > return a long to bump the number of allowed files to more than 2^31.
> >
> > But assuming a platform where an unsigned long is 64bit which is what
> > get_max_files() returns and atomic_long_read() is 64bit too this is
> > guaranteed to overflow, no?  So I'm not clear what this is trying to do.
> > Seems this should simply be:
> >
> > if (atomic_long_read(&unix_nr_socks) > get_max_files())
> >         goto out;
> >
> > or am I missing a crucial point?
> >
> >>
> >> Seems like max-files should be  SLONG_MAX / 2 or something instead?
> >
> > Hm. Isn't that a bit low? Iiuc, this would mean cutting the maximum
> > number of open files in half? If at all shouldn't it be LONG_MAX?
> 
> LONG_MAX would align us with the values in the percpu stuff. I'm
> really not sure what's happening in the sock check, but it's prone to
> an unsigned multiplication overflow, if I'm reading it right. Probably
> should just be a separate bug fix:
> 
> -         if (atomic_long_read(&unix_nr_socks) > 2 * get_max_files())
> +         if (atomic_long_read(&unix_nr_socks) / 2 > get_max_files())

Yeah, as I said before this is just waiting for an overflow and it seems
this bug has existed since the switch to git. The intention apparently
was indeed to allow the number of sockets to be double the open file
limit. However, as it is right now this just overflows. I'll send a
separate patch for this but I'd sugest to do something like:


diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index d1edfa3cad61..7e461f4f0466 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -754,9 +754,12 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern)
 {
 	struct sock *sk = NULL;
 	struct unix_sock *u;
+	static atomic_long_t tmp;
 
 	atomic_long_inc(&unix_nr_socks);
-	if (atomic_long_read(&unix_nr_socks) > 2 * get_max_files())
+	tmp = atomic_long_read(&unix_nr_socks);
+	do_div(tmp, 2);
+	if (tmp > get_max_files())
 		goto out;
 
 	sk = sk_alloc(net, PF_UNIX, GFP_KERNEL, &unix_proto, kern);

> 
> -Kees
> 
> >
> >>
> >> >         },
> >> >         {
> >> >                 .procname       = "nr_open",
> >> > @@ -2795,6 +2797,8 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
> >> >                                 break;
> >> >                         if (neg)
> >> >                                 continue;
> >> > +                       if (max && val > *max)
> >> > +                               val = *max;
> >> >                         val = convmul * val / convdiv;
> >> >                         if ((min && val < *min) || (max && val > *max))
> >> >                                 continue;
> >> > --
> >> > 2.17.1
> >> >
> >>
> >> -Kees
> >>
> >> --
> >> Kees Cook
> >> Pixel Security
> 
> 
> 
> -- 
> Kees Cook
> Pixel Security
