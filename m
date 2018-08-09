Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEDFC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B9B22395
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B9B22395
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeHJBaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:30:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:57362 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbeHJBaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:30:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2018 16:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,217,1531810800"; 
   d="scan'208";a="80454643"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.32])
  by orsmga001.jf.intel.com with ESMTP; 09 Aug 2018 16:03:11 -0700
Date:   Thu, 9 Aug 2018 16:03:11 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gage Eads <gage.eads@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] vfio/pci: Some buggy virtual functions incorrectly
 report 1 for intx.
Message-ID: <20180809230311.GA79703@otc-nc-03>
References: <1533843426-79170-1-git-send-email-ashok.raj@intel.com>
 <20180809134417.50de7fe7@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809134417.50de7fe7@t450s.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 01:44:17PM -0600, Alex Williamson wrote:
> On Thu,  9 Aug 2018 12:37:06 -0700
> Ashok Raj <ashok.raj@intel.com> wrote:
> 
> > PCI_INTERRUPT_PIN should always read  0 for SRIOV Virtual Functions.
> > 
> > Some SRIOV devices have some bugs in RTL and VF's end up reading 1
> > instead of 0 for the PIN.
> 
> Hi Ashok,
> 
> One question, can we identify which VFs are known to have this issue so
> that users (and downstreams) can know how to prioritize this patch?
> Thanks,

Hi Alex,

The hardware isn't public yet, so can't talk about it :-(. Once this patch gets 
merged, will let the OSV engagement folks drive it for inclusions. We 
could mark this for stable, but i would rather wait until we know the 
timeline when they are expecting it to be in. It shouldn't break anything
since we are just enforcing the spec.

Cheers,
Ashok
