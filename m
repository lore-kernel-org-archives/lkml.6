Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C482BECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650EC2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbJ6Ixj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650EC2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbeGQVLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:11:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44759 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeGQVLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:11:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id f23-v6so2317259edr.11;
        Tue, 17 Jul 2018 13:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mq0wjIinXUIxJsBWkS5q5JkX0v0DbP74sXNxSL+VwNI=;
        b=XbJ6Ixj1hMxStVgmxT6ijhOrSjIeGWflqqqaxQbXDwnpFrNlYNzmdxNQRIVJMudhQj
         tHBhSCYu+JVY2V1fBSicFcU8ogxD/zGtV1sOY6MJ0klWdIq9qYrKbvNxPDimw0HodYkw
         6OyuBTnAcU/+PMFSjKSEry2TSKYZpQHiSCfhXQurQGpTDK8yziUoeo5XHA94tD/XYH/c
         X4NOR/Ohui4N/1OelfxG6Nvr3RrSsDngmpv1TEY4ta/KvtV/BmwB117KTcfgu5YCsbXy
         PWLRchA5jxQFf5xT15ewfAAmn2GPRh+Z00/UValW1ckJ5BToJHtv/4NIvv93fx362lx7
         4MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mq0wjIinXUIxJsBWkS5q5JkX0v0DbP74sXNxSL+VwNI=;
        b=TlSIB/5rxL9z/yQS84m6rVOz2Uv2EfLv+0bR5WcB9bz5Z6Xfd2W5DvJXY1KeCLVpRp
         ooaXS1XOffi52qAfDQh8qX57LKDSBeQyO7iKX8+cZ68RqoKbTT66wAquKWwlwY1H+/GR
         1a0VxYi+6wbfTHe4t1FW+rlnrMdnJZLno1Wfil2IsqijoKRs/g/EwnQnrhiQYf3y+gmx
         9oQ4K8UlqDc2kpK2ZVllhEDLgN67vmTEG7iRTW4R/b5W17j3QYa2PL6gMiXnvkQ4UBQo
         cBB39XOyQxVwWelgupTVU5C96Kie1pnwMq5zSL8ADB85CWeSLAMsQLJ+WGRFHUtBKEXw
         z7Kw==
X-Gm-Message-State: AOUpUlHkjhvHBAXPl+oq61ImhDdoQHncWNQIqkMP9XAmKimu/EzQL654
        ZnNTuzrxQ2AErWahsBlqVfpsJtzMdFN1mo39sss=
X-Google-Smtp-Source: AAOMgpdr2iCbMEChbBBjIxFHJQQgWXzFt4Lt4iUUUzVnSe1qE1HTw0iY3ZUeT8+SANSJeEl2AEABvDd4XTQG9BkWzQc=
X-Received: by 2002:a50:a166:: with SMTP id 93-v6mr3845041edj.184.1531859852816;
 Tue, 17 Jul 2018 13:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180717120651.15748-1-dsahern@kernel.org> <CAM_iQpW4g2v6xk49Gz+WBasKaO9VUk3Q-umX7iBRK-mAhn21Fw@mail.gmail.com>
 <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com> <CAM_iQpWabZorkMNswyfHyS4KT=f_bgMtK8K35=84uah6Kfqxew@mail.gmail.com>
 <1a27e301-3275-b349-a2f8-afdfdc02f04f@gmail.com>
In-Reply-To: <1a27e301-3275-b349-a2f8-afdfdc02f04f@gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 17 Jul 2018 13:37:26 -0700
Message-ID: <CAM_iQpX-wZooTDqWeqtqAc=a-S2HVcJJtkKdn6gxZx-2YmXpmA@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to per-namespace
To:     David Ahern <dsahern@gmail.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        nikita.leshchenko@oracle.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Alexander Aring <alex.aring@gmail.com>,
        linux-wpan@vger.kernel.org,
        NetFilter <netfilter-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:02 PM David Ahern <dsahern@gmail.com> wrote:
> As for the per-namespace tables, it is 4 years later and over that time
> Linux supports a number of features: EVPN which is very mac heavy, VRR
> which doubles mac entries (one against the VRR device and one against
> the lower device) and NOS level features such as mlxsw which has to
> ensure mac entries for nexthop gateaways stay active. In addition there
> are other features on the horizon - like the ability to use namespaces
> to create virtual switches (what Cisco calls a VDC) where you absolutely
> want isolation and not allowing entries from virtual switch to evict
> entries from another. And of course the continued proliferation of
> containerized workloads where isolation is desired.

As long as no change in neigh table code base itself, these can't
address the concern people raised before.


>
> I understand the concern about global resource and limits: as it stands
> you have to increase the limits in init_net to the max expected and hope
> for the best. With per namespace limits you can lower the limits of each
> namespace better control the total impact on the total memory used.

The problem is that the number of containers in a host is usually
not predictable.

Of course, you can say containers limit kernel memory too, but
memcg is not part of netns. I once told David Miller cpuset is the
isolation for isolating per-CPU softnet_data, he didn't like it. Based
on that I don't think you can convince him with memcg as a solution
here.
