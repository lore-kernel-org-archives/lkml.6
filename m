Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007D4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FE3208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfAJW0k convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:26:40 -0500
Received: from sw.attotech.com ([208.69.85.34]:11692 "EHLO
        NOTESERV1.attotech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728042AbfAJW0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:26:39 -0500
X-Greylist: delayed 919 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jan 2019 17:26:39 EST
Received: from [10.30.1.34] ([10.30.1.34])
          by NOTESERV1.attotech.com (IBM Domino Release 9.0.1FP10 HF314)
          with ESMTP id 2019011017111804-18675 ;
          Thu, 10 Jan 2019 17:11:18 -0500 
Subject: Re: [PATCH 14/41] scsi: esas2r: esas2r_init: mark expected switch
 fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Bradley Grove <linuxdrivers@attotech.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
From:   "Grove, Bradley" <bgrove@attotech.com>
Message-ID: <6bcead36-dc21-0ba9-48e4-35a9fa19df09@attotech.com>
Date:   Thu, 10 Jan 2019 17:11:18 -0500
In-Reply-To: <3751e0eb-e57b-9aed-c23a-f593b780605b@embeddedor.com>
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <eb98d6f510cd93e45d7832837acd4e5811f3d20e.1543374820.git.gustavo@embeddedor.com>
 <b7f0fbf6-a793-c22c-cc3e-e35706d722f9@embeddedor.com>
 <3751e0eb-e57b-9aed-c23a-f593b780605b@embeddedor.com>
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on NOTESERV1/SERV/ATTO(Release 9.0.1FP10
 HF314|September 20, 2018) at 01/10/2019 05:11:18 PM
X-TNEFEvaluated: 1
X-Disclaimed: 7795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Bradley Grove <bgrove@atto.com>


On 1/10/2019 3:08 PM, Gustavo A. R. Silva wrote:
> Hi,
> 
> Friendly ping (second one):
> 
> Who can ack/review/take this patch, please?
> 
> Thanks
> -- 
> Gustavo
> 
> On 12/19/18 9:39 AM, Gustavo A. R. Silva wrote:
>> Hi,
>>
>> Friendly ping:
>>
>> Who can ack or review this patch, please?
>>
>> Thanks
>> -- 
>> Gustavo
>>
>> On 11/27/18 10:28 PM, Gustavo A. R. Silva wrote:
>>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>>> where we are expecting to fall through.
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>   drivers/scsi/esas2r/esas2r_init.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/scsi/esas2r/esas2r_init.c 
>>> b/drivers/scsi/esas2r/esas2r_init.c
>>> index 46b2c83ba21f..950cd92df2ff 100644
>>> --- a/drivers/scsi/esas2r/esas2r_init.c
>>> +++ b/drivers/scsi/esas2r/esas2r_init.c
>>> @@ -1241,6 +1241,7 @@ static bool esas2r_format_init_msg(struct 
>>> esas2r_adapter *a,
>>>               a->init_msg = ESAS2R_INIT_MSG_GET_INIT;
>>>               break;
>>>           }
>>> +        /* fall through */
>>>       case ESAS2R_INIT_MSG_GET_INIT:
>>>           if (msg == ESAS2R_INIT_MSG_GET_INIT) {
>>> @@ -1254,7 +1255,7 @@ static bool esas2r_format_init_msg(struct 
>>> esas2r_adapter *a,
>>>                   esas2r_hdebug("FAILED");
>>>               }
>>>           }
>>> -    /* fall through */
>>> +        /* fall through */
>>>       default:
>>>           rq->req_stat = RS_SUCCESS;
>>>



This electronic transmission and any attachments hereto are intended only for the use of the individual or entity to which it is addressed and may contain confidential information belonging to ATTO Technology, Inc. If you have reason to believe that you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution or the taking of any action in reliance on the contents of this electronic transmission is strictly prohibited. If you have reason to believe that you have received this transmission in error, please notify ATTO immediately by return e-mail and delete and destroy this communication.   
