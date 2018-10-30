Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E72C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33BD20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="i2gDO7MX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33BD20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeJaAwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:52:14 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38525 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeJaAwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:52:13 -0400
Received: by mail-ot1-f65.google.com with SMTP id f24so5840220otl.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cBTw3wYT8YeicD7CM/nix+JIKpDpzrZ7yXAwZhKq6HM=;
        b=i2gDO7MXe467P88dNA9Oku1CAnmWAnZSKDJbbJao7681sN4BC6da6bHML3Dah1y4vD
         m2UdXqrHBSlITQn4vUCXsqwEy8m+RXJYWmrjMORSeAKp49WGnE4UKMHVfbCqumdYz8v8
         4JRA51wUGifc6B/hebGp5aFjY5JBYIwBU6S07QYbqi4gY/dL7GY4gDfbTxHFFLbJTKjI
         iqHffvjUs6t5GZCio3/dvvvWr8LZsH5WuKYjNrOpCW+2RD76hoIH9H4e87hv/TWeWPld
         zkqqurw2DXEimOnUdlUE+ei9xMMxfg/xB1ms9cU1KwcEFBoj5DMwi9+adzCzZ2UnvGFB
         8lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBTw3wYT8YeicD7CM/nix+JIKpDpzrZ7yXAwZhKq6HM=;
        b=qGOIf1Rt+vu/eE7h7cPF5NFpfUUUQ2ajiFcgZgmsiOreJOVS8QSq20qLewVx3k9ST4
         UICvENMR/qJkDh+BTSLWdaO+PZEYD+lxvq60uPcHGegB81wQE3o6NCYq6jIjvFuS5QaA
         cIdlCbhgj0L2uwnxPI3GQbzI1CDSL2THIFmzjjTtQli/R/wfLGVvrzRYbxzKMRCtGEiq
         1HijW2rqiFNwIqw8YSLgrdFjqtPQJR3AVQwqk8phyFbeNQ6AT9B47SWeCDm/zrxYapYi
         eMmHWxSiSy9Vf2yELS3cIatG1ylYs6wCFBo+CkupTkOsvmrxeYFN3aaWEtPtiMg+P0cZ
         8Q6w==
X-Gm-Message-State: AGRZ1gLGPi0hyDh2f4pPKehRAF55Iplh/L1j+l6+0qAIZzGtiAVGQNrB
        kolbDEhPmreuL3Yv+ImvxMgBOOSPkdAQsSCNkD0Z2A==
X-Google-Smtp-Source: AJdET5eAZT8srNh2COgFLhDueiSN7nQdEWVKgbUgzD+Eaa1ELRPfmasKnI9vq5fugnnWjT3WgP3SuReHK5f82Bsfh3Y=
X-Received: by 2002:a9d:2ff8:: with SMTP id b53mr6568960otd.229.1540915090793;
 Tue, 30 Oct 2018 08:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181029141210.GJ32673@dhcp22.suse.cz> <84f09883c16608ddd2ba88103f43ec6a1c649e97.camel@linux.intel.com>
 <20181029163528.GL32673@dhcp22.suse.cz> <18dfc5a0db11650ff31433311da32c95e19944d9.camel@linux.intel.com>
 <20181029172415.GM32673@dhcp22.suse.cz> <8e7a4311a240b241822945c0bb4095c9ffe5a14d.camel@linux.intel.com>
 <20181029181827.GO32673@dhcp22.suse.cz> <3281f3044fa231bbc1b02d5c5efca3502a0d05a8.camel@linux.intel.com>
 <20181030062915.GT32673@dhcp22.suse.cz> <CAPcyv4itSde5oiW2j5uK8PCqdpXkHKz=kS8NBk2Ge+Ldb=yLUg@mail.gmail.com>
 <20181030081757.GX32673@dhcp22.suse.cz>
In-Reply-To: <20181030081757.GX32673@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Oct 2018 08:57:58 -0700
Message-ID: <CAPcyv4jPoNC86wKH7aNiJfy0ZHKDZ6kTjjomeu8uFecuMNpqHA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     Michal Hocko <mhocko@kernel.org>
Cc:     alexander.h.duyck@linux.intel.com, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        osalvador@techadventures.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 1:18 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 29-10-18 23:55:12, Dan Williams wrote:
> > On Mon, Oct 29, 2018 at 11:29 PM Michal Hocko <mhocko@kernel.org> wrote:
[..]
> > That testing identified this initialization performance problem and
> > thankfully got it addressed in time for the current merge window.
>
> And I still cannot see a word about that in changelogs.

True, I would have preferred that commit 966cf44f637e "mm: defer
ZONE_DEVICE page initialization to the point where we init pgmap"
include some notes about the scaling advantages afforded by not
serializing memmap_init_zone() work. I think this information got
distributed across several patch series because removing the lock was
not sufficient by itself, Alex went further to also rework the
physical socket affinity of the nvdimm sub-system's async
initialization threads.

As the code gets refactored further it's a chance to add commentary on
the scaling expectations of the design.
