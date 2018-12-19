Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55866C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E00A218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbeLSPhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:37:12 -0500
Received: from gateway30.websitewelcome.com ([192.185.179.30]:31924 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728301AbeLSPhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:37:11 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 24C5214E87
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 09:37:10 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZduIgGBrI4FKpZduIglbQi; Wed, 19 Dec 2018 09:37:10 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=35298 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZduH-000fXP-Od; Wed, 19 Dec 2018 09:37:09 -0600
Subject: Re: [PATCH 06/41] scsi: aic7xxx: mark expected switch fall-throughs
To:     Hannes Reinecke <hare@suse.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <b55c3f902d88871053983314cfa837e641db5db6.1543374820.git.gustavo@embeddedor.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <76760259-100e-f149-bbbf-4c1044152ff7@embeddedor.com>
Date:   Wed, 19 Dec 2018 09:37:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b55c3f902d88871053983314cfa837e641db5db6.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gZduH-000fXP-Od
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:35298
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
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

On 11/27/18 10:26 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that, in some cases, I replaced "FALLTHROUGH" with a "fall through"
> annotation and then placed it at the bottom of the corresponding switch
> case, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/scsi/aic7xxx/aic7xxx_core.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
> index f3362f4ab16e..d4a7263e4b8f 100644
> --- a/drivers/scsi/aic7xxx/aic7xxx_core.c
> +++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
> @@ -4920,24 +4920,30 @@ ahc_fini_scbdata(struct ahc_softc *ahc)
>   		}
>   		ahc_dma_tag_destroy(ahc, scb_data->sg_dmat);
>   	}
> +		/* fall through */
>   	case 6:
>   		ahc_dmamap_unload(ahc, scb_data->sense_dmat,
>   				  scb_data->sense_dmamap);
> +		/* fall through */
>   	case 5:
>   		ahc_dmamem_free(ahc, scb_data->sense_dmat, scb_data->sense,
>   				scb_data->sense_dmamap);
>   		ahc_dmamap_destroy(ahc, scb_data->sense_dmat,
>   				   scb_data->sense_dmamap);
> +		/* fall through */
>   	case 4:
>   		ahc_dma_tag_destroy(ahc, scb_data->sense_dmat);
> +		/* fall through */
>   	case 3:
>   		ahc_dmamap_unload(ahc, scb_data->hscb_dmat,
>   				  scb_data->hscb_dmamap);
> +		/* fall through */
>   	case 2:
>   		ahc_dmamem_free(ahc, scb_data->hscb_dmat, scb_data->hscbs,
>   				scb_data->hscb_dmamap);
>   		ahc_dmamap_destroy(ahc, scb_data->hscb_dmat,
>   				   scb_data->hscb_dmamap);
> +		/* fall through */
>   	case 1:
>   		ahc_dma_tag_destroy(ahc, scb_data->hscb_dmat);
>   		break;
> @@ -6002,8 +6008,8 @@ ahc_search_qinfifo(struct ahc_softc *ahc, int target, char channel,
>   				if ((scb->flags & SCB_ACTIVE) == 0)
>   					printk("Inactive SCB in Waiting List\n");
>   				ahc_done(ahc, scb);
> -				/* FALLTHROUGH */
>   			}
> +				/* fall through */
>   			case SEARCH_REMOVE:
>   				next = ahc_rem_wscb(ahc, next, prev);
>   				break;
> @@ -7008,8 +7014,8 @@ ahc_download_instr(struct ahc_softc *ahc, u_int instrptr, uint8_t *dconsts)
>   		}
>   		address -= address_offset;
>   		fmt3_ins->address = address;
> -		/* FALLTHROUGH */
>   	}
> +		/* fall through */
>   	case AIC_OP_OR:
>   	case AIC_OP_AND:
>   	case AIC_OP_XOR:
> @@ -7035,7 +7041,7 @@ ahc_download_instr(struct ahc_softc *ahc, u_int instrptr, uint8_t *dconsts)
>   			fmt1_ins->opcode = AIC_OP_AND;
>   			fmt1_ins->immediate = 0xff;
>   		}
> -		/* FALLTHROUGH */
> +		/* fall through */
>   	case AIC_OP_ROL:
>   		if ((ahc->features & AHC_ULTRA2) != 0) {
>   			int i, count;
> 
