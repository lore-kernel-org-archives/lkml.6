Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185ADC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B1324765
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2AR4cnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B1324765
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934263AbeFVSqU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:46:20 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37899 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933878AbeFVSqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:46:17 -0400
Received: by mail-pf0-f194.google.com with SMTP id b74-v6so3616195pfl.5;
        Fri, 22 Jun 2018 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rXkqddkMzEb07pJDJliCPzlM66xSj7yASHw2MBPqpNU=;
        b=b2AR4cnFqb/FvvR+m/q8YjoiXzGd1iiaUS/YtRFdInswLMM3tlbI71HMihruKk3BCF
         1aLXRq+dJu8KwS2ECOjhAkjbzCfGorqd/rbL2hSEDAKbyTEdOJMkKJEJOx+AM51oohkm
         MfWZz6QB2WJsBpwLtQ9yASLOwNCkCiDDh7JT40GxNybCHEomwrfvgHptP3xOPwZJc9NM
         MCI0f0n1wxgXVF4aKf4lMLEupWfuu7UjR6jt0sZoGDJz0R++UgrsQ9mepKPcTcpPHuax
         flYGxix0Q4nLsL689ib+PcTZK1Qa96zkI2U5cJAo0c69Y2hekiwiTMkecixiRm7WifXR
         PQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rXkqddkMzEb07pJDJliCPzlM66xSj7yASHw2MBPqpNU=;
        b=cgxcz3SnwyQaWSA96uynbhH1d+1sWT4qIvEbhIjby8hDBN31EL4E6Zzu8YUq87/Plq
         R1kDTzjL/Pt7VFtkzK+MBk9TIMNfuryW07qgql2FMNXqv5yj0bqZmAP4UU8CQ1R2WliY
         JZXCh4LYeS23y3sXOQFo13B7VHL53uHP7/HCaB/4QBn0TBJCu5CWArFvqIA67KIvrCS2
         PnkG+/yDobSNG8HmiibLkTaUFN4QapLd351T8F/1PxamvbOj14my+9VS0jnfwyVdUOQw
         F6eBk6PcBpf2uGsLgLBLUaJKRkhVVAoKFV1oaf6LPee6bACKs5fkiQxYoTkG0QOJGeOL
         P9yw==
X-Gm-Message-State: APt69E2qbKjYigrFT2AjT6MlYpx+apO0HJY8KtGF7/mdK7mGgGAPdVIW
        B8JJIrizZnMdhyovFBTNOAmZpq6+
X-Google-Smtp-Source: ADUXVKIqIir0DqtYsZlQLP/93Lh+ZKnXoAovTdfwYNz2Ye4xsuCiee1Mdpcd0vpDAvmS6cEsaPq2FA==
X-Received: by 2002:a65:6319:: with SMTP id g25-v6mr2470767pgv.437.1529693176601;
        Fri, 22 Jun 2018 11:46:16 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id q77-v6sm19192271pfk.152.2018.06.22.11.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 11:46:15 -0700 (PDT)
Date:   Fri, 22 Jun 2018 11:46:13 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        agk@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        shli@kernel.org, linux-raid@vger.kernel.org,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 3/5] bitmap: Add bitmap_alloc(), bitmap_zalloc() and
 bitmap_free()
Message-ID: <20180622184613.GC92912@dtor-ws>
References: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
 <20180618131003.88110-4-andriy.shevchenko@linux.intel.com>
 <20180618141404.68124daab97bd0f3a3051544@linux-foundation.org>
 <CAKdAkRTHOORds7aEauv4rp3_=PnGi=Nv-VS3-nAb9MztJPKG=Q@mail.gmail.com>
 <20180618161056.e52efd0e8bd36211e60705a2@linux-foundation.org>
 <CAHp75Vei2_V7h4oKAU+uoCG2gUJH6uXtg9zVqQ_vnyr5KEmNYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vei2_V7h4oKAU+uoCG2gUJH6uXtg9zVqQ_vnyr5KEmNYw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 05:13:39AM +0300, Andy Shevchenko wrote:
> On Tue, Jun 19, 2018 at 2:10 AM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Mon, 18 Jun 2018 15:01:43 -0700 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> >> We can't as we end up including bitmap.h (by the way of cpumask.h)
> >> form slab.h, so we gen circular dependency.
> >
> 
> It's not just so easy. See below.
> 
> > That info should have been in the changelog, and probably a code
> > comment.
> >
> >> Maybe if we removed memcg
> >> stuff from slab.h so we do not need to include workqueue.h...
> >
> > Or move the basic slab API stuff out of slab.h into a new header.  Or
> > create a new, standalone work_struct.h - that looks pretty simple.
> 
> I tried to move out work_struct, it didn't help. There are actually
> several circular dependencies that ends in bitmap.h either way or
> another.
> 
> First one is
> 
> slab.h -> gfp.h -> mmzone.h -> nodemask.h -> bitmap.h
> 
> And so on...
> 
> Splitting out kXalloc stuff to a separate header won't help, I think,
> because of the above.
> Splitting out struct work_struct is just a tip of an iceberg.
> Splitting out memcg stuff won't help in the similar way.
> 
> I'm all ears for (a better) solution.

I think ultimately we'd want to untangle this, but allocating bitmaps is
not in any hot paths so having them as non-inlined functions should not
hurt us that much for time being.

Just my 2 cents...

-- 
Dmitry
