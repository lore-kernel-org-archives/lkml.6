Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7379CC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5EA208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5EA208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755989AbeFOLtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:49:52 -0400
Received: from verein.lst.de ([213.95.11.211]:50732 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755650AbeFOLtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:49:51 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A469268E44; Fri, 15 Jun 2018 13:58:19 +0200 (CEST)
Date:   Fri, 15 Jun 2018 13:58:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: export __blk_complete_request
Message-ID: <20180615115819.GA25694@lst.de>
References: <1529027847-29085-1-git-send-email-jianchao.w.wang@oracle.com> <CACVXFVMe4zSvfXfuSn0NFayeQqbmDwBBy1kcso=5iznT6EfpSA@mail.gmail.com> <3dd3f82a-5b68-f039-3a8a-7c5fe4e24c3e@oracle.com> <e5344293-b0b7-d2e0-f2e7-c0700efdfbe4@oracle.com> <CACVXFVMRCM6AvNJjAESbwOeJ_P5AZ+1C-7RfhE9L4u0T=_5h4Q@mail.gmail.com> <3970fdc7-52d9-d05b-4118-059d48bf4f2d@oracle.com> <CACVXFVMPAdFbX3x-KUjHCQhb_rT6p9ROYHg63aUtEqdbitEaKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVMPAdFbX3x-KUjHCQhb_rT6p9ROYHg63aUtEqdbitEaKQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 11:20:40AM +0800, Ming Lei wrote:
> > but blk_mq_check_expired doesn't do that.
> > do I miss anything ?
> 
> Right, that is the difference between blk-mq and legacy now, then if scsi-mq
> drivers can work well, they should work well with the following change in the
> non-mq mode:

We'll still need referene counting against reuse and/or premature
freeing of requests.
