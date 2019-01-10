Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9E1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D700C2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfAJUJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:09:08 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.80]:47059 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728145AbfAJUJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:09:08 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 20650198E2C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:09:08 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hgdYgUmzbdnCehgdYgaO8X; Thu, 10 Jan 2019 14:09:08 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41252 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghgdX-002bsU-L9; Thu, 10 Jan 2019 14:09:07 -0600
Subject: Re: [PATCH 14/41] scsi: esas2r: esas2r_init: mark expected switch
 fall-throughs
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Bradley Grove <linuxdrivers@attotech.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <eb98d6f510cd93e45d7832837acd4e5811f3d20e.1543374820.git.gustavo@embeddedor.com>
 <b7f0fbf6-a793-c22c-cc3e-e35706d722f9@embeddedor.com>
Message-ID: <3751e0eb-e57b-9aed-c23a-f593b780605b@embeddedor.com>
Date:   Thu, 10 Jan 2019 14:08:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b7f0fbf6-a793-c22c-cc3e-e35706d722f9@embeddedor.com>
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
X-Exim-ID: 1ghgdX-002bsU-L9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:41252
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 39
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

On 12/19/18 9:39 AM, Gustavo A. R. Silva wrote:
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
> On 11/27/18 10:28 PM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/scsi/esas2r/esas2r_init.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/esas2r/esas2r_init.c b/drivers/scsi/esas2r/esas2r_init.c
>> index 46b2c83ba21f..950cd92df2ff 100644
>> --- a/drivers/scsi/esas2r/esas2r_init.c
>> +++ b/drivers/scsi/esas2r/esas2r_init.c
>> @@ -1241,6 +1241,7 @@ static bool esas2r_format_init_msg(struct esas2r_adapter *a,
>>               a->init_msg = ESAS2R_INIT_MSG_GET_INIT;
>>               break;
>>           }
>> +        /* fall through */
>>       case ESAS2R_INIT_MSG_GET_INIT:
>>           if (msg == ESAS2R_INIT_MSG_GET_INIT) {
>> @@ -1254,7 +1255,7 @@ static bool esas2r_format_init_msg(struct esas2r_adapter *a,
>>                   esas2r_hdebug("FAILED");
>>               }
>>           }
>> -    /* fall through */
>> +        /* fall through */
>>       default:
>>           rq->req_stat = RS_SUCCESS;
>>
