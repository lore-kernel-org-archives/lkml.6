Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E75ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EFC2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DuYDo8D9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EFC2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbeGRSwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:52:30 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:41738 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeGRSwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:52:30 -0400
Received: by mail-wr1-f42.google.com with SMTP id j5-v6so5567002wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/7Q5Z/18aFxh+6riHynik1PUwDFCMLLBI3txTkzF7/4=;
        b=DuYDo8D9+4mE42ztMXAE3WxgKBWjVKSzqpFtMExeytleT2U/geUAwV28UiTYmQzYYT
         WbVxWR/sDUzl3W1ceeCylFjugRotmAGYUqcrbb1nSVk0y2a19U+E1G5YT7+pKKNsK56h
         sqTmv7HXYyCCfcxgopmhrxOTVTP9GyYnr13p4RnOQWxA0fGC6eo7+R6cSA8IPv6DDJEu
         Sp9eSpIe/g9gfSkQf1tLCkL7RZpf8ezGGUGC+2WgphYpTiTXIXJzjVFHnlrz0w004yiy
         mr6kA1oTXjARRGMCk9YS5+BnBdqDTPu+g+AbjqFUVlcdz13Z+lmneyqK09NLGcJb/g4f
         /yIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7Q5Z/18aFxh+6riHynik1PUwDFCMLLBI3txTkzF7/4=;
        b=iwC7BNkGJbk0EdUwNpo0+3O2wTZvvyR34kXcPifzpIsNwokRLZWS0ZgE6Ip9tA3hCj
         Fqw6dDFEFCAbRKS51btthE5pmZ8RPnUxABmIaBCxIbW7yvKaCIvR+RepLPOTU1xCL+kC
         zgL2d17ogLycaAOJIHsxZdYDH7VURUxCzX77cEst7NA3ikzMSQlnIycXZWCQxbb34J86
         8KB5DuogDxSV+eHk9ucU2tnMeuGt8uTL0rwnlMTe2oGjqQDi5aWz6CHjGPWrsJsGL0TE
         R5AivayBZ9xG25KsNZc+daLjnTj52LRO6kkpdPSe4+JSCa/oqXXP7y4ujk87gstm0eMf
         OpJw==
X-Gm-Message-State: AOUpUlEtwlmnXbjIJTzPUnEVtD3sqOCr+8xGfYGJti1viEm1d1HVP7Jc
        hgWoBhhPJwevLRxIzyoT4Mk0ZznxNVZBA7/yUm/0zg==
X-Google-Smtp-Source: AAOMgpfjDt3/iAloMn66cVL1pjqNP98Sde0uI17ThY+kRGLNFLiEdguwlDbbagKAdV5gEKvWyLOQy9w5IIWjTj2+mxU=
X-Received: by 2002:adf:b112:: with SMTP id l18-v6mr5490838wra.101.1531937604663;
 Wed, 18 Jul 2018 11:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz> <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
 <CALvZod7_vPwqyLBxiecZtREEeY4hioCGnZWVhQx9wVdM8CFcog@mail.gmail.com>
 <CAOm-9aprLokqi6awMvi0NbkriZBpmvnBA81QhOoHnK7ZEA96fw@mail.gmail.com>
 <CALvZod4ag02N6QPwRQCYv663hj05Z6vtrK8=XEE6uWHQCL4yRw@mail.gmail.com>
 <CAOm-9arxtTwNxXzmb8nN+N_UtjiuH0XkpkVPFHpi3EOYXvZYVA@mail.gmail.com>
 <CALvZod5UsYzNs_FJqy2U4HiZ+SdKzKZtzdK1OYcV7v_91kqn8A@mail.gmail.com> <CAOm-9aocfOOFODdGn2Gz236_PKaff++6S0U0bTj9eOPnRwM-_w@mail.gmail.com>
In-Reply-To: <CAOm-9aocfOOFODdGn2Gz236_PKaff++6S0U0bTj9eOPnRwM-_w@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 18 Jul 2018 11:13:12 -0700
Message-ID: <CALvZod77dzc2qxQ4=Xc8P-Yup7fks37Nron0WHV_-q9PyoDaBg@mail.gmail.com>
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some machines
To:     bmerry@ska.ac.za
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:58 AM Bruce Merry <bmerry@ska.ac.za> wrote:
>
> On 18 July 2018 at 19:48, Shakeel Butt <shakeelb@google.com> wrote:
> > On Wed, Jul 18, 2018 at 10:40 AM Bruce Merry <bmerry@ska.ac.za> wrote:
> >> > Yes, very easy to produce zombies, though I don't think kernel
> >> > provides any way to tell how many zombies exist on the system.
> >> >
> >> > To create a zombie, first create a memcg node, enter that memcg,
> >> > create a tmpfs file of few KiBs, exit the memcg and rmdir the memcg.
> >> > That memcg will be a zombie until you delete that tmpfs file.
> >>
> >> Thanks, that makes sense. I'll see if I can reproduce the issue. Do
> >> you expect the same thing to happen with normal (non-tmpfs) files that
> >> are sitting in the page cache, and/or dentries?
> >>
> >
> > Normal files and their dentries can get reclaimed while tmpfs will
> > stick and even if the data of tmpfs goes to swap, the kmem related to
> > tmpfs files will remain in memory.
>
> Sure, page cache and dentries are reclaimable given memory pressure.
> These machines all have more memory than they need though (64GB+) and
> generally don't come under any memory pressure. I'm just wondering if
> the behaviour we're seeing can be explained as a result of a lot of
> dentries sticking around (because there is no memory pressure) and in
> turn causing a lot of zombie cgroups to stay present until something
> forces reclamation of dentries.
>

Yes, if there is no memory pressure such memory can stay around.

On your production machine, before deleting memory containers, you can
try force_empty to reclaim such memory from them. See if that helps.

Shakeel
