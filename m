Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C77C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC41F208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbfAJUNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:13:05 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.194]:32812 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730063AbfAJUNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:13:05 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 751608689B3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:13:04 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hghMgUq6WdnCehghMgaRDa; Thu, 10 Jan 2019 14:13:04 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41300 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghghK-002fBg-Ee; Thu, 10 Jan 2019 14:13:02 -0600
Subject: Re: [PATCH 08/41] scsi: be2iscsi: be_main: Mark expected switch
 fall-through
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <ca994231ba2101ba489ee7b18862a10a8c9dad7e.1543374820.git.gustavo@embeddedor.com>
 <8cecc2e7-5008-678f-e2de-7d8ab3b95195@embeddedor.com>
Message-ID: <c5cb7155-b2f5-8872-75c8-81ce6dc6692f@embeddedor.com>
Date:   Thu, 10 Jan 2019 14:12:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8cecc2e7-5008-678f-e2de-7d8ab3b95195@embeddedor.com>
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
X-Exim-ID: 1ghghK-002fBg-Ee
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:41300
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 74
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

On 12/19/18 9:38 AM, Gustavo A. R. Silva wrote:
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
> On 11/27/18 10:27 PM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Addresses-Coverity-ID: 1357387 ("Missing break in switch")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/scsi/be2iscsi/be_main.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
>> index effb6fc95af4..b6449da1320c 100644
>> --- a/drivers/scsi/be2iscsi/be_main.c
>> +++ b/drivers/scsi/be2iscsi/be_main.c
>> @@ -1539,6 +1539,7 @@ beiscsi_hdl_get_handle(struct beiscsi_conn *beiscsi_conn,
>>           break;
>>       case UNSOL_DATA_DIGEST_ERROR_NOTIFY:
>>           error = 1;
>> +        /* fall through */
>>       case UNSOL_DATA_NOTIFY:
>>           pasync_handle = pasync_ctx->async_entry[ci].data;
>>           break;
>>
