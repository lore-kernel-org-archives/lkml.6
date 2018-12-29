Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC90C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 19:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA1720873
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 19:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfTXSxz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeL2Tem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 14:34:42 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38230 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeL2Tem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 14:34:42 -0500
Received: by mail-yb1-f193.google.com with SMTP id x9so481661ybj.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 11:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rm4V5mvOJxeB4IxCyXzJR7q46ixdXejdpIGZhtAm/DA=;
        b=bfTXSxz5Zddw/9ltMyrfT7C5wJ9uM+MADH0R72Ii/MvtJvURondOXyRSWBmm4skOl4
         leG+tp5URxkh68+/zRBGOdfMRYN6lmMOwTlh5yWll6F1ySNDB7qOQTfCGoeNdsvUScQP
         r23wHoc8zIpmaE8eqbO1AtXnw0waCNnPCEYzpx9dndS0SxZezVgYC+izxyUjUHAz6isr
         rXi4UIMFCieB56GJJswjVSAwDCLICjJ51iU5ykcXMXk5IyJ3EpLj0tde7S3feAye/zKV
         5q2ABxhmpL7IRIC6s0gmGKnOhyk+fr3v6YSEimhQioHHMDqOPxuzxs7fmtW+a9keJIKP
         wWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rm4V5mvOJxeB4IxCyXzJR7q46ixdXejdpIGZhtAm/DA=;
        b=CXBjO2fkJx3sLpSZa7ePHEUYkGFl3Px9RYw9KjtRjahD6OAoBlSnDpzD/tzWEy/Cn3
         9VFeCzuAP5nLpHsaWKvKxxei6lpzqJjNDoShwke8GwNADRcZ+MLnDR2oiBJAvG37sAeA
         Lf7U6Cb/gRdqRyVSkWViWixVO1/UyevFQm07wNxqG7HvbRguPYCgrKIyzWiN9pdVSThQ
         NZkW38+D8pBzIa6oYTejmq7fHI3AUP7Wpb6O9g5YdfKVwjIm/Poz5LDElzJMihQ9gcZD
         +lOgO3aZJNYfDPiGeY2yfgDP9pBmxvQ/iFU3DDNcpPEyTjxdjnUeHGdl/b69dzMPDvbF
         RyKQ==
X-Gm-Message-State: AJcUukcFATYTFdkIdqS2cAonsw21bldpujNNBwh+Ex8R6P7EugpyJPjY
        4w8GoxCVi/zI/3B3H0qviUgzOjYQjrOdwYoEggEfYA==
X-Google-Smtp-Source: ALg8bN5dXmkJ/AmEgrcBLDrOSPMZRpne6/ywolwLjXUlixj8WqVeudQ9ZuX0qxUUbAeMy+YBwwKS9vBHci8vyP5hxGo=
X-Received: by 2002:a5b:f01:: with SMTP id x1mr27072891ybr.464.1546112080563;
 Sat, 29 Dec 2018 11:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20181229015524.222741-1-shakeelb@google.com> <20181229073325.GZ16738@dhcp22.suse.cz>
 <20181229095215.nbcijqacw5b6aho7@breakpoint.cc> <20181229100615.GB16738@dhcp22.suse.cz>
In-Reply-To: <20181229100615.GB16738@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 29 Dec 2018 11:34:29 -0800
Message-ID: <CALvZod7v-CC1XipLAerFj1Zp_M=qXZq6MzDL4pubJMTRCsMFNw@mail.gmail.com>
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

On Sat, Dec 29, 2018 at 2:06 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Sat 29-12-18 10:52:15, Florian Westphal wrote:
> > Michal Hocko <mhocko@kernel.org> wrote:
> > > On Fri 28-12-18 17:55:24, Shakeel Butt wrote:
> > > > The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
> > > > memory is already accounted to kmemcg. Do the same for ebtables. The
> > > > syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
> > > > whole system from a restricted memcg, a potential DoS.
> > >
> > > What is the lifetime of these objects? Are they bound to any process?
> >
> > No, they are not.
> > They are free'd only when userspace requests it or the netns is
> > destroyed.
>
> Then this is problematic, because the oom killer is not able to
> guarantee the hard limit and so the excessive memory consumption cannot
> be really contained. As a result the memcg will be basically useless
> until somebody tears down the charged objects by other means. The memcg
> oom killer will surely kill all the existing tasks in the cgroup and
> this could somehow reduce the problem. Maybe this is sufficient for
> some usecases but that should be properly analyzed and described in the
> changelog.
>

Can you explain why you think the memcg hard limit will not be
enforced? From what I understand, the memcg oom-killer will kill the
allocating processes as you have mentioned. We do force charging for
very limited conditions but here the memcg oom-killer will take care
of

Anyways, the kernel is already charging the memory for
[ip,ip6,arp]_tables and this patch adds the charging for ebtables.
Without this patch, as Kirill has described and shown by syzbot, a low
priority memcg can force system OOM.

Shakeel
