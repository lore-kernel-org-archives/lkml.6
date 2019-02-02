Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1539AC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 05:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDA92086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 05:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="GDSqJfdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfBBF0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 00:26:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42014 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfBBF0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 00:26:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id v23so7938262otk.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 21:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEMNr9EgFC0bLddPJuZtvhocqlCPLLpahgYnShSd+k0=;
        b=GDSqJfdh1HT9eGdZXkOwmFETS7sphYCeYoaXOxWjmDBrwkdjPxgmbonWmvhEcLXK47
         mdY5cJwlrBDq3wAl2o7p2G69hSySDPrwYBBTXVStTJuNakw4zcurkdhAyzQgsdt0AVqX
         GZbnxKGoUHOCFqHj7qyD/6FAWm0kcMERYbc8XeM2AsP21vlGHEHSKLg80UboWFblghci
         T70+81d+dyIgxfMlg9qNhlGzfImv74uuk7iwQtiZDRWrnZfqVaFGvPq2QkRJ7NPoBs/z
         9P46EDQ9jYA6ZdVpcMhlhQrC5F2pmuNU3Vd+AYGSbZwLkiIJa6t2H3yZhEodjfJ3DWOm
         aASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEMNr9EgFC0bLddPJuZtvhocqlCPLLpahgYnShSd+k0=;
        b=MOvumn3hvyLUagxmxXFnvL9GswqLzTvyepTokZr0nMrZGHZ3fuuIg8S9qmvBp2mVZ+
         v6Z5doWGZi6VqvJgKMs4fNm1RaVAWyz4eDMxiJYjgZDX/A2NXmuIu4cyNV0ytvSyqyVA
         7pfqCP+aJEB0afyBWRvLk0TxUTb3b0Gm7ac5u/yVHDAdyHEKdzCjNxjMybJnVWUZFqML
         xpvNZI59s/JMiucsYRT6f3jnShKKsVnhAY94NMMtuK4BzPA788daaCv35BvjrRp5i8L8
         1wtuNSDH7RiHODgU4j1q12iAEOPae0lLckD2HDciO4lHfgofdi1YH9MXWSqAoLecITou
         +ALg==
X-Gm-Message-State: AJcUukdk2hSQh5JaLip4jw+J0ebcV35wjc/FuPoD2jfQvesJ7wp1OrdK
        x+853CIcSqpzukHQX0dW+GR5h6UXhNkUahhkZPpnLQ==
X-Google-Smtp-Source: ALg8bN7O4cTx/1c75XxOOG4ealnDnKudS0kOZ7ViHqIf5gEVsJs3g2fywMNFRMRuj65IgSqLXV0f908DhccXkfRsZiM=
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr31857435otn.214.1549085197562;
 Fri, 01 Feb 2019 21:26:37 -0800 (PST)
MIME-Version: 1.0
References: <PU1P153MB01690EDA138D3ABDE5B4A482BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4jD1oRWzA4ZiMYZm1uxsbOdgqzbb9raH70-HBDqapcE_g@mail.gmail.com>
 <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4haUouYs_Vfju2SMvjcwc7rqY06zqT8NJ-3uakGMZSu0w@mail.gmail.com>
 <PU1P153MB01694FCAF062E089059CD441BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4gdWJ8qtiASU9ggz56Mkrm9OXfsO74RM9OOrXFmBw_A9Q@mail.gmail.com>
 <PU1P153MB0169D8F7C6E29C22FE122F3FBF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <PU1P153MB0169D661955195EA070E7EF0BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4iEcCG0h+HLPkfSC0aNDLq9hdoO00XErF93PHTmEgO-TQ@mail.gmail.com> <PU1P153MB01692AB56F732623399A9EC5BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB01692AB56F732623399A9EC5BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 1 Feb 2019 21:26:25 -0800
Message-ID: <CAPcyv4g6mC09QZoPVbvuFuccovc-umdxHePXkKM2UQPo51gnZg@mail.gmail.com>
Subject: Re: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white list
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Josh Poulson <jopoulso@microsoft.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 7:32 PM Dexuan Cui <decui@microsoft.com> wrote:
>
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Friday, February 1, 2019 5:29 PM
> > ...
> > Honestly, the quickest path to something functional for Linux is to
> > simply delete the _LSR support and use raw mode defined namespaces.
> > Why have labels if they are read-only and the region is sufficient for
> > defining boundaries?
> Hyper-V Virtual NVDIMM can already work with Ubuntu 19.04 virtual machine
> running on Hyper-V, i.e. I can create a raw or fsdax namesapce, and create a
> xfs or ext4 file sysetm in /dev/pmem0p1, and mount the file system with and
> without "-o dax". The basic functionality is good.

Only in label-less mode apparently.

> My recent work is mainly for ndctl support, i.e. get the health info by ndctl,
> and use ndctl to monitor the error events (if applicable).

Right, but the recent fixes have exposed Linux to a labelled namespace
implementation that violates some of the driver's basic assumptions.

To preserve the level of operation you're currently seeing Linux might
need to add a hyper-v-specific quirk to force label-less operation.
