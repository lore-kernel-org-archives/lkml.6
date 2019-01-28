Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484E7C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DA72175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="XYwiYgro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfA1WBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:01:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44380 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfA1WBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:01:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so15653819lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 14:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LoHgW2d3BE6j6Tu6n40ERwtLyjY1HPYWgpEU7vefcGM=;
        b=XYwiYgrouLKXOq762t0nxAy9pVxuAW/+JCz3QhmmM6Y9XQQHBZmwZNvpT/hsDPZqKh
         xAwVEICnmaOduGl0vTYlQWrozwdOfywXK3/ZaI4v7fWWHifPHgX5pq74/qy04pyJZwyC
         tA1PvZUTOI7fo+4KSG0A3F6N7AaJRyLhF6Sodya4IFhr4pl8bzTm4y/bJLa/ONoPABLp
         20TVPAvp2/oSy3bI+ybiG9YAwLuZxudMMu0FnD2mln4cO4Bq/F0Mh/AiIihNXBlniLlm
         zmI+eQspN4a2hm57OvLb/KnFTo9NuzIEqw35EmIkhTs+sIKKhahpsO2uPGfD/mb27cJC
         vEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LoHgW2d3BE6j6Tu6n40ERwtLyjY1HPYWgpEU7vefcGM=;
        b=VOXBv0vWYOetaPMblecmZDUvN46LzxQPGJk0H5TqoXzoCdiFly4mE8+UqN9o3id7o+
         508Zxhl0QwGeuIZfK4OibJTjii/xpEcklyMc7zIBAWTc7p2tbgfwByO3rvP3BGT5FOew
         nukDXV1jOeZztFA0xhd+Jdtf2yzQZ4fLi3IKCooLQS4NCBPUrzoJMEuuXSOTo9fP9jKw
         XuDB9uQJPVTjdFJTe7REMt9bgUexyqhNl1GHLZ14QyQp7zBx+ssikvl2R3j3QB0+PI5y
         L8hS19g2u1/OxgWXFv6d+5W8Y+UJbrRkPIdmhgWxfCd9imlN5Gk7D9rqsmXMzPcDXChp
         nwwg==
X-Gm-Message-State: AHQUAuawQXRzQwLbIRLpV4JX7zKcpZAhtNAKPhAoSXN9pw/mKx7CyN1L
        RC/jGebENpNuYQmRJABjhEwJejhBa/kFBVdkRLss
X-Google-Smtp-Source: AHgI3IZPpimrLazB2k+U5QN8n0NGb5o2KLEA323wK9hoMXdUyS5WgxZu1yW7OZIwhTD9UjNG7s4ufx5ZBLlECALpU3A=
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr4242210ljj.95.1548712902143;
 Mon, 28 Jan 2019 14:01:42 -0800 (PST)
MIME-Version: 1.0
References: <20151208164237.15736.42955.stgit@localhost> <5490ae28-251b-bfda-38a6-5be201a4a8d8@nokia.com>
 <CAHC9VhQsVFY1LAakAUUCBZw6nmSy0-eoFrhQgVQrkqgAsWVGhQ@mail.gmail.com>
 <4fb6def1-a1d9-8af0-394c-f92224884d18@nokia.com> <CAHC9VhT1T4wTonW_L8CH2j1aMqSaBcUf-zH==233+ZZvSKhkwg@mail.gmail.com>
 <8bf5d613-9b27-381d-283b-c8892483f424@nokia.com> <CAHC9VhR25UdWPSRurefEX3YjM80DEh5BXETvK4na3Ym+k2=9xQ@mail.gmail.com>
 <20190128210328.64b7719c@ivy-bridge> <CAHC9VhSCFiEfzcwwkDdMsyh0xa2zh-WDTbv55tsDXYU4Td0zDQ@mail.gmail.com>
 <20190128221951.57a5e03b@ivy-bridge>
In-Reply-To: <20190128221951.57a5e03b@ivy-bridge>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Jan 2019 17:01:30 -0500
Message-ID: <CAHC9VhT0_aPUk+QOD4hgp-kQ3Uu596ifF0hOTDwDyZZZe-F+bQ@mail.gmail.com>
Subject: Re: [PATCH] audit: always enable syscall auditing when supported and
 audit is enabled
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Richard Guy Briggs <rbriggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 4:20 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Mon, 28 Jan 2019 15:08:56 -0500
> Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Jan 28, 2019 at 3:03 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > > On Mon, 28 Jan 2019 11:26:51 -0500
> > > Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > > On Mon, Jan 28, 2019 at 10:38 AM Sverdlin, Alexander (Nokia -
> > > > DE/Ulm) <alexander.sverdlin@nokia.com> wrote:
> > > > > Hello Paul,
> > > > >
> > > > > On 28/01/2019 15:52, Paul Moore wrote:
> > > > > >>>>> time also enables syscall auditing; this patch simplifies
> > > > > >>>>> the Kconfig menus by removing the option to disable
> > > > > >>>>> syscall auditing when audit is selected and the target
> > > > > >>>>> arch supports it.
> > > > > >>>>>
> > > > > >>>>> Signed-off-by: Paul Moore <pmoore@redhat.com>
> > > > > >>>> this patch is responsible for massive performance
> > > > > >>>> degradation for those who used only
> > > > > >>>> CONFIG_SECURITY_APPARMOR.
> > > > > >>>>
> > > > > >>>> And the numbers are, take the following test for instance:
> > > > > >>>>
> > > > > >>>> dd if=/dev/zero of=/dev/null count=2M
> > > > > >>>>
> > > > > >>>> ARM64:      500MB/s -> 350MB/s
> > > > > >>>> ARM:        400MB/s -> 300MB/s
> > > > > >>> Hi there.
> > > > > >>>
> > > > > >>> Out of curiosity, what kernel/distribution are you running,
> > > > > >>> or is this a custom kernel compile?  Can you also share the
> > > > > >>> output of 'auditctl
> > > > > >> This test was carried out with Linux 4.9. Custom built.
> > > > > > I suspected that was the case, thanks.
> > > > > >
> > > > > >>> -l' from your system?  The general approach taken by
> > > > > >>> everyone to turn-off the per-syscall audit overhead is to
> > > > > >>> add the "-a never,task" rule to their audit configuration:
> > > > > >>>
> > > > > >>>  # auditctl -a never,task
> > > > > >>>
> > > > > >>> If you are using Fedora/CentOS/RHEL, or a similarly
> > > > > >>> configured system,
> > > > > >> This is an embedded distribution. We are not using auditctl
> > > > > >> or any other audit-related user-space packages.
> > > > > >>
> > > > > >>> you can find this configuration in
> > > > > >>> the /etc/audit/audit.rules file (be warned, that file is
> > > > > >>> automatically generated based on /etc/audit/rules.d).
> > > > > >> I suppose in this case rule list must be empty. Is there a
> > > > > >> way to check this without extra user-space packages?
> > > > > > Yes, unless you are loading rules through some other method I
> > > > > > would expect that your audit rule list is empty.
> > > > > >
> > > > > > I'm not aware of any other tools besides auditctl to load
> > > > > > audit rules into the kernel, although I haven't ever had a
> > > > > > need for another tool so I haven't looked very hard.  If you
> > > > > > didn't want to bring auditctl into your distribution, I
> > > > > > expect it would be a rather trivial task to create a small
> > > > > > tool to load a single "-a never,task" into the kernel.
> > > > >
> > > > > I've done a quick test on my x86_64 PC and got the following
> > > > > results:
> > > >
> > > > ...
> > > >
> > > > > Which brings me to an idea, that the subject patch should have
> > > > > been accompanied by a default "never,task" rule inside the
> > > > > kernel, otherwise you require an extra user-space package
> > > > > (audit) just to bring Linux 4.5+ to 4.4 performance levels.
> > > >
> > > > [NOTE: I dropped pmoore@redhat.com from the To/CC line, I left
> > > > Red Hat for greener pastures several months ago.]
> > > >
> > > > Well, it generally hasn't been an issue as 1) most people that
> > > > enable audit also enable syscall auditing and 2) most people that
> > > > enable audit have some sort of audit userspace tools to work with
> > > > the audit logs (and configure audit if necessary).  I don't want
> > > > to diminish your report, but this change was made several years
> > > > ago and we really haven't heard of many issues surrounding the
> > > > change.  If we can ever get all of the different arches to
> > > > support syscall auditing, I'd love to get rid of the syscall
> > > > auditing Kconfig knob entirely.
> > > >
> > > > If you wanted to put together a patch that added a single "-a
> > > > never,task" rule on boot I could get behind that, just make it
> > > > default to off.
> > >
> > > That will make processes unauditable for everyone. That's how it
> > > gets a speedup is not entering into the audit machinery.
> >
> > That is pretty much what is being asked for in this thread.  It's
> > really no different from what Fedora/CentOS/RHEL (and who knows how
> > many others) ship with their default audit config.  It's important to
> > note that you could always delete this rule at runtime; all that is
> > being proposed is to have the kernel populate the the audit ruleset
> > with the "-a never,task" rule *IF* the proposed kernel Kconfig option
> > is enabled (and it would default to being off, you would have to turn
> > it on during build).
>
> Yes, but you can't add the auditable flag back to the task struct
> because syscalls never enter audit machinery where it can be added back.
> Meaning that even if you wanted to audit, there will be processes you
> never can audit. Whereas deciding via auditd, they become unauditable
> only after auditd loads the rule. Prior to that they are and all
> processes are auditable if you decide to audit. So, this is
> fundamentally different than what fedora does.

What I'm suggesting is adding an audit rule, just like Fedora, the
only difference is that it is going to be populated at boot by the
kernel.  Sure, it is going to happen earlier than if you use auditctl
during boot, but arguably if you want to disable all the syscall
auditing, this is what you want.  Calling it fundamentally different
from what Fedora does is not correct.

For the record, this is something I would only recommend for a limited
number of use cases (e.g. limited embedded environments with no need
for syscall auditing), as for most users it is better to install a
proper audit userspace and just configure it with auditctl during
boot.

-- 
paul moore
www.paul-moore.com
