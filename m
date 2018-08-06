Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D13BC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADBE219E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0HsPQUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADBE219E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387396AbeHFV5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:57:19 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36989 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeHFV5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:57:18 -0400
Received: by mail-yw1-f65.google.com with SMTP id w76-v6so4049922ywg.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOg3RV8SRZCbnagjoEakArIwehGS+D2YXWWhBkXef64=;
        b=a0HsPQUzp+dDL+Kj6jG6XC0T5+Egcjof4Suj+875d0AH14F+ZJpY5a0ulCjjp6nLPt
         N7CgOEc5yJnsoP9mQVdNJeEDo4+TevLIGtw0o40O66tvj3YZRpoYukv2vrPjn1mKJ24n
         UMzvskfUxv7AiwwuSs9eNu8st67QTiW3sH3OCCmTKNPk9i7ZG9ypPaXiL9Q9Yd8HZcIb
         nqvTRYNxHxFyxHjaguRyxUgkkWVMIvyUvVPT7bX/HuHDVfqGJse5QqM2BnFinhwc7Xtd
         w1lt9wJ7re/i9e09QVD86/2yU1GB9M68lpLBdwRF+R3LcPMeXi+GxwXTfz+9pQqOOLM1
         MY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOg3RV8SRZCbnagjoEakArIwehGS+D2YXWWhBkXef64=;
        b=gDMYTGNn5TgexxUEvADDOHpt7w1CGT5xRp3S8v/qC9n595Go1yWy9f+L1hwMHt42Vp
         ljv9i5AdLcWyzqh0lk3eKXWBHwfjFjDW1WuW6QiIVZmqgmiGYSwjK+W/r2EdS+xOoEY/
         SOlD0UXM+VMguKfdsPKmSEOcAYzg0aSu1CEv5fXxp+AsxuXInJ5zEOmMz5IJjgRiy3ZG
         SMKWK6SZFTeo0ck0zsqrBDfI+2UYvC9hckJaUXyTBkK3dPMFF1TRziXXFtPEIllqdJv/
         CUfD84AiqEMC9JYupBoR67zlvoTfjDgyRuXjrj4kEMxr2sZbgbdepfmuN5k1Wc42tTXb
         D3xw==
X-Gm-Message-State: AOUpUlGWOf5N7gdPyTM5vjPieIhA7EWr6S8WKboZlaz6imsim9Sz1LOw
        lHrM4jUEDXPGgShH5oFDJrJ2hL5Zwbw5e61Q9d5I
X-Google-Smtp-Source: AAOMgpdgNZAe6w3bqnGwSmZMVemHFZDaDAjt24FLBGveQ8c1FWd3B60x52EQ9YpRqnML0w0HqFsEdxhUeZnSx5kc/Jg=
X-Received: by 2002:a0d:ea95:: with SMTP id t143-v6mr8426786ywe.383.1533584800967;
 Mon, 06 Aug 2018 12:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
 <20180723200339.23943-1-mr.nuke.me@gmail.com> <20180723140143.1a46902f@cakuba.netronome.com>
 <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com> <fc04618a-3b3b-58bd-edd5-cbde11638d7b@mellanox.com>
 <1b914780-e342-6aee-ffb2-ef81ac3ddd29@gmail.com> <7424c5ba-ae44-3d8d-9dd5-360e17b6e3b9@mellanox.com>
 <c0f2f79b1fe1491287b35e70ba76902a@ausx13mps321.AMER.DELL.COM>
In-Reply-To: <c0f2f79b1fe1491287b35e70ba76902a@ausx13mps321.AMER.DELL.COM>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 6 Aug 2018 14:46:28 -0500
Message-ID: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
Subject: Re: [PATCH v5] PCI: Check for PCIe downtraining conditions
To:     Alex_Gagniuc@dellteam.com
Cc:     Tal Gilboa <talgi@mellanox.com>, mr.nuke.me@gmail.com,
        jakub.kicinski@netronome.com, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>, Austin.Bolen@dell.com,
        Shyam.Iyer@dell.com,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        ariel.elior@cavium.com, michael.chan@broadcom.com,
        ganeshgr@chelsio.com, tariqt@mellanox.com,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 1:39 PM <Alex_Gagniuc@dellteam.com> wrote:
>
> On 08/05/2018 02:06 AM, Tal Gilboa wrote:
> > On 7/31/2018 6:10 PM, Alex G. wrote:
> >> On 07/31/2018 01:40 AM, Tal Gilboa wrote:
> >> [snip]
> >>>>>> @@ -2240,6 +2258,9 @@ static void pci_init_capabilities(struct
> >>>>>> pci_dev *dev)
> >>>>>>        /* Advanced Error Reporting */
> >>>>>>        pci_aer_init(dev);
> >>>>>> +    /* Check link and detect downtrain errors */
> >>>>>> +    pcie_check_upstream_link(dev);
> >>>>
> >>>> This is called for every PCIe device right? Won't there be a
> >>>> duplicated print in case a device loads with lower PCIe bandwidth
> >>>> than needed?
> >>>
> >>> Alex, can you comment on this please?
> >>
> >> Of course I can.
> >>
> >> There's one print at probe() time, which happens if bandwidth < max. I
> >> would think that's fine. There is a way to duplicate it, and that is if
> >> the driver also calls print_link_status(). A few driver maintainers who
> >> call it have indicated they'd be fine with removing it from the driver,
> >> and leaving it in the core PCI.
> >
> > We would be fine with that as well. Please include the removal in your
> > patches.
>
> What's the proper procedure? Do I wait for confirmation from Bjorn
> before knocking on maintainer's doors, or do I William Wallace into
> their trees and demand they merge the removal (pending Bjorn's approval
> on the other side) ?

Post a v4 series that does the PCI core stuff as well as removing the
driver code.

Bjorn
