Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFCBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44C32070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FnFhqWjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbfACREM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:04:12 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33907 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730870AbfACREL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:04:11 -0500
Received: by mail-yw1-f68.google.com with SMTP id g75so13507582ywb.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 09:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOa5IQ+9QpakIS1qQWCjI383Pmf9DvpNGSYurftvPLs=;
        b=FnFhqWjJI8jMOGKfyG9SvTYBEw33RyGJef4mSM4iaKIcKQpGeKmA2CDVKj3xhplRFi
         PgxKW6LfkpIpRv6rDBCti1i4synkulMgENYelJloscl7kSZNxnFreycbr6dY69oUCBAy
         I3+lPz96ak5UtS8LVPPnDlG9z6h8hk9SfbaMkoZ6MZEwC4rYhpW5XMES9MQCHrAxdVgX
         XiZvHyB8dkr263E4XpfPFLvrdSQ0wn1nSxkMF5yMCvDmh9M+aK9T/DR7I1oXy5bbHehL
         +jPjGI2fg2qtCH8eFpoEG6V4wVmxZpxoS+K2QQ9j3/Os5s9fVzVIueifyLLzgYAUbIUi
         IwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOa5IQ+9QpakIS1qQWCjI383Pmf9DvpNGSYurftvPLs=;
        b=r/Vs3GFfqMMTPxrnh39vGLwDBwMHKwBjrBLAzp5VMWCRtIo/h666aNTIhi/uhjoAz8
         rAGetENfLomBTWgbu2uagqvJ2siRwxrtFOU8hlzpE4aQcaLOqL7GXH5KNAtLQwpJ8nwG
         Vq3NPDjki/FdIZPev/V0yn+oYEC8CNLc5aptHFPdyS/FP6WJ3F0MeFx8DWYVrznIWmd6
         B9EsmBIFrO5eEk5JnZrnMeFVCyNnwFpsytxSWNA9cBq7GXfY2c5tY5tBx+Sm1iMUWYC+
         0UKj5bBlv04x0fUjHH6lUFLTGGLxTq98ezI5E5r+c5d9RbPTxWAtsVim8s5TFgvOKG+D
         R6xQ==
X-Gm-Message-State: AA+aEWZF3pDCgrGodFJE3Yrx1c97YwAA3WMtl7zT3l396/1pMKLFbSl6
        +E3FEJ9fvBPtsz0YAdOLlU+LZAzb2sBlo56u0UEdng==
X-Google-Smtp-Source: AFSGD/W+8mJUletzYTpjEW3nYTKShDIMhSRtP1a2XGBUvlkFyAAT6bvtIfXSCb2cTn7KnXkl7XEDN6M07o2J+7DI9Uk=
X-Received: by 2002:a81:30d6:: with SMTP id w205mr49736002yww.27.1546535049481;
 Thu, 03 Jan 2019 09:04:09 -0800 (PST)
MIME-Version: 1.0
References: <1546459533-36247-1-git-send-email-yang.shi@linux.alibaba.com>
 <1546459533-36247-3-git-send-email-yang.shi@linux.alibaba.com>
 <CALvZod7X6FOMnZT48Q9Joh_nha6NMXntL3XqMDqRYFZ1ULgh=w@mail.gmail.com> <763b97f5-ea9c-e3e6-7fd9-0ab42cf09ca8@linux.alibaba.com>
In-Reply-To: <763b97f5-ea9c-e3e6-7fd9-0ab42cf09ca8@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 3 Jan 2019 09:03:58 -0800
Message-ID: <CALvZod5cZ60VkrxuO8o9dnSOhGmNt21o+NoS5Qy1Mh3-k6suyw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: memcontrol: do not try to do swap when force empty
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 8:57 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>
>
> On 1/2/19 1:45 PM, Shakeel Butt wrote:
> > On Wed, Jan 2, 2019 at 12:06 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
> >> The typical usecase of force empty is to try to reclaim as much as
> >> possible memory before offlining a memcg.  Since there should be no
> >> attached tasks to offlining memcg, the tasks anonymous pages would have
> >> already been freed or uncharged.
> > Anon pages can come from tmpfs files as well.
>
> Yes, but they are charged to swap space as regular anon pages.
>

The point was the lifetime of tmpfs anon pages are not tied to any
task. Even though there aren't any task attached to a memcg, the tmpfs
anon pages will remain charged. Other than that, the old anon pages of
a task which have migrated away might still be charged to the old
memcg (if move_charge_at_immigrate is not set).

> >
> >> Even though anonymous pages get
> >> swapped out, but they still get charged to swap space.  So, it sounds
> >> pointless to do swap for force empty.
> >>
> > I understand that force_empty is typically used before rmdir'ing a
> > memcg but it might be used differently by some users. We use this
> > interface to test memory reclaim behavior (anon and file).
>
> Thanks for sharing your usecase. So, you uses this for test only?
>

Yes.

Shakeel
