Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CF9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA3F2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA3F2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755809AbeFSFGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:06:35 -0400
Received: from verein.lst.de ([213.95.11.211]:38799 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750739AbeFSFGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:06:33 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D725968E44; Tue, 19 Jun 2018 07:15:31 +0200 (CEST)
Date:   Tue, 19 Jun 2018 07:15:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Avi Kivity <avi@scylladb.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Revert "eventfd: only return events requested in
        poll_mask()"
Message-ID: <20180619051531.GB22076@lst.de>
References: <20180617083141.26543-1-avi@scylladb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180617083141.26543-1-avi@scylladb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 11:31:41AM +0300, Avi Kivity wrote:
> This reverts commit 4d572d9f46507be8cfe326aa5bc3698babcbdfa7. It is
> superceded by the more general
> 2739b807b0885a09996659be82f813af219c7360 ("aio: only return events
> requested in poll_mask() for IOCB_CMD_POLL"). Unfortunately, hch
> nacked it on the bug report rather than on the patch itself, so it
> was picked up.

Note that even with that patch this patch is harmless, although indeed
not actually needed.
