Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C584AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D89208B6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D89208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753647AbeGFIDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:03:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55128 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753599AbeGFIDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:03:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC840ADC5;
        Fri,  6 Jul 2018 08:03:02 +0000 (UTC)
Date:   Fri, 6 Jul 2018 10:03:01 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Dave Carroll <david.carroll@microsemi.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>
Subject: Re: [PATCH 1/4] scsi: aacraid: remove AAC_STAT_GOOD define
Message-ID: <20180706080301.gvjxdd4w5eun2x2h@linux-x5ow.site>
References: <20180705110140.19545-1-jthumshirn@suse.de>
 <20180705110140.19545-2-jthumshirn@suse.de>
 <4cd9a8cb64dc4d8aa1e10c3b008c3ba0@microsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cd9a8cb64dc4d8aa1e10c3b008c3ba0@microsemi.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 05:42:02PM +0000, Dave Carroll wrote:
> > Remove the AAC_STAT_GOOD definition and open code it in the places it was
> > used.
> > 
> > This will make subsequent refactoring in this area easier.
> > 
> Please don't ... the definition itself was added to make refactoring easier.

Well in the end scsi_cmnd::result as we know it currently will go
away, so splitting up the define is rather crucial for this. I could
do it when changing the ->result from one integer into 4 u8s but doing
it in a separate preparation step would be preferable to me and it
doesn't hurt accraid at all.

For more information please see [1] and [2]. A first preparation
series [3] has already landed upstream.

[1] https://marc.info/?l=linux-scsi&m=152300071418035&w=2
[2] https://marc.info/?l=linux-scsi&m=152406381222604&w=2
[3] https://marc.info/?l=linux-scsi&m=152887646121085&w=2

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
