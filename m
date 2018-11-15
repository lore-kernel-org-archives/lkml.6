Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B128C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1723E223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1723E223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbeKPBK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:10:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:2786 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbeKPBK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:10:57 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 07:02:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,236,1539673200"; 
   d="scan'208";a="281348564"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 15 Nov 2018 07:02:45 -0800
Date:   Thu, 15 Nov 2018 07:59:20 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/7] node: Link memory nodes to their compute nodes
Message-ID: <20181115145920.GG11416@localhost.localdomain>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181115135710.GD19286@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115135710.GD19286@bombadil.infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 05:57:10AM -0800, Matthew Wilcox wrote:
> On Wed, Nov 14, 2018 at 03:49:14PM -0700, Keith Busch wrote:
> > Memory-only nodes will often have affinity to a compute node, and
> > platforms have ways to express that locality relationship.
> > 
> > A node containing CPUs or other DMA devices that can initiate memory
> > access are referred to as "memory iniators". A "memory target" is a
> > node that provides at least one phyiscal address range accessible to a
> > memory initiator.
> 
> I think I may be confused here.  If there is _no_ link from node X to
> node Y, does that mean that node X's CPUs cannot access the memory on
> node Y?  In my mind, all nodes can access all memory in the system,
> just not with uniform bandwidth/latency.

The link is just about which nodes are "local". It's like how nodes have
a cpulist. Other CPUs not in the node's list can acces that node's memory,
but the ones in the mask are local, and provide useful optimization hints.

Would a node mask would be prefered to symlinks?
