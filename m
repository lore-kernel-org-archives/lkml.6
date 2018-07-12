Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E23C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6700B21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FwVlNeUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6700B21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbeGLQR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:17:59 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33431 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeGLQR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:17:59 -0400
Received: by mail-io0-f194.google.com with SMTP id z20-v6so28712951iol.0;
        Thu, 12 Jul 2018 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VsP8gzpgcXxlTAZMKVKNU/EFbc+W1xB4jMQVVFPYgOo=;
        b=FwVlNeUsWqV1vi3rbz6CHySm94wH2kcMFiSJ3p64jBShnXkq8UScP6w59lIgsPGm0o
         VjsBhUdtc8z/eX9X2+AakSZmEml/r2TnCvfjKh8Wo0SBubrJ6c9ltzVxAjrfhlV2DSEP
         oK3T0ELoJPLiq0oZ9NkshupSoVZvpw7A8Jc1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VsP8gzpgcXxlTAZMKVKNU/EFbc+W1xB4jMQVVFPYgOo=;
        b=ccN+aTiO3fQnUuQiFZMlFHRSUvLvmX/W0mKA+chgZ0cej7XokgAGTuSi4uFD48ICo8
         0dkA+nPh3U/Fp+5uKDPGOkcLnariNHUuRaJLS44w9y8uRMfmoNPpXaBuPsqKHJZoevYW
         GeKbYnp2YWLEWIEgc4h1nCdCh6RDiFxowFNChI6BvdpLPIng4YqHTDwA4wMTVToiQzcW
         Sedqg5O2E07N5d7ZQjqwwND2wj8oOVVd5DDO1t2SzYwM3GzvdNkIlaPCLfgxRntq3gNM
         R9wN6AipoM0a/yeqFatFb/Zg8tljlPdDM6GB1SJ4sBZtMnrLN6YkbumYGcOywRBqFoan
         tQwQ==
X-Gm-Message-State: APt69E1Ntqmo+ipF6LiwLras4y+AT34y/1b9LSo0p2gTS+1mepXGdeNv
        RvtocnrllgpXxmMBf8QrAgJ2PXj2lG3336NuWn0=
X-Google-Smtp-Source: AAOMgpfarGiTCA8xDo2UguiPrFkO9f+gV8SBWSv5n2Z7KrICHZTW/56Z15prBVAdwSwFdIIufnCjYucbgxP1qp8e4WQ=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr29689467iov.203.1531411667250;
 Thu, 12 Jul 2018 09:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk>
 <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
 <7002.1531407244@warthog.procyon.org.uk> <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com>
 <20180712160030.GV30522@ZenIV.linux.org.uk>
In-Reply-To: <20180712160030.GV30522@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jul 2018 09:07:36 -0700
Message-ID: <CA+55aFwkiFdhGmT8gaSohAQGMWpGUZBQ0dhGNGWEN4cpjK7XHA@mail.gmail.com>
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

On Thu, Jul 12, 2018 at 9:00 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Wait a sec - that's only a problem if your command contains pointer-chasing
> et.al.

No.

It's a problem if anybody ever does something like "let's have a
helper splice thread that uses splice to move data automatically from
one buffer to another".

And yes, it's something people have wanted.

Seriously. I'm putting my foot down. NO COMMANDS IN WRITE DATA!

We have made that mistake in the past. Having done stupid things in
the past is not an excuse for doing so again. Quite the reverse.
Making the same mistake and not learning from your mistakes is the
sign of stupidity.

So I repeat: write is for data. If you want an action, you do it with
ioctl, or you do it with a system call.

              Linus
