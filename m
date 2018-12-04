Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ED0C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FCD20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S14t0tlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FCD20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbeLDIk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:40:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33744 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDIkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:40:55 -0500
Received: by mail-ed1-f66.google.com with SMTP id p6so4905183eds.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 00:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=taMYfSr3Z1OLGbDUYyrbc/6grk+5DrFU2CpFJTK6Rj8=;
        b=S14t0tlCuMSkLpXGTZOM5uHrLh7bfZ9ZBGSfyzaOsc0eX5UIqAMiXW/h/LKjo7k6im
         T9WCeNShPge5mlB8HBfwf8w+YCD2RcfV9bjsXDHlURHVBJbhw/e6ilbi05uw1YN+DSka
         GDDQasK75MrCQpMvxdD40vWC2sC+BlI8wG8Dci0TAjicMOj25KjiBxn9ntNfz1aJRnzS
         WHx8wwAOjpcxeD2A5f0beAa1ITX8mlf0niH9oMu/fOHLk1rBsyacAVZ5ubZQB3TWUEGw
         GRkEz/IxJRzVmplBqmvkGRnPfe86lvCNe7HAwZaLnVr8BQmqROij5+dZ03GRw/qIAff7
         eLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=taMYfSr3Z1OLGbDUYyrbc/6grk+5DrFU2CpFJTK6Rj8=;
        b=N8+6wXf866lwX9s8T7uHoL0DMrHi0ZOGwo/+OaZCTRoAwzM9EP+DYQiDip7snAfg36
         xb5xArp/tNo5JEyG2lRAtLksgxKZxQx6htJdTQgei/zs5yqVGqXjzZMZQi/HM6yAU7os
         jaCPXU+BfJWdEVEv6N4vn6NEFsGKcb76U09Xxs3lOuytGpVXLb/HwN4RRUpOIBRgXejU
         tniXHncTHKxrBar1i04PR1+RPe/K6OEOAd+7u9rJgrVoH5JeoVd1NgXm85AM/s2sW44V
         x88QdiI1mXA1rcvnad23X4/BDSS1yv0TKL08e9z3ze3z4Hly2za1FkBqpGdCYqhp08p0
         87Lg==
X-Gm-Message-State: AA+aEWZUGReS+GLFz0DZUF8RtCJ96cRwLoAPUcNdmdEqGVFk3ofkEMvI
        /TjHNYEs3/nylYD5tJOG7mg=
X-Google-Smtp-Source: AFSGD/WgIuSeUMZtoBamhgHraODIQ0ub0bDxLDB2Km6sXyRstNlP61mJVKQ1WVaqMWayya+Z4duqxQ==
X-Received: by 2002:a50:fe15:: with SMTP id f21mr16388693edt.116.1543912853531;
        Tue, 04 Dec 2018 00:40:53 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id h47sm4667544eda.8.2018.12.04.00.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 00:40:53 -0800 (PST)
Date:   Tue, 4 Dec 2018 08:40:52 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     mhocko@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node
 offline
Message-ID: <20181204084052.gpwwlnp6n2zehjy5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
 <20181204072251.GT31738@dhcp22.suse.cz>
 <CAFgQCTv56drDBx-sTr6KdeQNKJnojG3g_a-k8wKe_q2y9w9NtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTv56drDBx-sTr6KdeQNKJnojG3g_a-k8wKe_q2y9w9NtA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 04:20:32PM +0800, Pingfan Liu wrote:
>On Tue, Dec 4, 2018 at 3:22 PM Michal Hocko <mhocko@kernel.org> wrote:
>>
>> On Tue 04-12-18 11:05:57, Pingfan Liu wrote:
>> > During my test on some AMD machine, with kexec -l nr_cpus=x option, the
>> > kernel failed to bootup, because some node's data struct can not be allocated,
>> > e.g, on x86, initialized by init_cpu_to_node()->init_memory_less_node(). But
>> > device->numa_node info is used as preferred_nid param for
>> > __alloc_pages_nodemask(), which causes NULL reference
>> >   ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
>> > This patch tries to fix the issue by falling back to the first online node,
>> > when encountering such corner case.
>>
>> We have seen similar issues already and the bug was usually that the
>> zonelists were not initialized yet or the node is completely bogus.
>> Zonelists should be initialized by build_all_zonelists quite early so I
>> am wondering whether the later is the case. What is the actual node
>> number the device is associated with?
>>
>The device's node num is 2. And in my case, I used nr_cpus param. Due
>to init_cpu_to_node() initialize all the possible node.  It is hard
>for me to figure out without this param, how zonelists is accessed
>before page allocator works.

If my understanding is correct, we can't do page alloc before zonelist
is initialized.

I guess Michal's point is to figure out this reason.

>
>> Your patch is not correct btw, because we want to fallback into the node in
>> the distance order rather into the first online node.
>> --
>What about this:
>+extern int find_next_best_node(int node, nodemask_t *used_node_mask);
>+
> /*
>  * We get the zone list from the current node and the gfp_mask.
>  * This zone list contains a maximum of MAXNODES*MAX_NR_ZONES zones.
>@@ -453,6 +455,11 @@ static inline int gfp_zonelist(gfp_t flags)
>  */
> static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
> {
>+       if (unlikely(!node_online(nid))) {
>+               nodemask_t used_mask;
>+               nodes_complement(used_mask, node_online_map);
>+               nid = find_next_best_node(nid, &used_mask);
>+       }
>        return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
> }
>
>I just finished the compiling, not test it yet, since the machine is
>not on hand yet. It needs some time to get it again.
>
>Thanks,
>Pingfan

-- 
Wei Yang
Help you, Help me
