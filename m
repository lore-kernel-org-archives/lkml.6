Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB1BC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F78620870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F78620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeLLOsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:48:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:22652 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeLLOsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:48:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 06:48:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; 
   d="scan'208";a="117766522"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 12 Dec 2018 06:48:21 -0800
Date:   Wed, 12 Dec 2018 07:45:53 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv2 12/12] doc/mm: New documentation for memory performance
Message-ID: <20181212144553.GB10780@localhost.localdomain>
References: <20181211010310.8551-1-keith.busch@intel.com>
 <20181211010310.8551-13-keith.busch@intel.com>
 <681f14eb-def4-bf40-fdfd-b5fb89045132@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <681f14eb-def4-bf40-fdfd-b5fb89045132@linux.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:23:24AM +0530, Aneesh Kumar K.V wrote:
> On 12/11/18 6:33 AM, Keith Busch wrote:
> > +When multiple memory initiators exist, they may not all have the same
> > +performance when accessing a given memory target. The highest performing
> > +initiator to a given target is considered to be one of that target's
> > +local initiators. Any given target may have one or more local initiators,
> > +and any given initiator may have multiple local memory targets.
> > +
> 
> Can you also add summary here suggesting node X is compute and Node y is
> memory target

Sure thing.
 
> > +To aid applications matching memory targets with their initiators,
> > +the kernel provide symlinks to each other like the following example::
> > +
> > +	# ls -l /sys/devices/system/node/nodeX/local_target*
> > +	/sys/devices/system/node/nodeX/local_targetY -> ../nodeY
> > +
> > +	# ls -l /sys/devices/system/node/nodeY/local_initiator*
> > +	/sys/devices/system/node/nodeY/local_initiatorX -> ../nodeX
> > +
> 
> the patch series had primary_target and primary_initiator

Yeah, I noticed that mistake too. I went through several iterations of
naming this, and I think it will yet be named something else in the
final revision to accomodate different access levels since it sounds
like some people may wish to show more than just the best.

> > +When the kernel first registers a memory cache with a node, the kernel
> > +will create the following directory::
> > +
> > +	/sys/devices/system/node/nodeX/side_cache/
> > +
> 
> This is something even the patch commit message didn't explain we create
> side_cache directory in memory target nodes or initiator nodes? I assume it
> is part of memory target nodes. If so to be consistent can you use nodeY?

Right, only memory targets may have memory side caches. Will use more
consistent symbols.
