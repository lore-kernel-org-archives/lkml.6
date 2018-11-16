Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B14CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BFB2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BFB2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389812AbeKQCH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:07:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:16199 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbeKQCH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:07:59 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 07:55:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,240,1539673200"; 
   d="scan'208";a="89870885"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 16 Nov 2018 07:55:04 -0800
Date:   Fri, 16 Nov 2018 08:51:41 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/7] ACPI HMAT memory sysfs representation
Message-ID: <20181116155141.GA14630@localhost.localdomain>
References: <20181114224902.12082-1-keith.busch@intel.com>
 <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 11:57:58AM +0530, Anshuman Khandual wrote:
> On 11/15/2018 04:19 AM, Keith Busch wrote:
> > This series provides a new sysfs representation for heterogeneous
> > system memory.
> > 
> > The previous series that was specific to HMAT that this series was based
> > on was last posted here: https://lkml.org/lkml/2017/12/13/968
> > 
> > Platforms may provide multiple types of cpu attached system memory. The
> > memory ranges for each type may have different characteristics that
> > applications may wish to know about when considering what node they want
> > their memory allocated from. 
> > 
> > It had previously been difficult to describe these setups as memory
> > rangers were generally lumped into the NUMA node of the CPUs. New
> > platform attributes have been created and in use today that describe
> > the more complex memory hierarchies that can be created.
> > 
> > This series first creates new generic APIs under the kernel's node
> > representation. These new APIs can be used to create links among local
> > memory and compute nodes and export characteristics about the memory
> > nodes. Documentation desribing the new representation are provided.
> > 
> > Finally the series adds a kernel user for these new APIs from parsing
> > the ACPI HMAT.
> 
> Not able to see the patches from this series either on the list or on the
> archive (https://lkml.org/lkml/2018/11/15/331). 

The send-email split the cover-letter from the series, probably
something I did. Series followed immediately after:

  https://lkml.org/lkml/2018/11/15/332

> IIRC last time we discussed
> about this and the concern which I raised was in absence of a broader NUMA
> rework for multi attribute memory it might not a good idea to settle down
> and freeze sysfs interface for the user space. 
