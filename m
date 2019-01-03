Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A76C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937CA208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9PpFd3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbfACQSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:18:23 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41643 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730643AbfACQSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:18:22 -0500
Received: by mail-yb1-f193.google.com with SMTP id j10so10582101ybj.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 08:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nRuzp0vI0flryI3MP5+vDJIF6vIrlB4Ktla0xA64B1Y=;
        b=P9PpFd3n7HFykVrlxL8ZDNljuAJ/n4gopOyvWY6bWuAMNKTRC8Xro/HUuAj2m+8Q+w
         tvTGTCrHEGsoSaFRZnR4jBBwCl5W5K+Jcap4iSOC29bEZeTvAQeh6LpUcYZt9UWRUDm/
         V07rtj1AARtUg4eJR1vZueQaNHE4PmTrtxvpLUb+Dx8b+DyI4KocCEC9E6gNMqfUKw2P
         ynAQgrWxWdMUZcFyR2dN+CkU7mHx40FNdy8gVu5iDVUfsUETVMEdbQunpaRdXfKb0KFs
         FmMikP6SYycVjla6fgf5S4WLb0KQsEnOPCXZ737utsNhrdzo1HfuovNeWa7cawc386Kl
         mgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nRuzp0vI0flryI3MP5+vDJIF6vIrlB4Ktla0xA64B1Y=;
        b=fWh0/HbbDai5f7OjAlHxmJ5eLEDrlrkIA12pXdXkChXB/Zo/ZyQh1mXppaTxR9ALOk
         xhHTiIc8Wydgh7AySUvLkdG5Y4w7/BezU+kZjZjtpL4QpBrp435rcfzGpR7Su3seub+W
         nat0ABP9JrH7ceM1hsuSnrZro/jaXxFISheFrkevnjn0Q+RtvL7d6doXAoPNIUvyfa7Q
         6Tt29CLbGkGx7E3Wb/tthEDK67Um+N3iT5ujq/y+TLnIVe4rVFGtAFVPL3zqeASihMkr
         xvMfvAW4w5wlbJiALGo1qdZMbsV8iCe2NJYAKOOJQ5d58a16Lm4/bIFp5La22dRa9fct
         RJTQ==
X-Gm-Message-State: AJcUukfY3NL0TiAgINUw9AorjI/LMRHH71Ryul5AbR75hf2fGzfQM4d5
        FsQCFlGWYbRkhd7U9o9rBMCplRLVtRbNNsIRhqEcrA==
X-Google-Smtp-Source: ALg8bN6zoDyrvoFDNcOIR1iqUPk80TIVnFl3r2XKj/GeBrT0vMCsvmgMujQF2FBzaT0VeIssxklpz2+N9+oihSzQ104=
X-Received: by 2002:a25:a269:: with SMTP id b96mr18971395ybi.148.1546532300334;
 Thu, 03 Jan 2019 08:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20190103031431.247970-1-shakeelb@google.com> <313C6566-289D-4973-BB15-857EED858DA3@oracle.com>
In-Reply-To: <313C6566-289D-4973-BB15-857EED858DA3@oracle.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 3 Jan 2019 08:18:09 -0800
Message-ID: <CALvZod5YSKZvWq13ptbfignECxLVH5H_1YbdvoghrmicuDwuSA@mail.gmail.com>
Subject: Re: [PATCH v2] netfilter: account ebt_table_info to kmemcg
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Westphal <fw@strlen.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 2:15 AM William Kucharski
<william.kucharski@oracle.com> wrote:
>
>
>
> > On Jan 2, 2019, at 8:14 PM, Shakeel Butt <shakeelb@google.com> wrote:
> >
> >       countersize = COUNTER_OFFSET(tmp.nentries) * nr_cpu_ids;
> > -     newinfo = vmalloc(sizeof(*newinfo) + countersize);
> > +     newinfo = __vmalloc(sizeof(*newinfo) + countersize, GFP_KERNEL_ACCOUNT,
> > +                         PAGE_KERNEL);
> >       if (!newinfo)
> >               return -ENOMEM;
> >
> >       if (countersize)
> >               memset(newinfo->counters, 0, countersize);
> >
> > -     newinfo->entries = vmalloc(tmp.entries_size);
> > +     newinfo->entries = __vmalloc(tmp.entries_size, GFP_KERNEL_ACCOUNT,
> > +                                  PAGE_KERNEL);
> >       if (!newinfo->entries) {
> >               ret = -ENOMEM;
> >               goto free_newinfo;
> > --
>
> Just out of curiosity, what are the actual sizes of these areas in typical use
> given __vmalloc() will be allocating by the page?
>

We don't really use this in production, so, I don't have a good idea
of the size in the typical case. The size depends on the workload. The
motivation behind this patch was the system OOM triggered by a syzbot
running in a restricted memcg.

Shakeel
