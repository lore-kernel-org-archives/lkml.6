Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08AFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C238E20664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C238E20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbeK0CMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:12:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:46986 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeK0CMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:12:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 07:17:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,282,1539673200"; 
   d="scan'208";a="108598701"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 26 Nov 2018 07:17:48 -0800
Date:   Mon, 26 Nov 2018 08:14:47 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 4/7] node: Add memory caching attributes
Message-ID: <20181126151446.GK26707@localhost.localdomain>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-5-keith.busch@intel.com>
 <91698cef-cdcd-5143-884f-3da5536e156f@arm.com>
 <20181119230600.GC26707@localhost.localdomain>
 <731533d5-26e1-ade7-1a63-d1f85461d091@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731533d5-26e1-ade7-1a63-d1f85461d091@arm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 06:59:21PM +0530, Anshuman Khandual wrote:
> 
> 
> On 11/20/2018 04:36 AM, Keith Busch wrote:
> > On Mon, Nov 19, 2018 at 09:44:00AM +0530, Anshuman Khandual wrote:
> >> On 11/15/2018 04:19 AM, Keith Busch wrote:
> >>> System memory may have side caches to help improve access speed. While
> >>> the system provided cache is transparent to the software accessing
> >>> these memory ranges, applications can optimize their own access based
> >>> on cache attributes.
> >>
> >> Cache is not a separate memory attribute. It impacts how the real attributes
> >> like bandwidth, latency e.g which are already captured in the previous patch.
> >> What is the purpose of adding this as a separate attribute ? Can you explain
> >> how this is going to help the user space apart from the hints it has already
> >> received with bandwidth, latency etc properties.
> > 
> > I am not sure I understand the question here. Access bandwidth and latency
> > are entirely attributes different than what this patch provides. If the
> > system side-caches memory, the associativity, line size, and total size
> > can optionally be used by software to improve performance.
> 
> Okay but then does this belong to this series which about memory attributes ?

This patch series is about exporting memory attributes, and this system
memory caching is  one such attribute, so yes, I think it belongs.
