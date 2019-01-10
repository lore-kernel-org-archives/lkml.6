Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2CAC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D94206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfAJUMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:12:25 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.144]:28381 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730128AbfAJUMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:12:24 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id A4337A93C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:12:23 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hgghg78RjYTGMhgghgsAcD; Thu, 10 Jan 2019 14:12:23 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41286 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghggh-002efX-1F; Thu, 10 Jan 2019 14:12:23 -0600
Subject: Re: [PATCH 10/41] scsi: bfa: bfa_fcs_lport: Mark expected switch
 fall-throughs
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <5cc329185c0b92f3aad001fc1afa54996a2c1112.1543374820.git.gustavo@embeddedor.com>
 <a2a4fd41-d231-4d72-a95e-e1109c209f94@embeddedor.com>
Message-ID: <fad1ad2c-1004-6064-931a-6c898ba00915@embeddedor.com>
Date:   Thu, 10 Jan 2019 14:12:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a2a4fd41-d231-4d72-a95e-e1109c209f94@embeddedor.com>
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
X-Exim-ID: 1ghggh-002efX-1F
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:41286
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 61
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
> On 11/27/18 10:27 PM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Notice that, in this particular case, I replaced "!!! fall through !!!"
>> with a "fall through" annotation, which is what GCC is expecting to
>> find.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/scsi/bfa/bfa_fcs_lport.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/scsi/bfa/bfa_fcs_lport.c b/drivers/scsi/bfa/bfa_fcs_lport.c
>> index b4f2c1d8742e..646f09f66443 100644
>> --- a/drivers/scsi/bfa/bfa_fcs_lport.c
>> +++ b/drivers/scsi/bfa/bfa_fcs_lport.c
>> @@ -6430,9 +6430,7 @@ bfa_fcs_vport_sm_logo_for_stop(struct bfa_fcs_vport_s *vport,
>>       switch (event) {
>>       case BFA_FCS_VPORT_SM_OFFLINE:
>>           bfa_sm_send_event(vport->lps, BFA_LPS_SM_OFFLINE);
>> -        /*
>> -         * !!! fall through !!!
>> -         */
>> +        /* fall through */
>>       case BFA_FCS_VPORT_SM_RSP_OK:
>>       case BFA_FCS_VPORT_SM_RSP_ERROR:
>> @@ -6458,9 +6456,7 @@ bfa_fcs_vport_sm_logo(struct bfa_fcs_vport_s *vport,
>>       switch (event) {
>>       case BFA_FCS_VPORT_SM_OFFLINE:
>>           bfa_sm_send_event(vport->lps, BFA_LPS_SM_OFFLINE);
>> -        /*
>> -         * !!! fall through !!!
>> -         */
>> +        /* fall through */
>>       case BFA_FCS_VPORT_SM_RSP_OK:
>>       case BFA_FCS_VPORT_SM_RSP_ERROR:
>>
