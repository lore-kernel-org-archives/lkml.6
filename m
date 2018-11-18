Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E748C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190A620817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IURlL1tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190A620817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeKSEGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 23:06:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbeKSEGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 23:06:25 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F279820869
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 17:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542563132;
        bh=MlYcTA+pxCgRlLmkq7p10271XiJ9hbticyJ1njnyFsQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IURlL1tvEjBqbGeborq7K5QglZ4Wlv0EaaB/ebnCijfgZ167g5ONgZHGjr0qVxday
         7zQ0I99mjgUbu37x+8XTTJpVeeRBEuqUQ+eUlS5bqeemZzzTUkNYOiyW2EwziNixnf
         Bt3IMJKe8GXacD9JYES7ahdEzQ+T4yxU6unS9o/M=
Received: by mail-wm1-f43.google.com with SMTP id s11so3092095wmh.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 09:45:31 -0800 (PST)
X-Gm-Message-State: AA+aEWZQmAVtwEjCyAe+lWpeGjztOwcoZfkSAINsIWvFOEvZGH6uVaEW
        hsfo3VciIYCGXlHQo55P04U8vzywqY6wunIhFT9xlw==
X-Google-Smtp-Source: AJdET5d2h7VKi4CG5DuHDqLhl9nCvGXdRxQ47ppG1zriGIaTeyWGDWElkNryTkn02fZwjl5IQiQsiQ4IBTooQDJNFAU=
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr5018311wmc.74.1542563130440;
 Sun, 18 Nov 2018 09:45:30 -0800 (PST)
MIME-Version: 1.0
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
 <CAKOZuetuuxW+yFnyaqS5kW6gkVMstLa8D-7SgYtrLBUQB+sgDg@mail.gmail.com>
 <CALCETrXNBNcASRtxTL_aO-KSj4ahPRpXKLUdHaWG3sPjsWx3CQ@mail.gmail.com>
 <CAKOZues3_uh1mnQr=VPCxoWiY0wfiUq0oFXcVuiHF7rPmUXsuw@mail.gmail.com> <875zwu46z1.fsf@xmission.com>
In-Reply-To: <875zwu46z1.fsf@xmission.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 18 Nov 2018 09:45:18 -0800
X-Gmail-Original-Message-ID: <CALCETrVKzCy=0xYxRMJkEkT6NsiSyaUv2_U=yBPqXn0sSfL2OQ@mail.gmail.com>
Message-ID: <CALCETrVKzCy=0xYxRMJkEkT6NsiSyaUv2_U=yBPqXn0sSfL2OQ@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 9:43 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Daniel Colascione <dancol@google.com> writes:
>
> > On Sun, Nov 18, 2018 at 9:13 AM, Andy Lutomirski <luto@kernel.org> wrote:
> >> On Sun, Nov 18, 2018 at 8:29 AM Daniel Colascione <dancol@google.com> wrote:
> >>>
> >>> On Sun, Nov 18, 2018 at 8:17 AM, Andy Lutomirski <luto@kernel.org> wrote:
> >>> > On Sun, Nov 18, 2018 at 7:53 AM Daniel Colascione <dancol@google.com> wrote:
> >>> >>
> >>> >> On Sun, Nov 18, 2018 at 7:38 AM, Andy Lutomirski <luto@kernel.org> wrote:
> >>> >> > I fully agree that a more comprehensive, less expensive API for
> >>> >> > managing processes would be nice.  But I also think that this patch
> >>> >> > (using the directory fd and ioctl) is better from a security
> >>> >> > perspective than using a new file in /proc.
> >>> >>
> >>> >> That's an assertion, not an argument. And I'm not opposed to an
> >>> >> operation on the directory FD, now that it's clear Linus has banned
> >>> >> "write(2)-as-a-command" APIs. I just insist that we implement the API
> >>> >> with a system call instead of a less-reliable ioctl due to the
> >>> >> inherent namespace collision issues in ioctl command names.
> >>> >
> >>> > Linus banned it because of bugs iike the ones in the patch.
> >>>
> >>> Maybe: he didn't provide a reason. What's your point?
> >>
> >> My point is that an API that involves a file like /proc/PID/kill is
> >> very tricky to get right.  Here are some considerations:
> >
> > Moot. write(2) for this interface is off the table anyway. The right
> > approach here is a system call that accepts a /proc/pid directory file
> > descriptor, a signal number, and a signal information field (as in
> > sigqueue(2)).
>
> If we did not have the permission check challenges and could perform
> the permission checks in open, write(2) would be on the table.
> Performing write(2) would only be concrend about data.
>
> Unfortunately we have setresuid and exec which make that infeasible
> for the kill operations.

setresuid() should be irrelevant.  If you had permission to kill a
process and the process calls setresuid(), you should still have
permission to kill it.

For execve(), we could make execve() invalidate the fd.  (See other email.)
