Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB772C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E9120842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y2P2jfCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E9120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbeGLRYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:24:45 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37201 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeGLRYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:24:45 -0400
Received: by mail-it0-f65.google.com with SMTP id p17-v6so7806177itc.2;
        Thu, 12 Jul 2018 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=75n14uXlMfFID40faZb/54QOEji1la+9qZWFPnZn89E=;
        b=Y2P2jfCGeGlwFXyCI6fpyqrg4g7/ylyS6kNRiAPGd24URD5lvdiw9P02atozasgj4/
         CzpTqgg4o3Gd6I3FFoKS3diWrTlpZGGXCLSS5n6Qbe7bFS2DyZX5ndArgXHyEYq0WLTN
         Yh/9ViAFhnR81pI3DVZ0KnKFrfxl+pZPwxrvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=75n14uXlMfFID40faZb/54QOEji1la+9qZWFPnZn89E=;
        b=bhIR2rKr2Qc9PtPdck3Hq4f8GAR/hCYR0vd80gaIUpRYES5fuvWGTn738fe9dgx64Q
         mTeW98qln9GgPmhAb+SoN4I1IuuZoqPQ0Uij+/DHwEEodXbDbrlog2lEFH7oZH9m0bjN
         cr25VBgYYqM6naEZplMIWPxsbyUdY+LMFOBE6I1Pp2X/bLf978LA0zJQRsqlt3Uz5vs8
         VSBN+c8CSqw4laxdK+3B7PzwqUJmR7V/fER4ryMDH65v9CsKWr+t+WFKz0PTLcRZ5NwX
         A+vT+jfUPYLJNnyD6jqfYxWBEfTsRHp+++HvAI+mzDH0U2U01e0/cXv30E1IbRMjpk4o
         0CCA==
X-Gm-Message-State: AOUpUlFUz6rOeUTWonoeLBuG2L18S1q39afUtgI1J8wA64cQbHnl93ph
        kCLGulnDkei9HUohUcuEfJNj5RI0ZuObWCYv56k=
X-Google-Smtp-Source: AAOMgpfwZts1oPgQEkQdpv2c5J40WLtidlXyMY+xFqFVSKEmWFUqpktpqtfuPkrmsMriR/EMPeHSv0zPPKzX8gJgrIM=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr2013172itm.113.1531415657142;
 Thu, 12 Jul 2018 10:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk>
 <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
 <7002.1531407244@warthog.procyon.org.uk> <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com>
 <20180712160030.GV30522@ZenIV.linux.org.uk> <CA+55aFwkiFdhGmT8gaSohAQGMWpGUZBQ0dhGNGWEN4cpjK7XHA@mail.gmail.com>
 <20180712163107.GW30522@ZenIV.linux.org.uk> <CA+55aFz6Uaqag5qPcT2M3Q07-yc_6y2cAarfw7hjXEiQq4tTYw@mail.gmail.com>
In-Reply-To: <CA+55aFz6Uaqag5qPcT2M3Q07-yc_6y2cAarfw7hjXEiQq4tTYw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jul 2018 10:14:05 -0700
Message-ID: <CA+55aFw9WuyGqRHerhESw+Shzg1UtCjORLVYT=uCMh8jXbLWmg@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 9:39 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I agree that a system call is likely saner. Especially since we'd have
> one to _start_ this (ie "fsopen()") it would make sense to have the
> one to finalize it.

Side note: if we can make do with just a buffer, then we wouldn't need
"fsopen()". You could literally just open a pipe, and write to it.
It's got 16 pages worth of buffers by default, and you can increase it
(within reason) as root.

Of course, depending on IO patterns, not all the buffer pages are
necessarily fully used, so it's not like you get a buffer of size
PAGE_SIZE*16, but we do merge buffers so you should be fairly close.

Then you really could do without a fsopen(). Just fill a pipe with
data, and do "fsmount()" on the pipe contents.

Added upside? You can use "iov_iter_pipe()" to iterate over all that data.

I'm only half joking.

            Linus
