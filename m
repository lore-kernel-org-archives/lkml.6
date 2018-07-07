Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72296C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131E2217AB
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dH0c/QM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131E2217AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbeGGCtF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:49:05 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35922 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932496AbeGGCtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:49:03 -0400
Received: by mail-it0-f65.google.com with SMTP id j185-v6so19407008ite.1;
        Fri, 06 Jul 2018 19:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Ki/bvNFG0NbYrvFFgpd4QjvVlnOj8iebM1eYxxtzC8=;
        b=dH0c/QM0fwmaXUMx/W4jL0EBGxuanS1M2z5n9GnhvQ8fYdZRFUBSC2QJrxByxulo18
         CjPwy4S1ORevpQ/X9Gxp79Tx/J4k8Whhss/dELDxuS41qseUemWOVSbOLF/elJU1TDZI
         gVO5WJFwY3WEa/SK0t8I4xXjCENYdGyUmHlAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ki/bvNFG0NbYrvFFgpd4QjvVlnOj8iebM1eYxxtzC8=;
        b=ARY8Oms2tGkDOna/ijxVOsjx2SBg9gTCmB+U57Zl/E3MLEXWeF4hvxQpyC5v1JIfrM
         JtQCsDve2bzrsWIB4fk0lWFLiFtUCr7MlRkOZ/mZ11PPhBLBeRt/ll/RKUDa1tBdYPAj
         KRVYQBBGd5Ig4gotdlutK3QwNYfl/VKw5HISVAVJ4nSrXRl+Y6lt1VduiXUsiidEcbaT
         0YFsp5Kr+h4mvJTFREHYtXuSra8ZhhUCXWayAJLulCCX0WpDd5z6oUcMKchxtksussmz
         I7Dk0FBFWCSDCAw2yOqLqKwNlEbj4o8deQZn44912PgsrIAZalXToqzL+kL17RgRivzE
         LBWQ==
X-Gm-Message-State: APt69E1GMlURRNcKyrUMmTxbe46sAA9ZKDXWqrmDnVqkPpbY6RBdBrR8
        yOcaJZsqK1orRQOL4O/vuu5Kp5jy1YvyONgr1Tw=
X-Google-Smtp-Source: AAOMgpeiN3gehZTU2bcPYzOWf/SSYPiGtuxaSWoW2MzAf46Ba1QNnATsJ6cmcNORTqAxVogPCCHjnPCkB0BE0SP6Ucc=
X-Received: by 2002:a24:d0d7:: with SMTP id m206-v6mr9631301itg.1.1530931742760;
 Fri, 06 Jul 2018 19:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <1530913134.3135.2.camel@HansenPartnership.com>
 <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com> <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com>
In-Reply-To: <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jul 2018 19:48:52 -0700
Message-ID: <CA+55aFxAy__3hE1OoUFPKZfptLT1cXuoujsnSGXBMzJPQ+Qjzg@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 4.18-rc3
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 7:39 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'd rather add a deprecation warning to the whole "read/write
> to /dev/sg" itself

In the meantime, I've pulled this, but do wonder why we actually allow
that crazy read/write that doesn't even work for any other models (ie
I guarantee you that cdrom writers etc don't use that interface,
because SG_IO is the only thing that works on most hardware).

              Linus
