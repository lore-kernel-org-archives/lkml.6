Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12999C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22C3208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUHCFEpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22C3208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757293AbeFSPIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:08:42 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43258 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756749AbeFSPIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:08:41 -0400
Received: by mail-wr0-f193.google.com with SMTP id d2-v6so3914wrm.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opJoBFuvvDtEnN7Pz8o9xKJnsr6HvUDmf8Lm5gbV+xI=;
        b=VUHCFEpV25krnCLg2LqpIo5Wnq+yd+zaTTFFUmJWa7g9e+TXPdkoUHRIHiFUMvZG7V
         A1lYa9ntAObWRiqnjJbJ+IOl0XYr+XgRXAlJdqk/UBilY4YGoRgjgk2pANtdvA3K91Sa
         gHqS2DwSZLLZ/YH8w19o/Rf+sbi9FH6RWIo0RwqVvd7bUyXStl7uOx0PwmxUv6ewvkpD
         dvW/L/jbYeh/3BXs+rhvWXBVxIKiym5CVv9kqBrdz6UluGrnhpIbobRC6sKvQOFoN3cr
         K+vxMcJ5Hp82MxVgwox9NvCuqHDoev3E3M3lROUxrD/Lr5B46M60avIc1eT89aiAYyCV
         KGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opJoBFuvvDtEnN7Pz8o9xKJnsr6HvUDmf8Lm5gbV+xI=;
        b=lFv9VfDt2iqLIjBqyvn2biiHH0ro8IN2NMSC4av2jX/0m3gfGEGJxzgvgsF611rc72
         5JG4Tm6XEcizMZo1iSR0WrcGyrt3/WVoc+M+5WIwuVnjGhbt35uDH9z6m+pPNENZVmzc
         uYS6suLas96ookcpavh2c1Dl/MjvYI3CfMCRqkyjY1ONh1/X/s+AvzNCaftKBcm9CXIG
         YF+LcDkYfd7KjnVjJ5XslFzKA6vP48lo3bvN+2kvx7chL9IWLNyZtM+JB9TBIsTGV0jk
         xkCf28wtLB5MTqI5tZMltYQY5Tl1sE9nlqzT3tBdoY5xumKyTtrO4xI1LPQYf8rEsOht
         XTvQ==
X-Gm-Message-State: APt69E0t4ay6QwyV3wL9CCZW2PqU9SYTWb92bj9cz1uIlv4Tt2ExPy1J
        6IQZF+ckegrkvePO6IQoVdEDjxjc8Y0v3haRv/ZmNg==
X-Google-Smtp-Source: ADUXVKIEaTtTxaVsws2/RDj9dT2qnqcu7Slo04K3ZZiNhuwhzpguh7a6SCYQ7PSjKYMPeqnPH6oTOAG0fYI6YGne4SI=
X-Received: by 2002:adf:9525:: with SMTP id 34-v6mr13603463wrs.99.1529420919649;
 Tue, 19 Jun 2018 08:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com>
 <CALvZod6Dxx79ztxzHsDVe6pj7Fa7ydJAjMf_EHV9H15+AsVwdA@mail.gmail.com>
 <CAHmME9qvRDQOJYdSPaAf-hg5raacu4TBgStLy7NzFL+j+dXheQ@mail.gmail.com>
 <CACT4Y+YLySJMfG4kCJ2FiPpPtN6sgU6k2FoZUYMFrJGLj+vDjw@mail.gmail.com> <CAHmME9oeoSbRZyf6qJTg+q-zZanYGu4q=YOZNqCCbRAFu15R9w@mail.gmail.com>
In-Reply-To: <CAHmME9oeoSbRZyf6qJTg+q-zZanYGu4q=YOZNqCCbRAFu15R9w@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 19 Jun 2018 08:08:27 -0700
Message-ID: <CALvZod7MfTTwbfG3zC1kGrZB1Cf0UAnbvdbqhC5Dm=uy6=DtOg@mail.gmail.com>
Subject: Re: Possible regression in "slab, slub: skip unnecessary kasan_cache_shutdown()"
To:     Jason@zx2c4.com
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 6:05 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> HI Dimitry,
>
> On Tue, Jun 19, 2018 at 6:55 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > Your code frees all entries before freeing the cache, right? If you
> > add total_entries check before freeing the cache, it does not fire,
> > right?
>
> Yes, certainly.
>
> > Are you using SLAB or SLUB? We stress kernel pretty heavily, but with
> > SLAB, and I suspect Shakeel may also be using SLAB. So if you are
> > using SLUB, there is significant chance that it's a bug in the SLUB
> > part of the change.
>
> Nice intuition; I am indeed using SLUB rather than SLAB...
>

Can you try once with SLAB? Just to make sure that it is SLUB specific.
