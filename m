Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3928C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E02F20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfAUItw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:49:52 -0500
Received: from verein.lst.de ([213.95.11.211]:57032 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbfAUItv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:49:51 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CE37F68DD2; Mon, 21 Jan 2019 09:49:50 +0100 (CET)
Date:   Mon, 21 Jan 2019 09:49:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH v1] fs/jfs: Switch to use new generic UUID API
Message-ID: <20190121084950.GG18680@lst.de>
References: <20190110134153.83901-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110134153.83901-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	buf->f_fsid.val[1] = (u32)crc32_le(0, (char *)&sbi->uuid + sizeof(sbi->uuid)/2,

This adds an overly long line, and has weird operator spacing.

In fact given how much deep magic it does it should probably be moved
into a helper and properly documented when you touch it anyway.
