Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5583BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C99F216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C99F216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeHUQlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:41:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726907AbeHUQlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:41:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D50040131A5;
        Tue, 21 Aug 2018 13:21:11 +0000 (UTC)
Received: from ming.t460p (ovpn-12-61.pek2.redhat.com [10.72.12.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68A6863F34;
        Tue, 21 Aug 2018 13:20:42 +0000 (UTC)
Date:   Tue, 21 Aug 2018 21:19:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: core: Update SCSI_MQ_DEFAULT help text to match
 default
Message-ID: <20180821131953.GA28549@ming.t460p>
References: <20180821114407.18393-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821114407.18393-1-geert+renesas@glider.be>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 21 Aug 2018 13:21:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 21 Aug 2018 13:21:11 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 01:44:07PM +0200, Geert Uytterhoeven wrote:
> The default was changed, but the help text was not updated.
> 
> Fix grammar (s/the option/this option/) while at it.
> 
> Fixes: d5038a13eca72fb2 ("scsi: core: switch to scsi-mq by default")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/scsi/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 8fc851a9e1162a56..a0491e11bd359499 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -53,11 +53,11 @@ config SCSI_MQ_DEFAULT
>  	depends on SCSI
>  	---help---
>  	  This option enables the new blk-mq based I/O path for SCSI
> -	  devices by default.  With the option the scsi_mod.use_blk_mq
> +	  devices by default.  With this option the scsi_mod.use_blk_mq
>  	  module/boot option defaults to Y, without it to N, but it can
>  	  still be overridden either way.
>  
> -	  If unsure say N.
> +	  If unsure say Y.
>  
>  config SCSI_PROC_FS
>  	bool "legacy /proc/scsi/ support"
> -- 
> 2.17.1
> 

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
