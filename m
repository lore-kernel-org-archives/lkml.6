Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BBAC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2202184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sTsQZeQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfACUxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:53:09 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34105 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfACUxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:53:08 -0500
Received: by mail-yb1-f194.google.com with SMTP id w6so9519189ybq.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 12:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GRC+e8lqJOGosZywWMxAPn3OsxYIJb83p4O3nDfq6mg=;
        b=sTsQZeQdrG8zu+wzyVKP746NktY7jBlU+tChfEIcRJgLTncpDFU6vVRJsCGUHNq/oH
         p3bTNNHUp3ojsKqo3qBu2iDAPGwlp734YhtgVR8tFcExKOoGed5h9G9mptzYFnLm0X5w
         4QbyKY41jyS3DBYk77kruQBX37U2WDyfp2VYgCoh/VKAqFNoiYQArxVGUyS7EsRfUqmo
         RaHpGpyjYTD4m3lq1dw1GVT2Ri9RnqLjpNVWeuR4bXtm29e2zKeSvB8kxvI9t2GCL78p
         GFdUsPo0lhkzot59BDcpNcU38qUl1QH/ZLKi8BWQOuMOEkdlD+dcJgC73bsKkSwfTJ6z
         g2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRC+e8lqJOGosZywWMxAPn3OsxYIJb83p4O3nDfq6mg=;
        b=TC8VcwhjHVwcvskrSlTkBFf+puf1xSYf0YHb2UvOm04777c90HolDiSjh1IClgMQJp
         SflbNqEj/FiEJun1k/DYX0FqvByiGctP9niWbKyoiLV16jGBxmhSRnT0nJYP6ZNhqAAn
         Vbb7rGHWa875SewlnVTR94yo4SCyuaGPhDApx8+k0EwwifXgblj1STmKgJS/3qqg+Yvv
         EMo2aJEVb/AeycsYIsaWZ4euukIqIMNM7hSJ/MhOfKttWPFngRja75ucvP4piTwzTum9
         7pOoeK81rA8HUmi7+sWVlcXEnqgmsSsZzNBM/5nrID3Kn3J2z1F4K/HSc+D8ybhrXqE0
         jXdA==
X-Gm-Message-State: AJcUukfZAXp9BNzLD2Gzuae7OEfIbsmHez3VdRehjLH3zzDNhao7Hkcg
        bDgIEDDNQFwxx/ebaJ2AUFJrHlmUFYf163ro8nUOcQ==
X-Google-Smtp-Source: ALg8bN4doCvWl/JB8l+4c0QFW7VaYDV4rj7A06Pi28x2T5ow7hUnfvDe6+QeYO2uRoJS3LfHJFylK7r1+jPmttgO4mM=
X-Received: by 2002:a5b:f01:: with SMTP id x1mr44935147ybr.464.1546548785896;
 Thu, 03 Jan 2019 12:53:05 -0800 (PST)
MIME-Version: 1.0
References: <20181229015524.222741-1-shakeelb@google.com> <20181229073325.GZ16738@dhcp22.suse.cz>
 <20181229095215.nbcijqacw5b6aho7@breakpoint.cc> <20181229100615.GB16738@dhcp22.suse.cz>
 <CALvZod7v-CC1XipLAerFj1Zp_M=qXZq6MzDL4pubJMTRCsMFNw@mail.gmail.com>
 <20181230074513.GA22445@dhcp22.suse.cz> <20181230080028.GB22445@dhcp22.suse.cz>
 <CALvZod6Ty30uQjJF8KZf=RS5djULaLVggYv_1WFrKJWaYa6EHw@mail.gmail.com> <20181231101158.GC22445@dhcp22.suse.cz>
In-Reply-To: <20181231101158.GC22445@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 3 Jan 2019 12:52:54 -0800
Message-ID: <CALvZod4sQ7ZEwfEefoNUeso2Va255x0jNgwOVZSU-b7+CevQuQ@mail.gmail.com>
Subject: Re: [PATCH] netfilter: account ebt_table_info to kmemcg
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, bridge@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 2:12 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Sun 30-12-18 19:59:53, Shakeel Butt wrote:
> > On Sun, Dec 30, 2018 at 12:00 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Sun 30-12-18 08:45:13, Michal Hocko wrote:
> > > > On Sat 29-12-18 11:34:29, Shakeel Butt wrote:
> > > > > On Sat, Dec 29, 2018 at 2:06 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > > >
> > > > > > On Sat 29-12-18 10:52:15, Florian Westphal wrote:
> > > > > > > Michal Hocko <mhocko@kernel.org> wrote:
> > > > > > > > On Fri 28-12-18 17:55:24, Shakeel Butt wrote:
> > > > > > > > > The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
> > > > > > > > > memory is already accounted to kmemcg. Do the same for ebtables. The
> > > > > > > > > syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
> > > > > > > > > whole system from a restricted memcg, a potential DoS.
> > > > > > > >
> > > > > > > > What is the lifetime of these objects? Are they bound to any process?
> > > > > > >
> > > > > > > No, they are not.
> > > > > > > They are free'd only when userspace requests it or the netns is
> > > > > > > destroyed.
> > > > > >
> > > > > > Then this is problematic, because the oom killer is not able to
> > > > > > guarantee the hard limit and so the excessive memory consumption cannot
> > > > > > be really contained. As a result the memcg will be basically useless
> > > > > > until somebody tears down the charged objects by other means. The memcg
> > > > > > oom killer will surely kill all the existing tasks in the cgroup and
> > > > > > this could somehow reduce the problem. Maybe this is sufficient for
> > > > > > some usecases but that should be properly analyzed and described in the
> > > > > > changelog.
> > > > > >
> > > > >
> > > > > Can you explain why you think the memcg hard limit will not be
> > > > > enforced? From what I understand, the memcg oom-killer will kill the
> > > > > allocating processes as you have mentioned. We do force charging for
> > > > > very limited conditions but here the memcg oom-killer will take care
> > > > > of
> > > >
> > > > I was talking about the force charge part. Depending on a specific
> > > > allocation and its life time this can gradually get us over hard limit
> > > > without any bound theoretically.
> > >
> > > Forgot to mention. Since b8c8a338f75e ("Revert "vmalloc: back off when
> > > the current task is killed"") there is no way to bail out from the
> > > vmalloc allocation loop so if the request is really large then the memcg
> > > oom will not help. Is that a problem here?
> > >
> >
> > Yes, I think it will be an issue here.
> >
> > > Maybe it is time to revisit fatal_signal_pending check.
> >
> > Yes, we will need something to handle the memcg OOM. I will think more
> > on that front or if you have any ideas, please do propose.
>
> I can see three options here:
>         - do not force charge on memcg oom or introduce a limited charge
>           overflow (reserves basically).
>         - revert the revert and reintroduce the fatal_signal_pending
>           check into vmalloc
>         - be more specific and check tsk_is_oom_victim in vmalloc and
>           fail
>

I think for the long term solution we might need something similar to
memcg oom reserves (1) but for quick fix I think we can do the
combination of (2) and (3).

Shakeel
