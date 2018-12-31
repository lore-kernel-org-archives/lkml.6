Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0484C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A008D20815
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RsuU+lvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeLaEBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 23:01:08 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37886 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeLaEBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 23:01:08 -0500
Received: by mail-yw1-f65.google.com with SMTP id h193so10222418ywc.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 20:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HucXhT1A5BsfCWwXDCGEmDntqGT95qD9mv34uGfHnxM=;
        b=RsuU+lvfvuTkfqdJFBT8SLdXXznzlurD/F+aInXrpFa6GSP1fSjyw9q2m3Bau5zyDI
         dbelbjh6tB6WNln9v0wEi7oYQ2qGhxKwygG0+EFT8hgVL9owteRvqjBDDIT+R80Hb5p7
         f91auxNDqrYHTqNyZdIno7sRFtGHqqvz2oqegQzfBlu+vAmNZ6IC647YOAwvgKDwimpo
         doJ7peKGizkv0XNrw6XE8DceI4Ucv6f5HjratekTiSaqsBXVe4S2Uf1iiermj/g3ZZFw
         tLmWb2exvIfMvyST/43xDhptQM90g8BqL+tHxDbTVJnT5QfAZPmj3D+oBkS9vdj80q7V
         33bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HucXhT1A5BsfCWwXDCGEmDntqGT95qD9mv34uGfHnxM=;
        b=jGcXS5q5HLt2UKbdkP5zTklHiGJHd4/igR5NZFyKSV6b0grJjh4Sn/lOc85Dix/HR/
         jV1rspuRUXULv/Jy0iRPQpcG/WmsoqkxMSvhalFXFjtwa4wqLq3Su+wY9qv/1Bgu80R1
         zPLlJD0dCKBJrfA4tLGO54HEe2khOpKmNLevzODJnpw+JR6ReymopI09mqs1c76AjeYq
         nR2xeLXQMWhSQItOKtdqyWOur6KmSuXI1xkntTWSNVzSME6WkP2DRslI0iIIjQRj/dfI
         CpmIbDOVLRR1g75vutsndAqbfFfROWWDTemBKiF8zbRDMEOCBeCxIOqE3qmC1Bp+lbzj
         LCJA==
X-Gm-Message-State: AA+aEWaYMk55yjvWDDhJoMyEZMIE/y6zTDLgtfx9dXX6w8x92XtkZL3l
        S66ImlC7MLyIDwjrrNR1s1EheJY3MaXw2QfVIu9xzQ==
X-Google-Smtp-Source: AFSGD/V4nZq7heg6xHqPmwYJmQWtTikncqxw/sJsQ9YY0Tk7m/QSKoI79X8QoNjMi43UVqebUtvkeLXv4lVFn3OObvs=
X-Received: by 2002:a81:7cd:: with SMTP id 196mr35500985ywh.255.1546228866798;
 Sun, 30 Dec 2018 20:01:06 -0800 (PST)
MIME-Version: 1.0
References: <20181229015524.222741-1-shakeelb@google.com> <20181229073325.GZ16738@dhcp22.suse.cz>
 <20181229095215.nbcijqacw5b6aho7@breakpoint.cc> <20181229100615.GB16738@dhcp22.suse.cz>
 <CALvZod7v-CC1XipLAerFj1Zp_M=qXZq6MzDL4pubJMTRCsMFNw@mail.gmail.com> <20181230074513.GA22445@dhcp22.suse.cz>
In-Reply-To: <20181230074513.GA22445@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 30 Dec 2018 20:00:55 -0800
Message-ID: <CALvZod7sCXxVXwfvsR3jR8apq1BVFwv1sOinrgUfW+H5K3RJww@mail.gmail.com>
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

On Sat, Dec 29, 2018 at 11:45 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Sat 29-12-18 11:34:29, Shakeel Butt wrote:
> > On Sat, Dec 29, 2018 at 2:06 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Sat 29-12-18 10:52:15, Florian Westphal wrote:
> > > > Michal Hocko <mhocko@kernel.org> wrote:
> > > > > On Fri 28-12-18 17:55:24, Shakeel Butt wrote:
> > > > > > The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
> > > > > > memory is already accounted to kmemcg. Do the same for ebtables. The
> > > > > > syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
> > > > > > whole system from a restricted memcg, a potential DoS.
> > > > >
> > > > > What is the lifetime of these objects? Are they bound to any process?
> > > >
> > > > No, they are not.
> > > > They are free'd only when userspace requests it or the netns is
> > > > destroyed.
> > >
> > > Then this is problematic, because the oom killer is not able to
> > > guarantee the hard limit and so the excessive memory consumption cannot
> > > be really contained. As a result the memcg will be basically useless
> > > until somebody tears down the charged objects by other means. The memcg
> > > oom killer will surely kill all the existing tasks in the cgroup and
> > > this could somehow reduce the problem. Maybe this is sufficient for
> > > some usecases but that should be properly analyzed and described in the
> > > changelog.
> > >
> >
> > Can you explain why you think the memcg hard limit will not be
> > enforced? From what I understand, the memcg oom-killer will kill the
> > allocating processes as you have mentioned. We do force charging for
> > very limited conditions but here the memcg oom-killer will take care
> > of
>
> I was talking about the force charge part. Depending on a specific
> allocation and its life time this can gradually get us over hard limit
> without any bound theoretically.
>
> > Anyways, the kernel is already charging the memory for
> > [ip,ip6,arp]_tables and this patch adds the charging for ebtables.
> > Without this patch, as Kirill has described and shown by syzbot, a low
> > priority memcg can force system OOM.
>
> I am not opposing the patch per-se. I would just like the changelog to
> be more descriptive about the life time and consequences.
> --

I will resend the patch with more detailed change log.

thanks,
Shakeel
