Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F61C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DAF20811
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="2R9S32R3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390402AbfA1QfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:35:09 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36419 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388520AbfA1QfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:35:07 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so13539896oix.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3RfSfUYfpAZphq/vcCmv0IEDUe5SxwKKRVSXT2VCPcU=;
        b=2R9S32R3QbZIbFSXmkascFMRRVMAOiMqJ3qvr07hqBS1ju4LNBiYd8iN0aJlFJ/JOd
         ElwAmIWmUZVOJZh97bQmAQNPXvf4VeX/+ilxGHTi0QIP+0rQncKNqMKRYlz+MSD4MPWe
         7SOir2tSv8csXy26UxMYxsv2CVHTjd6wJ++zLlWA+0KqzFCGxEyu/6nu+5t98s1PMWuH
         5zQibZ8M9eYLnxd+kpWMF/5/REPgfD5P0t+Rn9anI3+Izb4dePLt3HH+s6g9ZII/B1ph
         ENHZXTvgfY1CqvGoI4ipoCYITGRfAZREThglH4ckIwDdQ19VSdjSvyi+R7cgPuXSRaKf
         txJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3RfSfUYfpAZphq/vcCmv0IEDUe5SxwKKRVSXT2VCPcU=;
        b=hgtjGQMAe6Fcs664nFGUUrwbvUbEGCxJoi1623EKmRbnvJZ4FY5bHjghyiJfP6pnit
         rHQvS5fEsVS9Eza5otxfl89bafn4c7bgW7lAC43T2+mYl1PCQh64+O7XCoLPd4KCB1iI
         a5mvuER+/jInCtYXHT+l/Zb4lXwRveIi679hZeZVGQw3nQqL04KxnXQAGDXz4f2G07bz
         hItPpNHy4lEdcvYSyy1VGe+kS0nSZYsCx4WiGIGKmPu8tW31w+XAIztWLr3ZwiDz1WVO
         khZ9dvDo/NII6nvrtbmvo4FFqrbYTLIGI7Re9Ddul4WNlMyTy0GOSngVVPLkzKBFhMna
         mU/g==
X-Gm-Message-State: AJcUukcfqQSxxTxOwjf6ZPH6v1RH/JNYHxJ8iG123rg9YRYWCjezaeuk
        oBVMguz9FO8ueut7KvYkYOp6eWrBUr2JSN5/mbfIOw==
X-Google-Smtp-Source: AHgI3IbgJFlk8tJrI0mFbIeJrfjOlDEgz5j1qQlr0yPgG1LT8xVUjEcpah7jVEe/+JNiBZ1fjnUfa6ZOjZFL+/OYxKM=
X-Received: by 2002:aca:b804:: with SMTP id i4mr6360983oif.280.1548693306097;
 Mon, 28 Jan 2019 08:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20190124231441.37A4A305@viggo.jf.intel.com> <20190124231448.E102D18E@viggo.jf.intel.com>
 <0852310e-41dc-dc96-2da5-11350f5adce6@oracle.com> <CAPcyv4hjJhUQpMy1CVJZur0Ssr7Cr2fkcD50L5gzx6v_KY14vg@mail.gmail.com>
 <5A90DA2E42F8AE43BC4A093BF067884825733A5B@SHSMSX104.ccr.corp.intel.com>
 <CAPcyv4ikXD8rJAmV6tGNiq56m_ZXPZNrYkTwOSUJ7D1O_M5s=w@mail.gmail.com>
 <b7d45d83a314955e7dff25401dfc0d4f4247cfcd.camel@intel.com>
 <dc7d8190-2c94-9bdb-fb5b-a80a3fb55822@oracle.com> <CAPcyv4hEyG-1hC=20M7YGFG-BF7yvNcG7EkLurAfysHHB2yXBA@mail.gmail.com>
 <20190128092549.GF18811@dhcp22.suse.cz>
In-Reply-To: <20190128092549.GF18811@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 28 Jan 2019 08:34:56 -0800
Message-ID: <CAPcyv4j2vmWXQO0QoBU5-yXBJBaEuDrPJ0t1tWkftCbwb4rnWA@mail.gmail.com>
Subject: Re: [PATCH 5/5] dax: "Hotplug" persistent memory for use like normal RAM
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jane Chu <jane.chu@oracle.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Du, Fan" <fan.du@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 1:26 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 25-01-19 11:15:08, Dan Williams wrote:
> [...]
> > However, we should consider this along with the userspace enabling to
> > control which device-dax instances are set aside for hotplug. It would
> > make sense to have a "clear errors before hotplug" configuration
> > option.
>
> I am not sure I understand. Do you mean to clear HWPoison when the
> memory is hotadded (add_pages) or onlined (resp. move_pfn_range_to_zone)?

Before the memory is hot-added via the kmem driver it shows up as an
independent persistent memory namespace. A namespace can be configured
as a block device and errors cleared by writing to the given "bad
block". Once all media errors are cleared the namespace can be
assigned as volatile memory to the core-kernel mm. The memory range
starts as a namespace each boot and must be hotplugged via startup
scripts, those scripts can be made to handle the bad block pruning.
