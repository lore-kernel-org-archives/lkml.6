Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046F4C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE5120883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE5120883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932734AbeFUIJr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:09:47 -0400
Received: from verein.lst.de ([213.95.11.211]:50527 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932654AbeFUIJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:09:45 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2E3347F0E0; Thu, 21 Jun 2018 10:19:00 +0200 (CEST)
Date:   Thu, 21 Jun 2018 10:19:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Keith Busch <keith.busch@intel.com>, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, josef@toxicpanda.com,
        ulf.hansson@linaro.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5]stop normal completion path entering a timeout req
Message-ID: <20180621081900.GA5183@lst.de>
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com> <20180620181601.GA24145@localhost.localdomain> <e87f5946-bb21-942e-2dcc-b24cee1ad23c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e87f5946-bb21-942e-2dcc-b24cee1ad23c@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 09:43:26AM +0800, jianchao.wang wrote:
> So we have to preserve the ability of block layer that it could prevent
> IO completion path from entering a timeout request.
> 
> With scsi-debug module, I tried to simulate a scenario where timeout and IO
> completion path could occur concurrently, the system ran into crash easily.

Trace, please.  With the latest kernel.  I'm not saying that there
is nothing to fix, but the mode of never completing once timeout
requests as currently done is SCSI is clearly broken.
