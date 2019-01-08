Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF994C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EDB20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uRA9FLk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfAHRYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:24:32 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34586 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHRYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:24:30 -0500
Received: by mail-yw1-f67.google.com with SMTP id g75so1852150ywb.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GL7wYni0pGBI7aKT681Y9wbnQ+0L1OweM8XEjJxZKZE=;
        b=uRA9FLk3Ovq2/XZxEHM2QLRek+WzIngFkYCX3CdbfBujIgMjYlURKFJTkCqMKnlg44
         HcTyBZPM9hapyuyfqpFkC7th4LT/bgZ5Z1pLcrMinIB/7XaM91dypigXQH8QNmpDekRr
         l5NYpZKQHiJXK+rRER9tN7yyPJf4hkW13NfxncUnNHR5/B3GePIGssO5C0QNI2ncf/Lu
         COusA3Q5IxD60f5GjhqRawqlo496Ct8CEFgiLoiiDa5U99tvWPew1CYtIU/KCXc3E1fY
         26LJa1uvTNSITIUauX+AUKpWxqWckosoZSoHybTkAWs9UrLKb6fEh+Dx4hdPthl7TqKM
         uleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GL7wYni0pGBI7aKT681Y9wbnQ+0L1OweM8XEjJxZKZE=;
        b=rA9Yq406tG5XqT6K7cP9hzq04x+tJOIPhssNTsxg+d4+alYRfqgX6Qe2yjEI4Sdf6x
         q9UxfsLftCkOIC279f51bTtgSr3qBqH8CCvMZwZineLP+hLzx+wpkjF1EqihiaLpVhEo
         Uy4Nu2hbAWSs40+zrXwqzZJUJR84YbtnYGROljG5IFWKb3fAeGovyuGinwI0Oiztfq6/
         O3r+WHC38lHO2p0Rsyy1jSgh/rkoFmzyW2FX4EmR+eIZgieDEy1nFnmSnA2Mvq2wxG7S
         HnQJen0pMVR3mg+QBvUHt4aZ2BjEUkbNAcUVejKBS7iJ1QMvfHvwrxzz4xeH8F2V6Z/3
         jgqQ==
X-Gm-Message-State: AJcUukcsNB3QPX0vfDfxKgnTN+pWTdKMw3gJmnJ8V5+QfawEz55NsQHi
        4LIqDy/+pUTmb0JqxmkX+7w4O9l+LU4WFjy4Wm731w==
X-Google-Smtp-Source: ALg8bN7UwPvwt91L36Lu6AysokOtoUleNIpTS0we+Yx31UnfjEVTVhxicsUhuZFn25YXZr40gyokug0U4gubFkJENr4=
X-Received: by 2002:a81:ee07:: with SMTP id l7mr2481282ywm.489.1546968269670;
 Tue, 08 Jan 2019 09:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20190103015638.205424-1-shakeelb@google.com> <20190108145942.GZ31793@dhcp22.suse.cz>
In-Reply-To: <20190108145942.GZ31793@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 8 Jan 2019 09:24:18 -0800
Message-ID: <CALvZod6sx6tA2EvnXZ_h=qZu6xtcL14uSMyp-gqxedy8T0L6qg@mail.gmail.com>
Subject: Re: [PATCH] memcg: schedule high reclaim for remote memcgs on high_work
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 6:59 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 02-01-19 17:56:38, Shakeel Butt wrote:
> > If a memcg is over high limit, memory reclaim is scheduled to run on
> > return-to-userland. However it is assumed that the memcg is the current
> > process's memcg. With remote memcg charging for kmem or swapping in a
> > page charged to remote memcg, current process can trigger reclaim on
> > remote memcg. So, schduling reclaim on return-to-userland for remote
> > memcgs will ignore the high reclaim altogether. So, punt the high
> > reclaim of remote memcgs to high_work.
>
> Have you seen this happening in real life workloads?

No, just during code review.

> And is this offloading what we really want to do?

That's the question I am brainstorming nowadays. More generally how
memcg-oom-kill should work in the remote memcg charging case.

> I mean it is clearly the current
> task that has triggered the remote charge so why should we offload that
> work to a system? Is there any reason we cannot reclaim on the remote
> memcg from the return-to-userland path?
>

The only reason I did this was the code was much simpler but I see
that the current is charging the given memcg and maybe even
reclaiming, so, why not do the high reclaim as well. I will update the
patch.

thanks,
Shakeel
