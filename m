Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75204C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9CE222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436604AbfBNRLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:11:05 -0500
Received: from verein.lst.de ([213.95.11.211]:51962 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394569AbfBNRLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:11:02 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 47FB76FA8D; Thu, 14 Feb 2019 18:11:00 +0100 (CET)
Date:   Thu, 14 Feb 2019 18:11:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Takao Indoh <indou.takao@fujitsu.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Takao Indoh <indou.takao@jp.fujitsu.com>, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Enable acceleration feature of A64FX processor
Message-ID: <20190214171100.GA473@lst.de>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com> <20190201145414.GA22199@localhost.localdomain> <20190205124757.GA28465@esprimo> <20190205143905.GG22199@localhost.localdomain> <20190205161347.GA847@lst.de> <20190213120358.GA3559@esprimo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213120358.GA3559@esprimo>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 09:03:58PM +0900, Takao Indoh wrote:
> Ok, let me think about how I should change this patch.

Just drop it.

> I'm thinking that the problem of this patch is adding processor specific
> code into NVMe common driver, is this correct? Or another problem? It
> would be great if you could give me a hint to improve this patch.

For one it is processor / root port specific.  But even more importantly
it is incorrect.  If the device wants to issue a relaxed order
transaction it should do so all by itself, not by hacking around it
from the kernel.
