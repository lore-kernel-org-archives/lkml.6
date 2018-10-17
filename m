Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C0EECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A51205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="gQF6Cfbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A51205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbeJRE07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:26:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40509 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeJRE07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:26:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id 1-v6so13223581plv.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 13:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FCQASoYRSaFzlH8fQN2IkGFzJDnxB4c3yZeFtDyQ6uA=;
        b=gQF6CfbxT7dpq9qMO4/5h2rOPvSTIRIInP2kk+siMkC8QOg5c5kinUWfEPzzOcXAh9
         xdoHyqV69ZALqv07+soF0Lzy28MM9rFbCCpf4CJKcNInmgQhfeIWojx2v+3cVPXqAHhf
         3GPeuHEioN8QuZJ3Wod2YPINzCOX8gIGuj3c7cU8C77/QQIQedv1xvpTXIKKvFE2sZkW
         XrXrxvqQa0uGNEDDj1+eltlM9AtXcsIE6p+NgYebPb44ZQU26XeaM3Ys7XJhJFW0rvLy
         Ptr8dKXLpeflNRonHH/RubGK6FmZKGJ3s3IdUxmhWyM2YCOYFuqOR7CIJWHkxInrlneW
         dOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FCQASoYRSaFzlH8fQN2IkGFzJDnxB4c3yZeFtDyQ6uA=;
        b=OSpdZMgPB817z1o5qA2aMZvGxMCDX+cXHWvvZRLbYIy6GKLQljS/tnJbEIdwiIiseW
         ow+Ic0xR4AWOTyVr0ca6CfwkHx7Mw47SD6XbB+7h3sKlWNsMrhYgf30D1R/RdJN/KRYL
         QzHtqherQOFxZoBe7wXxVHlb3idrt1B6kNSyro7Ob0LCjiA9XNjwATvnpU9CxAdlN+u4
         MypaqZbwtQEwN6zKaE5/gZSjJr4Cq0I4pT6pJWdrpMzOlvrabzSIzov7LL7HFfp/NH+k
         bD24fN4maoZQ1XF6bBNabQIR4OBbszJ7fT531Kz/2a75bm+Xtc/W6208lknXJ0hDVuFh
         yTlQ==
X-Gm-Message-State: ABuFfogvbVr0GyYyWmsYXWo/GmnFWrC+bI8rMeKOil5cXHhM2G3/REG0
        KQcpgAUq3UdQ8p0Z/qTvNxIvJg==
X-Google-Smtp-Source: ACcGV61fhAxrZa9j28teOHkm2u6RSoGloLQmvEhcVJSuVXAcMVzN+xh3fJZTEzWasc3qMABnlmlQVg==
X-Received: by 2002:a17:902:9047:: with SMTP id w7-v6mr27183566plz.4.1539808176278;
        Wed, 17 Oct 2018 13:29:36 -0700 (PDT)
Received: from cisco ([128.107.241.189])
        by smtp.gmail.com with ESMTPSA id y7-v6sm20459392pfl.57.2018.10.17.13.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 13:29:35 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:29:33 -0600
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
Message-ID: <20181017202933.GB14047@cisco>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-2-tycho@tycho.ws>
 <CAGXu5jJr3JWLYGrJ+knu3sj4wwJ_irVvs+JRrY5MuYT3voLegg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJr3JWLYGrJ+knu3sj4wwJ_irVvs+JRrY5MuYT3voLegg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 02:31:24PM -0700, Kees Cook wrote:
> On Thu, Sep 27, 2018 at 8:11 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> > @@ -60,4 +62,29 @@ struct seccomp_data {
> >         __u64 args[6];
> >  };
> >
> > +struct seccomp_notif {
> > +       __u16 len;
> > +       __u64 id;
> > +       __u32 pid;
> > +       __u8 signaled;
> > +       struct seccomp_data data;
> > +};
> > +
> > +struct seccomp_notif_resp {
> > +       __u16 len;
> > +       __u64 id;
> > +       __s32 error;
> > +       __s64 val;
> > +};
> 
> So, len has to come first, for versioning. However, since it's ahead
> of a u64, this leaves a struct padding hole. pahole output:
> 
> struct seccomp_notif {
>         __u16                      len;                  /*     0     2 */
> 
>         /* XXX 6 bytes hole, try to pack */
> 
>         __u64                      id;                   /*     8     8 */
>         __u32                      pid;                  /*    16     4 */
>         __u8                       signaled;             /*    20     1 */
> 
>         /* XXX 3 bytes hole, try to pack */
> 
>         struct seccomp_data        data;                 /*    24    64 */
>         /* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
> 
>         /* size: 88, cachelines: 2, members: 5 */
>         /* sum members: 79, holes: 2, sum holes: 9 */
>         /* last cacheline: 24 bytes */
> };
> struct seccomp_notif_resp {
>         __u16                      len;                  /*     0     2 */
> 
>         /* XXX 6 bytes hole, try to pack */
> 
>         __u64                      id;                   /*     8     8 */
>         __s32                      error;                /*    16     4 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         __s64                      val;                  /*    24     8 */
> 
>         /* size: 32, cachelines: 1, members: 4 */
>         /* sum members: 22, holes: 2, sum holes: 10 */
>         /* last cacheline: 32 bytes */
> };
> 
> How about making len u32, and moving pid and error above "id"? This
> leaves a hole after signaled, so changing "len" won't be sufficient
> for versioning here. Perhaps move it after data?

Just to confirm my understanding; I've got these as:

struct seccomp_notif {
	__u32                      len;                  /*     0     4 */
	__u32                      pid;                  /*     4     4 */
	__u64                      id;                   /*     8     8 */
	__u8                       signaled;             /*    16     1 */

	/* XXX 7 bytes hole, try to pack */

	struct seccomp_data        data;                 /*    24    64 */
	/* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */

	/* size: 88, cachelines: 2, members: 5 */
	/* sum members: 81, holes: 1, sum holes: 7 */
	/* last cacheline: 24 bytes */
};
struct seccomp_notif_resp {
	__u32                      len;                  /*     0     4 */
	__s32                      error;                /*     4     4 */
	__u64                      id;                   /*     8     8 */
	__s64                      val;                  /*    16     8 */

	/* size: 24, cachelines: 1, members: 4 */
	/* last cacheline: 24 bytes */
};

in the next version. Since the structure has no padding at the end of
it, I think the Right Thing will happen. Note that this is slightly
different than what Kees suggested, if I add signaled after data, then
I end up with:

struct seccomp_notif {
	__u32                      len;                  /*     0     4 */
	__u32                      pid;                  /*     4     4 */
	__u64                      id;                   /*     8     8 */
	struct seccomp_data        data;                 /*    16    64 */
	/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
	__u8                       signaled;             /*    80     1 */

	/* size: 88, cachelines: 2, members: 5 */
	/* padding: 7 */
	/* last cacheline: 24 bytes */
};

which I think will have the versioning problem if the next member
introduces is < 7 bytes.

Tycho
