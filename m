Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5C7C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B42C25AEB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B42C25AEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934196AbeFYODD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:03:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:53070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933996AbeFYODC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:03:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77620ADCC;
        Mon, 25 Jun 2018 14:03:01 +0000 (UTC)
Date:   Mon, 25 Jun 2018 16:03:00 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v4 1/1] nvme: trace: add disk name to tracepoints
Message-ID: <20180625140300.rebclfa6pa6mtsat@linux-x5ow.site>
References: <20180611184630.3435-1-jthumshirn@suse.de>
 <c05ae7fd-3580-ffb5-8beb-6e28666687f4@grimberg.me>
 <20180625070850.jdl7mudz6o6diwsj@linux-x5ow.site>
 <d4786519-1695-25a0-dbf5-5d6cb9809539@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4786519-1695-25a0-dbf5-5d6cb9809539@grimberg.me>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 04:31:28PM +0300, Sagi Grimberg wrote:
> 
> 
> On 06/25/2018 10:08 AM, Johannes Thumshirn wrote:
> > On Tue, Jun 19, 2018 at 05:09:27PM +0300, Sagi Grimberg wrote:
> > > We are going to need it for traffic based keep alive to update
> > > that we saw a completion to extend the kato.
> > > 
> > > But I suggest you simply keep a ctrl reference in struct nvme_request
> > > instead so you don't need to pass it to nvme_complete_req (that's what
> > > I did for traffic based keep alive).
> > 
> > Do you have a patch for this around? IIRC I started this (as Christoph
> > also suggested it) but it turned out to be quite a big refactoring
> > work.
> 
> How about the below? patch #1 is what you are looking for, patch #2 is
> a slightly modified version that applies on #1. Let me know what you
> think...

Looks good (both #1 if we want to use the two patch version or #2).

I have no idea what I did when I was trying to do when I tried it.

  Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
