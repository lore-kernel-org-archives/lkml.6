Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3816EC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A17F20815
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WsMYvGBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeLaEAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 23:00:07 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36646 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeLaEAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 23:00:06 -0500
Received: by mail-yb1-f193.google.com with SMTP id a190so7350665ybg.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 20:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eF0ABIO04VeZkpOY0d/MbtAbWyc/7osI9Wsdii8Iryw=;
        b=WsMYvGBBN2/J5TQQBVcqovv2bEfNjdCyIRg5kbp1wjhY/Prghg1P1M4P6CeojjVQXN
         +3Ld8voPys4iM6gA6ISn3mxmEZWHubo/kAKi1kehK/TgFErskZuHba6Ezpbjf1XxkTw/
         4Xgl/ptU9djk0dAr3/bz5veQ8TwQhYa4Hj5sH2Yl0OGhz20Uue2gr0hRvyIYzXuf2uUy
         jpYnUAZAKEsQeguKQCsNWjQ6ml7Pt3F1WgAjP/s3ws5a4k80Vv6tr565xOdRMKI91q4a
         PuXhoD0W8N7KzOZhNNwE2eTAl/5RYxCk2Ko49roCooUUhE6e+XQR0/EWtRMVZXF+XcqB
         Cmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eF0ABIO04VeZkpOY0d/MbtAbWyc/7osI9Wsdii8Iryw=;
        b=kmJtSwff/rEqaSzRL9QnV388BFlgss4zsSL0jDUglfe9vfrBvod6COSfGpBaQbP8lm
         aY2KrewzwdUh+R7XN6Q9wH6sUdH7Vk9uztb7yueiUgqNAEuGZg67huxBnMro4E7fYAf6
         nhDbZxJbSNu9PbYDiDE8HRdmQ8fSPGsEemF3GN1fJKjxKqQ3z5OxCZD8oVIwXHNnA0Ih
         syDSx2VpehOPKxxlK+vaD95Kz9R0+zQ3Q7+tIUqB/4RTyHlUaNzalN22s4PkdXoESSFg
         Q6Vt/OXzXrOBMDo/Qvqg2UvPEqgUOyLrftG2/rDVpdYi+i6DqjaCDbKC8GRt6gJQOwOE
         A66w==
X-Gm-Message-State: AJcUukew7+6djim5K3vRY+aB8atjfT28HeEYjaP+5bzBXwKBGs1sJ32x
        2aq6LTLc+cI73VTYRs4128plXUi65kftOQop+ruSNQ==
X-Google-Smtp-Source: ALg8bN4HAL0f10ML47/BEy5ZzmC8D6GegrQAY6kSTd7bulovhCXgr9ECCaW1Iun1vE9ts3AKBkL+jH2EmSF8qvxkQ68=
X-Received: by 2002:a25:c5c7:: with SMTP id v190mr24695789ybe.377.1546228804773;
 Sun, 30 Dec 2018 20:00:04 -0800 (PST)
MIME-Version: 1.0
References: <20181229015524.222741-1-shakeelb@google.com> <20181229073325.GZ16738@dhcp22.suse.cz>
 <20181229095215.nbcijqacw5b6aho7@breakpoint.cc> <20181229100615.GB16738@dhcp22.suse.cz>
 <CALvZod7v-CC1XipLAerFj1Zp_M=qXZq6MzDL4pubJMTRCsMFNw@mail.gmail.com>
 <20181230074513.GA22445@dhcp22.suse.cz> <20181230080028.GB22445@dhcp22.suse.cz>
In-Reply-To: <20181230080028.GB22445@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 30 Dec 2018 19:59:53 -0800
Message-ID: <CALvZod6Ty30uQjJF8KZf=RS5djULaLVggYv_1WFrKJWaYa6EHw@mail.gmail.com>
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

On Sun, Dec 30, 2018 at 12:00 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Sun 30-12-18 08:45:13, Michal Hocko wrote:
> > On Sat 29-12-18 11:34:29, Shakeel Butt wrote:
> > > On Sat, Dec 29, 2018 at 2:06 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Sat 29-12-18 10:52:15, Florian Westphal wrote:
> > > > > Michal Hocko <mhocko@kernel.org> wrote:
> > > > > > On Fri 28-12-18 17:55:24, Shakeel Butt wrote:
> > > > > > > The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
> > > > > > > memory is already accounted to kmemcg. Do the same for ebtables. The
> > > > > > > syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
> > > > > > > whole system from a restricted memcg, a potential DoS.
> > > > > >
> > > > > > What is the lifetime of these objects? Are they bound to any process?
> > > > >
> > > > > No, they are not.
> > > > > They are free'd only when userspace requests it or the netns is
> > > > > destroyed.
> > > >
> > > > Then this is problematic, because the oom killer is not able to
> > > > guarantee the hard limit and so the excessive memory consumption cannot
> > > > be really contained. As a result the memcg will be basically useless
> > > > until somebody tears down the charged objects by other means. The memcg
> > > > oom killer will surely kill all the existing tasks in the cgroup and
> > > > this could somehow reduce the problem. Maybe this is sufficient for
> > > > some usecases but that should be properly analyzed and described in the
> > > > changelog.
> > > >
> > >
> > > Can you explain why you think the memcg hard limit will not be
> > > enforced? From what I understand, the memcg oom-killer will kill the
> > > allocating processes as you have mentioned. We do force charging for
> > > very limited conditions but here the memcg oom-killer will take care
> > > of
> >
> > I was talking about the force charge part. Depending on a specific
> > allocation and its life time this can gradually get us over hard limit
> > without any bound theoretically.
>
> Forgot to mention. Since b8c8a338f75e ("Revert "vmalloc: back off when
> the current task is killed"") there is no way to bail out from the
> vmalloc allocation loop so if the request is really large then the memcg
> oom will not help. Is that a problem here?
>

Yes, I think it will be an issue here.

> Maybe it is time to revisit fatal_signal_pending check.

Yes, we will need something to handle the memcg OOM. I will think more
on that front or if you have any ideas, please do propose.

thanks,
Shakeel
