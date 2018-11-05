Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41045C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067DF2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067DF2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeKERMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:12:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:41862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbeKERMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:12:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27313ACD3;
        Mon,  5 Nov 2018 07:54:07 +0000 (UTC)
Subject: Re: [PATCH] scsi: myrs: only build on little-endian platforms
To:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181102154740.2011289-1-arnd@arndb.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <69fd8fbd-987a-c48e-6732-387239c3ab0e@suse.de>
Date:   Mon, 5 Nov 2018 08:54:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102154740.2011289-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18 4:47 PM, Arnd Bergmann wrote:
> Reading throught the new driver, I noticed that this cannot work on
> big-endian CPUs, and the old DAC960 had exactly the same behavior.
> 
> To document this for the future, add a Kconfig dependency that prevents it
> from being included in big-endian kernels.  Since the hardware is really
> old and we never had a working driver on it for big-endian platforms,
> it's unlikely to make a difference to users.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/scsi/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index f07444d30b21..640cd1b31a18 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -578,6 +578,7 @@ config SCSI_MYRB
>   config SCSI_MYRS
>   	tristate "Mylex DAC960/DAC1100 PCI RAID Controller (SCSI Interface)"
>   	depends on PCI
> +	depends on !CPU_BIG_ENDIAN || COMPILE_TEST
>   	select RAID_ATTRS
>   	help
>   	  This driver adds support for the Mylex DAC960, AcceleRAID, and
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
