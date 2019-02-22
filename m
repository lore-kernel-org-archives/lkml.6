Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7EDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7296D20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfBVRHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:07:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:3069 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfBVRHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:07:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2019 09:07:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,400,1544515200"; 
   d="scan'208";a="135565019"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Feb 2019 09:07:12 -0800
Date:   Fri, 22 Feb 2019 10:07:15 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Takao Indoh <indou.takao@fujitsu.com>
Cc:     "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>,
        Takao Indoh <indou.takao@jp.fujitsu.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme: Enable acceleration feature of A64FX processor
Message-ID: <20190222170715.GA10237@localhost.localdomain>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
 <20190201145414.GA22199@localhost.localdomain>
 <20190205124757.GA28465@esprimo>
 <20190205143905.GG22199@localhost.localdomain>
 <AT5PR8401MB1169E9738C0A4754D0190F2FAB670@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <20190220094610.GB3559@esprimo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220094610.GB3559@esprimo>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 06:46:11PM +0900, Takao Indoh wrote:
> On Thu, Feb 14, 2019 at 08:44:48PM +0000, Elliott, Robert (Persistent Memory) wrote:
> > * how does this interact with an iommu, if there is one? Must the 
> > address with bit 56 also be granted permission, or is that
> > stripped off before any iommu comparisons?
> 
> The latter. A bit 56 is cleared in Root Port before pass it to iommu.

What if the intendend destination is a peer and never hits the root port?

Really, though, PCI device vendors need to just use the existing
capability as intended and not have arch specific work-arounds. I'm sure
nvme can't be the only device class you'd want this behavior.
