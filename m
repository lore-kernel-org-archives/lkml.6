Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48562C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B4E20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JNu1P8vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfAQSbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:31:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37802 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfAQSbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:31:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id t18-v6so9445462ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 10:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1yIglByXhllkLqjBRUpBOb41TSaRcY+ux63T8808PE=;
        b=JNu1P8vkyfMWqDz1ADZvw0c5Vi1T2Qc3ZiFrnlHwHmjrp6Z5BViwkqo2dBxQkJy6uc
         mEyaVQD2QbQQqi9RQEAv5txKNaEy6zjyJIyZBozkdA5IV6DPFk2hTrti5HxQ2npoJHgq
         WhcR6OIjxH/3KskbohjPP5Is0pz4PAphoYLQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1yIglByXhllkLqjBRUpBOb41TSaRcY+ux63T8808PE=;
        b=A8blbd73u7GHWbQO+Tbw+YwwDhnxuIvve7ZwOt5ItKS6OQbGgkAAxzKFtsRTAuV7vX
         SWB86QTQh9Zc66rL+cC/SIdb6n6RYF8BTP/VLm4CZHudz+P70qNuwt/VTZBSwHAGL5Kl
         SPxqycRoQNOzt8ID/+PWnJUavCO8v7vVuHkLzuFbkkoFs4vbLrKQ3O7Hmmxs3PiyJv6I
         7EpYGyisvUvy7fTLgxB17C8FzqKXy0WHi4n2tS6HTnQnIj6rgwvCZ1xzDhQlXpRKr1hP
         FxIG18e/n5OSUVXQVR+Mw+kZzXIK3UQmjSU/SVHmqm+H6HXF39Z8B9osXh4lx2xrqt3b
         NF6A==
X-Gm-Message-State: AJcUukeMHwSRxAzwejZQyHRGg78RyU9z4TMEWihNM21PjhKHj2cNGOe1
        ZScNzvjmXn5Biw+uLJkve5Ihx7lgjw4=
X-Google-Smtp-Source: ALg8bN7u7M9RLmRzX12x5hzhwvI3ZmoOKSZdyeDAec5hsPw/ij1ZTfhfpskAxOnUtMW8zcP0XA2K3Q==
X-Received: by 2002:a2e:1241:: with SMTP id t62-v6mr9520209lje.171.1547749909651;
        Thu, 17 Jan 2019 10:31:49 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id t19-v6sm367843lje.23.2019.01.17.10.31.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 10:31:48 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id b20so8540093lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 10:31:48 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr11473335lfc.124.1547749908275;
 Thu, 17 Jan 2019 10:31:48 -0800 (PST)
MIME-Version: 1.0
References: <154773884927.24105.2730570814701376379.stgit@warthog.procyon.org.uk>
 <CAHk-=wgM+h9K-MdyOAjonMchJViy-7stCKHqn0vMgitKDmpVbQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgM+h9K-MdyOAjonMchJViy-7stCKHqn0vMgitKDmpVbQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Jan 2019 06:31:31 +1200
X-Gmail-Original-Message-ID: <CAHk-=whSXM3YgJfRwuWtP0BS9jiUvdYM-xmCUw1PjMO=DtKm0g@mail.gmail.com>
Message-ID: <CAHk-=whSXM3YgJfRwuWtP0BS9jiUvdYM-xmCUw1PjMO=DtKm0g@mail.gmail.com>
Subject: Re: [PATCH 0/6] AFS fixes
To:     David Howells <dhowells@redhat.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 6:29 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> >         http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git
> >         tag afs-fixes-20190117
>
> is not  valid pull address.. Yes, I can fix up the thing (and have
> done so), but a normal git pull-request wouldn't have had that issue.

Side note: I suspect that also means that this won't get an automated
pr-tracker reply now that I've pulled it. But maybe pr-tracker ends up
being very permissive.. We'll see.

             Linus
