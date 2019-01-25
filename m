Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605A3C282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E942087E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="j0naHyGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfAYTPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:15:24 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44080 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYTPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:15:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id g16so5509373otg.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 11:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXX004AUcxBjaHmlWfnuskZBXjN2zPH5jsYaxqyIBbA=;
        b=j0naHyGZb7bTOZgS5cKphb1EaD6TDe8yYOuc3+W4EFKKF0dqoNYQZ0C4GxAOqGhQ0X
         pDtgQ8ti8VVxXkKWPEGq6sFIatbuZTQJsxj9O6U9667pmeSAPODPTPkR+ObAPZ7TYKAp
         b+S3oydSEbwteEh7fUofOubhcbLuzrle7wQ6ofNxh5mE5DmTJaj0CZHHIh1JePCh7Tpd
         no+lYtsUgMbOTmxgMlqB61uSNA2maTzIvV31tyt+a4Dj2bm94JzAvP/J3c+XsxUY15rR
         Hxif60hGnf80FZo9hzMvwmIq05FLlUTS0Ai7LIWG5rW6TKsGwyfUHyaPv9JrXdcZVs0/
         4tCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXX004AUcxBjaHmlWfnuskZBXjN2zPH5jsYaxqyIBbA=;
        b=U6pPiqBvKn7Y7dSMBaY5MWkDbGuhQlH/VMm01WTAsDJCjkbVomaFlrz8HYtsTOcmyG
         uhR4it/P9GJZ8fd9USDA4iAaCTxeeNvglDcNM84p2UrnCVntZf4Mmt/DXjCP+RtSiMIw
         M7DuAt3hpCFaQmFH2rwhKhi1FDeOqLob6yvd6mvlX5jhTwkEsT7oJtsA1eTU+WjP+kzB
         TexfiMZnywgNEUEu90wepl2LvSwF+SNEVBlUqgNm0EgzCvCET6p2v+HrfZjrUTz0KrsO
         HrhUi59TsDwF2rlU4WMTgtXCyRJiYMB54FSgnswfqyoZ2fCNFSgG60W+YFl0cXU6qG/3
         6KNg==
X-Gm-Message-State: AJcUukd5e31weJORQcqobhMoxa7K63MiSoUSxGKkdAaL64lZffzzl9il
        23IiDMUdE2HYSq/LvwyxFvEZjJrEGeeEqO1p3fPXog==
X-Google-Smtp-Source: ALg8bN6Kb8jFPohdwfb3jz7Y3w7BALuAbBbG0OIeL/vtE/+MMlIOH5lQdmAqpGvcB0DV1IB9r3F6bfAyrB9ZgAkju/M=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr8256461otn.95.1548443719889;
 Fri, 25 Jan 2019 11:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20190124231441.37A4A305@viggo.jf.intel.com> <20190124231448.E102D18E@viggo.jf.intel.com>
 <0852310e-41dc-dc96-2da5-11350f5adce6@oracle.com> <CAPcyv4hjJhUQpMy1CVJZur0Ssr7Cr2fkcD50L5gzx6v_KY14vg@mail.gmail.com>
 <5A90DA2E42F8AE43BC4A093BF067884825733A5B@SHSMSX104.ccr.corp.intel.com>
 <CAPcyv4ikXD8rJAmV6tGNiq56m_ZXPZNrYkTwOSUJ7D1O_M5s=w@mail.gmail.com>
 <b7d45d83a314955e7dff25401dfc0d4f4247cfcd.camel@intel.com> <dc7d8190-2c94-9bdb-fb5b-a80a3fb55822@oracle.com>
In-Reply-To: <dc7d8190-2c94-9bdb-fb5b-a80a3fb55822@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 25 Jan 2019 11:15:08 -0800
Message-ID: <CAPcyv4hEyG-1hC=20M7YGFG-BF7yvNcG7EkLurAfysHHB2yXBA@mail.gmail.com>
Subject: Re: [PATCH 5/5] dax: "Hotplug" persistent memory for use like normal RAM
To:     Jane Chu <jane.chu@oracle.com>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
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
        "mhocko@suse.com" <mhocko@suse.com>,
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

On Fri, Jan 25, 2019 at 11:10 AM Jane Chu <jane.chu@oracle.com> wrote:
>
>
> On 1/25/2019 10:20 AM, Verma, Vishal L wrote:
> >
> > On Fri, 2019-01-25 at 09:18 -0800, Dan Williams wrote:
> >> On Fri, Jan 25, 2019 at 12:20 AM Du, Fan <fan.du@intel.com> wrote:
> >>> Dan
> >>>
> >>> Thanks for the insights!
> >>>
> >>> Can I say, the UCE is delivered from h/w to OS in a single way in
> >>> case of machine
> >>> check, only PMEM/DAX stuff filter out UC address and managed in its
> >>> own way by
> >>> badblocks, if PMEM/DAX doesn't do so, then common RAS workflow will
> >>> kick in,
> >>> right?
> >>
> >> The common RAS workflow always kicks in, it's just the page state
> >> presented by a DAX mapping needs distinct handling. Once it is
> >> hot-plugged it no longer needs to be treated differently than "System
> >> RAM".
> >>
> >>> And how about when ARS is involved but no machine check fired for
> >>> the function
> >>> of this patchset?
> >>
> >> The hotplug effectively disconnects this address range from the ARS
> >> results. They will still be reported in the libnvdimm "region" level
> >> badblocks instance, but there's no safe / coordinated way to go clear
> >> those errors without additional kernel enabling. There is no "clear
> >> error" semantic for "System RAM".
> >>
> > Perhaps as future enabling, the kernel can go perform "clear error" for
> > offlined pages, and make them usable again. But I'm not sure how
> > prepared mm is to re-accept pages previously offlined.
> >
>
> Offlining a DRAM backed page due to an UC makes sense because
>   a. the physical DRAM cell might still have an error
>   b. power cycle, scrubing could potentially 'repair' the DRAM cell,
> making the page usable again.
>
> But for a PMEM backed page, neither is true. If a poison bit is set in
> a page, that indicates the underlying hardware has completed the repair
> work, all that's left is for software to recover.  Secondly, because
> poison is persistent, unless software explicitly clear the bit,
> the page is permanently unusable.

Not permanently... system-owner always has the option to use the
device-DAX and ARS mechanisms to clear errors at the next boot.
There's just no kernel enabling to do that automatically as a part of
this patch set.

However, we should consider this along with the userspace enabling to
control which device-dax instances are set aside for hotplug. It would
make sense to have a "clear errors before hotplug" configuration
option.
