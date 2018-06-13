Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 79941C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E69E208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E69E208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935199AbeFMQxh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:53:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:7257 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934802AbeFMQxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:53:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 09:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,219,1526367600"; 
   d="scan'208";a="62879459"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2018 09:53:34 -0700
Date:   Wed, 13 Jun 2018 10:56:32 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Jianchao Wang <jianchao.w.wang@oracle.com>, stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.4 110/268] nvme-pci: Fix nvme queue cleanup if IRQ
 setup fails
Message-ID: <20180613165631.GE5574@localhost.localdomain>
References: <20180528100202.045206534@linuxfoundation.org>
 <20180528100214.621806271@linuxfoundation.org>
 <1528906474.2289.155.camel@codethink.co.uk>
 <20180613163007.GD5574@localhost.localdomain>
 <1528907855.2289.157.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1528907855.2289.157.camel@codethink.co.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 05:37:35PM +0100, Ben Hutchings wrote:
> On Wed, 2018-06-13 at 10:30 -0600, Keith Busch wrote:
> > Thank you very much the catching that. This particular patch is indeed
> > not correct without the following:
> > 
> >   161b8be2bd6ab ("nvme-pci: initialize queue memory before interrupts")
> 
> Oh, now I see.  Do you think that commit is suitable for stable
> branches?

Yes, we can safely include that commit 4.4-stable. The scenario it fixes
isn't very common in 4.4, but it could happen with quirky hardware or
legacy interrupts.
