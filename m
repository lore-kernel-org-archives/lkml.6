Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DC3C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC1E214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="VEzklw7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC1E214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJIXrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:47:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43664 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeJIXrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:47:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id 30-v6so1077191plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RNstUzfEbz55EHxXYMN4aHHdg69U4mVv+Cd5JPL43Ic=;
        b=VEzklw7/zS5eC4TEvXYSARE6mzfWv72nr+sM9CrMEuphdQsX2LxhgHXWUt5UtM7/Ty
         /wgMmHtKQuIkKLwgkmQTptROuCQqax619VBy06rbIPLVb6xDb4+xnA9ONqWNzM9BUtW/
         Y3VIlxnuY5SAIBJ0Qo/nuCCWjfoGYBYeME37nlrXuw0V2+5Gs7k37F3MHo6jmEK2Gw9n
         ilV+5bZCafLU8bJJQuCzX4bcwJFTCe0ZZ9joh3kxunTo+GUIFqfVjLWi+Kks1nXTTjTT
         e7gqJj5MB30jIa6efGdkDO+mKPKNNAVOSEqd4wYTu0e3ajmnTfjdZ6xvXtIf0MuvY18f
         +Nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RNstUzfEbz55EHxXYMN4aHHdg69U4mVv+Cd5JPL43Ic=;
        b=iZL+mz5QhC1Pet45FQkeWzZgyu+h/hOnXteDY6jnh5M3PLT7pBOwYylb4VH7XrHCR7
         Okz3xSm3TAFn9lANOd5SduUezDlWBBtlf732rV0X46Kn5w3ewupbr/FCqItoWykIPp84
         9Q7p3VBAYNuShrzBCLwCYaWNYC4omnYPOL8edt5U+sq1WjGVLGZi4u3zRzKf5jpxfiJM
         AgMFc5jNWBYUnVHdqlWtFnWbeG1ADDWEJhTwJap5igY22ZAbq32rSu6pswRgUsnthdUN
         wOxTXfp2n3jWXljVDDtfYdv2FQ+4wxIEDwn4x1c1T6kVz/BqXpqCoXxu1YRnrjlabA0i
         4S7Q==
X-Gm-Message-State: ABuFfoin4bRhSqcrSvHlV3YpAqj4Cci+T+xjv20kk0Hlgz6U8c744mVc
        0387cmgGB4qnbxOLRfadAqH2vQ==
X-Google-Smtp-Source: ACcGV63kBujDi9Pc+MxsLsv1X/suJgSdGelh7PbG3MDAeWW9QKhCnWdY8pdnHk92qL4HVyCGqPV/ww==
X-Received: by 2002:a17:902:24a5:: with SMTP id w34-v6mr9546907pla.73.1539102563837;
        Tue, 09 Oct 2018 09:29:23 -0700 (PDT)
Received: from cisco ([2001:420:28e:1260:c7c:88c5:50e7:459f])
        by smtp.gmail.com with ESMTPSA id f25-v6sm25090803pfn.177.2018.10.09.09.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:29:22 -0700 (PDT)
Date:   Tue, 9 Oct 2018 09:29:21 -0700
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
Message-ID: <20181009162921.GC10149@cisco>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-2-tycho@tycho.ws>
 <CAGXu5jJr3JWLYGrJ+knu3sj4wwJ_irVvs+JRrY5MuYT3voLegg@mail.gmail.com>
 <20180927224839.GF15491@cisco.cisco.com>
 <20181008145803.ycawjwhc3mwkdogf@brauner.io>
 <20181009142833.GA10149@cisco>
 <20181009162413.sry5hnplvvpjggd4@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009162413.sry5hnplvvpjggd4@brauner.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 06:24:14PM +0200, Christian Brauner wrote:
> On Tue, Oct 09, 2018 at 07:28:33AM -0700, Tycho Andersen wrote:
> > On Mon, Oct 08, 2018 at 04:58:05PM +0200, Christian Brauner wrote:
> > > On Thu, Sep 27, 2018 at 04:48:39PM -0600, Tycho Andersen wrote:
> > > > On Thu, Sep 27, 2018 at 02:31:24PM -0700, Kees Cook wrote:
> > > > > I have to say, I'm vaguely nervous about changing the semantics here
> > > > > for passing back the fd as the return code from the seccomp() syscall.
> > > > > Alternatives seem less appealing, though: changing the meaning of the
> > > > > uargs parameter when SECCOMP_FILTER_FLAG_NEW_LISTENER is set, for
> > > > > example. Hmm.
> > > > 
> > > > From my perspective we can drop this whole thing. The only thing I'll
> > > > ever use is the ptrace version. Someone at some point (I don't
> > > > remember who, maybe stgraber) suggested this version would be useful
> > > > as well.
> > > 
> > > So I think we want to have the ability to get an fd via seccomp().
> > > Especially, if we all we worry about are weird semantics. When we
> > > discussed this we knew the whole patchset was going to be weird. :)
> > > 
> > > This is a seccomp feature so seccomp should - if feasible - equip you
> > > with everything to use it in a meaningful way without having to go
> > > through a different kernel api. I know ptrace and seccomp are
> > > already connected but I still find this cleaner. :)
> > > 
> > > Another thing is that the container itself might be traced for some
> > > reason while you still might want to get an fd out.
> > 
> > Sure, I don't see the problem here.
> 
> How'd you to PTRACE_ATTACH in that case?

Oh, you mean if someone has *ptrace*'d the task, and a third party
wants to get a seccomp fd? I think "too bad" is the answer; I don't
really mind not supporting this case.

> Anyway, the whole point is as we've discusses in the other thread we
> really want a one-syscall-only, purely-seccomp() based way of getting
> the fd. There are multiple options to get the fd even when you block
> sendmsg()/socket() whatever and there's no good reason to only be able
> to get the fd via a three-syscall-ptrace dance. :)

Ok, I'll leave these bits in then for v8.

Tycho
