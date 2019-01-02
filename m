Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61612C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA3A217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ee3OGe78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfABVqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:46:02 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46378 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfABVqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:46:01 -0500
Received: by mail-yb1-f195.google.com with SMTP id n16so2414689ybg.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 13:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0puuOBT2pD/XnAHjsSo/6sVuD3uUPGP+UfDkXMy5oA=;
        b=ee3OGe781HrG7cNNgDlY6Y1ESKVx3Ll3q10QZPrg1Xjsv1Nd/mY3Er7+cJRoosc5UL
         wNQARPudiXv0kWIpSJpH2iweIdt02p4syLpsPFNMu/a0k1jVhYRGevnNVbu84KD8vl1g
         ZCmzt+4y16g9hQ8Ye4yMw2Q97rc9tK5iyvFyP9NSUldVT5Od49FRffiFymyDFGyjSgHq
         SgP8iNEVAjRld8qaJ9sJ5w6nF2QRasvf5G0MXM2BQW26t/GJ+bLkhI5903g+hIBbZqMc
         JxEv8JMoLa+Sfe+Gkf2SRtP3V+T4u8BAUhGMmjm2VIbLaGml/VQo9tdZEe04Y4Sd1rtw
         NQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0puuOBT2pD/XnAHjsSo/6sVuD3uUPGP+UfDkXMy5oA=;
        b=jWAcZWHgjJeHmEXWgc3BvXpUMm2bkiuRr26HZHy44HSD7agXAISpGJtFPfvcH41Guf
         CVNEj6knSvcbnHh7bNqY19syoRhC6HB1UdUDGtTCK+nEAFujEEBawoZktUvIuMYWT9nQ
         7A/L1NJMa1wEF+8IanthkxzM5UFCELZwgv+84gqA/3jaXOcqHkseEleH5DSIwViI2s58
         e1GzdQmKNH5Gsefoeup0TTXfH9B4aRfjSyvTxbSqLkxT3/4TJBrWmCP37XH9pHsdPDO9
         HD69DITQ/LLoQDlc6yrsMJlX7VY8ik3+MoMunlQRrhBiKMRtwfhcsGdWY1oG/mTI5koN
         sW5A==
X-Gm-Message-State: AJcUukcS0d53kB5lj2ES+pu7xz5i4J4iA3aBeixUsuZQ7X72d5GAtAPr
        Qm3rsspgZQR5GtYLGeyp9ezp44rM4SXP8jCIUkWe+Xdv6iM1bg==
X-Google-Smtp-Source: ALg8bN5KUmK006nxWFp+cGe1e5WwFZFAGFl5TmA+9HHeAe21bPxM8CMyXvoTB+ZS06qvz5c65I7kfuvaZGKXeriVjO4=
X-Received: by 2002:a5b:f01:: with SMTP id x1mr41195493ybr.464.1546465560576;
 Wed, 02 Jan 2019 13:46:00 -0800 (PST)
MIME-Version: 1.0
References: <1546459533-36247-1-git-send-email-yang.shi@linux.alibaba.com> <1546459533-36247-3-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1546459533-36247-3-git-send-email-yang.shi@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 2 Jan 2019 13:45:49 -0800
Message-ID: <CALvZod7X6FOMnZT48Q9Joh_nha6NMXntL3XqMDqRYFZ1ULgh=w@mail.gmail.com>
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

On Wed, Jan 2, 2019 at 12:06 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> The typical usecase of force empty is to try to reclaim as much as
> possible memory before offlining a memcg.  Since there should be no
> attached tasks to offlining memcg, the tasks anonymous pages would have
> already been freed or uncharged.

Anon pages can come from tmpfs files as well.

> Even though anonymous pages get
> swapped out, but they still get charged to swap space.  So, it sounds
> pointless to do swap for force empty.
>

I understand that force_empty is typically used before rmdir'ing a
memcg but it might be used differently by some users. We use this
interface to test memory reclaim behavior (anon and file).

Anyways, I am not against changing the behavior, we can adapt
internally but there might be other users using this interface
differently.

thanks,
Shakeel
