Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31BBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96CC223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="U1e3BrYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96CC223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388694AbeKPD76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:59:58 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42984 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeKPD75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:59:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id w13so4873288oiw.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 09:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6cgZdosMlxyrO/beWziVKMNlEF4XdXAaq03i+0fKvo=;
        b=U1e3BrYhnKnjgROpn5otQDOIP+kPPehC8Jz+c6ylnY837pNV856o8eml2lLbN0EDm8
         CZsSeIZxAosLtA7JSLhvrtYgiVQ6p/o3TLV4qpWxIhu873Q/0wvv/Xds/M4IeNt5c0/x
         WFewaQK3894JZnWYvUR1ZObxZ6tx84nJXXZbALdikWGsVJTGrw/YKcoRH6aj4aXPBRKo
         EuIIQJTYTtu6V6gAbdZHkz54FR5Z4CvRpP3C4lVGB/HTgTg7DcRounn2UpFFllZ04ZiC
         XQcbnYncDgIj3RDezoZpxsEBHnr9TpG0nPgHTeXLfaxjwY91w4yV5UbeYYm40ttaRrH0
         492g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6cgZdosMlxyrO/beWziVKMNlEF4XdXAaq03i+0fKvo=;
        b=W5eGYFKD4JRXezTHDwLVGeGRRyrYnQYRv44gAfCgj7Ji89dtZnnJRQnLNf/4jf3zXt
         6HR+wgfZEXICSxhBIymjOFWZpNLbqOJVp7AiSZN6QyUHMD5iQTb+/WxdVCd7gBcNfW1J
         pnvj2rWfiBsoRDopW/ULUM2hUY9zO+pffVVfaRhuTbB6ka5iYqvXO8mYbSQrPVwqcG7i
         3yoSI/VTBnBOexwWBkm88Z/695wO2GZ+1oBEG9UVsktxUzhtXDyBdUmQroW9tFpEKDb9
         Rvpd/dlbE3G4g0F8v0/Y65mz1g8sE7Xc1OHFnsPHo65JNs/QHmeyED/wZL0PkbjofNec
         qj1Q==
X-Gm-Message-State: AGRZ1gJw80przQauM1Xxo3Yo5IntpSCGRBXCuiSe+slD6a6TEmg5LNDC
        D2NcD0yHDSaq3q5TMiuH0X21OnZWyuBLWbEpuOv9VQ==
X-Google-Smtp-Source: AJdET5erWR0SItIoTMUATFiCjB4kROhnmOmVu9x5PFAOB6ABQ0/37DDBB6IGrDUfrknEgLPqsl+3AqJjnP/zMhtQbsQ=
X-Received: by 2002:aca:e691:: with SMTP id d139-v6mr3958353oih.232.1542304269356;
 Thu, 15 Nov 2018 09:51:09 -0800 (PST)
MIME-Version: 1.0
References: <20181114224921.12123-2-keith.busch@intel.com> <20181115135710.GD19286@bombadil.infradead.org>
 <20181115145920.GG11416@localhost.localdomain>
In-Reply-To: <20181115145920.GG11416@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Nov 2018 09:50:58 -0800
Message-ID: <CAPcyv4iLSiJz6Z7qyjqpo=HUZQy-gAcaG69JytLPPGqOO157sg@mail.gmail.com>
Subject: Re: [PATCH 1/7] node: Link memory nodes to their compute nodes
To:     Keith Busch <keith.busch@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 7:02 AM Keith Busch <keith.busch@intel.com> wrote:
>
> On Thu, Nov 15, 2018 at 05:57:10AM -0800, Matthew Wilcox wrote:
> > On Wed, Nov 14, 2018 at 03:49:14PM -0700, Keith Busch wrote:
> > > Memory-only nodes will often have affinity to a compute node, and
> > > platforms have ways to express that locality relationship.
> > >
> > > A node containing CPUs or other DMA devices that can initiate memory
> > > access are referred to as "memory iniators". A "memory target" is a
> > > node that provides at least one phyiscal address range accessible to a
> > > memory initiator.
> >
> > I think I may be confused here.  If there is _no_ link from node X to
> > node Y, does that mean that node X's CPUs cannot access the memory on
> > node Y?  In my mind, all nodes can access all memory in the system,
> > just not with uniform bandwidth/latency.
>
> The link is just about which nodes are "local". It's like how nodes have
> a cpulist. Other CPUs not in the node's list can acces that node's memory,
> but the ones in the mask are local, and provide useful optimization hints.
>
> Would a node mask would be prefered to symlinks?

I think that would be more flexible, because the set of initiators
that may have "best" or "local" access to a target may be more than 1.
