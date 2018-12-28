Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA9CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBFE20866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUG6U8gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbeL1S2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:28:44 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37077 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbeL1S2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 13:28:43 -0500
Received: by mail-qt1-f195.google.com with SMTP id t33so24131006qtt.4;
        Fri, 28 Dec 2018 10:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OTNffT1eaQTcLAFvhNIeVKJ7Ks4jO89gQtFc2V6+jxc=;
        b=jUG6U8gyE0Alt4dCEEdEDk07uJSsv2AxyaUFQYbBJkEFYAu5vHDV/GiLr6INd9lez6
         0UhHUrZgwErbcyXor/OQNXMHw2EShgs/2woci1E53qGKB1Ww6jWW8TxwaexcrRy3DdDs
         aADE9YRxF2BNelhszBtKIFNWemeRmXM/yRSYY2FyxAv0J764P4bFijA+wI7xjjyY4n2x
         grcohJbASFlIP1mGO223kt6hpP4aLxKr+ddyDWBqXLz/TP2GPEqq1aG3v96dLn2QjIFe
         4W/4tQtMkMUnj8aAtkNOJCZXGmfrrlO318fs6Wh6bDPzSh31mJOdY8fNGAtTPTSgIXSo
         L2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OTNffT1eaQTcLAFvhNIeVKJ7Ks4jO89gQtFc2V6+jxc=;
        b=PT/LztCxUDkau14sGAVEIa2vRiLj2YpURRo0zgZMl0N3OLHIlcPBZgcFmlj+O3Y2Hq
         /OJ6WxA//uedZj2lXs4cXK6Se+ok0QiySaJuL7oTxKOsUDB0YKacbpLepKfbgebDPx5J
         od2+IEwasZDmMbABpPP4ESDJ8weKEs/c7O8uf/00LkgbqVpvNoEvWaTGCHOxityoXkfF
         hmo/vVVJX6cRxqjThOeJwmTPSo3FKfaTNwDTzRwzjeSy15TrWyoFCaHGFL8H96G3YmFj
         ndmCnelkxVwsJSDa7tRpkTSEqYYBOJ72WIwASHq3thKkzsw6we8dq7QbNKM1s0pamHyI
         MEwA==
X-Gm-Message-State: AJcUukc7OYLplDGrrjqSGudHOA0rBvJzb/oPCuO/Aky0sk9O6BLqCbQd
        pcmAWIW3BPXmLMP9/UmwF42BwM+urnuqC6JxF6c=
X-Google-Smtp-Source: ALg8bN6RJdjZWgaVAH30ZoxdUdjJEqpmXXm26j1aZhLKG+0DgYFGZcwn6g8o/jfNjBK84H50M7BIgQMeXCPIJZOkxnM=
X-Received: by 2002:a0c:d29b:: with SMTP id q27mr27178531qvh.62.1546021722446;
 Fri, 28 Dec 2018 10:28:42 -0800 (PST)
MIME-Version: 1.0
References: <20181226131446.330864849@intel.com> <20181227203158.GO16738@dhcp22.suse.cz>
 <20181228050806.ewpxtwo3fpw7h3lq@wfg-t540p.sh.intel.com> <20181228084105.GQ16738@dhcp22.suse.cz>
 <20181228094208.7lgxhha34zpqu4db@wfg-t540p.sh.intel.com> <20181228121515.GS16738@dhcp22.suse.cz>
 <20181228133111.zromvopkfcg3m5oy@wfg-t540p.sh.intel.com>
In-Reply-To: <20181228133111.zromvopkfcg3m5oy@wfg-t540p.sh.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 28 Dec 2018 10:28:31 -0800
Message-ID: <CAHbLzkq91SY2s-N8sKReaQeC4z16DHsygFad4sqSzuXsZFzwQg@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 00/21] PMEM NUMA node and hotness accounting/migration
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Fan Du <fan.du@intel.com>,
        Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 5:31 AM Fengguang Wu <fengguang.wu@intel.com> wrote:
>
> >> > I haven't looked at the implementation yet but if you are proposing a
> >> > special cased zone lists then this is something CDM (Coherent Device
> >> > Memory) was trying to do two years ago and there was quite some
> >> > skepticism in the approach.
> >>
> >> It looks we are pretty different than CDM. :)
> >> We creating new NUMA nodes rather than CDM's new ZONE.
> >> The zonelists modification is just to make PMEM nodes more separated.
> >
> >Yes, this is exactly what CDM was after. Have a zone which is not
> >reachable without explicit request AFAIR. So no, I do not think you are
> >too different, you just use a different terminology ;)
>
> Got it. OK.. The fall back zonelists patch does need more thoughts.
>
> In long term POV, Linux should be prepared for multi-level memory.
> Then there will arise the need to "allocate from this level memory".
> So it looks good to have separated zonelists for each level of memory.

I tend to agree with Fengguang. We do have needs for finer grained
control to the usage of DRAM and PMEM, for example, controlling the
percentage of DRAM and PMEM for a specific VMA.

NUMA policy sounds not good enough for some usecases since it just can
control what mempolicy is used by what memory range. Our usecase's
memory access pattern is random in a VMA. So, we can't control the
percentage by mempolicy. We have to put PMEM into a separate zonelist
to make sure memory allocation happens on PMEM when certain criteria
is met as what Fengguang does in this patch series.

Thanks,
Yang

>
> On the other hand, there will also be page allocations that don't care
> about the exact memory level. So it looks reasonable to expect
> different kind of fallback zonelists that can be selected by NUMA policy.
>
> Thanks,
> Fengguang
>
