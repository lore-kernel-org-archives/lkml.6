Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64239C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CBC2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UjPfCt97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CBC2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbeI1WPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:15:20 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42342 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbeI1WPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:15:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id h26-v6so6455667otl.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjBb3SQH/hsxIPobB+9r5d85WlcL1nVs52vIZOMa+bE=;
        b=UjPfCt971qK4Ooiyf51ime1IugxUXn+QnJaQZGysf9PqdWuh0xaFLa2oTkns5rTB8p
         Sb1K9Fy9Kx9af92II7788S5e6mKXjKxfuFlLIaATzhfR/mwadEj29KUgCfw9edRVBcjK
         VySmGzIsFKdxX+RmakF0O02sa5fXdb+TT0gHPLZDKpfQgB6DqnjJ3V/GI41F08VMTGLz
         g3mYFpjR09j2ObH4/EZyOH5nXEf+POEFjmQIChHAebsHTWulWio4WP3MfRxsIrBXmi0N
         dgrlCrOnKUWr9AE8yjTY7YKh0Os4ao3pYAy5+E1VmLhp5CfwGj90hTKEkYZzzg0qFZPA
         tJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjBb3SQH/hsxIPobB+9r5d85WlcL1nVs52vIZOMa+bE=;
        b=fQ4EOFr8BspgogBFicKHKP58lJ/pyUHWcU9RjV14JSvfUtUFKVDtrI1qQiM3bhyXOL
         DnXTZcfSZ3WNfW4Ek9HPtZTkdj0kVlApHYDGYHtxNoiNUMP+mVGYJHoAjWB0XB8umr2B
         CX/fsMvWkSME5oiZMozR6tb50QlaUNPi+oeQaJw51kvmIjbTcrJd6NLwsatRhTyscy7Q
         o/xSBFbUpoSXMZjcRjgSzgpXH+c9I4bczweeN1iIWMmCUv9FEl8YgGZZXImbOXp8WiN9
         2p4A0ahnAQwAphe4G4pOde1qR6piAiyi6jL7ayvbOOZDYbMxMI7EFRsyWyqgCM/JVBAf
         rP6Q==
X-Gm-Message-State: ABuFfogGt6MLwaTkh6tLBMIDvagUVX8jkUgcRFm78NQAzC7hZm85KJLr
        S75nODVokbAU8V4bDWrtkobksFa73XQP+SRBADbnwA==
X-Google-Smtp-Source: ACcGV61vOSraV3gCINzsgOdHSnTk0O2/dbNo3SMu961v45fNjqsOuGgShhXyQABt5Cz/0GTr0P1rDHrFPhbgFhUQDUU=
X-Received: by 2002:a9d:530c:: with SMTP id g12-v6mr10202171oth.353.1538149858104;
 Fri, 28 Sep 2018 08:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain> <20180926075540.GD6278@dhcp22.suse.cz>
 <6f87a5d7-05e2-00f4-8568-bb3521869cea@linux.intel.com> <20180927110926.GE6278@dhcp22.suse.cz>
 <20180927122537.GA20378@techadventures.net> <20180927131329.GI6278@dhcp22.suse.cz>
 <20180928081224.GA25561@techadventures.net> <20180928084433.GB25561@techadventures.net>
In-Reply-To: <20180928084433.GB25561@techadventures.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Sep 2018 08:50:46 -0700
Message-ID: <CAPcyv4hY97wL53Pa8oaq4UK6OS4R48_35nJhbY4SYmoMSctQHA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     osalvador@techadventures.net
Cc:     Michal Hocko <mhocko@kernel.org>,
        alexander.h.duyck@linux.intel.com, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Logan Gunthorpe <logang@deltatee.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 1:45 AM Oscar Salvador
<osalvador@techadventures.net> wrote:
>
> On Fri, Sep 28, 2018 at 10:12:24AM +0200, Oscar Salvador wrote:
> > Although I am not sure about leaving memmap_init_zone unprotected.
> > For the normal memory, that is not a problem since the memblock's lock
> > protects us from touching the same pages at the same time in online/offline_pages,
> > but for HMM/devm the story is different.
> >
> > I am totally unaware of HMM/devm, so I am not sure if its protected somehow.
> > e.g: what happens if devm_memremap_pages and devm_memremap_pages_release are running
> > at the same time for the same memory-range (with the assumption that the hotplug-lock
> > does not protect move_pfn_range_to_zone anymore).
>
> I guess that this could not happen since the device is not linked to devm_memremap_pages_release
> until the end with:
>
> devm_add_action(dev, devm_memremap_pages_release, pgmap)

It's a bug if devm_memremap_pages and devm_memremap_pages_release are
running simultaneously for the same range. This is enforced by the
requirement that the caller has done a successful request_region() on
the range before the call to map pages.
