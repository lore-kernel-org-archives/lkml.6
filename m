Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460A6C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1249A217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COdD2YH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbeLUGSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 01:18:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35583 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeLUGSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 01:18:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so3748651edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 22:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z2FHmaBlflrf9QUQop5IgR5jIVNSrnKow3guJqFNBp8=;
        b=COdD2YH8/h3nimEm7utrbsKg4Ml7JYcY9DfP8E4scwbaGpuJsKCz3axXxnQG7d69l1
         iL3X8SQvyHRMbjCOZCMIocN9XR15PQllEuE4eo8XEU65Zx9bLCMJKjzSxLewFESRJFx4
         T77p1L0xMiGDxr4ZnpW7k7s0TP2FX5yXCwa0jiz5n5LHM5gJQkz1NqibcdKz0oqX8YwO
         ofRZu1KW+GwS7VkjKjsFHKByVkwclMRes1Q9IlluMx95VQuNcR0LkO9Qd7RYZ2Wt4yiZ
         B1gso9GMg0VbAatszoGRHbQz6WeXiLzFYztoLdNARRl8GpqZTbNeUeH7brzySblK7yna
         50nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2FHmaBlflrf9QUQop5IgR5jIVNSrnKow3guJqFNBp8=;
        b=UNK6+ESsVBNpM5y3PgPgwak0MxMK4vfAZ6LxmEwmVmNqZ0eLjjlFubO1fqeoCK+YiR
         H7+THwrZevqPdR9N8ccCUkaGQJVvhk0Zfjwm9DCCkpB0TueAY1SXfTPKnpGe6MfdWm2B
         lQEzkG7Kg7VeUi9wNARFc/49VdBGeZeyIVAjCxc8yJ3GIrygWEi+NK+VoigaWYy4CsTy
         kBntgm8EAK8abzaIOUJB2o7XXr9d9r183ql6xEOxSVhObksCJEIwFNIcuWDqFiKREU9m
         u7Bx31sfAJnFfb0S2dl9hZhUP2EcvwsnRm6Euo7GUc/I8IUqPHGbvjSOsbQk2x7zIiIX
         CgAQ==
X-Gm-Message-State: AA+aEWbdBPVIGEczgt+/JxVviIO2JFFNmjJFBUH/oVVqdeHCc/5f80mO
        wT0f6gfJjt+BUGcj4TtRipiFzHod59BURi8DSQ==
X-Google-Smtp-Source: AFSGD/W295SA9uQLpCCc6OGp9eUjomqYd0htfZ7bydooizYHZi08nl66rQowi+RjD57V5T1tJ+ZpnXngOinhdNwztpM=
X-Received: by 2002:a50:9feb:: with SMTP id c98mr1312405edf.253.1545373086325;
 Thu, 20 Dec 2018 22:18:06 -0800 (PST)
MIME-Version: 1.0
References: <1545299439-31370-1-git-send-email-kernelfans@gmail.com>
 <1545299439-31370-3-git-send-email-kernelfans@gmail.com> <20181220113547.GC9104@dhcp22.suse.cz>
 <CAFgQCTvxNGTKD+DP_LxF86WoVnCHnPkWoSqdGeXQxXNVYD_orw@mail.gmail.com> <20181220124419.GD9104@dhcp22.suse.cz>
In-Reply-To: <20181220124419.GD9104@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 21 Dec 2018 14:17:54 +0800
Message-ID: <CAFgQCTsTTQLyEr6NG4QvpYuuovathge6t+1ej_1edkGCai-jXw@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] mm/numa: build zonelist when alloc for device on
 offline node
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 8:44 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 20-12-18 20:26:28, Pingfan Liu wrote:
> > On Thu, Dec 20, 2018 at 7:35 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Thu 20-12-18 17:50:38, Pingfan Liu wrote:
> > > [...]
> > > > @@ -453,7 +456,12 @@ static inline int gfp_zonelist(gfp_t flags)
> > > >   */
> > > >  static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
> > > >  {
> > > > -     return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
> > > > +     if (unlikely(!possible_zonelists[nid])) {
> > > > +             WARN_ONCE(1, "alloc from offline node: %d\n", nid);
> > > > +             if (unlikely(build_fallback_zonelists(nid)))
> > > > +                     nid = first_online_node;
> > > > +     }
> > > > +     return possible_zonelists[nid] + gfp_zonelist(flags);
> > > >  }
> > >
> > > No, please don't do this. We do not want to make things work magically
> >
> > For magically, if you mean directly replies on zonelist instead of on
> > pgdat struct, then it is easy to change
>
> No, I mean that we _know_ which nodes are possible. Platform is supposed
> to tell us. We should just do the intialization properly. What we do now
> instead is a pile of hacks that fit magically together. And that should
> be changed.
>
Not agree. Here is the typical lazy to do, and at this point there is
also possible node info for us to check and build pgdat instance.

> > > and we definitely do not want to put something like that into the hot
> >
> > But  the cose of "unlikely" can be ignored, why can it not be placed
> > in the path?
>
> unlikely will simply put the code outside of the hot path. The condition
> is still there. There are people desperately fighting to get every
> single cycle out of the page allocator. Now you want them to pay a
> branch which is relevant only for few obscure HW setups.
>
Data is more convincing.
I test with the following program  built with -O2 on x86. No
observable performance difference between adding an extra unlikely
condition. And it is apparent that the frequency of checking on
unlikely is much higher than my patch.
#include <stdio.h>
#define unlikely_notrace(x)     __builtin_expect(!!(x), 0)
#define unlikely(x) unlikely_notrace(x)
#define TEST_UNLIKELY 1
int main(int argc, char *argv[])
{
        unsigned long i,j;
        unsigned long end = (unsigned long)1 << 36;
        unsigned long x = 9;
        for (i = 1; i < end; i++) {
#ifdef TEST_UNLIKELY
                if (unlikely(i == end - 1))
                        x *= 8;
#endif
                x *= i;
                x = x%100000 + 1;
        }
        return 0;
}

> > > path. We definitely need zonelists to be build transparently for all
> > > possible nodes during the init time.
> >
> > That is the point, whether the all nodes should be instanced at boot
> > time, or not be instanced until there is requirement.
>
> And that should be done at init time. We have all the information
> necessary at that time.
> --

Will see other guys' comment.

Thanks and regards,
Pingfan
