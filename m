Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C95C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F9420827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YITLjU7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F9420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeKHBNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:13:18 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:32802 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbeKHBNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:13:18 -0500
Received: by mail-vs1-f66.google.com with SMTP id p74so9687523vsc.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 07:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NTlf3D3T8ljp27byuPiNlEgqSBfRuSKOXj8CzZz2qgk=;
        b=YITLjU7A1VdMoQkNh4hW3oi3Dm7zcs4io4FWkEDbPYKywndL38pPAgtv2znPPLGTHi
         0urwiagm5TRW3bit8xUa0HgQAHC+K0/gaQkrWzd3JLQv/RWX5Ydts2DWDIO/df1TyC4H
         PZtH8gzzMfDckNBAb6q/50xXnePchPvvaZvd5e/LBeGzuIo4S9UZ6StQtbzVMAyvPjlS
         UEw+UxKcjn3GI8Dvd226HGJNg9hppUcqkwC9S6uC17E9f3ff57HSNOKivGcEHQcRX1ZH
         pakMZEgeYNhIfAYN0HUYOK6SCk34yu6AF0K2KwWNvxHSMTNp9G5H8QNAkApQAKhvaAAp
         sQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NTlf3D3T8ljp27byuPiNlEgqSBfRuSKOXj8CzZz2qgk=;
        b=eA1U/Tht8fnXCpMlVo8SJvh4xddhQQzowShSrYCaQayXkUcibfmg2NzJ7mOI09wiy8
         zjlKW0FmX5Zy9+7bDGZCKKobtmdtK+61og1QFWZOPSsCTPv0G5IuiXtHn4ADNty+UIL7
         BHAOqbPljPli49davxnXWj9Lw1xkDmdWXsaVnW8/pTZdLNlQlhA1Uyl8tgVpR/MXWanK
         Xkv+ZCcYpo1EJmuIigCg1xx1p/E3xUx/Agiphjhz2tuEqSeDoMzrk0P0rPHmmpYWSd2s
         cV0dcI2uE0C9PHb0jOL3fhIkDA7F2tXwvmxZzNrgqOMy1/d+Ne4M1tEdrAe3HomLE61b
         5E1A==
X-Gm-Message-State: AGRZ1gIctusbDc/KkU/dDC83Wf54v60oWsHBN+9MhGZb583zuuv1yGXD
        nP48o/8SWtEu0is5sxDf9dk6G+/Gn7S1LEXkQrkg/7/zR1LI5Pt+
X-Google-Smtp-Source: AJdET5fEpiD20uysrf1/O499XgXzSzV3+FDSWU1mRccNW666sQSPqMFwpzdC4AsvPCLj6WC2/KsD/xZdS/R5rspuHiM=
X-Received: by 2002:a67:6e87:: with SMTP id j129mr282776vsc.171.1541605343645;
 Wed, 07 Nov 2018 07:42:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 07:42:22 -0800 (PST)
In-Reply-To: <CAJfpegsdFiM6QWt3VBEDvGdKHfvsvUnm06MC-ha7z_WPTP9znA@mail.gmail.com>
References: <20181029192521.23059-1-dave@stgolabs.net> <CAKOZuevx9beEB-KWz0gRNaJQLfzu0cu7nuMYaB5ZT1O_ooQYAA@mail.gmail.com>
 <20181106154840.3b448356214afa63dc8cb28c@linux-foundation.org> <CAJfpegsdFiM6QWt3VBEDvGdKHfvsvUnm06MC-ha7z_WPTP9znA@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 7 Nov 2018 15:42:22 +0000
Message-ID: <CAKOZueu=zM_HjeET6SBJaP2zHD6+w7K8ewtk6B8C38Gkm4g0LA@mail.gmail.com>
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>, longman@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 10:03 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Wed, Nov 7, 2018 at 12:48 AM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
>> On Mon, 29 Oct 2018 23:04:45 +0000 Daniel Colascione <dancol@google.com> wrote:
>>
>>> On Mon, Oct 29, 2018 at 7:25 PM, Davidlohr Bueso <dave@stgolabs.net> wrote:
>>> > This patch introduces a new /proc/stat2 file that is identical to the
>>> > regular 'stat' except that it zeroes all hard irq statistics. The new
>>> > file is a drop in replacement to stat for users that need performance.
>>>
>>> For a while now, I've been thinking over ways to improve the
>>> performance of collecting various bits of kernel information. I don't
>>> think that a proliferation of special-purpose named bag-of-fields file
>>> variants is the right answer, because even if you add a few info-file
>>> variants, you're still left with a situation where a given file
>>> provides a particular caller with too little or too much information.
>>> I'd much rather move to a model in which userspace *explicitly* tells
>>> the kernel which fields it wants, with the kernel replying with just
>>> those particular fields, maybe in their raw binary representations.
>>> The ASCII-text bag-of-everything files would remain available for
>>> ad-hoc and non-performance critical use, but programs that cared about
>>> performance would have an efficient bypass. One concrete approach is
>>> to let users open up today's proc files and, instead of read(2)ing a
>>> text blob, use an ioctl to retrieve specified and targeted information
>>> of the sort that would normally be encoded in the text blob. Because
>>> callers would open the same file when using either the text or binary
>>> interfaces, little would have to change, and it'd be easy to implement
>>> fallbacks when a particular system doesn't support a particular
>>> fast-path ioctl.
>
> Please.   Sysfs, with the one value per file rule, was created exactly
> for the purpose of eliminating these sort of problems with procfs.  So
> instead of inventing special purpose interfaces for proc, just make
> the info available in sysfs, if not already available.

First of all, is sysfs even right? Some people, for whatever reason,
are extremely particular about the purposes of various virtual
filesystems. "No, sysfs is for exposing kernel objects, not
configuration!" is something I've heard more than once. Who's to say
that sysfs is for exposing /proc/pid/stat, which isn't a "kernel
object" itself? (A process is not its struct task.) More generally,
objections about APIs rooted in arcane kernel-internal considerations
about the purposes of various virtual filesystems --- procfs, sysfs,
debugfs, configfs --- makes the userspace API worse, because it
enshrines implementation details (is this thing a kobject or not?) in
public API. If I had my way, we'd have continued putting *everything*
in procfs and just make procfs the "I want stuff from the kernel" API.
Nobody in userspace cares about these filesystem divisions.

Second, slurping from a sysfs-style setup in which there's one file
per piece of information creates massive overhead, because there's
currently no way to open multiple paths with one system call and no
way to read from multiple FDs with one system call. If you want this
kind of setup to work, you need some kind of batched openat-and-read
system call mechanism. I think a simple "get information from this
procfs FD" system call --- something like statx --- is both cleaner
and more efficient. Plus, without a batch operation, there's no way to
achieve atomicity. It's perfectly reasonable for userspace to request
some bits of information about a process want these bits to be
consistent with each other. Now, such an API would be good to add, but
it's not enough, since a generic batched openat-and-read would still
have to go through VFS, create struct files, (probably) encode to
ASCII, and so on. Why should any system pay to do that much work when
the fields anyone might want could be obtained with a simple
copy_to_user?

Third, and finally, a sysfs-style tree for processes doesn't currently
exist. Would you propose having *two* *different* representations of
the process list as virtual filesystems? That's another pointless
exposure of internal kernel divisions in the user API. We already have
procfs. Let's just make it better.
