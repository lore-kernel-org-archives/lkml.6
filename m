Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE705C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B353208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfAJTzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:55:35 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.82]:23770 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727927AbfAJTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:55:34 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id BB4CF19DF7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 13:55:33 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hgQPgDSpu2qH7hgQPgs1GC; Thu, 10 Jan 2019 13:55:33 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41038 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghgQP-002PpD-BN; Thu, 10 Jan 2019 13:55:33 -0600
Subject: Re: [PATCH 38/41] scsi: sym53c8xx_2: sym_hipd: mark expected switch
 fall-throughs
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <81f959a632339d224fd0dd894746d1081bf249f3.1543374820.git.gustavo@embeddedor.com>
 <7ecbfc9c-4c03-c441-cf9b-c5a44d5a9ea5@embeddedor.com>
Message-ID: <f375dc0d-bbca-e35a-4ded-96cf77494ae3@embeddedor.com>
Date:   Thu, 10 Jan 2019 13:55:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7ecbfc9c-4c03-c441-cf9b-c5a44d5a9ea5@embeddedor.com>
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
X-Exim-ID: 1ghgQP-002PpD-BN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:41038
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
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

On 12/19/18 6:08 PM, Gustavo A. R. Silva wrote:
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
> On 11/27/18 10:34 PM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Addresses-Coverity-ID: 114996 ("Missing break in switch")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/scsi/sym53c8xx_2/sym_hipd.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/scsi/sym53c8xx_2/sym_hipd.c b/drivers/scsi/sym53c8xx_2/sym_hipd.c
>> index 0a2a54517b15..054fb0599263 100644
>> --- a/drivers/scsi/sym53c8xx_2/sym_hipd.c
>> +++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c
>> @@ -3072,6 +3072,7 @@ static void sym_sir_bad_scsi_status(struct sym_hcb *np, int num, struct sym_ccb
>>               sym_print_addr(cp->cmd, "%s\n",
>>                       s_status == S_BUSY ? "BUSY" : "QUEUE FULL\n");
>>           }
>> +        /* fall through */
>>       default:    /* S_INT, S_INT_COND_MET, S_CONFLICT */
>>           sym_complete_error (np, cp);
>>           break;
>> @@ -4632,6 +4633,7 @@ static void sym_int_sir(struct sym_hcb *np)
>>        *  Negotiation failed.
>>        *  Target does not want answer message.
>>        */
>> +    /* fall through */
>>       case SIR_NEGO_PROTO:
>>           sym_nego_default(np, tp, cp);
>>           goto out;
>>
