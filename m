Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BBEEA4D8F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282DD2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fynqYJl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282DD2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeGLSEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:04:51 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36131 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeGLSEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:04:51 -0400
Received: by mail-io0-f195.google.com with SMTP id k3-v6so28997883iog.3;
        Thu, 12 Jul 2018 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ES7Mwi1+9rCBcFMiRzj0I/yck416AkEiPHtahr5UYTg=;
        b=fynqYJl/fa6P3N6fdLgnkORakQbIwiyeYV2wZ99eXkMl3iYWgkzMmcRDcqaYPMMWSA
         DUKN+vy5WwSXEuk/L57huPawZ1pqis4lA8fQismeCGkeHzskdijLrnbChj5SvRuKaLI1
         VgTI/o6nebvHfrA9ooK20RuIPRPhDYnSkL7bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ES7Mwi1+9rCBcFMiRzj0I/yck416AkEiPHtahr5UYTg=;
        b=L6VoDbDB0yPSrPXZCmlkPLF7+RQkLwJxPfnPvwz0O6Xm3nFTExZweLhm3JtJZwu9Ac
         9JvSNn8sVO/p3avLmraVK6WhVQQLc7MeetA7mH7CT5WZKCUEEFjsUURihXIYUFQSVRCu
         JRp7eLFNAxvjtHQw+HPD8/yvr14Bo4RJkiKQFWiq94tvuSnxk1WoBbMGW+BAc3Qe3qxZ
         yXHsDZug7Y8zGmV98oQAJjUZeMI9makkyxBTPyegwWDCKwyKiFqlzccvTP4G+dqqrL+J
         TTwjHsF5t9W1v0vy82QYBpavM/GhkIA7ilYzK0Gdao/QnJ8/VoFpwl/Lp7DMwiAYEKB1
         z0lg==
X-Gm-Message-State: APt69E0/i1rVHKfgK6ktfJ+Q6QtlucKxddkIVVua7CZdvJs7JOiECkrd
        iiZ0J4FMzqDh9DV18gwXhUY5dW104FcP718dFd0=
X-Google-Smtp-Source: AAOMgpeK94O4aaguZQdiMtQtagxYexF1D1hUTLa6vNT+V4zTlN9UgN0a8MHn5fh1401uvwjzRfhvrlnD5BYjavozTZo=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr30046844iov.203.1531418053750;
 Thu, 12 Jul 2018 10:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net>
 <22370.1531293761@warthog.procyon.org.uk> <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
 <7002.1531407244@warthog.procyon.org.uk> <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com>
 <20180712160030.GV30522@ZenIV.linux.org.uk> <CA+55aFwkiFdhGmT8gaSohAQGMWpGUZBQ0dhGNGWEN4cpjK7XHA@mail.gmail.com>
 <20180712163107.GW30522@ZenIV.linux.org.uk> <CA+55aFz6Uaqag5qPcT2M3Q07-yc_6y2cAarfw7hjXEiQq4tTYw@mail.gmail.com>
 <CA+55aFw9WuyGqRHerhESw+Shzg1UtCjORLVYT=uCMh8jXbLWmg@mail.gmail.com> <20180712174403.GA30522@ZenIV.linux.org.uk>
In-Reply-To: <20180712174403.GA30522@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jul 2018 10:54:02 -0700
Message-ID: <CA+55aFxmvkdzBaT4dxTdATW-Y=KFV1JZhMCQY7O5UNb01PotqQ@mail.gmail.com>
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

On Thu, Jul 12, 2018 at 10:44 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Separating type name from everything else makes a lot of sense

I do not dispute that at all.

But you can specify the type name in the "commit" phase, it doesn't
have to be at "fsopen" time.

In fact, doing so would _force_ a certain cleanliness to the
interfaces - it would force the rest to be filesystem-agnostic, rather
than possibly have semantic hacks for some part.

            Linus
