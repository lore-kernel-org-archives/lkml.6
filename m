Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0579C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5B920839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQjm4Glb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5B920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeILBCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:02:41 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52760 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeILBCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:02:41 -0400
Received: by mail-it0-f67.google.com with SMTP id h3-v6so3251078ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 13:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tY3hAzyua46qM88cex1j7mbhN+b7279JkNfKSpk0DNY=;
        b=WQjm4Glb3dQsPSMKm2ZxaOnwTnTlyfFHqp8jAxmASn1Je/4kL/YESZnji8OpgHlZCz
         yILX4x/TXbNj8WY/I+A0znXW7OfDsZUF57ZXQcAgqSNDxzlT3QfIs2QhDr7MopU61e93
         UshdwxEY3oSkj45W/N8GtbBZoAEvt2USWP3Psir1ZDORO40wPZouzWfULu8xbq41G2YW
         16+1Q4pqBrxMs5SnLo85ryPcb9pjti/ABpozEQ0oObDoYKWqYtpt9o9XA2Dn0nYwBQlC
         34ubpM3OnKMbbRpRETlwSnFJX9e75DrygHUaw7yseagGXI6X9Tp8JsFKUFQo4iox7e9h
         qbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tY3hAzyua46qM88cex1j7mbhN+b7279JkNfKSpk0DNY=;
        b=V/IFhZbdQlFkOEuV1Jyocif7Er3giQD3WoTBAnXA0sAhGeFyLNIlHsioF3Zn9F3aMI
         EWZYm7qGuQcEheMCU6iAMBW/X6ZqjjSwExfbbxws/zY3g2ztai5PsufM4GwWCcEU7o65
         63p2r84J+vePBMoctiGKC+qQJDAnYlSPb9JMMxMiAzINrEDoYRyGnCDDlQUa/+wayK8R
         kJBLKi6AJMKLZkIIL4Rr7QZ1bAdda0Of2JDxLCtXlVOBKnJNxhOCnuiSRu4eoBH4mpJH
         cAgHWz/7hd+Zk1DIOGFk9Cud5fXmiUvrMXiGjW1D0NoT8YJEpmjweQ3w49losZGQlrs6
         Xu9A==
X-Gm-Message-State: APzg51ChsmFAncIKf2IMy7S4MJguxljFiVCdJrYD3wUq50KxLrpPI8jv
        qAuMpRIk/kY0bweCZQfmzeYbVSRGdu/Xy9NTuFo=
X-Google-Smtp-Source: ANB0VdYYVqw2AMFeABWfzp4ic9piWnh2O/44z0VIoYN6rH7/L2883hmSoLCeKjRSIP1R7uKjVHhNGSpQNGjgnHDffYE=
X-Received: by 2002:a24:ed84:: with SMTP id r126-v6mr3276827ith.58.1536696108998;
 Tue, 11 Sep 2018 13:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
 <20180910234341.4068.26882.stgit@localhost.localdomain> <CAPcyv4j301Ma8D65oMzFo9-jVdwKGHzOVHb=7u9XaxACR5RAhg@mail.gmail.com>
In-Reply-To: <CAPcyv4j301Ma8D65oMzFo9-jVdwKGHzOVHb=7u9XaxACR5RAhg@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 11 Sep 2018 13:01:37 -0700
Message-ID: <CAKgT0UddVdf=+SnfeZ2hL=a47YkjOa+r96xnghP8r1fQZ_1Ycw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Provide kernel parameter to allow disabling page
 init poisoning
To:     dan.j.williams@intel.com
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm@lists.01.org, pavel.tatashin@microsoft.com,
        Michal Hocko <mhocko@suse.com>, dave.jiang@intel.com,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, jglisse@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>, logang@deltatee.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 9:50 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Sep 10, 2018 at 4:43 PM, Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> > From: Alexander Duyck <alexander.h.duyck@intel.com>
> >
> > On systems with a large amount of memory it can take a significant amount
> > of time to initialize all of the page structs with the PAGE_POISON_PATTERN
> > value. I have seen it take over 2 minutes to initialize a system with
> > over 12GB of RAM.
> >
> > In order to work around the issue I had to disable CONFIG_DEBUG_VM and then
> > the boot time returned to something much more reasonable as the
> > arch_add_memory call completed in milliseconds versus seconds. However in
> > doing that I had to disable all of the other VM debugging on the system.
> >
> > In order to work around a kernel that might have CONFIG_DEBUG_VM enabled on
> > a system that has a large amount of memory I have added a new kernel
> > parameter named "page_init_poison" that can be set to "off" in order to
> > disable it.
>
> In anticipation of potentially more DEBUG_VM options wanting runtime
> control I'd propose creating a new "vm_debug=" option for this modeled
> after "slub_debug=" along with a CONFIG_DEBUG_VM_ON to turn on all
> options.
>
> That way there is more differentiation for debug cases like this that
> have significant performance impact when enabled.
>
> CONFIG_DEBUG_VM leaves optional debug capabilities disabled by default
> unless CONFIG_DEBUG_VM_ON is also set.

Based on earlier discussions I would assume that CONFIG_DEBUG_VM would
imply CONFIG_DEBUG_VM_ON anyway since we don't want most of these
disabled by default.

In my mind we should be looking at a selective "vm_debug_disable="
instead of something that would be turning on features.

- Alex
