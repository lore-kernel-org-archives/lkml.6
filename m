Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17023C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E225A208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbfAJUMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:12:37 -0500
Received: from gateway30.websitewelcome.com ([50.116.125.1]:39144 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730050AbfAJUMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:12:37 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id B7B811C1EC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:12:36 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hggugMjqpiQerhggugNvnL; Thu, 10 Jan 2019 14:12:36 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41290 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghggu-002epl-7u; Thu, 10 Jan 2019 14:12:36 -0600
Subject: Re: [PATCH 09/41] scsi: bfa: bfa_fcpim: Mark expected switch
 fall-throughs
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <8f042a78366807fe4cf3c1f7157dc80f1dd49219.1543374820.git.gustavo@embeddedor.com>
 <8d5684c5-7b09-3e4a-d0ad-a024e3d06d05@embeddedor.com>
Message-ID: <c6dca956-619a-1f88-8e28-65304ed63319@embeddedor.com>
Date:   Thu, 10 Jan 2019 14:12:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8d5684c5-7b09-3e4a-d0ad-a024e3d06d05@embeddedor.com>
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
X-Exim-ID: 1ghggu-002epl-7u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:41290
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 67
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
>> Notice that I replaced "Fall through !!!" with a "fall through"
>> annotation, which is what GCC is expecting to find.
>>
>> Addresses-Coverity-ID: 114971 ("Missing break in switch")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/scsi/bfa/bfa_fcpim.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/scsi/bfa/bfa_fcpim.c b/drivers/scsi/bfa/bfa_fcpim.c
>> index 2c85f5b1f9c1..7e996bcf026c 100644
>> --- a/drivers/scsi/bfa/bfa_fcpim.c
>> +++ b/drivers/scsi/bfa/bfa_fcpim.c
>> @@ -2586,6 +2586,7 @@ bfa_ioim_send_ioreq(struct bfa_ioim_s *ioim)
>>       case FCP_IODIR_RW:
>>           bfa_stats(itnim, input_reqs);
>>           bfa_stats(itnim, output_reqs);
>> +        /* fall through */
>>       default:
>>           bfi_h2i_set(m->mh, BFI_MC_IOIM_IO, 0, bfa_fn_lpu(ioim->bfa));
>>       }
>> @@ -2820,6 +2821,7 @@ bfa_ioim_isr(struct bfa_s *bfa, struct bfi_msg_s *m)
>>       case BFI_IOIM_STS_TIMEDOUT:
>>           bfa_stats(ioim->itnim, iocomp_timedout);
>> +        /* fall through */
>>       case BFI_IOIM_STS_ABORTED:
>>           rsp->io_status = BFI_IOIM_STS_ABORTED;
>>           bfa_stats(ioim->itnim, iocomp_aborted);
>> @@ -3215,9 +3217,7 @@ bfa_tskim_sm_cleanup_qfull(struct bfa_tskim_s *tskim,
>>       switch (event) {
>>       case BFA_TSKIM_SM_DONE:
>>           bfa_reqq_wcancel(&tskim->reqq_wait);
>> -        /*
>> -         * Fall through !!!
>> -         */
>> +        /* fall through */
>>       case BFA_TSKIM_SM_QRESUME:
>>           bfa_sm_set_state(tskim, bfa_tskim_sm_cleanup);
>>           bfa_tskim_send_abort(tskim);
>>
