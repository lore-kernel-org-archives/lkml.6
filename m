Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1EFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F288521A2D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F288521A2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbeHFPgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:36:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:32874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727510AbeHFPgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:36:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD0F8AFDC;
        Mon,  6 Aug 2018 13:27:25 +0000 (UTC)
Date:   Mon, 6 Aug 2018 15:27:25 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     ard <ard@kwaak.net>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/3] scsi: fcoe: memleak fixes
Message-ID: <20180806132725.ihbi5rxvkuuppajr@linux-x5ow.site>
References: <20180731134603.20089-1-jthumshirn@suse.de>
 <20180806092503.6ed56kukj2i236qt@linux-x5ow.site>
 <20180806132234.GA23827@kwaak.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180806132234.GA23827@kwaak.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 03:22:34PM +0200, ard wrote:
> Ahh, yeah, sorry.
> I did test them.
> I can't say I see a regression.
> I also can't say I see progress, although it feels like there is
> a tad less leaking.
> For that I need to do some statistics.
> 
> But for now I ack that it does not regress further.

From what I've seen in your kmemleak reports, it wasn't only
libfc/fcoe that was leaking memory.

So kmemleak reports are welcome (especially if they confirm libfc/fcoe
is clean now ;-)).

@Martin can you stage these patches for 4.19?

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
