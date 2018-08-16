Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F306C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB5121480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB5121480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbeHQATf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 20:19:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:48053 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbeHQATf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 20:19:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 14:18:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,248,1531810800"; 
   d="scan'208";a="77468435"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2018 14:18:52 -0700
Date:   Thu, 16 Aug 2018 15:19:40 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "liudongdong3@huawei.com" <liudongdong3@huawei.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Add 'nodpc' parameter
Message-ID: <20180816211940.GB7400@localhost.localdomain>
References: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
 <20180816154940.GD5762@bombadil.infradead.org>
 <1534434641.17819.27.camel@intel.com>
 <20180816203111.GB10316@bhelgaas-glaptop.roam.corp.google.com>
 <1534452635.17819.53.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534452635.17819.53.camel@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 01:50:42PM -0700, Derrick, Jonathan wrote:
> It can also be disabled with setpci, but is that any less of a hassle?
> Genuine question to understand your point of view.

That is not a real solution, IMO. 'setpci' is good to inject things
for testing, but it changes config space without the kernel aware that
you've done that, so it is inherently racey with other kernel threads
touching pci config space. And the kernel or platform may end up undoing
what you had 'setpci' do anyway with no immediate way to be notified it
was changed.
