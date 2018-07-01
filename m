Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318C4C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 02:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE121252F0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 02:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DL4gH9j0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE121252F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeGACTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 22:19:12 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39343 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbeGACTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 22:19:10 -0400
Received: by mail-it0-f66.google.com with SMTP id p185-v6so7815567itp.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 19:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uphgE2D/2LmZzOr9Xn+cxWl6tl64MLETYGAzCovZolk=;
        b=DL4gH9j0zCsYYmYw21aW/eJsX0kmiPp/5W9U7IR8yetryRCzWYK7noMGyXac04xq7D
         bVdcO3q63W7HYMkhvIFLTwkbPGGbEXMYHpq/MMuyH5WlLNRzMRixrS5W9fPUF24oQVWB
         KGF1ptPhitFUGiTwDSWHAYEp2clg2AYRLzwnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uphgE2D/2LmZzOr9Xn+cxWl6tl64MLETYGAzCovZolk=;
        b=VwvsMH8i7ssAzVM2yudZzenPfvEO4WzvJ1VRWDr2n5jzY1uZNTTCfzAQQRSbSk/sem
         54vhHViU6w8T1QCkYuwX3tgG6lu0pNZBScWr0rguFLL588vLhALHIj7U8+xaFwobEU+v
         6DyNO4lNddgcfURNPlBGVAxHGp3NKBEew5QZOxxsOoGA3aDLzWbALVNOVzvfSyYgxCK8
         fGrCTFknEVeE9dbHKOBOl4+aFOi2fGog4MvuRK0cZcyf2qbMK/s7YgRHi6Gl2zSsYRyt
         LFcHNX3xgsuc+lLC4NKVsADbTCmj4HfK70VfkECmOORI7Y+jZyIXo/j3Kjru6WrgHocl
         ledw==
X-Gm-Message-State: APt69E3PjvXQGby/b+EXrqgxkt42AoqFxsmBOwBPD40UxmCGRtpb9ggK
        FmJiHrrEmu1iZJ5JEZW23rP3ofzqSg6QuBwnMNc=
X-Google-Smtp-Source: AAOMgpf5wiIobb8nGXskYdE0n1cje3EhsFuYrM5qD1qXtzYWO/lLPDUp76DD6CIb5opIZ5h9IOJldJmUq+OPBreILZU=
X-Received: by 2002:a02:664b:: with SMTP id l11-v6mr17260241jaf.70.1530411549709;
 Sat, 30 Jun 2018 19:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
 <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
 <edc7b03b9550ddcf1291ebf5a6dafd24f4455c23.camel@kernel.crashing.org>
 <CA+55aFxS7OVEN5XrxceC5ibz780mhn-qRa50w1gVFjsz2JjMbw@mail.gmail.com>
 <7eb06b499f2be366cf68c6b6588b16c603e6a567.camel@kernel.crashing.org> <CA+55aFyS1bdmETHUYEejecOcG5MAjGCAbkr-M5iphJYfrj2oLA@mail.gmail.com>
In-Reply-To: <CA+55aFyS1bdmETHUYEejecOcG5MAjGCAbkr-M5iphJYfrj2oLA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Jun 2018 19:18:58 -0700
Message-ID: <CA+55aFwwzF-PeS02x-9FFSQdPpJgmaEtC8KNfG_U_DTbSXz+-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 7:07 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Those locks won't protect kobj races in _general_ (ie there is no
> locking between two totally unrelated buses), but they *should*
> serialize the case of a device being added within one class. No?

Side note: there had *better* be some locking whenever there is a way
to find an object, because otherwise you have a fundamental lifetime
problem: one thread finding the object at the same time another thread
frees it for the last time. Even the "unless_zero()" won't fix it,
because the final free will release the underlying object itself, so
the "zero" state is ephemeral.

That locking might be just RCU during lookup, and rcu-delaying the
release, of course.  I think that's all the sysfs code needs, for
example, since that's what lookup uses.

And for any other embedded kobj cases, where you can reach the object
using some random subsystem pointers, there had better be other
locking in place for that pointer lookup vs the last removal.

kobject itself doesn't provide that locking, it only provides the
reference counting. But that's partly why it really has to disallow
any kobject_get() of a zero object, because it means that the
tear-down has been started, but the tear-down itself may not have had
time to get the lock yet (ie kobject_release() may be just about to
call the t->release() function).

But maybe I'm missing something subtle.

               Linus
