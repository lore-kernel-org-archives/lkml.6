Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0033FC6778B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDA22779D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bEbx9eyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDA22779D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030294AbeF2Qrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:47:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50597 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937045AbeF2Qru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:47:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so1871204wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nq87er1CPWKjBXZsG0f/ULyEyFgKKkdh+fxUCLRX74Q=;
        b=bEbx9eyjv7c1R8JW6C8Xv1u3snwYDl5TxTO+3eFFpEl57QsHjrVlKyFJLQgNAOWRWs
         ZXrHzPDPybrWeY7wc4HwU046BCmENpOtSoe/0cvwWMTdvBcdnp8btXdYMt2FdK0pmKnf
         STLHZK/0Q9wFcUJS+BH9yjWI10oAr9gQuB10v7L/aXuHRir2oK4PIpzaO+ExFwdTLGUY
         EHOl1t8YloUGfUITewWTxlJT9es6brxZhvBHVKav3BW9D8fGuhgkp/fyWJ0skZWZrTrm
         KsxkqiJS0kvigk0WcmlTwGmEBndY0+TWLUk+WAlPSF7sVcb1cgG/zybqpoFbkQaUs+Qh
         VuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nq87er1CPWKjBXZsG0f/ULyEyFgKKkdh+fxUCLRX74Q=;
        b=XP26f5P6mEv5ibl2JezvrhzIf0yeB/BqGxowJCgMVxefT4IAQf00plPZPGjaT7UueE
         AFu1a1TB8FSVX4UvMzBuKxGFysNLxMx2RFjNjfEDQmhcACfjeNE0OVg32uBfg5OBJe0N
         R7nE60MrpuEjr7s0fRW1RqwZSs+SL1Cua+6hqiMFr60bo3hz/Z/T4RiOBsUZY5Hi1wUf
         0rUDNTR/2tepD+w55PhwL6xrvMlLDhAO0KFI4xPaVmek2LN3LmPV5Eqk4eRQU5tSV/DI
         koMdQBCWL9wq1QImmuRgogeBm9N7ZaghK0Yi9f1vbzbHzrhHKPXwLbFhslEhZoz2J8NI
         c7zQ==
X-Gm-Message-State: APt69E2LzxYaepTPs00bgQe9CAkAKBufOkmdqjqhD1njHT30IWyYS6UD
        ijl7lSOPrmP6pSL745oKX7vlglOu11oqkiSENB5R2Q==
X-Google-Smtp-Source: AAOMgpeX/3uiSbEW+6JunOf8REVY+x0olVSw2uSu5uzTvDp8dqIn5Ox2r72B2uEepfU7HUyBn0WQNanAWd6qd/CIX6Q=
X-Received: by 2002:a1c:9106:: with SMTP id t6-v6mr2418412wmd.2.1530290869054;
 Fri, 29 Jun 2018 09:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180629140224.205849-1-shakeelb@google.com> <20180629143044.GF5963@dhcp22.suse.cz>
 <efdb8e40-742e-d120-6589-96b4fdf83cb9@redhat.com> <20180629145513.GG5963@dhcp22.suse.cz>
In-Reply-To: <20180629145513.GG5963@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 29 Jun 2018 09:47:37 -0700
Message-ID: <CALvZod4wW0-bzM1AQCnAaMpLOzOdEzLVhf0LCqe3dmMyCSCsmw@mail.gmail.com>
Subject: Re: [PATCH v2] kvm, mm: account shadow page tables to kmemcg
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Peter Feiner <pfeiner@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 7:55 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 29-06-18 16:40:23, Paolo Bonzini wrote:
> > On 29/06/2018 16:30, Michal Hocko wrote:
> > > I am not familiar wtih kvm to judge but if we are going to account this
> > > memory we will probably want to let oom_badness know how much memory
> > > to account to a specific process. Is this something that we can do?
> > > We will probably need a new MM_KERNEL rss_stat stat for that purpose.
> > >
> > > Just to make it clear. I am not opposing to this patch but considering
> > > that shadow page tables might consume a lot of memory it would be good
> > > to know who is responsible for it from the OOM perspective. Something to
> > > solve on top of this.
> >
> > The amount of memory is generally proportional to the size of the
> > virtual machine memory, which is reflected directly into RSS.  Because
> > KVM processes are usually huge, and will probably dwarf everything else
> > in the system (except firefox and chromium of course :)), the general
> > order of magnitude of the oom_badness should be okay.
>
> I think we will need MM_KERNEL longterm anyway. As I've said this is not
> a must for this patch to go. But it is better to have a fair comparision
> and kill larger processes if at all possible. It seems this should be
> the case here.
>

I will look more into MM_KERNEL counter. I still have couple more kmem
allocations in kvm (like dirty bitmap) which I want to be accounted. I
will bundle them together.

thanks,
Shakeel
