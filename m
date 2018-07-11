Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D53CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C5E208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BgLsZ594"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C5E208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbeGKBHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:07:42 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:32859 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732292AbeGKBHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:07:41 -0400
Received: by mail-io0-f194.google.com with SMTP id z20-v6so22117847iol.0;
        Tue, 10 Jul 2018 18:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XTSBXqOF7Ya6N8lC6touJNlkC+pe57MZPixyQfyUQEc=;
        b=BgLsZ594FxAF0Fyh27txTohyGChI5j26f+iVBP5AI0zFazBA4l6R7ZTnpyTVSrLiZb
         vjSmp55JSOVaYOQGqGElBZSCvilIqOHIGh3qpCq4IzSLynfD22uOI56NH3QbOQxkoJJn
         sW22AaXa3rbyvN2VFD0ySKBwL1/ngVY5jVGwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XTSBXqOF7Ya6N8lC6touJNlkC+pe57MZPixyQfyUQEc=;
        b=SfnYD9+jUpsOix8+p346POgEOepDO4FKgNpcgAPHH2i2/9XDW2Di9jMpCdDjs76Lqv
         xeKr5OLVRuOTJSOJdOChcU2/fl7fjrnPsvVbxns/qcnQeELrmDdMGa6RscEx6iBI0T0U
         uiK0aYdYKwtU/HSoeDVc93ITFiNvRfRHX8Tb5NwXrXktB/7gnsdBqY3P9/jEO25MCBfp
         IUs/8+tGR0tGY/SSKVr8As/fAZO9gF0ElbyLwbCu/aESio8M+x2zn++4Kf8yhxxnrosc
         /+zmhhRj0ab/4xP2Nwxxrh1hvvVYk0dnfrahA80h4IaRXKJCSzCwNLuF35YOSM8phFzV
         X0ow==
X-Gm-Message-State: APt69E2xGOGVICMsvjPHRKzQ9RXPt31MbQ8kYR9Amh1qB6siw7n1Q29l
        sksJkt5O/Ba8VIY7EKzqWqt0Qme7L70zcAQHFps=
X-Google-Smtp-Source: AAOMgpelLbi3mW0ayCs/u/oCoydTQgDCh/qv2FVAJoOS7eVLEBlZL7bCxPw8ttwp9fhbxtcVN26dDYyo6SKZO0NOUYs=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr24134686iov.203.1531271160235;
 Tue, 10 Jul 2018 18:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net>
In-Reply-To: <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 18:05:49 -0700
Message-ID: <CA+55aFzknfBLjg4-pRSCUeBFY3DWq04zX3PPyc949M0OygHktw@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, Andy is right that we should *not* make "write()" have side effects.

Use it to queue things by all means, but not "do" things. Not unless
there's a very sane security model.

On Tue, Jul 10, 2018 at 4:59 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> I think the right solution is one of:
>
> (a) Pass a netlink-formatted blob to fsopen() and do the whole thing in o=
ne syscall. I don=E2=80=99t mean using netlink sockets =E2=80=94 just the n=
lattr format.  Or you could use a different format. The part that matters i=
s using just one syscall to do the whole thing.

Please no. Not another nasty marshalling thing.

> (b) Keep the current structure but use a new syscall instead of write().
>
> (c) Keep using write() but literally just buffer the data. Then have a ne=
w syscall to commit it.  In other words, replace =E2=80=9Cx=E2=80=9D with a=
 syscall and call all the fs_context_operations helpers in that context ins=
tead of from write().

But yeah, b-or-c sounds fine.

               Linus
