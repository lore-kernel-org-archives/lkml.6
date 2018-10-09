Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A61C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A20213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="K13LoTm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A20213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeJIVpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:45:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40812 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJIVpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:45:49 -0400
Received: by mail-io1-f65.google.com with SMTP id w16-v6so1298953iom.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=08NDXM3bDeX775GQaUm9s+d9XSN1uhZl0K+kXRW+W1I=;
        b=K13LoTm7yUokeJEkHLhMJh1dLPx9q7/KDr3fzubInDwoH+et7jk7pMF1q0QRHD4eug
         s0etZ1OEaU5dbsvqtUfGL1af/nWBaOEQnuUwdApOMFVabA1lU8i/c8Ew1qfXNEyP/44H
         T+s7iZj01TY+NRf4DUAbrnAg8gybXx+BIISEwTeYtQw6N5ZVyvK1KOhojMfiFEHSMgqJ
         OyISNMzZ+SU+p3yLAECDnVjLsZX2VIKhtYZN0R7wHelAZMdFtPC3PK1A6Tt5xIp1yXVJ
         Qm4khX0nhGt5uqzentT4TK+HDCqCceVbXGbUuusmhhcORn7Ut+PGBRjPax+0zHa2FiW6
         X65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=08NDXM3bDeX775GQaUm9s+d9XSN1uhZl0K+kXRW+W1I=;
        b=AM5lAzt+0Cx19Bg5HgPTLkAVADkBV07DHyo93fsyP5nWmL2pYi9iLFEw4PurWahjP4
         yKPfb82gXohgnTrlaCy8vWaSc4qPHX25hKj10yc76GogskO1pt4qSeLBZRPPgvh9q5rz
         m5VUMXBLbqF3mP6HGUoK1sO0/1f6lq2P8H2qsl6Dc4XoMIe+MP3DhXxbXznlAuaszeG9
         +IEyK1VRpEQYr4Ogm7cUUlx2D9YxdvroYlLyCcXVgiZsP3AbtH6uDfA8yzpV15wdk7nl
         YjW1m0qOmGpDPu7TrTaNGBQAtHq4fr8fdmBBLoaXM/2PNwFaSTSsAGLrT/1nfiNBYFwZ
         Ve5Q==
X-Gm-Message-State: ABuFfojGAVcqQ2wQM23EtIkiVZFiiofNgm6Bf2bDPKbt0hkukU7T3UIL
        8vIeqJqU/uGpg3fpLURQps/9xQ==
X-Google-Smtp-Source: ACcGV62pGbZqYAObM7DOOccZMFbb2H7xr/BeRpqK/Ub33DXCgrC17PvY4VrYbxsQlmr+OTnVWtCb8w==
X-Received: by 2002:a6b:c085:: with SMTP id q127-v6mr18254087iof.255.1539095316118;
        Tue, 09 Oct 2018 07:28:36 -0700 (PDT)
Received: from cisco ([12.226.92.2])
        by smtp.gmail.com with ESMTPSA id b195-v6sm6159689itc.42.2018.10.09.07.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 07:28:34 -0700 (PDT)
Date:   Tue, 9 Oct 2018 07:28:33 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian@brauner.io>
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
Message-ID: <20181009142833.GA10149@cisco>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-2-tycho@tycho.ws>
 <CAGXu5jJr3JWLYGrJ+knu3sj4wwJ_irVvs+JRrY5MuYT3voLegg@mail.gmail.com>
 <20180927224839.GF15491@cisco.cisco.com>
 <20181008145803.ycawjwhc3mwkdogf@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008145803.ycawjwhc3mwkdogf@brauner.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 04:58:05PM +0200, Christian Brauner wrote:
> On Thu, Sep 27, 2018 at 04:48:39PM -0600, Tycho Andersen wrote:
> > On Thu, Sep 27, 2018 at 02:31:24PM -0700, Kees Cook wrote:
> > > I have to say, I'm vaguely nervous about changing the semantics here
> > > for passing back the fd as the return code from the seccomp() syscall.
> > > Alternatives seem less appealing, though: changing the meaning of the
> > > uargs parameter when SECCOMP_FILTER_FLAG_NEW_LISTENER is set, for
> > > example. Hmm.
> > 
> > From my perspective we can drop this whole thing. The only thing I'll
> > ever use is the ptrace version. Someone at some point (I don't
> > remember who, maybe stgraber) suggested this version would be useful
> > as well.
> 
> So I think we want to have the ability to get an fd via seccomp().
> Especially, if we all we worry about are weird semantics. When we
> discussed this we knew the whole patchset was going to be weird. :)
> 
> This is a seccomp feature so seccomp should - if feasible - equip you
> with everything to use it in a meaningful way without having to go
> through a different kernel api. I know ptrace and seccomp are
> already connected but I still find this cleaner. :)
> 
> Another thing is that the container itself might be traced for some
> reason while you still might want to get an fd out.

Sure, I don't see the problem here.

> Also, I wonder what happens if you want to filter the ptrace() syscall
> itself? Then you'd deadlock?

No, are you confusing the tracee with the tracer here? Filtering
ptrace() will happen just like any other syscall... what would you
deadlock with?

> Also, it seems that getting an fd via ptrace requires CAP_SYS_ADMIN in
> the inital user namespace (which I just realized now) whereas getting
> the fd via seccomp() doesn't seem to.

Yep, I'll leave this discussion to the other thread.

Tycho
