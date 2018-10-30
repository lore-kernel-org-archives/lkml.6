Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C428C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F112080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F112080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeJaDci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:32:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:27995 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbeJaDch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:32:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 11:38:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="275762646"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 30 Oct 2018 11:38:00 -0700
Date:   Tue, 30 Oct 2018 12:35:39 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v3 0/16] blk-mq: Add support for multiple queue maps
Message-ID: <20181030183538.GB19483@localhost.localdomain>
References: <20181030183252.17857-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 12:32:36PM -0600, Jens Axboe wrote:
> This series adds support for multiple queue maps for blk-mq.
> Since blk-mq was introduced, it's only support a single queue
> map. This means you can have 1 set of queues, and the mapping
> purely depends on what CPU an IO originated from. With this
> patch set, drivers can implement mappings that depend on both
> CPU and request type - and they can have multiple sets of mappings.
> 
> NVMe is used as a proof of concept. It adds support for a separate
> write queue set. One way to use this would be to limit the number
> of write queues to favor reads, since NVMe does round-robin service
> of queues. An easy extension of this would be to add multiple
> sets of queues, for prioritized IO.
> 
> NVMe also uses this feature to finally make the polling work
> efficiently, without triggering interrupts. This both increases
> performance (and decreases latency), at a lower system load. At
> the same time it's more flexible, as you don't have to worry about
> IRQ coalescing and redirection to avoid interrupts disturbing the
> workload. This is how polling should have worked from day 1.
> 
> This is on top of my mq-conversions branch. It can also be bound
> in my mq-maps branch.

Looks good to me. For the series:

Reviewed-by: Keith Busch <keith.busch@intel.com>
