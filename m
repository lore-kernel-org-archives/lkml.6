Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C2FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF44279C6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF44279C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754787AbeF1VUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:20:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:32949 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752547AbeF1VUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:20:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 14:20:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,284,1526367600"; 
   d="scan'208";a="62371032"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jun 2018 14:20:16 -0700
Date:   Thu, 28 Jun 2018 15:19:28 -0600
From:   Keith Busch <keith.busch@linux.intel.com>
To:     Bart Van Assche <bart.vanassche@wdc.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/5] blk-mq: add API to get hctx index from request
Message-ID: <20180628211928.GA13810@localhost.localdomain>
References: <20180628205601.13742-1-keith.busch@intel.com>
 <57c119c3-5704-0dcb-96dd-fede99c49511@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c119c3-5704-0dcb-96dd-fede99c49511@wdc.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 02:12:38PM -0700, Bart Van Assche wrote:
> Regarding the above patch: have you considered to use the existing function
> blk_mq_unique_tag_to_hwq() instead of introducing this new function?

Interesting. I think the usage I need using that is something like:

	blk_mq_unique_tag_to_hwq(blk_mq_unique_tag(req))

Sort of a round-about way to get to the hwq from the struct request,
but I'd rather not introduce anything new if there are other ways,
so thank you for the pointer.
