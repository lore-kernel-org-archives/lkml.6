Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7E3ABC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3427B208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3427B208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755984AbeFOJTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:19:16 -0400
Received: from verein.lst.de ([213.95.11.211]:50023 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755804AbeFOJTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:19:14 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E49D568E45; Fri, 15 Jun 2018 11:27:41 +0200 (CEST)
Date:   Fri, 15 Jun 2018 11:27:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anatoliy Glagolev <glagolig@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] block: fix bsg_unregister and bsg_open race
Message-ID: <20180615092741.GA21138@lst.de>
References: <20180613221417.GA22778@xldev-tmpl.dev.purestorage.com> <20180614083806.GA18966@lst.de> <20180614234733.GA38460@xldev-tmpl.dev.purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614234733.GA38460@xldev-tmpl.dev.purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 05:47:34PM -0600, Anatoliy Glagolev wrote:
> Thanks, Christoph. Good catch releasing the mutex on failure path.
> V2 patch with your suggestions applied.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Now just re-add the changelog and resend it in a new thread.
