Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F06C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5612220869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5612220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeJRXSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:18:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:61150 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbeJRXSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:18:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2018 08:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,396,1534834800"; 
   d="scan'208";a="100346656"
Received: from unknown (HELO [192.168.0.102]) ([10.10.37.145])
  by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2018 08:17:05 -0700
Subject: Re: rdma-core doesn't install driver.h, broke libibscif
From:   Sudeep Dutt <sudeep.dutt@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sudeep Dutt <sudeep.dutt@intel.com>,
        "Woodruff, Robert J" <robert.j.woodruff@intel.com>,
        james harvey <jamespharvey20@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Nikhil Rao <nikhil.rao@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20181017085453.GA30496@infradead.org>
References: <20181017085453.GA30496@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 18 Oct 2018 08:10:00 -0700
Message-ID: <1539875400.18931.450.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 (2.28.3-30.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-17 at 01:54 -0700, Christoph Hellwig wrote:
> On Mon, Oct 15, 2018 at 05:53:44PM +0000, Woodruff, Robert J wrote:
> > James Harvey wrote,
> > 
> > >Short: Is libibscif dead, and should OS repositories remove it?
> > 
> > Libibscif is for an old product,  Intel's KNC, that is no longer sold and the S/W is frozen. The open source libibscif is no longer maintained. 
> > It has already been removed from the latest community OFED distribution. The individual package on the OFA downloads is for archive purposed only.
> 
> Does this mean we can kill the kernel scif code as well? 

The MIC COSM drivers are using the kernel SCIF code. These drivers have
been upstream since 2015 and we are not sure who is using them. Our
preference will be to keep these drivers in the kernel for now.

Thanks,
Sudeep Dutt

