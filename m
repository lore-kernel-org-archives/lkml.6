Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7B5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC6121841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbeLSOnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:43:50 -0500
Received: from verein.lst.de ([213.95.11.211]:47460 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729651AbeLSOnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:43:49 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3FA3668AFE; Wed, 19 Dec 2018 15:43:47 +0100 (CET)
Date:   Wed, 19 Dec 2018 15:43:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Boaz Harrosh <ooo@electrozaur.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        martin.petersen@oracle.com,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove exofs, the T10 OSD code and block/scsi bidi support V3
Message-ID: <20181219144347.GB23410@lst.de>
References: <20181111133211.13926-1-hch@lst.de> <4f4b6aff-6726-c500-e3e4-f8b73d641851@electrozaur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f4b6aff-6726-c500-e3e4-f8b73d641851@electrozaur.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 07:11:10PM +0200, Boaz Harrosh wrote:
> On 11/11/18 15:32, Christoph Hellwig wrote:
> > The only real user of the T10 OSD protocol, the pNFS object layout
> > driver never went to the point of having shipping products, and we
> > removed it 1.5 years ago.  Exofs is just a simple example without
> > real life users.
> > 
> 
> You have failed to say what is your motivation for this patchset? What
> is it you are trying to fix/improve.

Drop basically unused support, which allows us to

 1) reduce the size of every kernel with block layer support, and
    even more for every kernel with scsi support
 2) reduce the size of the critical struct request structure by
    128 bits, thus reducing the memory used by every blk-mq driver
    significantly, never mind the cache effects
 3) stop having the maintainance overhead for this code in the
    block layer, which has been rather painful at times
