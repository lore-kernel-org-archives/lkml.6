Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8BFC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 05:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DD4218FF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 05:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="O4Wup4E7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfBBF17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 00:27:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45682 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfBBF17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 00:27:59 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so7908984ota.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 21:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1waq06OWdqq4vzz4nDS9UTwMPh42LYxUPqkoB1dv6e0=;
        b=O4Wup4E7kLH2Z5zP7r+3YAtogfPcy5CW+MndM8VigV1fh0sXV1bOcZ41dhZHcNLA3W
         HAhc267PoTa+CzoYcIQWk+dCt8J3RPqHMa93ovQrmG9GTfENDgaO2H7qusejFPGMorAh
         /NifSPmFKcvzhqDLGSuaN0umxmnq8zp0Wyth8fMvY5uhCy/s1P8wUBLL4kO5fdws7dvW
         kfwGDVxhDCLjwgjcnIIvMG/i3mSM/w7QmT915fzjBqV1ggvyECPabghO0kNwAHJkgrwt
         V1U5r5DgCwxKv3QjUTRQjFGyPCl+KSEn6RzHd1+YAxscHzAqo1lcYvaXy4Pw1d6H53Lr
         0jWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1waq06OWdqq4vzz4nDS9UTwMPh42LYxUPqkoB1dv6e0=;
        b=Bj2aYjJQlFJfa13bA04LLBivfFVfEu5w+q6rAMF+dq54B4mqYUCLaksTZPYhdqaTMa
         diw2wxCLme2+5LoqYMRJqNJzHRgPP+DhFllTlEEzRXvFwaxaB93fY68pPo4eu1LOj0/y
         A6jHvulCGxxBzTIt7rpBX0e7AWgC778vijJkJaoYG5T49qzh0TNi114n0QxwENB5I4p5
         XSoEUghQvlLHVhagpSUBnAT+EHjqTob5Mro7ZlDfp8GFukbCMISkxqdzuXDysrrmxHaa
         axZ3R7rFi/ZqKzRRF08o4+c5Hu85sNXGuLrH3M23x3uoq8GN0YxoP8e5kBXDCDa4xJe9
         tnLQ==
X-Gm-Message-State: AJcUukfTOwvR39gqKp0fAkk/a3aKBuilUVh1PzBnPVnoW8AVdWi6EnSx
        TR7JEktfq+LYaPkz2COb8MdxBfDx4hDBO671RB7QiQ==
X-Google-Smtp-Source: ALg8bN657zJTpp2Czdu8BXytUXFUAhsnfK3aV/dP3J9h09YiaoB/i7zqyXYEDFdsm9kAbSDjtj2O4Dek2WN681ZaA9I=
X-Received: by 2002:a9d:775a:: with SMTP id t26mr29340479otl.32.1549085278415;
 Fri, 01 Feb 2019 21:27:58 -0800 (PST)
MIME-Version: 1.0
References: <PU1P153MB01690EDA138D3ABDE5B4A482BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4jD1oRWzA4ZiMYZm1uxsbOdgqzbb9raH70-HBDqapcE_g@mail.gmail.com>
 <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4haUouYs_Vfju2SMvjcwc7rqY06zqT8NJ-3uakGMZSu0w@mail.gmail.com>
 <PU1P153MB01694FCAF062E089059CD441BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4gdWJ8qtiASU9ggz56Mkrm9OXfsO74RM9OOrXFmBw_A9Q@mail.gmail.com>
 <PU1P153MB0169D8F7C6E29C22FE122F3FBF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <PU1P153MB0169D661955195EA070E7EF0BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4iEcCG0h+HLPkfSC0aNDLq9hdoO00XErF93PHTmEgO-TQ@mail.gmail.com> <PU1P153MB0169FBCCB5639054FC0E6DB6BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169FBCCB5639054FC0E6DB6BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 1 Feb 2019 21:27:47 -0800
Message-ID: <CAPcyv4iv1dbAZ89OXizzHDucU0y254NC3CBW3pQ2hMER0gTk9Q@mail.gmail.com>
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

On Fri, Feb 1, 2019 at 6:17 PM Dexuan Cui <decui@microsoft.com> wrote:
> > From: Dan Williams <dan.j.williams@intel.com>
[..]
> > Honestly, the quickest path to something functional for Linux is to
> > simply delete the _LSR support and use raw mode defined namespaces.
> > Why have labels if they are read-only and the region is sufficient for
> > defining boundaries?
>
> Just now Hyper-V team confirmed _LSW is not supported.
>
> But with Ubuntu 19.04 kernel (4.18.0-11-generic), I'm able to run the commands
> without any issue:

This is because Ubuntu is running in "label-less" mode. So all the
writes it is performing for namespace reconfiguration are just going
to the data-space of the region, not the labels.
