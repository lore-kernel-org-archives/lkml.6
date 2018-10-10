Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B12C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21934214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="GBE6zOK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21934214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeJKAtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:49:35 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34435 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbeJKAtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:49:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id v69-v6so4764289oif.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BvFm+sBkGwaMR27WU5BUOfE1yXXdCNYSFVLHIiUXbB0=;
        b=GBE6zOK94/8Z7qPPXHdpV9+TfSXwrsn7fuo85V4DijWhvxHcM5xBITc2dMiFOfNPyB
         zhh+AGL4k6T6J6taalisNTn0JMf7GU1TY0tJONDiPj2Fq922CwRYLXUTGKQC9EEG69+4
         hD5sEGQxT4Pe2yP6t8Ecz7rS4ORvaWBGwicCwXJp0i2l8VngOEiTPSN12yUQOxWFZgIW
         fqd+RmQI+/vwrr5jpobBKLLpeL2cfzhwIpFF4MOiTK4L4/nRhYoJkwpSARjapwXZ381x
         BbpRUklR+49SFUF0ah1DDA/VCHeTXm5hrfu8d/mhSYRc8ytLumVLeWXnsI+pqUiBILib
         mNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BvFm+sBkGwaMR27WU5BUOfE1yXXdCNYSFVLHIiUXbB0=;
        b=VvCXX0Coou62kSKoOxvRlXVBN3Y1GmsksDCHe33UdhIUrAxtTY/K05VzVKjmB6WunP
         Xw+YHrHhekCAWSg/6e9wBGUtqM/wlfxdUNOLjSVBLYJQRXuYxIC7fJNzEGaNqo5JB9nK
         kXLppUhl1wF+4FbwfcqXtc3Ng+mGsfLmrhC5kx53a0pmxBTZ00FQDpKexxHAF5nNY5DF
         jhM1FxiWJVcEJe2caHs0P29izXId5AsKPVtScde1vMU0JvBeugqxOt8Ie0jiENLk0D3W
         qzgkrKGZmYyxSoxFXfRUt/p+scZgCp7OdbUTOI1uH//hS88NW+qq5nhd9tLn7cKqWxoM
         fkiQ==
X-Gm-Message-State: ABuFfoiSqln6z/oXjliYxjSqHHv0UepN7fzGfNBYO6X7YqbMpdd8ryhi
        eg8AkN0OMY8OfbhN4qZn0vkF5A==
X-Google-Smtp-Source: ACcGV63GdttosrYrQcwRL53CrPwuNYC7UZyRmiJRFDeg8yBb2Jbe6+ZfHpS++o6KqnReMvp1nEFl3Q==
X-Received: by 2002:aca:401:: with SMTP id 1-v6mr2272544oie.229.1539192386443;
        Wed, 10 Oct 2018 10:26:26 -0700 (PDT)
Received: from cisco ([2001:420:28e:1260:c7c:88c5:50e7:459f])
        by smtp.gmail.com with ESMTPSA id 89-v6sm2807269otr.51.2018.10.10.10.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 10:26:25 -0700 (PDT)
Date:   Wed, 10 Oct 2018 10:26:22 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, suda.akihiro@lab.ntt.co.jp,
        Oleg Nesterov <oleg@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20181010172622.GB5607@cisco>
References: <CAG48ez3O+wAkq+0yDfoMt73ybnCOEPpi3Mu-uF57_v=6hA8ZEw@mail.gmail.com>
 <20181008181815.pwnqxngj22mhm2vj@brauner.io>
 <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
 <20181009132850.fp6yne2vgmfpi27k@brauner.io>
 <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <CAHC9VhQfzJgG3i=Q8C+pGY2Lpr+2MRTwxgUWec_heGOecd=xRg@mail.gmail.com>
 <CAG48ez2hTBFwmA65FXv0zJjc0_wpc1S-uOBn1t+X=0vPH25YvQ@mail.gmail.com>
 <20181010153956.zzlatxdlcwolbs6k@brauner.io>
 <20181010165458.GA5607@cisco>
 <20181010171500.wh4yygmh7u6ynqid@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010171500.wh4yygmh7u6ynqid@brauner.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 07:15:02PM +0200, Christian Brauner wrote:
> On Wed, Oct 10, 2018 at 09:54:58AM -0700, Tycho Andersen wrote:
> > On Wed, Oct 10, 2018 at 05:39:57PM +0200, Christian Brauner wrote:
> > > On Wed, Oct 10, 2018 at 05:33:43PM +0200, Jann Horn wrote:
> > > > On Wed, Oct 10, 2018 at 5:32 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Tue, Oct 9, 2018 at 9:36 AM Jann Horn <jannh@google.com> wrote:
> > > > > > +cc selinux people explicitly, since they probably have opinions on this
> > > > >
> > > > > I just spent about twenty minutes working my way through this thread,
> > > > > and digging through the containers archive trying to get a good
> > > > > understanding of what you guys are trying to do, and I'm not quite
> > > > > sure I understand it all.  However, from what I have seen, this
> > > > > approach looks very ptrace-y to me (I imagine to others as well based
> > > > > on the comments) and because of this I think ensuring the usual ptrace
> > > > > access controls are evaluated, including the ptrace LSM hooks, is the
> > > > > right thing to do.
> > > > 
> > > > Basically the problem is that this new ptrace() API does something
> > > > that doesn't just influence the target task, but also every other task
> > > > that has the same seccomp filter. So the classic ptrace check doesn't
> > > > work here.
> > > 
> > > Just to throw this into the mix: then maybe ptrace() isn't the right
> > > interface and we should just go with the native seccomp() approach for
> > > now.
> > 
> > Please no :).
> > 
> > I don't buy your arguments that 3-syscalls vs. one is better. If I'm
> > doing this setup with a new container, I have to do
> > clone(CLONE_FILES), do this seccomp thing, so that my parent can pick
> > it up again, then do another clone without CLONE_FILES, because in the
> > general case I don't want to share my fd table with the container,
> > wait on the middle task for errors, etc. So we're still doing a bunch
> > of setup, and it feels more awkward than ptrace, with at least as many
> > syscalls, and it only works for your children.
> 
> You're talking about the case where you already have shot yourself in
> the foot by blocking basically all other sensible ways of getting the fd
> out.

Ok, but these other ways involve syscalls too (sendmsg() or whatever).
And if you're going to allow arbitrary policy from your users, you
have to be maximally flexible.

> Also, this was meant to show that parts of your initial justification
> for implementing the ptrace() way of getting an fd doesn't really stand.
> And it doesn't really. Even with ptrace() you can get into situations
> where you're not able to get an fd. (see prior threads)

Of course. I guess my point was that we shouldn't design an API that's
impossible to use. I'll drop the notes about sendmsg() from the commit
message.

Tycho
