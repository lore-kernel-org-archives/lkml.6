Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F3AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F20024C6D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F20024C6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbeFZWEf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 18:04:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:22033 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752621AbeFZWEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 18:04:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 15:04:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,276,1526367600"; 
   d="scan'208";a="66579134"
Received: from theros.lm.intel.com (HELO linux.intel.com) ([10.232.112.164])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jun 2018 15:04:30 -0700
Date:   Tue, 26 Jun 2018 16:04:30 -0600
From:   Ross Zwisler <ross.zwisler@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Kani, Toshi" <toshi.kani@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
Message-ID: <20180626220430.GA4269@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
References: <CAPcyv4iWgPnHmBKhUvhManC6UL9CkLqN_d8vBo6KmcPJdPzuUw@mail.gmail.com>
 <20180626185830.GA7171@redhat.com>
 <CAPcyv4h6HO6fs6k7QMD77jkz2djCeWCtWomCdNb0-1Q4VKanqw@mail.gmail.com>
 <20180626191346.GA7233@redhat.com>
 <1530046327.14039.273.camel@hpe.com>
 <CAPcyv4hP_Y3xdyCa-UkYCMJ5OtnjnkwPZDS2Z2Ge8+5ymBONwQ@mail.gmail.com>
 <1530048093.14039.286.camel@hpe.com>
 <CAPcyv4gXAC7imJs5qfsDNLeN545Rqyd2b1M9s5kr4f9y48LXgQ@mail.gmail.com>
 <1530048545.14039.288.camel@hpe.com>
 <CAPcyv4ifHX95fCM9Xj87CugwNWzgq=y-4LxPQ5L6RdjX0jdctQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ifHX95fCM9Xj87CugwNWzgq=y-4LxPQ5L6RdjX0jdctQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 02:51:52PM -0700, Dan Williams wrote:
> On Tue, Jun 26, 2018 at 2:31 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
> > On Tue, 2018-06-26 at 14:28 -0700, Dan Williams wrote:
> >> On Tue, Jun 26, 2018 at 2:23 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
> >> > On Tue, 2018-06-26 at 14:02 -0700, Dan Williams wrote:
> >> > > On Tue, Jun 26, 2018 at 1:54 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
> >>
> >> [..]
> >> > > > When this dm change was made, the pmem driver supported DAX for both raw
> >> > > > and memory modes (note: sector mode does not use the pmem driver).  I
> >> > > > think the issue was introduced when we dropped DAX support from raw
> >> > > > mode.
> >> > >
> >> > > Still DAX with raw mode never really worked any way. It was also
> >> > > something that was broken from day one. So what happens to someone who
> >> > > happened to avoid all the problems with page-less DAX and enabled
> >> > > device-mapper on top? That failure mode detail needs to be added to
> >> > > this changelog if we want to propose this for -stable.
> >> >
> >> > My point is that the behavior should be consistent between pmem and
> >> > device-mapper.  When -o dax succeeds on a pmem, then it should succeed
> >> > on a device-mapper on top of that pmem.
> >> >
> >> > Has the drop of dax support from raw mode made to -stable back to the
> >> > baseline accepted 545ed20e6df6?  It will introduce inconsistency,
> >> > otherwise.
> >>
> >> That commit, 569d0365f571 "dax: require 'struct page' by default for
> >> filesystem dax", has not been tagged for -stable.
> >
> > Then, Fixes tag should be set to 569d0365f571 to keep the behavior
> > consistent.
> 
> Sure, and the failure mode is...? I'm thinking the commit log should say:
> 
> "Starting with commit 569d0365f571 "dax: require 'struct page' by
> default for filesystem dax", dax is no longer supported for page-less
> configurations. However, device-mapper sees the QUEUE_FLAG_DAX still
> being set and falsely assumes that DAX is enabled, this leads to
> <insert user visible failure mode details here>"

Dan is correct that there is no user visible change for this.  It is the right
thing to do for consistency and sanity, but it doesn't actually have user
visible behavior that needs to be backported to stable.

Toshi is correct that this change is only for raw mode namespaces, not btt
namespaces.

I'll adjust the changelog and remove the stable flag for v5, and I'll add a
Fixes: tag for patch 2.
