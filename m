Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAF8C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA322154C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA322154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbeGBNTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:19:22 -0400
Received: from verein.lst.de ([213.95.11.211]:38552 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbeGBNTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:19:20 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CA5E168D41; Mon,  2 Jul 2018 15:19:51 +0200 (CEST)
Date:   Mon, 2 Jul 2018 15:19:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Fabio Coatti <fabio.coatti@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: iwlwifi problem with iommu/intel-iommu: Enable
        CONFIG_DMA_DIRECT_OPS=y and clean up intel_{alloc,free}_coherent()
Message-ID: <20180702131951.GA5786@lst.de>
References: <1537224.nkESeFtY4z@hobbes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537224.nkESeFtY4z@hobbes>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> By reverting this commit the card works again, tested in 4.17.3 . I've noticed 
> that the corresponding amd commit ( b468620f2a1dfdcfddfd6fa54367b8bcc1b51248)
> has been reverted in linus tree (e16c4790de39dc861b749674c2a9319507f6f64f), 
> and 4.16.X stable tree iirc,  but the intel one has not been reverted.
> 
> hw: Lenovo P50 Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz
> 
> Please let me know if more details are needed, but CC: me as I'm not currently 
> subscribed to LKML.

It probablty is the same issue.  Did you check if you can just revert
the commit cleanly on top of current mainline and that fixes the issue
for you?
