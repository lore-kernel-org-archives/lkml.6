Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4FBC4151A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67B2218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbfBFQ0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:26:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:42960 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbfBFQ0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:26:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 08:26:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="132038943"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 06 Feb 2019 08:26:24 -0800
Date:   Wed, 6 Feb 2019 09:25:53 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com
Subject: Re: [PATCHv5 10/10] doc/mm: New documentation for memory performance
Message-ID: <20190206162553.GI28064@localhost.localdomain>
References: <20190124230724.10022-1-keith.busch@intel.com>
 <20190124230724.10022-11-keith.busch@intel.com>
 <20190206104552.00003bad@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206104552.00003bad@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 10:45:52AM +0000, Jonathan Cameron wrote:
> On Thu, 24 Jan 2019 16:07:24 -0700
> Keith Busch <keith.busch@intel.com> wrote:
> > +	# tree -P "read*|write*" /sys/devices/system/node/nodeY/access0/
> > +	/sys/devices/system/node/nodeY/access0/
> > +	|-- read_bandwidth
> > +	|-- read_latency
> > +	|-- write_bandwidth
> > +	`-- write_latency
> 
> These seem to be under
> /sys/devices/system/node/nodeY/access0/initiators/
> (so one directory deeper).

You're right, I used data from the previous series to generate that.
 
> > +	# tree sys/devices/system/node/node0/side_cache/
> > +	/sys/devices/system/node/node0/side_cache/
> > +	|-- index1
> > +	|   |-- associativity
> > +	|   |-- level
> 
> What is the purpose of having level in here?  Isn't it the same as the A..C
> in the index naming?

Yes, it is redundant with the name. I will remove it.
 
> > +	|   |-- line_size
> > +	|   |-- size
> > +	|   `-- write_policy
> > +
> > +The "associativity" will be 0 if it is a direct-mapped cache, and non-zero
> > +for any other indexed based, multi-way associativity.
> 
> Is it worth providing the ACPI mapping in this doc?  We have None, Direct and
> 'complex'.   Fun question of what None means?  Not specified?

Yeah, my take on "none" was that it's unreported and we don't know what
is actually happening..

> > +
> > +The "level" is the distance from the far memory, and matches the number
> > +appended to its "index" directory.
> > +
> > +The "line_size" is the number of bytes accessed on a cache miss.
> 
> Maybe "number of bytes accessed from next cache level" ?

Sounds good.
