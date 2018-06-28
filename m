Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA84C43148
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3004275BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3004275BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966928AbeF1PDJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:03:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:29348 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964841AbeF1PDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:03:07 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 08:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,284,1526367600"; 
   d="scan'208";a="51238266"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2018 08:03:06 -0700
Date:   Thu, 28 Jun 2018 09:02:18 -0600
From:   Keith Busch <keith.busch@linux.intel.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] nvme: trace: add disk name to tracepoints
Message-ID: <20180628150218.GA12970@localhost.localdomain>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
 <20180626150106.GB6628@localhost.localdomain>
 <20180627073328.aws2apvc357jobge@linux-x5ow.site>
 <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>
 <20180627234313.GB10657@localhost.localdomain>
 <20180628005943.GC10657@localhost.localdomain>
 <c25e48f5-ace4-5d2c-8174-11ac63316323@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c25e48f5-ace4-5d2c-8174-11ac63316323@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 05:34:07PM +0300, Sagi Grimberg wrote:
> 
> > Thinking more on this, not using the hw qid really limits the utility
> > out of using these trace events: We may not be able to match a completion
> > to the submission without it since cmdid alone isn't enough to match up
> > the two events.
> > 
> > Here's an updated proposal and actually tested. I was also able to
> > combine admin and io submissions.
> 
> This looks good!
> 
> One thing that is missing is the controller id when we have multiple
> controllers/subsystems in the host like:
> 
> TP_printk("nvme%d: qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx,
> cmd=(%s %s)",
> 
> But Johannes can add it I guess.

Yep, I'm sort of going off on a tangent from what Johannes was adding.
We definitely need both. I have some time today, I'll send out the a
series with the combined results.
