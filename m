Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CB3C4161B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408B020868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="MZ8jT/pJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408B020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeK3ImA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:42:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46564 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbeK3ImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:42:00 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so1656234pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 13:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MT1oWujqp+4cAEuTrVxZsei8xOnKPWYUQitNJOOzRuo=;
        b=MZ8jT/pJBbmD2Pc9+YA0R8/oKUIF0gNXmfAGhu4ITq9RVMHeqoKZ87c2AqU8ogm543
         4YqFsRzJfllOM6l2CC1Q1OAm0nXBsT1YCp1aIr59fTpuAO86W1jUB7k5MF85Pz0jPaOO
         gy/2kgjigQaycv6JQAVUCdddyuBMURSesZqd8MVpsCVwePV58fLdWg+T6b7mXZF8g+L8
         w4C3NmaNbyCDAR2tjkA8dEOphoPE31s/T/OuVs9+iGyf3a82Lux74Ct53NqGoK2myMvi
         +wXxpiQy21aK23OSm2xZwZSF+OnWihj2EHGvg0N62MN0MOdI95oBnreo/CY18lHTfdPz
         T41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MT1oWujqp+4cAEuTrVxZsei8xOnKPWYUQitNJOOzRuo=;
        b=AOy79EvnlpMIFTJx4QMAva0vMOvwRa3Ny+B+j0dBX+9b3gw3t9QoTX0ZI+A6Gq6WZS
         S4Tdd1LIHZn7wPyPYf9Me8Vq+89lLwHzr2J3eWDyitvN/CcHuJc4RwuTn58bRwRqqPcD
         tzNpImQYIxnj7dW/MZmbqmDfm7xQTUS+2EMavRr60qj/SzPROkSDyU6KIgqBKGnZboK2
         aMO6YEn2/P6s7cmtfuM8zsLFa7Lr/ECNcuvfOH3ZuZVNCQj7yPfmPct+XBXJBdoHCllj
         uZTwS/5dw42cdO++MXDbWhktQPW+HDqwh3ietbqwiZsRpAjgnknlNKZ3UmpUAp7mfHmB
         UlGA==
X-Gm-Message-State: AA+aEWaGdmTvx4OTCik8JpJ0modVRV3BrcRAQ1lJ8ouqm7A/Av0q7y41
        3QQRf6sC9Z0ej4wLpMdp5CcxUg==
X-Google-Smtp-Source: AFSGD/WOubS2EoXMKz5CJWngiPuqDkPAfF1Gd3SkGfcnTtTEZztUKI2o2TyZx9ILFsYn7amYIcb2yg==
X-Received: by 2002:a63:1a4b:: with SMTP id a11mr2656833pgm.254.1543527310737;
        Thu, 29 Nov 2018 13:35:10 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:ad2e:14cc:5849:819])
        by smtp.gmail.com with ESMTPSA id d3sm3681789pgl.64.2018.11.29.13.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 13:35:09 -0800 (PST)
Date:   Thu, 29 Nov 2018 22:35:00 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
Message-ID: <20181129213458.4h44dpg6ltqow4k4@brauner.io>
References: <20181120105124.14733-1-christian@brauner.io>
 <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net>
 <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
 <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
 <20181129195551.woe2bl3z3yaysqb6@brauner.io>
 <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
 <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:02:13PM +0100, Arnd Bergmann wrote:
> On Thu, Nov 29, 2018 at 9:14 PM Andy Lutomirski <luto@amacapital.net> wrote:
> > > On Nov 29, 2018, at 11:55 AM, Christian Brauner <christian@brauner.io> wrote:
> > >> On Thu, Nov 29, 2018 at 11:22:58AM -0800, Andy Lutomirski wrote:
> > >>> On Thu, Nov 29, 2018 at 11:17 AM Christian Brauner <christian@brauner.io> wrote:
> > >>>> On November 30, 2018 5:54:18 AM GMT+13:00, Andy Lutomirski <luto@amacapital.net> wrote:
> > >>
> > >> The #1 fix would add a copy_siginfo_from_user64() or similar.
> > >
> > > Thanks very much! That all helped a bunch already! I'll try to go the
> > > copy_siginfo_from_user64() way first and see if I can make this work. If
> > > we do this I would however only want to use it for the new syscall first
> > > and not change all other signal syscalls over to it too. I'd rather keep
> > > this patchset focussed and small and do such conversions caused by the
> > > new approach later. Does that sound reasonable?
> >
> > Absolutely. I don’t think we can change old syscalls — the ABI is set in stone.
> > But for new syscalls, I think the always-64-bit behavior makes sense.
> 
> It looks like we already have a 'struct signalfd_siginfo' that is defined in a
> sane architecture-independent way, so I'd suggest we use that.

Just so that I understand you correctly: swapping out struct signinfo
for struct signalfd_siginfo in procfd_<whatever-suffix>? If so that
sounds great to me!

> 
> We may then also want to make sure that any system call that takes a
> siginfo has a replacement that takes a signalfd_siginfo, and that this
> replacement can be used to implement the old version purely in
> user space.

Sounds good but is unrelated to this patchset I take it. :)

> 
> Is the current procfd_signal() proposal (under whichever name) sufficient
> to correctly implement both sys_rt_sigqueueinfo() and sys_rt_tgsigqueueinfo()?

Yes, I see no reason why not. My idea is to extend it - after we have a
basic version in - to also work with:
/proc/<pid>/task/<tid>
If I'm not mistaken this should be sufficient to get rt_tgsigqueueinfo.
The thread will be uniquely identified by the tid descriptor and no
combination of /proc/<pid> and /proc/<pid>/task/<tid> is needed. Does
that sound reasonable?

> Can we implement sys_rt_sigtimedwait() based on signalfd()?
> If yes, that would leave waitid(), which already needs a replacement
> for y2038, and that should then also return a signalfd_siginfo.
> My current preference for waitid() would be to do a version that
> closely resembles the current interface, but takes a signalfd_siginfo
> and a __kernel_timespec based rusage replacement (possibly
> two of them to let us map wait6), but does not operate on procfd or
> take a signal mask. That would require yet another syscall, but I
> don't think I can do that before we want to have the set of y2038
> safe syscalls.

All sounds reasonable to me but that's not a blocker for the current
syscall though, is it?

Christian
