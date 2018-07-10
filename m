Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C59C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A47208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gu0CLpYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A47208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389262AbeGJSe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:34:28 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41883 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388417AbeGJSe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:34:27 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so44496996oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5bU7K8A9ysMbOaQWCxJWzy2fhbFNCOm2wbDzpv/hOc=;
        b=Gu0CLpYn4zG8wzSp+f3y3iV1ZPaYhO/XtePvSBRZaHxB8VhZlJvejiKUUyAiAWw0wV
         nXAoFDfuvgs0S0DQP+Auo/2mNLwlbxA8CJfeN4cx6JpQPxQyu93Q2jPmMv8BXqdvYVu8
         8+y2zKNzAJcAf58wzvJpekOQX87MDU5rytYmmgb1yOZ97VQzQ/8t0bJoxUD4gC+jpNQe
         yoU8pThsaH53xFxWR8OMzagh2gqBdOloRyfF/leTnsjEGS9Ij4/1WopthcmZhemWuPR6
         MzZr1hGGCYuYdQaC/6JDnVVgy1kN+bX28ejvhsabLtHz3XIne90uJWQq2oY/MI4o6PMB
         ttRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5bU7K8A9ysMbOaQWCxJWzy2fhbFNCOm2wbDzpv/hOc=;
        b=s3C527+Z/2dqNIo//BYoYk2+u7njVqlYHA8Zwng6xYDrQmZ56m0i7xEkYmZRPtt6rc
         9p58aRSi6Wnvs/tNXhgCsT0sjdElh29lmNT275m6h7tgLa2la/WnEURVMKh0ns5gjjs6
         dm3qL1zZB2yt1/EEJ9qaoA/FlxgvpFxvFPBkWm8EafnZHu73/t2LSbJNUNrUz2HGZZYQ
         Uq9w7MwEc7rK7we6CISOI1RXVRqHw+lyzPvwVWCGerUNzpD7lzHWQUkTJp9F+1y7jcRS
         FCPe/r8K9KZJR4CdDrsP956x7H2mxPyhr19NAwEfO30sdrS0/dfhnrb+614C0aODOw0H
         Twqw==
X-Gm-Message-State: APt69E2Zcmple53as/fmsTMsXXQa6yHg06NqXNi2AlB0GKGwFzB+hZGF
        leMCzghxVVHKQPiSREtl3L60FQrGUuZjfOr5sm3h4vGQm98=
X-Google-Smtp-Source: AAOMgpdOIXIH3EJI6hYFF5hKH2kcCyFeEorZT6CTytCudTOpe0STqQPa/KcbNYTewdUQ5shcB0Y1NlW4pNipSp6BHlQ=
X-Received: by 2002:aca:d015:: with SMTP id h21-v6mr30457312oig.142.1531244189295;
 Tue, 10 Jul 2018 10:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <1530913134.3135.2.camel@HansenPartnership.com>
 <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com>
 <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com>
 <CA+55aFxAy__3hE1OoUFPKZfptLT1cXuoujsnSGXBMzJPQ+Qjzg@mail.gmail.com>
 <1530940958.3135.4.camel@HansenPartnership.com> <CA+55aFwg-2GP4ASTdd1pusmZkF7c8AN9febVDCaioDxzYJSLfw@mail.gmail.com>
In-Reply-To: <CA+55aFwg-2GP4ASTdd1pusmZkF7c8AN9febVDCaioDxzYJSLfw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 10 Jul 2018 10:36:02 -0700
Message-ID: <CAG48ez0Ccpp3yv+FVX9Sp3WHqPh6US=quDjELmv5RYVgqfBtVg@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 4.18-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 5:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jul 6, 2018 at 10:22 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > We did discuss removing the r/w interface, but, as you say, it's been
> > around for ages so it's not clear what regressions would surface if we
> > did.
>
> So since nobody else followed up on this, the attached patch is what I
> was thinking of just committing.
>
> It removes the warnings from the access check, and just puts them
> (unconditionally) at the top of the read/write function instead.
>
> Hmm?

Random unimportant nitpickery:

AFAICS it does mean that if two processes use /dev/sg* - the first one
in a way that passes sg_check_file_access(), the second one in a way
that gets blocked for whatever reason -, the pr_err_once() will fire
for the process that's working and not fire for the one that got
blocked. But if nobody should be using that interface anyway, I guess
that's not a practical concern.

Also, the device is called /dev/sg%d with %d being sdp->index.
