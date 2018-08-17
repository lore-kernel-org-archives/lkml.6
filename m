Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB51C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E897521536
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KFqpsRSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E897521536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeHQTlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:41:20 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36045 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeHQTlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:41:20 -0400
Received: by mail-it0-f65.google.com with SMTP id p81-v6so12531887itp.1;
        Fri, 17 Aug 2018 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VieFQTmhvM46SjyzHAHzc6yNNxLIRtqamCHY3sBeXiw=;
        b=KFqpsRSZ9GDpAwNyK5HhPqdJcK4+3oKQy+RhgmhXXMY1r8tr7OjsNEovp4atCqYUte
         5MTEh1yjRSD30mkgUmDqZZFDFvlCwYWHU3xMXcVSl32L7Ko8gZmitmvfkOjWgXq2jPKu
         C0WuVmL2ad33xJfB/YaRYJCj/Bxyaf8zSmT1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VieFQTmhvM46SjyzHAHzc6yNNxLIRtqamCHY3sBeXiw=;
        b=grIM3DmIdD/T1gutaEp9FjjlkJCvMUu0Uv++wyZkPC7nOkvggmK7BZaPDPLI/PyN1L
         b4fHsfJCRVyGx/IOgHA6Z0ryw4iC9+OT5N7v0HGEM8Qn2xYFrKgvKstZBxRKOW/TTmzD
         F8JNBNbVO3zQ+SqrFzQuP/nFEfFKkvV5hJRlAaMyoDgi8tkGOvAf1uU+JeU0bDDIqkTB
         256MM6E3cMJYDUep5IUtxrD5F0al1Bmk1bmJ0GC3M9QtkCtaiVVl36a3mr3PxibamcE7
         0LkqeKWxvHXW9eLqFnmVs+hHfstd+zRViC3ICN6UwW/NvGgy07Ikp7sORFLKuhCqpWhm
         Vidg==
X-Gm-Message-State: AOUpUlFlHORB3x6oOuS/JggfpqPCbdBFQ2dZZiL7wPq3dDRH0dXhmwOu
        1SqU0pZod9oXPzt76zgQFRdHQ687yTRlG69R+9s=
X-Google-Smtp-Source: AA+uWPyk5YI3mGl8hWhwa7xRciXq9yTHfSnkBwY9tJ4tKOIm6a7l4fuMnUVRM6wHnJgHJdtr6Aiv2NlVVyu4VDYKS7g=
X-Received: by 2002:a24:4c0b:: with SMTP id a11-v6mr25201542itb.123.1534523837333;
 Fri, 17 Aug 2018 09:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180813012347.GA32555@nautica> <20180817023307.GA32726@nautica>
In-Reply-To: <20180817023307.GA32726@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Aug 2018 09:37:05 -0700
Message-ID: <CA+55aFzLe7C03-53=0WrXXfZcfsJfTsvRqrrBNqnLvOxUiCJqQ@mail.gmail.com>
Subject: Re: [GIT PULL] 9p updates for 4.19
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     V9FS Developers <v9fs-developer@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So this pull request confuses me, and that's not a good thing.

On Thu, Aug 16, 2018 at 7:33 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Pull request for inclusion in 4.19 for 9p

So when I pull the tag, I get a different message, talking about

  This tag is the same as 9p-for-4.19 without the two MAINTAINERS patches

but I never saw a first version.

And it comes from a github address, with a pgp key that I've not seen
before, and without me having been told about said maintainership
updates. And while the  key has a lot of signatures, none of them are
any that I have recognized previously from kernel development.

I'm sure it's all ok, but honestly, there's no way I can pull this
without a bit more clarification.

             Linus
