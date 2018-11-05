Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A65BC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFBE20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFBE20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbeKEX6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:58:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:55795 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeKEX6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:58:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 06:38:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="106035800"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 05 Nov 2018 06:38:19 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gJg1C-0005n5-5g; Mon, 05 Nov 2018 16:38:18 +0200
Date:   Mon, 5 Nov 2018 16:38:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/4] device property: Add fwnode_name() helper
Message-ID: <20181105143818.GL10650@smile.fi.intel.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 12:17:23PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> I prepared fwnode_name() for something I'm working on, but then I
> realized that it makes it possible to also implement a generic
> fwnode_get_named_child_node(). So in practice I'm proposing that we
> replace get_named_child_node fwnode op with that new "name" fwnode op
> in this series.
> 

All LGTM, though consider one minor comment in patch 1.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> thanks,
> 
> Heikki Krogerus (4):
>   device property: Introduce fwnode_name()
>   ACPI: property: Introduce acpi_fwnode_name()
>   of/property: Introduce of_fwnode_name()
>   device property: Drop get_named_child_node callback
> 
>  drivers/acpi/property.c  | 26 +++++++-------------------
>  drivers/base/property.c  | 28 +++++++++++++++++++++++++++-
>  drivers/of/property.c    | 21 ++++++---------------
>  include/linux/fwnode.h   |  4 +---
>  include/linux/property.h |  2 ++
>  5 files changed, 43 insertions(+), 38 deletions(-)
> 
> -- 
> 2.19.1
> 

-- 
With Best Regards,
Andy Shevchenko


