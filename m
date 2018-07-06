Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38136C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2F723CD9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2F723CD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933322AbeGFNk3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:40:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:56690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932470AbeGFNk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:40:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42282ACF9;
        Fri,  6 Jul 2018 13:40:27 +0000 (UTC)
Subject: Re: [PATCH 1/2] scsi: remove NCR_D700 driver
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
References: <20180706133349.28508-1-jthumshirn@suse.de>
 <20180706133349.28508-2-jthumshirn@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8f655b93-0cab-5bdf-9c71-3d4ffd906ac8@suse.de>
Date:   Fri, 6 Jul 2018 15:40:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706133349.28508-2-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 03:33 PM, Johannes Thumshirn wrote:
> The NCR DUAL 700 SCSI driver depends on microchannel support, but
> microchannel support was removed from the kernel with commit
> bb8187d35f82 ("MCA: delete all remaining traces of microchannel bus
> support.") over 6 years ago.
> 
> So zap the D700 SCSI driver as well.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  MAINTAINERS             |   6 -
>  drivers/scsi/Kconfig    |  12 --
>  drivers/scsi/Makefile   |   1 -
>  drivers/scsi/NCR_D700.c | 405 ------------------------------------------------
>  drivers/scsi/NCR_D700.h |  30 ----
>  5 files changed, 454 deletions(-)
>  delete mode 100644 drivers/scsi/NCR_D700.c
>  delete mode 100644 drivers/scsi/NCR_D700.h
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
