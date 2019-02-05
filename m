Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066F7C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F3920818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfBERQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:16:31 -0500
Received: from verein.lst.de ([213.95.11.211]:55271 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfBERQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:16:30 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DE7CF68D93; Tue,  5 Feb 2019 18:16:28 +0100 (CET)
Date:   Tue, 5 Feb 2019 18:16:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Boaz Harrosh <ooo@electrozaur.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        martin.petersen@oracle.com,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove exofs, the T10 OSD code and block/scsi bidi support V4
Message-ID: <20190205171628.GA2129@lst.de>
References: <20190201075557.9249-1-hch@lst.de> <3be11773-5ea9-4c08-25a5-dc556ded2d6f@electrozaur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3be11773-5ea9-4c08-25a5-dc556ded2d6f@electrozaur.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:31:39PM +0200, Boaz Harrosh wrote:
> On 01/02/19 09:55, Christoph Hellwig wrote:
> > The only real user of the T10 OSD protocol, the pNFS object layout
> > driver never went to the point of having shipping products, and we
> > removed it 1.5 years ago.  Exofs is just a simple example without
> > real life users.
> > 
> > The code has been mostly unmaintained for years and is getting in the
> > way of block / SCSI changes, 
> 
> For the 4th time: Which ?

Speeding up the I/O path for example.  Making sense of SCSI
command allocation for another.  Having to deal with sense data
handling for the duplicate scsi command allocation as a third.
