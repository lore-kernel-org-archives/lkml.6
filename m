Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A4EC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD912086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="jhS/HtgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD912086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeILBZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:25:27 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41201 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeILBZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:25:27 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so49786814oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vD0nD+HVjz2E0kSTNivs0qFVb5RwWM6144DPgBaKT3o=;
        b=jhS/HtgNQSGIyeq2ITSNkw/fCtE2EwxYw3cGsGCJBKN5mVC18Qge4P9l7zF0PeELSl
         gt/l7bhz2haatx7Nnf872PIZpiMJfPxZuDwoRv5VvOW0AkgA+QTdUmFQ5dM40t6CeZ8w
         ixxPvTWw0Ht5Bp7SACIY6dFBgBZuEMnaoIbk5voIEeKBcD57NODVEKjDAWCGW07y2SDB
         7fgTRXO8z+GsCARn5r/SqHWr53i8UevS02/gmBpR5+YzsZ5gLF3a2MAzcGtVD9t7s2YT
         x9xEJsB3jTbVR/l4cKxlYgbfEcPYRoYazRYDRKQzhzVtBiSQxpAFKC2gA0Xs2yxLfwlx
         cCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vD0nD+HVjz2E0kSTNivs0qFVb5RwWM6144DPgBaKT3o=;
        b=noZggeJlyP40XA6N12M4eFifAPHChm5ql709qEyvjEezzFI+RrY4C45wT0ezQUsoq9
         UFrPDU2XBdIj5PWo0xxI7GhqkM80g2A9xXcS30KuMeqnVu5X72xmbMz0T+XJOTsJEIZu
         GZ1AAOROfiRbjX8fRbEQb+QcCcgYL4p8D4crld2z0iEJP/wYq563GeSTM1Oc+bTL8fTS
         4Y9ei45fxLiB26t2oEnj1z5iLN4Ing+X9i9K/sJvaFqC76Xoui6Mo8Oj2uDFTIr29PMP
         RshIcRao/dqtsa38RrjpTwb5N79LsBxCJcMW1AoWRpE3LBhGiGQLO3d9E4r/k4e39ZWs
         7nCw==
X-Gm-Message-State: APzg51AFVloAhJCV2//58xzmnSCOHAouEnQIS3zv9ybgANUta9WNWLSp
        g47Z2Vpr6APPS8wZhkv9mbPF8NqF38ptHmDr819pvw==
X-Google-Smtp-Source: ANB0VdYOgzoTczsM9bNz8L4209K55kfD8MDKL5AcLgvbcuXQoCDBFui7s8tVmoIB708W/yPJdM6v9X7TvTe2yrInbDA=
X-Received: by 2002:aca:4914:: with SMTP id w20-v6mr31122838oia.5.1536697469581;
 Tue, 11 Sep 2018 13:24:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 13:24:29
 -0700 (PDT)
In-Reply-To: <CAKgT0UddVdf=+SnfeZ2hL=a47YkjOa+r96xnghP8r1fQZ_1Ycw@mail.gmail.com>
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
 <20180910234341.4068.26882.stgit@localhost.localdomain> <CAPcyv4j301Ma8D65oMzFo9-jVdwKGHzOVHb=7u9XaxACR5RAhg@mail.gmail.com>
 <CAKgT0UddVdf=+SnfeZ2hL=a47YkjOa+r96xnghP8r1fQZ_1Ycw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 Sep 2018 13:24:29 -0700
Message-ID: <CAPcyv4gV1q1RE5ck=+GcdydrN-_x3AqKPxF2sbCUhsafUov1Gw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Provide kernel parameter to allow disabling page
 init poisoning
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        pavel.tatashin@microsoft.com, Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 1:01 PM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On Tue, Sep 11, 2018 at 9:50 AM Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> On Mon, Sep 10, 2018 at 4:43 PM, Alexander Duyck
>> <alexander.duyck@gmail.com> wrote:
>> > From: Alexander Duyck <alexander.h.duyck@intel.com>
>> >
>> > On systems with a large amount of memory it can take a significant amount
>> > of time to initialize all of the page structs with the PAGE_POISON_PATTERN
>> > value. I have seen it take over 2 minutes to initialize a system with
>> > over 12GB of RAM.
>> >
>> > In order to work around the issue I had to disable CONFIG_DEBUG_VM and then
>> > the boot time returned to something much more reasonable as the
>> > arch_add_memory call completed in milliseconds versus seconds. However in
>> > doing that I had to disable all of the other VM debugging on the system.
>> >
>> > In order to work around a kernel that might have CONFIG_DEBUG_VM enabled on
>> > a system that has a large amount of memory I have added a new kernel
>> > parameter named "page_init_poison" that can be set to "off" in order to
>> > disable it.
>>
>> In anticipation of potentially more DEBUG_VM options wanting runtime
>> control I'd propose creating a new "vm_debug=" option for this modeled
>> after "slub_debug=" along with a CONFIG_DEBUG_VM_ON to turn on all
>> options.
>>
>> That way there is more differentiation for debug cases like this that
>> have significant performance impact when enabled.
>>
>> CONFIG_DEBUG_VM leaves optional debug capabilities disabled by default
>> unless CONFIG_DEBUG_VM_ON is also set.
>
> Based on earlier discussions I would assume that CONFIG_DEBUG_VM would
> imply CONFIG_DEBUG_VM_ON anyway since we don't want most of these
> disabled by default.
>
> In my mind we should be looking at a selective "vm_debug_disable="
> instead of something that would be turning on features.

Sorry, I missed those earlier discussions, so I won't push too hard if
this has been hashed before. My proposal for opt-in is the fact that
at least one known distribution kernel, Fedora, is shipping with
CONFIG_DEBUG_VM=y. They also ship with CONFIG_SLUB, but not
SLUB_DEBUG_ON. If we are going to picemeal enable some debug options
to be runtime controlled I think we should go further to start
clarifying the cheap vs the expensive checks and making the expensive
checks opt-in in the same spirit of SLUB_DEBUG.
