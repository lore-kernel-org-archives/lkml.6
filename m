Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FE8C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F93E2082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bU4rDGlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F93E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeJ3JAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 05:00:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38698 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeJ3JAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 05:00:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2-v6so4145982wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 17:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q0hLaPzmf+ORYNB37gqW9keNyCCW9t+vs6KNdhEmkxc=;
        b=bU4rDGlCB82LW8cSBjjSrc1a7bficEh97x3GBnXV3eX1csJqmQTYDa0UADPAzo0GiR
         rpBKu22ldK+swxyJHWhkEiUdg1BJO4PL8GT3D13bFCreEvldiV19bnucQ9P76WavflHP
         ihHRfb5s+2JCPMDZXlvI5YJySJS5bVXYnpK6BazrAEEEj3eqcgVsPxZbymVjt8P2mj1u
         747G4LUJ/ID/SkE82HsBQNvRAQSGPquZMWJVZBMsqXCErjEXUSs+mtXX935ShImxvcGE
         bn5lv/+P+SBPe9pKlici4gyWaTSRbuq6mwslAPKGKwxI3fwbD5vJGHEl2D638i/EU2Sz
         +9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q0hLaPzmf+ORYNB37gqW9keNyCCW9t+vs6KNdhEmkxc=;
        b=DuLUElgO06FCvgRe92eLuUgwAGJcNdbDWFEAweN7mLfrcLTB2Tpw3lVP8cZ0fFCtB0
         sCjXjUtNM6Plx0soLFYDvW0kV2pujDm7sUF8j45LeEX3MbqCCnBUD8xalIoqK34vQUcN
         HOvbCEAZoW4oIE3vg8LkQjUZKQjCozulXw1Z8szRNHSYtgPevnTUH24Y8NP4V/zry4sE
         x502XdpVbeZ+SFY/Ir/PKyAbNKRRu4cwksMqqLEG/+sQDIiJVQ2qTWy1bU/C6Z08CPGC
         3N8ODwCxrHJWiFhJp+wwqVnxOo8MGAfup6DyRDA96erVNKdxRJxxihEAwapP+4jC3qRw
         6ZoA==
X-Gm-Message-State: AGRZ1gJRLTKDWHh7+z/GkawUpVsx9Nu3FloZIRnSTZ86M9PMACOc0l/J
        p/jVq5/ao+1wEzzzBrpfFuvXVGM=
X-Google-Smtp-Source: AJdET5eMtkqabm7LuenRSAJvumeS0uZCVEx3tQyvJkhQmOfZMONq3RKNK5BcLEx7jwIOtrTlXeAjFg==
X-Received: by 2002:a1c:9355:: with SMTP id v82-v6mr15193721wmd.128.1540858146828;
        Mon, 29 Oct 2018 17:09:06 -0700 (PDT)
Received: from avx2 (nat5-minsk-pool-46-53-217-92.telecom.by. [46.53.217.92])
        by smtp.gmail.com with ESMTPSA id q185-v6sm5708048wmg.45.2018.10.29.17.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 17:09:06 -0700 (PDT)
Date:   Tue, 30 Oct 2018 03:09:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] fs/proc: introduce /proc/stat2 file
Message-ID: <20181030000903.GA30495@avx2>
References: <20181029233414.GA29750@avx2>
 <CAKOZuetMT0uC7MaYF6_meq+jX=4A1Lz5gpUsBZZUQd8WyHYosQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZuetMT0uC7MaYF6_meq+jX=4A1Lz5gpUsBZZUQd8WyHYosQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:40:47PM +0000, Daniel Colascione wrote:
> On Mon, Oct 29, 2018 at 11:34 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >> I'd much rather move to a model in which userspace *explicitly* tells
> >> the kernel which fields it wants, with the kernel replying with just
> >> those particular fields, maybe in their raw binary representations.
> >> The ASCII-text bag-of-everything files would remain available for
> >> ad-hoc and non-performance critical use, but programs that cared about
> >> performance would have an efficient bypass. One concrete approach is
> >> to let users open up today's proc files and, instead of read(2)ing a
> >> text blob, use an ioctl to retrieve specified and targeted information
> >> of the sort that would normally be encoded in the text blob. Because
> >> callers would open the same file when using either the text or binary
> >> interfaces, little would have to change, and it'd be easy to implement
> >> fallbacks when a particular system doesn't support a particular
> >> fast-path ioctl.
> >
> > You've just reinvented systems calls.
> 
> I don't know why you say so. There are important benefits that come
> from using an ioctl on a proc file FD instead of a plain system call.
> Procfs files have file permissions,auditing, SCM_RIGHTS-ability, PID
> race immunity, and other things that you wouldn't get from a plain
> "get this information about this PID" system call.

This whole thread started because /proc/stat is slow and every number in
/proc/stat is system global.

If you continue adding stuff to /proc, one day someone will notice that
core VFS adds considerable overhead, at this point there is nothing
anyone could do.

I'd strongly advise to look at what this DB actually needs and deliver
just that.

Very little of other things apply to /proc/stat:
* system call auditing exists,
* /proc/stat is world readable and continues to be so,
* thus passing descriptor around is pretty useless,
* $PID race doesn't apply.

Additionally passing descriptors feels like party trick.
I suspect that's not how people use statistics in /proc: they run
processes and one priviledged enough monitoring daemon collects data,
otherwise userspace needs to cooperate with monitoring userspace
which of course doesn't happen.

PID race is solved by giving out descriptors which pin "struct pid".
Which is how the race is solved currently: dentry pins inode, inode
pins "struct pid".
