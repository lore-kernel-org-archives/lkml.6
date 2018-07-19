Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB19BECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F60C2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F60C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbeGSCLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 22:11:20 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:51680 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbeGSCLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 22:11:20 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ffxmE-0007wU-IV; Wed, 18 Jul 2018 19:30:42 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ffxlz-00028y-1L; Wed, 18 Jul 2018 19:30:42 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Howells <dhowells@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
References: <5A7CC3BF-5F4E-4624-A129-4BD0434D0747@amacapital.net>
        <3236C75A-5D74-4BB4-A1EC-06F6E22D810C@amacapital.net>
        <611054C7-D6E8-4C89-958E-3128C9305E1E@amacapital.net>
        <20180712223223.GA28610@thunk.org>
        <CA+55aFw1WyKY+-2dg62M-QT_F0-waCTCrba1DW4dStYz-f_fjA@mail.gmail.com>
        <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
        <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
        <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net>
        <22370.1531293761@warthog.procyon.org.uk>
        <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
        <7002.1531407244@warthog.procyon.org.uk>
        <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com>
        <16699.1531426991@warthog.procyon.org.uk>
        <18233.1531430797@warthog.procyon.org.uk>
        <22105.1531436081@warthog.procyon.org.uk>
        <23894.1531438559@warthog.procyon.org.uk>
        <26064.1531440190@warthog.procyon.org.uk>
        <3429.1531467024@warthog.procyon.org.uk>
Date:   Wed, 18 Jul 2018 20:30:19 -0500
In-Reply-To: <3429.1531467024@warthog.procyon.org.uk> (David Howells's message
        of "Fri, 13 Jul 2018 08:30:24 +0100")
Message-ID: <87o9f4f1w4.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ffxlz-00028y-1L;;;mid=<87o9f4f1w4.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18raZo2qbeltvm9HtK1ksyxPNimAgjxaWM=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Andy Lutomirski <luto@amacapital.net> wrote:
>
>> > Also you can't currently directly create a bind mount from userspace as you
>> > can only bind from another path point - which you may not be able to access
>> > (either by permission failure or because it's not in your mount namespace).
>> > 
>> 
>> Are you trying to preserve the magic bind semantics with the new API?
>
> No, I'm pointing out that you can't emulate this by doing a bind mount from
> userspace if you can't access the thing you're binding from.
>
> Now, we could create a syscall that just picks up an extant superblock using a
> device and attaches it to a mount for you, but that would have to be at least
> partially parameterised - which would be very fs-dependent - so that it can
> know whether or not you're allowed to create another mount to that sb.
>
> What you're talking about is emulating sget() in userspace - when we have to
> do it in the kernel anyway if we still offer mount(2).

I am just going to chime in and say that it is absolutely a problem in
the current mount interface that when I mount a filesystem with fresh
parameters I don't know if it is generates an sget and a new super_block
or if it just increments the refcount on an existing super_block.

It is the kind of problem that is actually security sensitive and has
resulted in a security issue in the current linux kernel with respect to
proc.

So yes we absolutely need to have a clean way of dealing with:

mount /dev/sda3 /tmp
mount /dev/sda3 /mnt

So that the second one is forbidden fails.  And userspace has to do the
equivalent of sget to get a file descriptor it can bind into the mount
namespace.

The deep problem is that the second mount does not parse the mount
options and userspace does not know that.  So userspace thinks it is
getting one kind of mount and in practice it gets another (sometimes
with different security properties).  Those different security
properties are an out and out bug.  Although any kind of different and
unexpected properties can be a problem.

Eric
