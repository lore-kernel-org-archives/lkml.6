Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F66DC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBF32084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBF32084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeJDVvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:51:09 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:34013 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeJDVvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:51:09 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g854C-0006VT-OE; Thu, 04 Oct 2018 08:57:28 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g854B-0001Kp-7F; Thu, 04 Oct 2018 08:57:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Pavel Snajdr <snajpa@snajpa.net>
Cc:     michaeljpwoods@gmail.com, linux-kernel@vger.kernel.org
References: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
        <93424bb0-180e-71ff-f0d6-602caa2d5883@gmail.com>
        <260205ec45d097fb037f71ae42e7b69e@snajpa.net>
Date:   Thu, 04 Oct 2018 16:57:19 +0200
In-Reply-To: <260205ec45d097fb037f71ae42e7b69e@snajpa.net> (Pavel Snajdr's
        message of "Tue, 18 Sep 2018 03:30:38 +0200")
Message-ID: <87murtg3ow.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g854B-0001Kp-7F;;;mid=<87murtg3ow.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18xM1Vq0FKUABGO4gjnTY0rd9EvDfVrtGc=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Snajdr <snajpa@snajpa.net> writes:
>
> We started our organization (vpsFree.org) on top of OpenVZ patch set and are now
> working to get vanilla up to the task of replacing the venerable 2.6.32-based
> OpenVZ 6 Linux-like thing. The new Code of Conduct is a guarantee for us, that
> we won't be laughed out of the room  and that our members won't be demotivated
> to contribute upstream - if we can all agree to be nice on each other; yet we
> still need you guys to tell us, when we're trying stupid things or going about
> things the wrong way, in some way that we will notice & can learn from.
> If I understand the context correctly, the previous "regime" could be the
> culprit, at least to some extent, why still don't have the VM look&feel-having
> containers with vanilla.

At an implementation level namespaces and cgroups are hard.  Coming up
with a good solid design that is very maintainable and handles all of
the corner cases is difficult.  Very few people choose to do the work
of digging into the details and figuring out what is really needed.

This is not an area where you can hand hold someone.  It really takes
people who are able to work out from first principles what the code will
need to do.

Very often people will propose patches that do solve their specific case
but only do 10% or maybe 20% of what is needed for a general kernel
level solution.  For something that just works and does not cause
maintenance problems in the long run.

Someone has to deep dive and understand all of the problems and sort it
out.

That takes a person that is willing and able to stand up with all of the
rest of the kernel developers as an equal.   It requires listening to
other opinions to see where you need to change and where things are
wrong but it also requires being able to figure things out for yourself
and to come up with solid technical contributions.

I hope I have been something reasonable to work with on this front, if
not please let me know.

I know many other maintainers get hit with such a stream of bad
container ideas that they tend to stop listening.  As their priorities
are elsewhere I don't blame them.

Also don't forget that most of the time to do a good implemenation that it
requires rewriting an entire subsystem to make it container friendly.
Think of the effort that requires, especially when you are not allowed
to cause regressions in the subystem while rewriting it.

Further the only power a maintainer has is to accept patches, to listen
to people, and to express opinions that are worth listening to.  In the
midst of doing all of those things a maintainers time is limited.

You said a change in attitude gives you optimism that you can make work
with the upstream kernel.  I am glad you have optimism as overall the
kernel is a welcoming place.

At the same time there can't be guarantees that people won't be
demontivated.  If you care about the remaining kernel problems for
implementing containers, you need to realize those that are difficult
problems that don't easily admit to solutions.  That is why the problems
still remain.  To get a small flavor just look at how much work I had to
go through to sort out siginfo in the kernel which is just one very
small piece of the larger puzzle.  So please realize that sometimes
actually realizing the scope of the technical difficulties might be
demotivating in and of itself.

Similarly because maintainers have a limited amount of time there are no
guarantees how much we can help others.  We can try but people have to
meet maintainers at least half way in figuring out how things work
themselves, and sometimes there is just not enough time to say anything.
As the old saying goes: "You can lead a horse to water but you can't make
him drink".

So there are no guarantees that people won't be demotivated or that they
will learn what is necessary.  All that we can do is aim to keep
conversations polite and focused on the technical details of the project.
Which should keep things from getting unpleasant at the level of humans
interacting with humans.  I don't think that will give you greater
guarantees beyond that, and it feels like you are reading greater
guarantees into recent events.

I would like to see what you see as missing from the mainline
kernel.  But that is a topic for the containers list, and possibly for
the containers track at Linux Plumbers conference in Vancouver.

Eric
