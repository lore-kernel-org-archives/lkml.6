Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D6EC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4770A208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4770A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeJELG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:06:58 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49956 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeJELG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:06:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id EE768231E6;
        Fri,  5 Oct 2018 00:10:05 -0400 (EDT)
Date:   Fri, 5 Oct 2018 14:10:04 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Leonardo Bras <leobras.c@gmail.com>
cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 3/7] drivers: parisc: Avoids building driver if
 CONFIG_PARISC is disabled
In-Reply-To: <CADvQ+rG0WQjFTU=A4tAACvqFevw51DX_-yq2-9j78T8pSrjcXQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1810051332350.33@nippy.intranet>
References: <20180928020816.11251-1-leobras.c@gmail.com> <20180928020816.11251-4-leobras.c@gmail.com> <1538118915.3593.4.camel@HansenPartnership.com> <CADvQ+rGQenkoE0xCRTwjA5BuKZbZ2Upkyx=+qWFUGnUcit-aCQ@mail.gmail.com> <1538628062.18776.5.camel@HansenPartnership.com>
 <CADvQ+rG0WQjFTU=A4tAACvqFevw51DX_-yq2-9j78T8pSrjcXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2018, Leonardo Bras wrote:

> ... 
> But, why these chosen Makefiles, and not all of them?

I think that inconsistency is untenable. If nothing else, it means your 
changes will get broken by other people who also apply constraints 
inconsistently.

I think you need to consider what happens when you apply this regime 
tree-wide. Either that or explain why it would make sense to build e.g. 
drivers/s390 but not drivers/s390/net.

-- 
