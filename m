Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9246ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8302320C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8302320C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbeGQN2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:28:30 -0400
Received: from verein.lst.de ([213.95.11.211]:51227 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731198AbeGQN2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:28:30 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6583C7FDC5; Tue, 17 Jul 2018 14:58:29 +0200 (CEST)
Date:   Tue, 17 Jul 2018 14:58:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aio@kvack.org
Subject: Re: compliation error with aio_abi.h
Message-ID: <20180717125829.GA12368@lst.de>
References: <05018ab0-37ce-37f3-e032-7daf0338a75d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05018ab0-37ce-37f3-e032-7daf0338a75d@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:40:19AM -0700, Laura Abbott wrote:
> This looks like the structure that was introduced with 7a074e96dee6
> ("aio: implement io_pgetevents") . is #include <linux/signal.h>
> the correct header? This breaks compilation of nginx
> https://bugzilla.redhat.com/show_bug.cgi?id=1597674

As far as the kernel is concerned it is the right header, but the
glibc side of signals is a mess.  I've thus submitted the fix below
to avoid exposing the signal bits at all:

https://marc.info/?l=linux-fsdevel&m=153131732618217&w=2
