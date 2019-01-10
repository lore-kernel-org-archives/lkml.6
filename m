Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6DBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FD2206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfAJUQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:16:05 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.38]:15542 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729068AbfAJUQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:16:05 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id B9A2A400E5F82
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:15:20 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hgjYgMlwSiQerhgjYgNxrP; Thu, 10 Jan 2019 14:15:20 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=60208 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghgjY-002gsq-B4; Thu, 10 Jan 2019 14:15:20 -0600
Subject: Re: [PATCH 05/41] scsi: aic7xxx: aic79xx: mark expected switch
 fall-through
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Hannes Reinecke <hare@suse.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <ff0ea78271abe136badebfbeba1d4373fb836bce.1543374820.git.gustavo@embeddedor.com>
 <1d73dbbd-7e8e-e5ba-6a0f-97fdd799d4c4@embeddedor.com>
Message-ID: <a676a977-c55b-a0ce-1be3-b4d53ec68411@embeddedor.com>
Date:   Thu, 10 Jan 2019 14:15:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1d73dbbd-7e8e-e5ba-6a0f-97fdd799d4c4@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ghgjY-002gsq-B4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.130.205]:60208
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 91
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Friendly ping (second one):

Who can ack/review/take this patch, please?

Thanks
--
Gustavo

On 12/19/18 9:36 AM, Gustavo A. R. Silva wrote:
> Hi,
> 
> Friendly ping:
> 
> Who can ack or review this patch, please?
> 
> Thanks
> -- 
> Gustavo
> 
> On 11/27/18 10:26 PM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Notice that, in some cases, I replaced "FALLTHROUGH" with a "fall through"
>> annotation and then placed it at the bottom of the corresponding switch
>> case, which is what GCC is expecting to find.
>>
>> Addresses-Coverity-ID: 114961 ("Missing break in switch")
>> Addresses-Coverity-ID: 114962 ("Missing break in switch")
>> Addresses-Coverity-ID: 114963 ("Missing break in switch")
>> Addresses-Coverity-ID: 114964 ("Missing break in switch")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/scsi/aic7xxx/aic79xx_core.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
>> index 9ee75c9a9aa1..7e5044bf05c0 100644
>> --- a/drivers/scsi/aic7xxx/aic79xx_core.c
>> +++ b/drivers/scsi/aic7xxx/aic79xx_core.c
>> @@ -2285,6 +2285,7 @@ ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat)
>>               switch (scb->hscb->task_management) {
>>               case SIU_TASKMGMT_ABORT_TASK:
>>                   tag = SCB_GET_TAG(scb);
>> +                /* fall through */
>>               case SIU_TASKMGMT_ABORT_TASK_SET:
>>               case SIU_TASKMGMT_CLEAR_TASK_SET:
>>                   lun = scb->hscb->lun;
>> @@ -2295,6 +2296,7 @@ ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat)
>>                   break;
>>               case SIU_TASKMGMT_LUN_RESET:
>>                   lun = scb->hscb->lun;
>> +                /* fall through */
>>               case SIU_TASKMGMT_TARGET_RESET:
>>               {
>>                   struct ahd_devinfo devinfo;
>> @@ -6550,8 +6552,8 @@ ahd_fini_scbdata(struct ahd_softc *ahd)
>>               kfree(sns_map);
>>           }
>>           ahd_dma_tag_destroy(ahd, scb_data->sense_dmat);
>> -        /* FALLTHROUGH */
>>       }
>> +        /* fall through */
>>       case 6:
>>       {
>>           struct map_node *sg_map;
>> @@ -6565,8 +6567,8 @@ ahd_fini_scbdata(struct ahd_softc *ahd)
>>               kfree(sg_map);
>>           }
>>           ahd_dma_tag_destroy(ahd, scb_data->sg_dmat);
>> -        /* FALLTHROUGH */
>>       }
>> +        /* fall through */
>>       case 5:
>>       {
>>           struct map_node *hscb_map;
>> @@ -7209,6 +7211,7 @@ ahd_init(struct ahd_softc *ahd)
>>           case FLX_CSTAT_OVER:
>>           case FLX_CSTAT_UNDER:
>>               warn_user++;
>> +            /* fall through */
>>           case FLX_CSTAT_INVALID:
>>           case FLX_CSTAT_OKAY:
>>               if (warn_user == 0 && bootverbose == 0)
>> @@ -8413,7 +8416,7 @@ ahd_search_scb_list(struct ahd_softc *ahd, int target, char channel,
>>               if ((scb->flags & SCB_ACTIVE) == 0)
>>                   printk("Inactive SCB in Waiting List\n");
>>               ahd_done_with_status(ahd, scb, status);
>> -            /* FALLTHROUGH */
>> +            /* fall through */
>>           case SEARCH_REMOVE:
>>               ahd_rem_wscb(ahd, scbid, prev, next, tid);
>>               *list_tail = prev;
>> @@ -8422,6 +8425,7 @@ ahd_search_scb_list(struct ahd_softc *ahd, int target, char channel,
>>               break;
>>           case SEARCH_PRINT:
>>               printk("0x%x ", scbid);
>> +            /* fall through */
>>           case SEARCH_COUNT:
>>               prev = scbid;
>>               break;
>> @@ -9547,8 +9551,8 @@ ahd_download_instr(struct ahd_softc *ahd, u_int instrptr, uint8_t *dconsts)
>>       {
>>           fmt3_ins = &instr.format3;
>>           fmt3_ins->address = ahd_resolve_seqaddr(ahd, fmt3_ins->address);
>> -        /* FALLTHROUGH */
>>       }
>> +        /* fall through */
>>       case AIC_OP_OR:
>>       case AIC_OP_AND:
>>       case AIC_OP_XOR:
>> @@ -9559,7 +9563,7 @@ ahd_download_instr(struct ahd_softc *ahd, u_int instrptr, uint8_t *dconsts)
>>               fmt1_ins->immediate = dconsts[fmt1_ins->immediate];
>>           }
>>           fmt1_ins->parity = 0;
>> -        /* FALLTHROUGH */
>> +        /* fall through */
>>       case AIC_OP_ROL:
>>       {
>>           int i, count;
>>
