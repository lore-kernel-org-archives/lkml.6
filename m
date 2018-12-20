Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8853C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F41B21841
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbeLTAHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 19:07:05 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.178]:35104 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727589AbeLTAHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 19:07:05 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 083575020E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 18:07:04 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZlrjgkNhF2qH7ZlrkgT8SL; Wed, 19 Dec 2018 18:07:04 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=50510 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZlrh-00151s-Hz; Wed, 19 Dec 2018 18:07:01 -0600
Subject: Re: [PATCH 31/41] scsi: mpt3sas: mpt3sas_scsih: Mark expected switch
 fall-through
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <892c3e5e27213c1c2f3da128afe958429bbef672.1543374820.git.gustavo@embeddedor.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <4bce4543-ae65-8dfa-cbe6-405d78003129@embeddedor.com>
Date:   Wed, 19 Dec 2018 18:07:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <892c3e5e27213c1c2f3da128afe958429bbef672.1543374820.git.gustavo@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gZlrh-00151s-Hz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:50510
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Friendly ping:

Who can ack or review this patch, please?

Thanks
--
Gustavo

On 11/27/18 10:32 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1475400 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/scsi/mpt3sas/mpt3sas_scsih.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> index 5b9806d0719e..920b80ce4748 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> @@ -10370,6 +10370,7 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		case MPI26_MFGPAGE_DEVID_CFG_SEC_3916:
>   			dev_info(&pdev->dev,
>   			    "HBA is in Configurable Secure mode\n");
> +			/* fall through */
>   		case MPI26_MFGPAGE_DEVID_SAS3508:
>   		case MPI26_MFGPAGE_DEVID_SAS3508_1:
>   		case MPI26_MFGPAGE_DEVID_SAS3408:
> 
