Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBDBC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6014B27842
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6014B27842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754590AbeF1TD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:03:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:37506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751981AbeF1TD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:03:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 294ABACD2;
        Thu, 28 Jun 2018 19:03:23 +0000 (UTC)
Date:   Thu, 28 Jun 2018 09:44:06 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Keith Busch <keith.busch@linux.intel.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: trace: add disk name to tracepoints
Message-ID: <20180628074406.pbf4tjluylq3lkkr@linux-x5ow.site>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
 <20180626150106.GB6628@localhost.localdomain>
 <20180627073328.aws2apvc357jobge@linux-x5ow.site>
 <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>
 <20180627234313.GB10657@localhost.localdomain>
 <20180628005943.GC10657@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180628005943.GC10657@localhost.localdomain>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 06:59:43PM -0600, Keith Busch wrote:
> Thinking more on this, not using the hw qid really limits the utility
> out of using these trace events: We may not be able to match a completion
> to the submission without it since cmdid alone isn't enough to match up
> the two events.
> 
> Here's an updated proposal and actually tested. I was also able to
> combine admin and io submissions.

Awesome, thanks.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
