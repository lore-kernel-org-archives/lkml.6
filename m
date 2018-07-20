Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123B1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D8020673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D8020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeGTHXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:23:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:60360 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727048AbeGTHXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:23:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ABDB6ACD8;
        Fri, 20 Jul 2018 06:36:31 +0000 (UTC)
Date:   Fri, 20 Jul 2018 08:36:31 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     James Smart <james.smart@broadcom.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Ewan Milne <emilne@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 0/4] Rework NVMe abort handling
Message-ID: <20180720063631.tn4nh2njt43u27bi@linux-x5ow.site>
References: <20180719132838.15556-1-jthumshirn@suse.de>
 <20180719134203.GA15212@lst.de>
 <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>
 <20180719142355.GA18800@lst.de>
 <20180719143534.i36vo45lhz24xbrg@linux-x5ow.site>
 <20180719145005.GA21000@lst.de>
 <20180719145422.2tdrbwa34gheuam3@linux-x5ow.site>
 <8d1ad465-c6b2-b67d-39f5-c88d849a89dd@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d1ad465-c6b2-b67d-39f5-c88d849a89dd@broadcom.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 08:04:09AM -0700, James Smart wrote:
> Which I'm going to say no on. I originally did the abort before the reset
> and it brought out some confusion in the reset code. Thus the existing flow
> which just resets the controller which has to be done after the abort
> anyway.

OK copied that.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
