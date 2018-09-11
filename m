Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7153C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F05D20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="GPQn9khJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F05D20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeIKVvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:51:09 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37728 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbeIKVvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:51:08 -0400
Received: by mail-oi0-f66.google.com with SMTP id p84-v6so48508189oic.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lNj2SyibD2/ZFnLTJC7LDZoFwwKQA0POEalo9I1Io9U=;
        b=GPQn9khJsjfrDJGAnVbxcuxKwrFyYXG2d/aAYh6/S8Iaxt4Ws1i/E6da3gvSM0fCsY
         FsNiJhxmQySNLMwVBgDrfkbFJSzBNf7g37MvV/eIkQ0GvyLYg7mml4Hvp+Uv8df2DJkg
         fSg/axfsrneP99SD5xybI0vtG7sNatA35mjskE1mK7J4g/qvrBJC7TXlimln/9wsxgSY
         Hua68AqTOo0Afu6QXqL1i0aH/BVIiB1R+i6gcgoj2EtD6WHrjGaQeRCnZ6O/2JS984IS
         CcvA60AjWHtR8eVxxWar/f78mXNNs+2gqcmTdgt5j7ibyoZ27hh4jMERFG3oVbcyz+87
         4FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lNj2SyibD2/ZFnLTJC7LDZoFwwKQA0POEalo9I1Io9U=;
        b=n1WgJF07tf8YsmsXBIo1MI6gjqQl8a+dhvx8Z4xRSCeciwguylaCfd/3z04SguRnFR
         j/saodeCCQjpDGfZz1gPVMsT/tegwn68NoHktAmHcXRfbZTdEOUGTHFkqz31t0HeHSep
         Joufu0lXFlAUFamgnFuIbDK9tu5QUQf8A3rEcduyLJEzcjLoJ79mE4RsJGC6xu8UGk/q
         vBk0vdlkGb64oT5rbXoBiDhz0rYEHpWolfOjd3wDRnc3sGkvMBdo00spgAqGxDm0YrXR
         k6ZNokQHiOM1RuDN/HjMSUQ1HioHLBn6LZyc5e7zQEbdB4t6UHHmmV1ZH/W5NksKYJTL
         IzZg==
X-Gm-Message-State: APzg51DzlbF1hO0sSJuXSXfxaocw9uBRh0/XM8ViDxXJD8oW6I8TX4Uy
        JSypBazD/2YuOFNDgIY2s0yNQjAFrEjPIBYZ4XpImQ==
X-Google-Smtp-Source: ANB0VdbVL5CyKKPikkjnj7j+ybebrKpP2fMO3epvevW7SUDkWuE5LulDX/Gzl0SNljrMCoai8mX7FJE3PZK1q48E7UE=
X-Received: by 2002:aca:4914:: with SMTP id w20-v6mr30209869oia.5.1536684658387;
 Tue, 11 Sep 2018 09:50:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 09:50:57
 -0700 (PDT)
In-Reply-To: <20180910234341.4068.26882.stgit@localhost.localdomain>
References: <20180910232615.4068.29155.stgit@localhost.localdomain> <20180910234341.4068.26882.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 Sep 2018 09:50:57 -0700
Message-ID: <CAPcyv4j301Ma8D65oMzFo9-jVdwKGHzOVHb=7u9XaxACR5RAhg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Provide kernel parameter to allow disabling page
 init poisoning
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Mon, Sep 10, 2018 at 4:43 PM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
>
> On systems with a large amount of memory it can take a significant amount
> of time to initialize all of the page structs with the PAGE_POISON_PATTERN
> value. I have seen it take over 2 minutes to initialize a system with
> over 12GB of RAM.
>
> In order to work around the issue I had to disable CONFIG_DEBUG_VM and then
> the boot time returned to something much more reasonable as the
> arch_add_memory call completed in milliseconds versus seconds. However in
> doing that I had to disable all of the other VM debugging on the system.
>
> In order to work around a kernel that might have CONFIG_DEBUG_VM enabled on
> a system that has a large amount of memory I have added a new kernel
> parameter named "page_init_poison" that can be set to "off" in order to
> disable it.

In anticipation of potentially more DEBUG_VM options wanting runtime
control I'd propose creating a new "vm_debug=" option for this modeled
after "slub_debug=" along with a CONFIG_DEBUG_VM_ON to turn on all
options.

That way there is more differentiation for debug cases like this that
have significant performance impact when enabled.

CONFIG_DEBUG_VM leaves optional debug capabilities disabled by default
unless CONFIG_DEBUG_VM_ON is also set.
